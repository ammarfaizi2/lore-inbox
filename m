Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJGDax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 23:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTJGDax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 23:30:53 -0400
Received: from digitalflex.digitalflex.net ([166.70.78.147]:57232 "EHLO
	digitalflex.digitalflex.net") by vger.kernel.org with ESMTP
	id S261782AbTJGDap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 23:30:45 -0400
Message-ID: <3F823362.9070805@digitalflex.net>
Date: Mon, 06 Oct 2003 21:30:42 -0600
From: Anthony Best <abest@digitalflex.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Yenta CardBus problem. 2.6.0-test6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Errors on boot.

Also system locks up when a PCMCIA card is removed.



[abest@lizard abest]$ dmesg
Linux version 2.6.0-test6 (root@lizard.localdomain) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #6 Mon Sep 29 18:55:01 MDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Sony Vaio laptop detected.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7700
ACPI: RSDT (v001 SONY   K5       0x06040000  LTP 0x00000000) @ 0x1fef9d68
ACPI: FADT (v001 SONY   K5       0x06040000 PTL_ 0x000f4240) @ 0x1fefee2b
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1fefee9f
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1fefeec7
ACPI: DSDT (v001  SONY  K5       0x06040000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ hdc=ide-scsi pci=usepirqmask
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1400.257 MHz processor.
Console: colour VGA+ 80x25
Memory: 515148k/524288k available (1732k kernel code, 8332k reserved, 
711k data, 232k init, 0k highmem)
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP 1600+   stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
divert: not allocating divert_blk for non-ethernet device lo
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23DA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA730 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(100)
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 194k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 232k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1PCI: Found IRQ 9 for device 0000:00:07.2
PCI: Sharing IRQ 9 with 0000:00:07.3
PCI: Sharing IRQ 9 with 0000:00:0e.0
uhci-hcd 0000:00:07.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:07.2 to 64
uhci-hcd 0000:00:07.2: irq 9, io base 00001c00
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:07.3
PCI: Sharing IRQ 9 with 0000:00:07.2
PCI: Sharing IRQ 9 with 0000:00:0e.0
uhci-hcd 0000:00:07.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:07.3 to 64
uhci-hcd 0000:00:07.3: irq 9, io base 00001c20
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda2, internal journal
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA730 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 9 for device 0000:00:0e.0
PCI: Sharing IRQ 9 with 0000:00:07.2
PCI: Sharing IRQ 9 with 0000:00:07.3
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e8004000-e80047ff]  Max 
Packet=[2048]
ip_tables: (C) 2000-2002 Netfilter core team
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301308bbc]
8139too Fast Ethernet driver 0.9.26
PCI: Assigned IRQ 10 for device 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:07.5
PCI: Sharing IRQ 10 with 0000:00:07.6
PCI: Sharing IRQ 10 with 0000:00:0a.1
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xe0897800, 08:00:46:6f:42:6b, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link down
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
irq 5: nobody cared!
Call Trace:
 [<c010c7da>] __report_bad_irq+0x2a/0x90
 [<c010c8d0>] note_interrupt+0x70/0xa0
 [<c010cb79>] do_IRQ+0x139/0x170
 [<c010af24>] common_interrupt+0x18/0x20
 [<c0121740>] do_softirq+0x40/0xa0
 [<c010cb56>] do_IRQ+0x116/0x170
 [<c010af24>] common_interrupt+0x18/0x20
 [<c010d11e>] setup_irq+0x9e/0xf0
 [<c023afc0>] pcibios_test_irq_handler+0x0/0x10
 [<c010cc56>] request_irq+0xa6/0xe0
 [<c023b385>] pcibios_lookup_irq+0x3b5/0x460
 [<c023afc0>] pcibios_test_irq_handler+0x0/0x10
 [<c023b4be>] pirq_enable_irq+0x7e/0x100
 [<c023ba48>] pcibios_enable_device+0x28/0x60
 [<c01c40ab>] pci_enable_device_bars+0x2b/0x40
 [<c01c40d7>] pci_enable_device+0x17/0x20
 [<e091ec76>] yenta_probe+0x76/0x240 [yenta_socket]
 [<c016aaa2>] dput+0x22/0x220
 [<c01c6332>] pci_device_probe_static+0x52/0x70
 [<c01c638c>] __pci_device_probe+0x3c/0x50
 [<c01c63cc>] pci_device_probe+0x2c/0x50
 [<c01eec6f>] bus_match+0x3f/0x70
 [<c01eedbf>] driver_attach+0x6f/0xa0
 [<c01ef05d>] bus_add_driver+0x8d/0xa0
 [<c01ef4df>] driver_register+0x2f/0x40
 [<c01c65bf>] pci_register_driver+0x5f/0x90
 [<e089000f>] yenta_socket_init+0xf/0x13 [yenta_socket]
 [<c01345fc>] sys_init_module+0x12c/0x250
 [<c010ad65>] sysenter_past_esp+0x52/0x71
 
