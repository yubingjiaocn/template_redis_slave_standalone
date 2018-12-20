# =================================================================
# Copyright 2017 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =================================================================

# This is a terraform generated template generated from apache_tomcat_v8_standalone

##############################################################
# Keys - CAMC (public/private) & optional User Key (public)
##############################################################
variable "user_public_ssh_key" {
  type        = "string"
  description = "User defined public SSH key used to connect to the virtual machine. The format must be in openSSH."
  default     = "None"
}

variable "ibm_stack_id" {
  description = "A unique stack id."
}

variable "ibm_pm_public_ssh_key" {
  description = "Public CAMC SSH key value which is used to connect to a guest, used on VMware only."
}

variable "ibm_pm_private_ssh_key" {
  description = "Private CAMC SSH key (base64 encoded) used to connect to the virtual guest."
}

variable "allow_unverified_ssl" {
  description = "Communication with vsphere server with self signed certificate"
  default     = "true"
}

##############################################################
# Define the vsphere provider
##############################################################
provider "vsphere" {
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version              = "~> 1.3"
}

provider "camc" {
  version = "~> 0.2"
}

##############################################################
# Define pattern variables
##############################################################
##### unique stack name #####
variable "ibm_stack_name" {
  description = "A unique stack name."
}

##############################################################
# Vsphere data for provider
##############################################################
data "vsphere_datacenter" "Node01_datacenter" {
  name = "${var.Node01_datacenter}"
}

data "vsphere_datastore" "Node01_datastore" {
  name          = "${var.Node01_root_disk_datastore}"
  datacenter_id = "${data.vsphere_datacenter.Node01_datacenter.id}"
}

data "vsphere_resource_pool" "Node01_resource_pool" {
  name          = "${var.Node01_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.Node01_datacenter.id}"
}

data "vsphere_network" "Node01_network" {
  name          = "${var.Node01_network_interface_label}"
  datacenter_id = "${data.vsphere_datacenter.Node01_datacenter.id}"
}

data "vsphere_virtual_machine" "Node01_template" {
  name          = "${var.Node01-image}"
  datacenter_id = "${data.vsphere_datacenter.Node01_datacenter.id}"
}

##### Environment variables #####
#Variable : ibm_pm_access_token
variable "ibm_pm_access_token" {
  type        = "string"
  description = "IBM Pattern Manager Access Token"
}

#Variable : ibm_pm_service
variable "ibm_pm_service" {
  type        = "string"
  description = "IBM Pattern Manager Service"
}

#Variable : ibm_sw_repo
variable "ibm_sw_repo" {
  type        = "string"
  description = "IBM Software Repo Root (https://<hostname>:<port>)"
}

#Variable : ibm_sw_repo_password
variable "ibm_sw_repo_password" {
  type        = "string"
  description = "IBM Software Repo Password"
}

#Variable : ibm_sw_repo_user
variable "ibm_sw_repo_user" {
  type        = "string"
  description = "IBM Software Repo Username"
  default     = "repouser"
}

##### Node01 variables #####
#Variable : Node01-image
variable "Node01-image" {
  type        = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
}

#Variable : Node01-name
variable "Node01-name" {
  type        = "string"
  description = "Short hostname of virtual machine"
}

#Variable : Node01-os_admin_user
variable "Node01-os_admin_user" {
  type        = "string"
  description = "Name of the admin user account in the virtual machine that will be accessed via SSH"
}

#Variable : Node01_redis_port
variable "Node01_redis_port" {
  type        = "string"
  description = "The redis port to service requests."
  default     = "6379"
}

variable "Node01_redis_master_address" {
  type        = "string"
  description = "Master redis address."
  default     = ""
}

variable "Node01_redis_master_port" {
  type        = "string"
  description = "Master redis port."
  default     = "6379"
}

##### virtualmachine variables #####

#########################################################
##### Resource : Node01
#########################################################

variable "Node01-os_password" {
  type        = "string"
  description = "Operating System Password for the Operating System User to access virtual machine"
}

variable "Node01_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "Node01_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "Node01_domain" {
  description = "Domain Name of virtual machine"
}

