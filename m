Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVDJSMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVDJSMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVDJSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:12:06 -0400
Received: from smtpa2.aruba.it ([62.149.128.207]:58052 "HELO smtpa2.aruba.it")
	by vger.kernel.org with SMTP id S261545AbVDJSIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:08:06 -0400
Message-ID: <42596B7F.4000808@teknolab.net>
Date: Sun, 10 Apr 2005 20:07:59 +0200
From: Marco Gaddoni <marco.gaddoni@teknolab.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: swsuspend scheduling while atomic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

i am playing a little with swsuspend and getting
"scheduling while atomic: bash/0x00000001/5244"
messages while the system is resuming.
Apparently  the  resume  work  correctly.
Do i have to fear for my data?

Some data about my system:

kernel 2.6.11.5

modules
Module                  Size  Used by
it87                   26204  0
eeprom                  7632  0
i2c_sensor              3520  2 it87,eeprom
i2c_isa                 1984  0
i2c_viapro              7888  0
tuner                  22500  0
tvaudio                23588  0
bttv                  155408  0
video_buf              22084  1 bttv
firmware_class         10688  1 bttv
i2c_algo_bit            9480  1 bttv
v4l2_common             5824  1 bttv
btcx_risc               4936  1 bttv
tveeprom               13144  1 bttv
i2c_core               23184  10 
it87,eeprom,i2c_sensor,i2c_isa,i2c_viapro,tuner,tvaudio,bttv,i2c_algo_bit,tveeprom
videodev               10112  1 bttv

pci:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Multimedia audio controller: C-Media Electronics Inc CM8738 
(rev 10)
0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 02)
0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 02)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]0000:00:11.5 Multimedia audio controller: VIA 
Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 78)
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0326 (rev a1)

and finally the messages:

/visor.c: USB HandSpring Visor / Palm OS driver v2.1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 
09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0x9000, irq 17
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI wakeup devices:
SLPB PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0 MC97 UAR1 UAR2 ECP1
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
kjournald starting.  Commit interval 5 seconds
Adding 1082584k swap on /dev/hdd4.  Priority:-1 extents:1
Adding 297160k swap on /dev/hdb1.  Priority:-2 extents:1
EXT3 FS on hdd1, internal journal
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 19, latency: 32, mmio: 0xea000000
bttv0: detected: Terratec TValue (Philips PAL B/G) [card=33], PCI 
subsystem ID is 153b:1117
bttv0: using: Terratec TerraTValue Version Bt878 [card=33,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffefff [init]
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
(PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 
#0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
it87: Found IT8705F chip at 0x290, revision 2
it87 2-0290: detected broken BIOS defaults, disabling pwm 
interface<6>kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
Stopping tasks: ===========================================|
Freeing memory... done (18809 pages freed)
swsusp: Need to copy 9791 pages
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
APIC error on CPU0: 00(00)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 .<3>scheduling while atomic: 
bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c011a5b5>] call_console_drivers+0x65/0x140
 [<c0123775>] __mod_timer+0x1e5/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<e0921233>] set_pll+0x63/0x1a0 [bttv]
 [<e09213b7>] bt848A_set_timing+0x47/0x140 [bttv]
 [<e09219c7>] set_tvnorm+0x87/0xb0 [bttv]
 [<e0921aa4>] set_input+0xb4/0xf0 [bttv]
 [<e0921d57>] bttv_reinit_bt848+0x77/0xb0 [bttv]
 [<e0927aca>] bttv_resume+0x4a/0x170 [bttv]
 [<c02300a7>] kobject_get+0x17/0x20
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
.<3>scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c011a5b5>] call_console_drivers+0x65/0x140
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<e0921233>] set_pll+0x63/0x1a0 [bttv]
 [<e09213b7>] bt848A_set_timing+0x47/0x140 [bttv]
 [<e09219c7>] set_tvnorm+0x87/0xb0 [bttv]
 [<e0921aa4>] set_input+0xb4/0xf0 [bttv]
 [<e0921d57>] bttv_reinit_bt848+0x77/0xb0 [bttv]
 [<e0927aca>] bttv_resume+0x4a/0x170 [bttv]
 [<c02300a7>] kobject_get+0x17/0x20
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
 ok
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<c023e550>] pci_set_power_state+0x190/0x1d0
 [<c031b2f5>] usb_hcd_pci_resume+0x115/0x120
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<c023e550>] pci_set_power_state+0x190/0x1d0
 [<c031b2f5>] usb_hcd_pci_resume+0x115/0x120
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<c023e550>] pci_set_power_state+0x190/0x1d0
 [<c031b2f5>] usb_hcd_pci_resume+0x115/0x120
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<c023e550>] pci_set_power_state+0x190/0x1d0
 [<c031b2f5>] usb_hcd_pci_resume+0x115/0x120
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c01236ce>] __mod_timer+0x13e/0x1f0
 [<c0431b8d>] schedule_timeout+0x5d/0xb0
 [<c01241e0>] process_timeout+0x0/0x10
 [<c01245cf>] msleep+0x2f/0x40
 [<c023e550>] pci_set_power_state+0x190/0x1d0
 [<c031b2f5>] usb_hcd_pci_resume+0x115/0x120
 [<c02408fc>] pci_device_resume+0x2c/0x40
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
ehci_hcd 0000:00:10.4: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c02e8524>] do_rw_taskfile+0x254/0x2b0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c04312e6>] wait_for_completion+0x86/0xf0
 [<c0116910>] default_wake_function+0x0/0x20
 [<c0116910>] default_wake_function+0x0/0x20
 [<c02a7e29>] __elv_add_request+0x99/0xd0
 [<c02e374f>] ide_do_drive_cmd+0x11f/0x170
 [<c02e04c3>] generic_ide_resume+0x93/0xc0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c02300a7>] kobject_get+0x17/0x20
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c02e8524>] do_rw_taskfile+0x254/0x2b0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c04312e6>] wait_for_completion+0x86/0xf0
 [<c0116910>] default_wake_function+0x0/0x20
 [<c0116910>] default_wake_function+0x0/0x20
 [<c02a7e29>] __elv_add_request+0x99/0xd0
 [<c02e374f>] ide_do_drive_cmd+0x11f/0x170
 [<c02e04c3>] generic_ide_resume+0x93/0xc0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c02300a7>] kobject_get+0x17/0x20
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c02e8524>] do_rw_taskfile+0x254/0x2b0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c04312e6>] wait_for_completion+0x86/0xf0
 [<c0116910>] default_wake_function+0x0/0x20
 [<c0116910>] default_wake_function+0x0/0x20
 [<c02a7e29>] __elv_add_request+0x99/0xd0
 [<c02e374f>] ide_do_drive_cmd+0x11f/0x170
 [<c02e04c3>] generic_ide_resume+0x93/0xc0
 [<c02e8710>] task_no_data_intr+0x0/0xb0
 [<c02300a7>] kobject_get+0x17/0x20
 [<c02a7498>] dpm_resume+0xa8/0xb0
 [<c02a74b1>] device_resume+0x11/0x20
 [<c0137778>] finish+0x8/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
