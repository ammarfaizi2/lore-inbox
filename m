Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275339AbTHMTiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHMTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:38:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24836 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275339AbTHMTik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:38:40 -0400
Subject: 2.6.0-test3-mm2: Badness in class_dev_release at
	drivers/base/class.c
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-RCQgypCaM/3t7yEevAbW"
Message-Id: <1060803513.1221.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 13 Aug 2003 21:38:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RCQgypCaM/3t7yEevAbW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

I've seen the following oops when I was unplugging my HP Deskjet 970Cxi
USB printer from its USB socket:

usb 1-1: USB disconnect, address 2
Device class 'lp0' does not have a release() function, it is broken and
must be fixed.
Badness in class_dev_release at drivers/base/class.c:201

The complete "dmesg" output is attached to this message.
Thanks!

--=-RCQgypCaM/3t7yEevAbW
Content-Disposition: attachment; filename=dmesg.compaq
Content-Type: text/plain; name=dmesg.compaq; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-test3-mm2 (root@fab.felipe-alfaro.com) (gcc version 3.3 20030715 (Red Hat Linux 3.3-14)) #1 Wed Aug 13 21:11:07 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57344 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6dc0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0eefb63b
ACPI: FADT (v001 COMPAQ  EAGLES  01540.00000) @ 0x0eefeeb6
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0eefef2a
ACPI: DSDT (v001 COMAPQ   EAGLES 01540.00000) @ 0x00000000
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known ACPI BIOS problem.
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda4
current: c02c99c0
current->thread_info: c0330000
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 996.620 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1961.98 BogoMIPS
Memory: 239980k/245760k available (1594k kernel code, 4968k reserved, 638k data, 116k init, 0k highmem)
zapping low mappings.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd7ae, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 6)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 2048 Unix98 ptys configured
Machine check exception polling timer started.
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f6c30
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 21 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:8 (@c00f6cb2)
powernow:  cpuid: 0x762	fsb: 100	maxFID: 0xe	startvid: 0xc
powernow:    FID: 0x4 (5.0x [500MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x8 (7.0x [700MHz])	VID: 0xe (1.300V)
powernow:    FID: 0xe (10.0x [1000MHz])	VID: 0xc (1.400V)

powernow: Minimum speed 500 MHz. Maximum speed 1000 MHz.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Initializing Cryptographic API
Applying VIA southbridge workaround.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT133/KM133/TwisterK chipset
agpgart: Maximum main memory to use for agp memory: 190M
agpgart: AGP aperture is 64M @ 0xec000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 42) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(100)
hda: TCQ not supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Yenta: CardBus bridge found at 0000:00:0a.0 [0e11:b103]
Yenta IRQ list 0008, PCI irq11
Socket status: 30000006
mice: PS/2 mouse device common for all mice
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firmware: 5.6
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding 131064k swap on /swap.  Priority:-1 extents:42
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xcf83c000, 00:08:02:02:1c:31, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 9, io base 00001800
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1004
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 3
input: Logitech N48 on usb-0000:00:07.2-2
usb 1-1: USB disconnect, address 2
Device class 'lp0' does not have a release() function, it is broken and must be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [<c019eb63>] kobject_cleanup+0x83/0x90
 [<c01ebd43>] class_device_unregister+0x13/0x30
 [<cf86fc63>] usb_deregister_dev+0x73/0xd0 [usbcore]
 [<cf86e544>] usb_disable_endpoint+0x74/0x80 [usbcore]
 [<cf854523>] usblp_disconnect+0x23/0xd5 [usblp]
 [<cf868135>] usb_unbind_interface+0x75/0x80 [usbcore]
 [<c01eafd2>] device_release_driver+0x62/0x70
 [<c01eb11e>] bus_remove_device+0x5e/0xb0
 [<c01e98ed>] device_del+0x5d/0xa0
 [<c01e9943>] device_unregister+0x13/0x30
 [<cf868c33>] usb_disconnect+0xe3/0x110 [usbcore]
 [<cf86b3e8>] hub_port_connect_change+0x328/0x330 [usbcore]
 [<cf86ac8d>] hub_port_status+0x3d/0xb0 [usbcore]
 [<cf86b6c0>] hub_events+0x2d0/0x350 [usbcore]
 [<cf86b76d>] hub_thread+0x2d/0xf0 [usbcore]
 [<c028e6ca>] ret_from_fork+0x6/0x14
 [<c011de00>] default_wake_function+0x0/0x30
 [<cf86b740>] hub_thread+0x0/0xf0 [usbcore]
 [<c0109239>] kernel_thread_helper+0x5/0xc

kobject 'class_obj' does not have a release() function, it is broken and must be fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [<c019eb3f>] kobject_cleanup+0x5f/0x90
 [<cf86fc63>] usb_deregister_dev+0x73/0xd0 [usbcore]
 [<cf86e544>] usb_disable_endpoint+0x74/0x80 [usbcore]
 [<cf854523>] usblp_disconnect+0x23/0xd5 [usblp]
 [<cf868135>] usb_unbind_interface+0x75/0x80 [usbcore]
 [<c01eafd2>] device_release_driver+0x62/0x70
 [<c01eb11e>] bus_remove_device+0x5e/0xb0
 [<c01e98ed>] device_del+0x5d/0xa0
 [<c01e9943>] device_unregister+0x13/0x30
 [<cf868c33>] usb_disconnect+0xe3/0x110 [usbcore]
 [<cf86b3e8>] hub_port_connect_change+0x328/0x330 [usbcore]
 [<cf86ac8d>] hub_port_status+0x3d/0xb0 [usbcore]
 [<cf86b6c0>] hub_events+0x2d0/0x350 [usbcore]
 [<cf86b76d>] hub_thread+0x2d/0xf0 [usbcore]
 [<c028e6ca>] ret_from_fork+0x6/0x14
 [<c011de00>] default_wake_function+0x0/0x30
 [<cf86b740>] hub_thread+0x0/0xf0 [usbcore]
 [<c0109239>] kernel_thread_helper+0x5/0xc

drivers/usb/class/usblp.c: usblp0: removed
updfstab: numerical sysctl 1 23 is obsolete.
inserting floppy driver for 2.6.0-test3-mm2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
updfstab: numerical sysctl 1 49 is obsolete.
updfstab: numerical sysctl 1 49 is obsolete.
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1004

--=-RCQgypCaM/3t7yEevAbW--

