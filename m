Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTHOOzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275470AbTHOOzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 10:55:38 -0400
Received: from math.ut.ee ([193.40.5.125]:38562 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267402AbTHOOy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 10:54:29 -0400
Date: Fri, 15 Aug 2003 17:49:45 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: PnPBIOS: Unknown tag '0x82'
Message-ID: <Pine.GSO.4.44.0308151743270.3973-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test3+bk (at about bk3 state) gives the following warning for one
pnpbios device:

...
PM: Adding info for pnp:00:09
PnPBIOS: Unknown tag '0x82', length '18'.
PM: Adding info for pnp:00:0a
...

Full dmesg is below. It's a Celeron 900 with Intel D815EEA2 mainboard.

Excerpt from lspnp -vvv (but this probably does not report what the
kernel does not understand):

09 PNP0c02 Motherboard resources
    flags: [no disable] [no config] [static]
    allocated resources:
        io 0x04d0-0x04d1 [16-bit decode]
        io 0x0cf8-0x0cff [16-bit decode]
        io 0x0010-0x001f [16-bit decode]
        io 0x0022-0x002d [16-bit decode]
        io 0x0030-0x003f [16-bit decode]
        io 0x0050-0x0052 [16-bit decode]
        io 0x0072-0x0077 [16-bit decode]
        io 0x0091-0x0093 [16-bit decode]
        io 0x00a2-0x00be [16-bit decode]
        io 0x0400-0x047f [16-bit decode]
        io 0x0540-0x054f [16-bit decode]
        io 0x0500-0x053f [16-bit decode]
        io 0x0884-0x0885 [16-bit decode]
        io disabled [16-bit decode]
        io disabled [16-bit decode]
        io disabled [16-bit decode]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
        mem disabled [8/16 bit] [r/o] [cacheable] [shadow]

0a INT0800 memory controller: flash
    flags: [no disable] [no config] [static]
    allocated resources:
        mem 0xffb00000-0xffbfffff [32 bit] [r/o]
    possible resources:
    compatible devices:
        identifier 'Intel Firmware Hub'


Full dmesg:

Linux version 2.6.0-test3 (mroos@rhn) (gcc version 3.3.1 (Debian)) #5 Fri Aug 15 14:51:01 EEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fec0000 (usable)
 BIOS-e820: 000000000fec0000 - 000000000fef8000 (ACPI data)
 BIOS-e820: 000000000fef8000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
254MB LOWMEM available.
On node 0 totalpages: 65216
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61120 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000ff980
ACPI: RSDT (v001 D815EA D815EEA2 0x20010404 MSFT 0x00001011) @ 0x0fef0000
ACPI: FADT (v001 D815EA EA81510A 0x20010404 MSFT 0x00001011) @ 0x0fef1000
ACPI: DSDT (v001 D815E2 EA81520A 0x00000021 MSFT 0x0100000b) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux2.6 ro root=304
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 897.444 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1773.56 BogoMIPS
Memory: 254140k/260864k available (2140k kernel code, 6024k reserved, 802k data, 160k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 896.0926 MHz.
..... host bus clock speed is 99.0658 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Transparent bridge - 0000:00:1e.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.4
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:01:08.0
PM: Adding info for pci:0000:01:09.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f2910
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x21ba, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PnPBIOS: Unknown tag '0x82', length '18'.
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:11
PM: Adding info for pnp:00:12
PM: Adding info for pnp:00:13
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU1] (supports C1)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11a
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
PM: Adding info for No Bus:ide0
hdb: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
PM: Adding info for ide:0.1
hdc: CDU5211, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
hdb: max request size: 128KiB
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Frame Diverter 0.46
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 497972k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

divert: allocating divert_blk for eth0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

SCSI subsystem initialized
PM: Adding info for No Bus:ide-scsi
NTFS driver 2.1.4 [Flags: R/O MODULE].
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci-hcd 0000:00:1f.2: irq 10, io base 0000ef40
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci-hcd 0000:00:1f.4: irq 5, io base 0000ef80
uhci-hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
ip_tables: (C) 2000-2002 Netfilter core team
hub 2-0:0: new USB device on port 2, assigned address 2
PM: Adding info for usb:2-2
PM: Adding info for usb:2-2:0
e100: eth0 NIC Link is Up 100 Mbps Full duplex
drivers/usb/core/usb.c: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1f.4-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 41143
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c03a7f80(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0

-- 
Meelis Roos (mroos@linux.ee)