variable "Node01_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
  default     = "2"
}

variable "Node01_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
  default     = "4096"
}

variable "Node01_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "Node01_resource_pool" {
  description = "Target vSphere Resource Pool to host the virtual machine"
}

variable "Node01_dns_suffixes" {
  type        = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "Node01_dns_servers" {
  type        = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "Node01_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "Node01_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "Node01_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "Node01_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "Node01_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
  default     = "vmxnet3"
}

variable "Node01_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "Node01_root_disk_keep_on_remove" {
  type        = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
  default     = "false"
}

variable "Node01_root_disk_size" {
  description = "Size of template disk volume. Should be equal to template's disk size"
  default     = "100"
}

module "provision_proxy" {
  source 						= "git::https://github.com/IBM-CAMHub-Open/terraform-modules.git?ref=1.0//vmware/proxy"
  ip                  = "${var.Node01_ipv4_address}"
  id									= "${vsphere_virtual_machine.Node01.id}"
  ssh_user            = "${var.Node01-os_admin_user}"
  ssh_password        = "${var.Node01-os_password}"
  http_proxy_host     = "${var.http_proxy_host}"
  http_proxy_user     = "${var.http_proxy_user}"
  http_proxy_password = "${var.http_proxy_password}"
  http_proxy_port     = "${var.http_proxy_port}"
  enable							= "${ length(var.http_proxy_host) > 0 ? "true" : "false"}"
}