Restarting tasks...<3>scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c0115e4e>] wake_up_process+0x1e/0x20
 [<c0136310>] thaw_processes+0xb0/0xf0
 [<c0137786>] finish+0x16/0x40
 [<c013789e>] pm_suspend_disk+0x3e/0x80
 [<c0135e75>] enter_state+0x75/0x80
 [<c013e59f>] __alloc_pages+0x18f/0x410
 [<c0135fc2>] state_store+0xa2/0xb5
 [<c0194c65>] subsys_attr_store+0x35/0x40
 [<c0194f0e>] flush_write_buffer+0x3e/0x50
 [<c0194f74>] sysfs_write_file+0x54/0x80
 [<c015a4fc>] vfs_write+0x14c/0x160
 [<c015a5e1>] sys_write+0x51/0x80
 [<c010330f>] syscall_call+0x7/0xb
usb 3-1: USB disconnect, address 2
 done
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c015a5e1>] sys_write+0x51/0x80
 [<c0103336>] work_resched+0x5/0x16
scheduling while atomic: bash/0x00000001/4686
 [<c04310ef>] schedule+0x44f/0x500
 [<c011751a>] sys_sched_yield+0x5a/0x80
 [<c0167012>] coredump_wait+0x32/0xa0
 [<c016716c>] do_coredump+0xec/0x226
 [<c0115e6a>] wake_up_state+0x1a/0x20
 [<c012515e>] signal_wake_up+0x1e/0x20
 [<c01256f9>] specific_send_sig_info+0xc9/0xd0
 [<c01246cc>] free_uid+0x1c/0x80
 [<c0124ff5>] __dequeue_signal+0x105/0x180
 [<c01250a5>] dequeue_signal+0x35/0xd0
 [<c012709f>] get_signal_to_deliver+0x2ef/0x340
 [<c01030dd>] do_signal+0x9d/0x170
 [<c0103fe5>] show_trace+0x35/0x90
 [<c0103fe5>] show_trace+0x35/0x90
 [<c0103336>] work_resched+0x5/0x16
 [<c0116140>] finish_task_switch+0x30/0x90
 [<c0430f64>] schedule+0x2c4/0x500
 [<c01148b0>] do_page_fault+0x0/0x5e3
 [<c01031e7>] do_notify_resume+0x37/0x3c
 [<c010335a>] work_notifysig+0x13/0x15
note: bash[4686] exited with preempt_count 1
usb 3-1: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.11 Mouse [Microsoft Microsoft USB Wireless Mouse] on 
usb-0000:00:10.1-1
...

Please cc me in your replys as i am not subscibed to linux-kernel.

Ciao, Marco.

P.S. The mailing list for swsuspend in the MANTAINERS file seem to be 
dead 2 years ago...



