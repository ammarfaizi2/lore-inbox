Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265009AbSKANDa>; Fri, 1 Nov 2002 08:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbSKANDa>; Fri, 1 Nov 2002 08:03:30 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1664 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265009AbSKANDQ>;
	Fri, 1 Nov 2002 08:03:16 -0500
Date: Fri, 1 Nov 2002 07:09:37 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
In-Reply-To: <20021101120618.GJ8428@suse.de>
Message-ID: <Pine.LNX.4.44.0211010702360.935-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Jens Axboe wrote:

> > Building ide-cd monolithic (or modular and attempting a modprobe) gives me 
> > endless streams of the following error messages (hand-copied from 
> > console):
> > 
> > hdc: irq timeout: status=0x90 {Busy}
> > hdc: irq timeout: error=0x01IllegalLengthIndication
> > hdc: drive not ready for command
> > hdc: ATAPI reset timed-out, status=0x80
> > ide1: reset: success
> 
> Interesting. Please send me a detailed list of your hardware, boot
> messages should suffice. Does 2.5.43 work correctly?

I'll have to download a 2.5.43 tarball and try later.  

Following is dmesg 
output from boot.  While looking in proc for additional info I got a NULL 
pointer dereference reading /proc/hdc/identity which I will submit as a 
separate bug report later when I can reproduce and copy down the data.

Linux version 2.5.44-tm4 (tmolina@dad.molina) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #1 Thu Oct 24 05:59:04 CDT 2002
Video mode to be used for restore is 318
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98284
  DMA zone: 4096 pages
  Normal zone: 94188 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda1 vga=792
Initializing CPU#0
Detected 1343.397 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2637.82 BogoMIPS
Memory: 386064k/393136k available (1270k kernel code, 6684k reserved, 1067k data, 100k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
Registering system device pic0
Registering system device rtc0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
Applying VIA southbridge workaround.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
vesafb: framebuffer at 0xe4000000, mapped to 0xd8800000, size 8192k
vesafb: mode is 1024x768x24, linelength=3072, pages=2
vesafb: protected mode interface info at c000:4785
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: unsupported bridge
agpgart: no supported devices found.
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

PCI: Found IRQ 3 for device 00:0d.0
PCI: Sharing IRQ 3 with 00:04.2
PCI: Sharing IRQ 3 with 00:04.3
e100: selftest OK.
e100: eth0: Intel(R) PRO/100+ Management Adapter
  Mem:0xe2800000  IRQ:3  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: MDT MD100EB-00BHF0, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRD-8520B, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 00:11.0
PCI: Found IRQ 11 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0x7000-0x7007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7008-0x700f, BIOS settings: hdg:pio, hdh:pio
hda: host protected area => 1
hda: 19541088 sectors (10005 MB) w/2048KiB Cache, CHS=1216/255/63, UDMA(100)
 hda: hda1 hda2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
oprofile: using timer interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 100k freed
Real Time Clock Driver v1.11
Adding 517096k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
e100: eth0 NIC Link is Up 100 Mbps Full duplex
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
PCI: Enabling device 00:0a.0 (0004 -> 0007)
PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 5 for device 00:0a.0
ymfpci: YMF754 at 0xe3000000 IRQ 5
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)

