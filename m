Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317634AbSGOUv5>; Mon, 15 Jul 2002 16:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317635AbSGOUv5>; Mon, 15 Jul 2002 16:51:57 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:18203 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S317634AbSGOUvy>; Mon, 15 Jul 2002 16:51:54 -0400
Message-ID: <002401c22c41$d78d4010$027ba8c0@pinguin>
From: "vincent" <vincent.blondel@chello.be>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.18 with Tekram Dc-390U3W ( Symbios Logic 53C10-10 )
Date: Mon, 15 Jul 2002 22:54:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My server is running with Slackware 8.0 and kernel 2.4.18. I got a
Pentium with a U160 SCSI Controller  ( Tekram DC-390U3W ) / 3COM 3C905C and
128 MB
RAM.

Compilation ran ok but I got some general performance problems. I have
one client connected to this machine through samba system. At the
beginning I directly looked at my network system and I changed a lot
of TCP/IP parameters but my client cannot write more than 200 - 220
ko/s ( client 10Mps on this server 100Mbps ). My client can well
download at ± 950 ko/s. This is all running fine but write sequence
takes a while and I think that I normally could have upload with
650-700 ko/s.

So I am now looking at my SCSI interface. Maybe problem comes from
there or eventually my Reiserfs config.

I compiled the kernel without applying patch-2.4.18.gz.

So my questions are the following :
- do I have to apply this patch ???
- I took driver "SYM53C8XX Version 2 SCSI support". Is that the right
one ( is that stable enough ??? ) or do I have to take another one ???
- do you see something wrong in the result of my dmesg command that
can degrade write process ...

Thanks
vincent

Linux version 2.4.18 (root@otter) (gcc version 2.95.3 20010315
(release)) #2 Wed Jul 3 19:10:11 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=805
Initializing CPU#0
Detected 166.194 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 331.77 BogoMIPS
Memory: 126172k/131072k available (1498k kernel code, 4512k reserved,
468k data, 244k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd9b1, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
vesafb: framebuffer at 0xff000000, mapped to 0xc880f000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c7d5:0000
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
hda: QUANTUM FIREBALL SE8.4A, ATA DISK drive
hdb: Pioneer CD-ROM ATAPI Model DR-A12X 0100, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 16514064 sectors (8455 MB) w/80KiB Cache, CHS=1027/255/63, (U)DMA
hdb: set_drive_speed_status: status=0x00 { }
hdb: ATAPI 12X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
sym.0.13.1: setting PCI_COMMAND_PARITY...
sym.0.13.0: setting PCI_COMMAND_PARITY...
sym0: <1010-33> rev 0x1 on pci bus 0 device 13 function 1 irq 10
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-33> rev 0x1 on pci bus 0 device 13 function 0 irq 10
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
  Vendor: SEAGATE   Model: ST336938LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym1:0:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
sym1:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sda: 72176567 512-byte hdwr sectors (36954 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
es1371: version v0.30 time 19:21:36 Jul  3 2002
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
NET4: AppleTalk 0.18a for Linux NET4.0
reiserfs: checking transaction log (device 08:05) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 49 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 244k freed
Adding Swap: 513000k swap-space (priority -1)
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
reiserfs: replayed 1 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0f.0: 3Com PCI 3c905C Tornado at 0xfc00. Vers LK1.1.16
00:10.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xff00. Vers
LK1.1.16
cdrom: open failed.
VFS: Disk change detected on device ide0(3,64)
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (C) 2000-2002 Netfilter core team



