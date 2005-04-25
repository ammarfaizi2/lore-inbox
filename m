Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVDYHmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVDYHmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVDYHmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:42:46 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:3012 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S262554AbVDYHmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:42:03 -0400
Message-ID: <426C9F44.8060202@molgaard.org>
Date: Mon, 25 Apr 2005 09:41:56 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PicoPower on 2.6
Content-Type: multipart/mixed;
 boundary="------------050702070607030004060903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050702070607030004060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

The patch I just submitted works for 2.4, but when applied to 
linux-2.6.11.7/arch/i386/pci/irq.c, it doesn't. Can anyone give suggestions?

Output of dmesg below.

Best regards,

Sune Mølgaard

--------------050702070607030004060903
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.11.7 (root@jekaterina.molgaard.org) (gcc version 3.3.2) #3 Tue Apr 19 15:02:17 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
48MB LOWMEM available.
On node 0 totalpages: 12288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 8192 pages, LIFO batch:2
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: Unable to locate RSDP
Allocating PCI resources starting at 03000000 (gap: 03000000:fd000000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.11.7 ro root=301
Initializing CPU#0
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 150.429 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 45412k/49152k available (1753k kernel code, 3284k reserved, 777k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 288.76 BogoMIPS (lpj=144384)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 000001bf 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 000001bf 00000000 00000000 00000000 00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After all inits, caps: 000001bf 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb83e, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PicoPower [1066/8002] at 0000:00:06.0
PCI: IRQ 0 for device 0000:00:07.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 0000:00:09.1 doesn't match PIRQ mask - try pci=usepirqmask
pnp: 00:01: ioport range 0x180-0x180 has been reserved
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
vesafb: framebuffer at 0x30000000, mapped to 0xc3880000, using 1088k, total 1088k
vesafb: mode is 800x600x16, linelength=1600, pages=0
vesafb: protected mode interface info at c000:7da0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:5:5, shift=0:10:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD643: IDE controller at PCI slot 0000:00:08.0
CMD643: chipset revision 0
CMD643: not 100% native mode: will probe irqs later
CMD643: simplex device: DMA forced
    ide0: BM-DMA at 0xfe00-0xfe07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfe08-0xfe0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IBM-DMCA-21440, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-ROM CDR_N110D, ATAPI CD/DVD-ROM drive
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0x04 { AbortedCommand }
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 2818368 sectors (1443 MB) w/96KiB Cache, CHS=2796/16/63
hda: cache flushes not supported
 hda: hda1 hda2
hdc: ATAPI 10X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Logitech Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
kjournald starting.  Commit interval 5 seconds
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda2
EXT3 FS on hda1, internal journal
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0x04 { AbortedCommand }
PCI: IRQ 0 for device 0000:00:09.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: setting IRQ 11 as level-triggered
PCI: Assigned IRQ 11 for device 0000:00:09.0
Yenta: CardBus bridge found at 0000:00:09.0 [0000:0000]
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
PCI: IRQ 0 for device 0000:00:09.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 11 for device 0000:00:09.1
Yenta: CardBus bridge found at 0000:00:09.1 [0000:0000]
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000020
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:05:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 0000:05:00.0 to 64
eth0: RealTek RTL8139 at 0xc382e000, 00:02:44:5a:de:1c, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.2
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a NS16550A

--------------050702070607030004060903--
