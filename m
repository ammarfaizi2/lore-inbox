Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUFIPHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUFIPHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUFIPHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:07:08 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24873 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266155AbUFIPF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:05:56 -0400
From: Pablo <pasrospa@myrealbox.com>
To: linux-kernel@vger.kernel.org
Subject: Trouble with VIA vt82c686a and UDMA.
Date: Wed, 9 Jun 2004 17:11:51 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091711.51572.pasrospa@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've an ABIT KT7-RAID (latest BIOS) with a DVD-ROM and a CD-Writer as hda and 
hdb. Problem is that when UDMA is activated drives that are attached to ide1 
or ide2 (via controller) seem corrupt data. I didn't notice this until I got 
the CD-Writer (LG 52x24x52x), all my attempts to burn CDs failed with the 
following error:

Sense Key: 0x4 Hardware Error, Segment 0
Sense Code: 0x08 Qual 0x03 (logical unit communication crc error 
(ultra-dma/32)) Fru 0x0

Then I looked in the kernel log and found that I was getting these messages:

hda: CHECK for good STATUS
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }

After googling I found someone that had the same problem long ago: 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.0/1017.html but I think 
this was not fixed or something.

Linux version 2.6.5-gentoo-r1 (root@gentoo) (gcc versi?n 3.3.2 20031218 
(Gentoo Linux 3.3.2-r5, prop
olice-3.3-7)) #1 Wed Jun 9 02:13:03 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)
 BIOS-e820: 0000000027ff0000 - 0000000027ff3000 (ACPI NVS)
 BIOS-e820: 0000000027ff3000 - 0000000028000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB LOWMEM available.
On node 0 totalpages: 163824
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159728 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 VT8371                                    ) @ 0x000f7900
ACPI: RSDT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x27ff3000
ACPI: FADT (v001 VT8371 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x27ff3040
ACPI: DSDT (v001 VT8371 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.5-gentoo ro root=2102 
video=vesa:ywrap,mtrr splash=verbose
bootsplash: verbose mode.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1000.556 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 644024k/655296k available (2557k kernel code, 10516k reserved, 927k 
data, 172k init, 0k high
mem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1957.88 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an 
initrd
Freeing initrd memory: 99k freed
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0927 MHz.
..... host bus clock speed is 199.0985 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
spurious 8259A interrupt: IRQ7.
vesafb: framebuffer at 0xd8000000, mapped to 0xe8800000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:0f3e
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
PCI: Disabling Via external APIC routing
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
bootsplash 3.1.4-2004/02/19: looking for picture.... silentjpeg size 75071 
bytes, found (1280x1024,
26385 bytes, v3).
Console: switching to colour frame buffer device 153x54
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: AGP aperture is 128M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: Via 686A parallel port disabled in BIOS
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
hda: LG DVD-ROM DRD-8120B, ATAPI CD/DVD-ROM drive
hdb: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
HPT370: IDE controller at PCI slot 0000:00:13.0
PCI: Found IRQ 11 for device 0000:00:13.0
PCI: Sharing IRQ 11 with 0000:00:09.0
HPT370: chipset revision 3
HPT37X: using 33MHz PCI clock
HPT370: 100% native mode on irq 11
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y120L0, ATA DISK drive
ide2 at 0xd800-0xd807,0xdc02 on irq 11
hde: max request size: 128KiB
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3
hda: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 8X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 7 for device 0000:00:07.2
PCI: Sharing IRQ 7 with 0000:00:07.3
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:07.2: irq 7, io base 0000c400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 7 for device 0000:00:07.3
PCI: Sharing IRQ 7 with 0000:00:07.2
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:07.3: irq 7, io base 0000c800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 
2004 UTC).
PCI: Found IRQ 5 for device 0000:00:0f.0
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0xd000, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Couldn't find valid RAM disk image starting at 0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 172k freed
Adding 128512k swap on /dev/hde3.  Priority:-1 extents:1
EXT3 FS on hde2, internal journal
8139too Fast Ethernet driver 0.9.27
PCI: Found IRQ 11 for device 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:13.0
eth0: RealTek RTL8139 at 0xe98d7000, 00:e0:7d:89:e6:c9, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 14 
18:29:26 PST 2004
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hda: CHECK for good STATUS
hdb: CHECK for good STATUS
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 0 changed to on
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 1 changed to on
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 2 changed to on
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 3 changed to on
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 4 changed to on
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1280x1024, 26385 
bytes, v3).
bootsplash: status on console 5 changed to on
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
hda: CHECK for good STATUS
hda: CHECK for good STATUS
hdb: CHECK for good STATUS
hdb: CHECK for good STATUS

/dev/hda:

 Model=LG DVD-ROM DRD-8120B, FwRev=1.03, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

/dev/hdb:

 Model=HL-DT-ST GCE-8520B, FwRev=1.04, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.38
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xc000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO       PIO
Address Setup:       30ns      30ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns      90ns     330ns     330ns
Data Recovery:       30ns      30ns     270ns     270ns
Cycle Time:          60ns      60ns     600ns     600ns
Transfer Rate:   33.3MB/s  33.3MB/s   3.3MB/s   3.3MB/s

I've tried changing the cables but I get the same result. This problems 
doesn't happen under Windows so the drives are ok (I also tried to attach a 
HDD there and I got many errors like now). I read that there might be 
problems with SB Live! but I get same errors without it.

A workaround for this has been to turn UDMA off and set it to MDMA, then I 
have no problem at all and CDs are burned ok. The HPT370 (ATA100) ide 
controller also works fine, my hd is there.

This is my first message to this list, I wish I told enough information. And 
please, CC this message to me because I'm not subscribed to the list.

Pablo.
