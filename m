Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTLWSSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTLWSRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:17:54 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:5897 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S262280AbTLWSQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:16:51 -0500
Date: Tue, 23 Dec 2003 19:17:00 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0] rmmod ohci1394 / scheduling while atomic
Message-ID: <20031223181659.GA9360@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
after i experienced some problems using eth1394 and trying to use a DVD
Burner afterwards i removed the ohci1394 after i brought eth1 down.

2.6.0 vanilla, P4 UP, 512MB Ram,

Here is the dmesg with the last lines of the bootup:

[...]
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 505976k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:05:3D:B1:E9, IRQ 20.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D[18]  MMIO=3D[d1005000-d10057ff]  Ma=
x Packet=3D[2048]
SCSI subsystem initialized
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0004830252004f0f]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0001b7000001515b]
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
md: could not lock hdd1.
md: could not import hdd1!
md: autostart unknown-block(0,5697) failed!
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: SONY      Model: DVD RW DRU-500A   Rev: 2.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem e088a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 00001000
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 00001400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 00001800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Disabled Privacy Extensions on device c0382440(lo)
hub 2-0:1.0: new USB device on port 1, assigned address 2
ip_tables: (C) 2000-2002 Netfilter core team
blk: queue dfd91000, I/O limit 4095Mb (mask 0xffffffff)
blk: queue dfd5e800, I/O limit 4095Mb (mask 0xffffffff)
proc_ide_write_settings(): parse error
proc_ide_write_settings(): parse error
proc_ide_write_settings(): parse error
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.0-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
cdrom: This disc doesn't have any tracks I recognize!
cdrom: This disc doesn't have any tracks I recognize!
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00000000004db3ac]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: sbp2: Reconnected to SBP-2 device
ieee1394: sbp2: Node 0-01:1023: Max speed [S400] - Max payload [2048]
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Error logging into SBP-2 device - login failed
ieee1394: sbp2: sbp2_reconnect_device failed!
eth0: TX underrun, threshold adjusted.
eth1394: $Rev: 1043 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (ohci1394)
smbfs: Unrecognized mount option noexec
IPv6: sending pkt_too_big to self