handlers:
[<c023afc0>] (pcibios_test_irq_handler+0x0/0x10)
Disabling IRQ #5
PCI: Found IRQ 5 for device 0000:00:0a.0
Yenta: CardBus bridge found at 0000:00:0a.0 [104d:80f6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
irq 5: nobody cared!
Call Trace:
 [<c010c7da>] __report_bad_irq+0x2a/0x90
 [<c010c8d0>] note_interrupt+0x70/0xa0
 [<c010cb79>] do_IRQ+0x139/0x170
 [<c010af24>] common_interrupt+0x18/0x20
 [<c0121740>] do_softirq+0x40/0xa0
 [<c010cb56>] do_IRQ+0x116/0x170
 [<c010af24>] common_interrupt+0x18/0x20
 [<c010d11e>] setup_irq+0x9e/0xf0
 [<e091d8c0>] yenta_interrupt+0x0/0x40 [yenta_socket]
 [<c010cc56>] request_irq+0xa6/0xe0
 [<e091ed86>] yenta_probe+0x186/0x240 [yenta_socket]
 [<e091d8c0>] yenta_interrupt+0x0/0x40 [yenta_socket]
 [<c01c6332>] pci_device_probe_static+0x52/0x70
 [<c01c638c>] __pci_device_probe+0x3c/0x50
 [<c01c63cc>] pci_device_probe+0x2c/0x50
 [<c01eec6f>] bus_match+0x3f/0x70
 [<c01eedbf>] driver_attach+0x6f/0xa0
 [<c01ef05d>] bus_add_driver+0x8d/0xa0
 [<c01ef4df>] driver_register+0x2f/0x40
 [<c01c65bf>] pci_register_driver+0x5f/0x90
 [<e089000f>] yenta_socket_init+0xf/0x13 [yenta_socket]
 [<c01345fc>] sys_init_module+0x12c/0x250
 [<c010ad65>] sysenter_past_esp+0x52/0x71
 
handlers:
[<e091d8c0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #5
Yenta: ISA IRQ list 0808, PCI irq5
Socket status: 30000059
PCI: Assigned IRQ 5 for device 0000:00:0a.1
PCI: Sharing IRQ 5 with 0000:00:07.5
PCI: Sharing IRQ 5 with 0000:00:07.6
PCI: Sharing IRQ 5 with 0000:00:10.0
Yenta: CardBus bridge found at 0000:00:0a.1 [104d:80f6]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0808, PCI irq5
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x388-0x38f 
0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
divert: allocating divert_blk for eth1
eth1: Station identity 001f:0001:0008:000a
eth1: Looks like a Lucent/Agere firmware version 8.10
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:90:B1:71
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Via 686a/8233/8235 audio driver 1.9.1-ac3-2.5
PCI: Found IRQ 5 for device 0000:00:07.5
PCI: Sharing IRQ 5 with 0000:00:07.6
PCI: Sharing IRQ 5 with 0000:00:0a.1
PCI: Sharing IRQ 5 with 0000:00:10.0
PCI: Setting latency timer of device 0000:00:07.5 to 64
ac97_codec: AC97 Audio codec, id: ADS72 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1000, IRQ 5
eth0: link down
eth1: New link status: Connected (0001)
eth1: no IPv6 routers present




-- 
Anthony Best <abest@digitalflex.net>
Consultant, DigitalFlex LLC
801-541-5013


