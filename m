Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTALNT4>; Sun, 12 Jan 2003 08:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTALNT4>; Sun, 12 Jan 2003 08:19:56 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:13487 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S266200AbTALNTv>; Sun, 12 Jan 2003 08:19:51 -0500
From: "=?iso-8859-1?Q?Philip_K.F._H=F6lzenspies?=" 
	<p.k.f.holzenspies@student.utwente.nl>
To: <linux-kernel@vger.kernel.org>
Cc: "'Pete Zaitcev'" <zaitcev@redhat.com>, "'Shawn Starr'" <spstarr@sh0n.net>,
       "'Bayard R. Coolidge'" <bayard@tds.net>
Subject: 
Date: Sun, 12 Jan 2003 14:28:35 +0100
Message-ID: <000001c2ba3e$84695730$53a85982@tomwaits>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-UTwente-MailScanner: Found to be clean
X-UTwente-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do have the following line in my fstab file (Bayard):

none  /proc/bus/usb  usbfs  defaults 0 0

I believe usbdevfs is deprecated (although - should I use it when my
hosthub is picked up by the OHCI driver in stead of the EHCI driver?).

My full dmesg is attached below (Pete), I'ld say the relevant section
is:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 02:08.2 (0014 -> 0016)
PCI: No IRQ known for interrupt pin C of device 02:08.2. Probably buggy
MP table.
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 02:08.2 setup!
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Enabling device 02:08.0 (0014 -> 0016)
PCI: No IRQ known for interrupt pin A of device 02:08.0. Probably buggy
MP table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
PCI: Enabling device 02:08.1 (0014 -> 0016)
PCI: No IRQ known for interrupt pin B of device 02:08.1. Probably buggy
MP table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.

Does anybody else with the A7M266-D have that "Probably buggy MP table."

For the OHCI 'found device with no IRQ assigned' I don't really get it.
I have all my PCI slots set to auto assign IRQ and I didn't reserve any
IRQ for Legacy Devices, so that shouldn't be the problem.

> I have this board, but the problem is the newer A7M266-D boards have
the USB
> 1.x pins removed.
(Shawn)

I don't know what would be considered a "newer" board, but mine is a 
03/07/2002-ASUS-A7M266-D

B.T.W.
I use BIOS rev. 1005.

Regards,

Philip

P.S.
Would configuring the kernel with >1GB mem support remove that
" Warning only 896MB will be used." from my dmesg?



Linux version 2.4.20 (root@tomwaits) (gcc version 3.2) #1 SMP Sat Jan 11
18:46:51 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000f6d10
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 16
Processor #1 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=lfs ro root=305
Initializing CPU#0
Detected 1533.431 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 904324k/917504k available (1707k kernel code, 12792k reserved,
604k data, 124k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(TM) MP 1800+ stepping 02
per-CPU timeslice cutoff: 731.39 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3060.53 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(TM) MP 1800+ stepping 02
Total of 2 processors activated (6121.06 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-17, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.4929 MHz.
..... host bus clock speed is 266.6942 MHz.
cpu: 0, clocks: 2666942, slice: 888980
CPU0<T0:2666928,T1:1777936,D:12,S:888980,C:2666942>
cpu: 1, clocks: 2666942, slice: 888980
CPU1<T0:2666928,T1:888960,D:8,S:888980,C:2666942>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf0de0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
PCI->APIC IRQ transform: (B1,I5,P0) -> 16
PCI->APIC IRQ transform: (B2,I5,P0) -> 18
BIOS failed to enable PCI standards compliance, fixing this error.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/O]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
amd768_rng: AMD768 system management I/O registers at 0xE400.
amd768_rng hardware driver 0.1.0 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800JB-00CRA1, ATA DISK drive
hdb: WDC WD307AA-00BAA0, ATA DISK drive
hdc: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
hdd: AOPEN CD-RW CRW3248 1.10 20020301, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03b9124, I/O limit 4095Mb (mask 0xffffffff)
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63,
UDMA(100)
blk: queue c03b9270, I/O limit 4095Mb (mask 0xffffffff)
hdb: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63,
UDMA(66)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 >
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:05.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xc800. Vers
LK1.1.16
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 32M @ 0xfc000000
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
es1371: version v0.30 time 18:48:06 Jan 11 2003
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 02:08.2 (0014 -> 0016)
PCI: No IRQ known for interrupt pin C of device 02:08.2. Probably buggy
MP table.
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 02:08.2 setup!
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Enabling device 02:08.0 (0014 -> 0016)
PCI: No IRQ known for interrupt pin A of device 02:08.0. Probably buggy
MP table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
PCI: Enabling device 02:08.1 (0014 -> 0016)
PCI: No IRQ known for interrupt pin B of device 02:08.1. Probably buggy
MP table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k freed


