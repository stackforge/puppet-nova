Puppet::Type.newtype(:nova_network) do

  @doc = "Manage creation/deletion of nova networks.  During creation, network
          CIDR and netmask will be calculated automatically"

  ensurable

  # there are concerns about determining uniqueness of network
  # segments b/c it is actually the combination of network/prefix
  # that determine uniqueness
  newparam(:network, :namevar => true) do
    desc "IPv4 Network (ie, 192.168.1.0/24)"
    newvalues(/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/(\d|[1-2]\d|3[0-2]))$/)
  end

  newparam(:label) do
    desc "The Nova network label"
    defaultto "novanetwork"

    munge do |value|
      Puppet.deprecation_warning('nova_network is deprecated and will be removed in a future release')
      value
    end
  end

  newparam(:num_networks) do
    desc 'Number of networks to create'
    defaultto(1)
  end

  newparam(:bridge) do
    desc 'bridge to use for flat network'
  end

  newparam(:project) do
    desc 'project that the network is associated with'
  end

  newparam(:gateway) do
  end

  newparam(:dns1) do
    desc 'first dns server'
   end

  newparam(:dns2) do
    desc 'second dns server'
  end

  newparam(:allowed_start) do
    desc 'Start of allowed addresses for instances'
    newvalues(/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/)
  end

  newparam(:allowed_end) do
    desc 'End of allowed addresses for instances'
    newvalues(/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/)
  end

  newparam(:vlan_start) do
  end

  newparam(:network_size) do
    defaultto('256')
  end

  validate do
    raise(Puppet::Error, 'Label must be set') unless self[:label]
  end

end