<- at this point i tried "rmmod ohci1394"

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c012aeca>] kill_proc_info+0x63/0x65
 [<e0893bc8>] nodemgr_remove_host+0x4f/0x90 [ieee1394]
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c012fce4>] queue_work+0x88/0x9b
 [<c012fc51>] call_usermodehelper+0xc4/0xcf
 [<c012fb28>] __call_usermodehelper+0x0/0x65
 [<e0892e89>] nodemgr_hotplug+0x1ce/0x205 [ieee1394]
 [<c01b79a6>] kset_hotplug+0x229/0x28d
 [<c01b7db3>] kobject_del+0x69/0x6b
 [<c022ae67>] device_del+0x70/0x9b
 [<c022aea5>] device_unregister+0x13/0x23
 [<e0891bb1>] nodemgr_remove_node_uds+0x20/0x2e [ieee1394]
 [<e0891bd5>] nodemgr_remove_ne+0x16/0x6f [ieee1394]
 [<e0891c4f>] nodemgr_remove_host_dev+0x21/0x80 [ieee1394]
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c012fce4>] queue_work+0x88/0x9b
 [<c012fc51>] call_usermodehelper+0xc4/0xcf
 [<c012fb28>] __call_usermodehelper+0x0/0x65
 [<c01b9f51>] vsprintf+0x27/0x2b
 [<c01b9f74>] sprintf+0x1f/0x23
 [<c01b79a6>] kset_hotplug+0x229/0x28d
 [<c01b7db3>] kobject_del+0x69/0x6b
 [<c022c7e4>] class_device_del+0x88/0xae
 [<c022c81d>] class_device_unregister+0x13/0x23
 [<e08bcf68>] scsi_remove_host+0x43/0x53 [scsi_mod]
 [<e08a37d7>] sbp2_remove_host+0x2c/0x47 [sbp2]
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<e08bd0e4>] scsi_host_dev_release+0x76/0x7f [scsi_mod]
 [<c016a432>] dput+0x22/0x212
 [<c022aad4>] device_release+0x20/0x78
 [<c022ae67>] device_del+0x70/0x9b
 [<c01b7ebe>] kobject_cleanup+0x98/0x9a
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c0130da4>] synchronize_kernel+0x31/0x39
 [<c0130d6a>] wakeme_after_rcu+0x0/0x9
 [<c02686a6>] unregister_netdevice+0xc9/0x1f6
 [<e0894247>] hpsb_iso_shutdown+0x1c/0x64 [ieee1394]
 [<c023ece8>] unregister_netdev+0x18/0x24
 [<e0998845>] ether1394_remove_host+0x46/0x59 [eth1394]
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c012fce4>] queue_work+0x88/0x9b
 [<c012fc51>] call_usermodehelper+0xc4/0xcf
 [<c012fb28>] __call_usermodehelper+0x0/0x65
 [<c01b9f26>] snprintf+0x27/0x2b
 [<c01b79a6>] kset_hotplug+0x229/0x28d
 [<c01724b3>] simple_unlink+0x16/0x1c
 [<c01b7db3>] kobject_del+0x69/0x6b
 [<c022c7e4>] class_device_del+0x88/0xae
 [<c02684a8>] netdev_run_todo+0xf9/0x1ef
 [<e0998845>] ether1394_remove_host+0x46/0x59 [eth1394]
 [<e088f8bc>] highlevel_remove_host+0x6d/0x7d [ieee1394]
 [<e086982b>] ohci1394_pci_remove+0x3e/0x22a [ohci1394]
 [<c01c4c13>] pci_device_remove+0x3b/0x3d
 [<c022bc6e>] device_release_driver+0x64/0x66
 [<c022bc90>] driver_detach+0x20/0x2e
 [<c022bead>] bus_remove_driver+0x3d/0x75
 [<c022c254>] driver_unregister+0x13/0x28
 [<c01c4db4>] pci_unregister_driver+0x16/0x26
 [<e0869cab>] ohci1394_cleanup+0xf/0x13 [ohci1394]
 [<c0134e31>] sys_delete_module+0x135/0x150
 [<c014a04f>] sys_munmap+0x44/0x64
 [<c01091fb>] syscall_call+0x7/0xb

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D[18]  MMIO=3D[d1005000-d10057ff]  Ma=
x Packet=3D[2048]
bad: scheduling while atomic!
Call Trace:
 [<c011e286>] schedule+0x571/0x576
 [<c011d53d>] try_to_wake_up+0xad/0x165
 [<c011e56a>] wait_for_completion+0x76/0xca
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c011e2ce>] default_wake_function+0x0/0x12
 [<c012fce4>] queue_work+0x88/0x9b
 [<c012fc51>] call_usermodehelper+0xc4/0xcf
 [<c012fb28>] __call_usermodehelper+0x0/0x65
 [<c01b9f26>] snprintf+0x27/0x2b
 [<c01b79a6>] kset_hotplug+0x229/0x28d
 [<c01b7ba3>] kobject_add+0xec/0x11a
 [<c022c692>] class_device_add+0x69/0x110
 [<c022c61c>] class_device_initialize+0x1d/0x2a
 [<c026b104>] netdev_register_sysfs+0x46/0xfc
 [<c0268585>] netdev_run_todo+0x1d6/0x1ef
 [<c0268226>] register_netdevice+0x180/0x205
 [<c023ecaa>] register_netdev+0x5e/0x84
 [<e09986ca>] ether1394_add_host+0x9b/0x1d0 [eth1394]
 [<e0865792>] ohci_initialize+0x211/0x218 [ohci1394]
 [<e088f84b>] highlevel_add_host+0x6a/0x6e [ieee1394]
 [<e088eee6>] hpsb_add_host+0x59/0x81 [ieee1394]
 [<e086965e>] ohci1394_pci_probe+0x3f5/0x584 [ohci1394]
 [<e0867712>] ohci_irq_handler+0x0/0x7a4 [ohci1394]
 [<c01c4b2f>] pci_device_probe_static+0x52/0x63
 [<c01c4b7b>] __pci_device_probe+0x3b/0x4e
 [<c01c4bba>] pci_device_probe+0x2c/0x4a
 [<c022bace>] bus_match+0x3f/0x6a
 [<c022bbe0>] driver_attach+0x56/0x80
 [<c022be5e>] bus_add_driver+0x8b/0x9d
 [<c022c23d>] driver_register+0x2f/0x33
 [<c01c4d76>] pci_register_driver+0x5c/0x84
 [<e0877013>] ohci1394_init+0x13/0x3d [ohci1394]
 [<c0136702>] sys_init_module+0x117/0x228
 [<c01091fb>] syscall_call+0x7/0xb

eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (ohci1394)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0001b7000001515b]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0004830252004f0f]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[00000000004db3ac]
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-01:1023: Max speed [S400] - Max payload [2048]
  Vendor: SONY      Model: DVD RW DRU-500A   Rev: 2.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 4x/20x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 5
ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
ieee1394: sbp2: Error logging into SBP-2 device - login failed
ieee1394: sbp2: sbp2_reconnect_device failed!

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/6IabUaz2rXW+gJcRAiV6AKCvni+TiIGIhxltuxhN5EfByo1hNwCg0aWU
NrdOFgY7YzsV0BJftWUTyRg=
=wIWo
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