# vsphere vm
resource "vsphere_virtual_machine" "Node01" {
  name             = "${var.Node01-name}"
  folder           = "${var.Node01_folder}"
  num_cpus         = "${var.Node01_number_of_vcpu}"
  memory           = "${var.Node01_memory}"
  resource_pool_id = "${data.vsphere_resource_pool.Node01_resource_pool.id}"
  datastore_id     = "${data.vsphere_datastore.Node01_datastore.id}"
  guest_id         = "${data.vsphere_virtual_machine.Node01_template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.Node01_template.scsi_type}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.Node01_template.id}"

    customize {
      linux_options {
        domain    = "${var.Node01_domain}"
        host_name = "${var.Node01-name}"
      }

      network_interface {
        ipv4_address = "${var.Node01_ipv4_address}"
        ipv4_netmask = "${var.Node01_ipv4_prefix_length}"
      }

      ipv4_gateway    = "${var.Node01_ipv4_gateway}"
      dns_suffix_list = "${var.Node01_dns_suffixes}"
      dns_server_list = "${var.Node01_dns_servers}"
    }
  }

  network_interface {
    network_id   = "${data.vsphere_network.Node01_network.id}"
    adapter_type = "${var.Node01_adapter_type}"
  }

  disk {
    label          = "${var.Node01-name}.disk0"
    size           = "${var.Node01_root_disk_size}"
    keep_on_remove = "${var.Node01_root_disk_keep_on_remove}"
    thin_provisioned = false
    eagerly_scrub = true
  }

  # Specify the connection
  connection {
    type     = "ssh"
    user     = "${var.Node01-os_admin_user}"
    password = "${var.Node01-os_password}"
    bastion_host        = "${var.bastion_host}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${ length(var.bastion_private_key) > 0 ? base64decode(var.bastion_private_key) : var.bastion_private_key}"
    bastion_port        = "${var.bastion_port}"
    bastion_host_key    = "${var.bastion_host_key}"
    bastion_password    = "${var.bastion_password}"
  }

  provisioner "file" {
    destination = "Node01_add_ssh_key.sh"

    content = <<EOF
# =================================================================
# Copyright 2017 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#	  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =================================================================
#!/bin/bash

if (( $# != 3 )); then
echo "usage: arg 1 is user, arg 2 is public key, arg3 is CAMC Public Key"
exit -1
fi

userid="$1"
ssh_key="$2"
camc_ssh_key="$3"

user_home=$(eval echo "~$userid")
user_auth_key_file=$user_home/.ssh/authorized_keys
echo "$user_auth_key_file"
if ! [ -f $user_auth_key_file ]; then
echo "$user_auth_key_file does not exist on this system, creating."
mkdir $user_home/.ssh
chmod 700 $user_home/.ssh
touch $user_home/.ssh/authorized_keys
chmod 600 $user_home/.ssh/authorized_keys
else
echo "user_home : $user_home"
fi

if [[ $ssh_key = 'None' ]]; then
echo "skipping user key add, 'None' specified"
else
echo "$user_auth_key_file"
echo "$ssh_key" >> "$user_auth_key_file"
if [ $? -ne 0 ]; then
echo "failed to add to $user_auth_key_file"
exit -1
else
echo "updated $user_auth_key_file"
fi
fi

echo "$camc_ssh_key" >> "$user_auth_key_file"
if [ $? -ne 0 ]; then
echo "failed to add to $user_auth_key_file"
exit -1
else
echo "updated $user_auth_key_file"
fi

EOF
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "bash -c 'chmod +x Node01_add_ssh_key.sh'",
      "bash -c './Node01_add_ssh_key.sh  \"${var.Node01-os_admin_user}\" \"${var.user_public_ssh_key}\" \"${var.ibm_pm_public_ssh_key}\">> Node01_add_ssh_key.log 2>&1'",
    ]
  }
provisioner "file" {
    destination = "Node01_enable_yum.sh"

    content = <<EOF
    rm -rf /etc/yum.repos.d/*
    cat << EOR > /etc/yum.repos.d/rhel.repo
[ftp3]
name=FTP3 yum repository
baseurl=ftp://jiajj%40cn.ibm.com:Passw0rd@ftp3.linux.ibm.com/redhat/yum/server/7/7Server/x86_64/os/
enabled=1
gpgcheck=0
[ftp3-updates]
name=FTP3 updates yum repository
baseurl=ftp://jiajj%40cn.ibm.com:Passw0rd@ftp3.linux.ibm.com/redhat/yum/server/7/7Server/x86_64/optional/os/
enabled=1
gpgcheck=0
[ftp3-supplementary]
name=FTP3 supplementary yum repository
baseurl=ftp://jiajj%40cn.ibm.com:Passw0rd@ftp3.linux.ibm.com/redhat/yum/server/7/7Server/x86_64/supplementary/os/
enabled=1
gpgcheck=0
[ftp3-extra]
name=FTP3 extra yum repository
baseurl=ftp://jiajj%40cn.ibm.com:Passw0rd@ftp3.linux.ibm.com/redhat/yum/server/7/7Server/x86_64/extras/os/
enabled=1
gpgcheck=0
[epel]
name=Extra Packages for Enterprise Linux 7 - \$basearch
baseurl=http://9.181.26.145/repo/epel/7/\$basearch
enabled=1
gpgcheck=0
[mariadb]
name=Mariadb 10
baseurl=http://9.111.97.171:19999/10.1/rhel7-amd64
enabled=1
gpgcheck=0

EOR
    yum makecache
    service firewalld stop
    setenforce 0

EOF
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "bash -c 'chmod +x Node01_enable_yum.sh'",
      "bash -c './Node01_enable_yum.sh >> Node01_enable_yum.log 2>&1'",
    ]
  }

}

#########################################################
##### Resource : Node01_chef_bootstrap_comp
#########################################################

resource "camc_bootstrap" "Node01_chef_bootstrap_comp" {
  depends_on      = ["camc_vaultitem.VaultItem", "vsphere_virtual_machine.Node01", "module.provision_proxy"]
  name            = "Node01_chef_bootstrap_comp"
  camc_endpoint   = "${var.ibm_pm_service}/v1/bootstrap/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "os_admin_user": "${var.Node01-os_admin_user}",
  "stack_id": "${var.ibm_stack_id}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.Node01.clone.0.customize.0.network_interface.0.ipv4_address}",
  "node_name": "${var.Node01-name}",
  "node_attributes": {
    "ibm_internal": {
      "stack_id": "${var.ibm_stack_id}",
      "stack_name": "${var.ibm_stack_name}",
      "vault": {
        "item": "secrets",
        "name": "${var.ibm_stack_id}"
      }
    }
  }
}
EOT
}

#########################################################
##### Resource : Node01_redis
#########################################################

resource "camc_softwaredeploy" "Node01_redis" {
  depends_on      = ["camc_bootstrap.Node01_chef_bootstrap_comp"]
  name            = "Node01_redis"
  camc_endpoint   = "${var.ibm_pm_service}/v1/software_deployment/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "os_admin_user": "${var.Node01-os_admin_user}",
  "stack_id": "${var.ibm_stack_id}",
  "environment_name": "_default",
  "host_ip": "${vsphere_virtual_machine.Node01.clone.0.customize.0.network_interface.0.ipv4_address}",
  "node_name": "${var.Node01-name}",
  "runlist": "recipe[redisio]",
  "node_attributes": {
    "ibm": {
      "sw_repo": "${var.ibm_sw_repo}",
      "sw_repo_user": "${var.ibm_sw_repo_user}"
    },
    "redisio": {
      "package_install": "true",
      "default_settings":
        {
          "port": "${var.Node01_redis_port}",
          "name": "${var.Node01-name}",
          "address": "0.0.0.0",
          "slaveof": {
            "address": "${var.Node01_redis_master_address}",
            "port": "${var.Node01_redis_master_port}"
          },
          "protected_mode": "no"
        }

    }
  },
  "vault_content": {
    "item": "secrets",
    "values": {
      "ibm": {
        "sw_repo_password": "${var.ibm_sw_repo_password}"
      }
    },
    "vault": "${var.ibm_stack_id}"
  }
}
EOT
}

#########################################################
##### Resource : VaultItem
#########################################################

resource "camc_vaultitem" "VaultItem" {
  camc_endpoint   = "${var.ibm_pm_service}/v1/vault_item/chef"
  access_token    = "${var.ibm_pm_access_token}"
  skip_ssl_verify = true
  trace           = true

  data = <<EOT
{
  "vault_content": {
    "item": "secrets",
    "values": {},
    "vault": "${var.ibm_stack_id}"
  }
}
EOT
}

resource "null_resource" "Node01_Service" {
  depends_on = ["vsphere_virtual_machine.Node01", "camc_softwaredeploy.Node01_redis"]

  # Specify the ssh connection
  connection {
    type     = "ssh"
    user     = "${var.Node01-os_admin_user}"
    password = "${var.Node01-os_password}"
    host = "${var.Node01_ipv4_address}"
    bastion_host        = "${var.bastion_host}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${ length(var.bastion_private_key) > 0 ? base64decode(var.bastion_private_key) : var.bastion_private_key}"
    bastion_port        = "${var.bastion_port}"
    bastion_host_key    = "${var.bastion_host_key}"
    bastion_password    = "${var.bastion_password}"
  }

  provisioner "remote-exec" {
    inline = [
      "bash -c 'systemctl stop redis.service'"
    ]
  }

  provisioner "file" {
    destination = "/usr/lib/systemd/system/redis.service"
    content     = <<EOF
[Unit]
Description=Redis persistent key-value database
After=network.target

[Service]
ExecStart=/usr/bin/redis-server /etc/redis/${var.Node01-name}.conf --daemonize yes
ExecStop=/usr/libexec/redis-shutdown
Type=forking
User=redis
Group=redis
#PIDFile=/var/run/redis.pid
RuntimeDirectory=redis
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
EOF
  }

  provisioner "remote-exec" {
    inline = [
      "bash -c 'systemctl daemon-reload'",
      "bash -c '/usr/bin/redis-server /etc/redis/${var.Node01-name}.conf --daemonize yes'"
    ]
  }
}

output "Node01_ip" {
  value = "VM IP Address : ${vsphere_virtual_machine.Node01.clone.0.customize.0.network_interface.0.ipv4_address}"
}

output "Node01_name" {
  value = "${var.Node01-name}"
}

output "Node01_roles" {
  value = "redis"
}

output "stack_id" {
  value = "${var.ibm_stack_id}"
}
