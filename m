Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbTBEFZt>; Wed, 5 Feb 2003 00:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBEFZt>; Wed, 5 Feb 2003 00:25:49 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:49419 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267804AbTBEFZl>; Wed, 5 Feb 2003 00:25:41 -0500
Date: Wed, 5 Feb 2003 06:34:40 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac2
Message-ID: <20030205053440.GA1239@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200302041702.h14H2O112078@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302041702.h14H2O112078@devserv.devel.redhat.com>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@redhat.com>
Date: Tue, Feb 04, 2003 at 12:02:24PM -0500
> More IDE updates. Finally switch the IDE layer over to the ide_execute_command
> interface. This should cure problems people have seen for a long time with
> big arrays and shared IRQ. Treat this with care. The other stuff is mostly
> minor fixes and obscure updates, except for the Kahlua audio enabler
> 
> Linux 2.4.21pre4-ac2

Your Makefile still claims to be ac1.

> o	Turn on use of ide_execute_command everywhere	(Ross Biro, me)
> o	First cut at settings locking for IDE		(me)

Some of these may be responsible for something new: my system hangs at shutdown,
saying 'flushing ide devices: hda hdc'. This didn't happen with
2.4.21pre3-ac5. hdc is a cdwriter, used as ide-scsi.

Kind regards,
Jurriaan

Linux version 2.4.21-pre4-ac2 (root@middle) (gcc version 3.2.2 20030131 (Debian prerelease)) #2 SMP Tue Feb 4 20:17:24 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4f80
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=power-off
ide_setup: hdc=scsi
Initializing CPU#0
Detected 1173.836 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2339.63 BogoMIPS
Memory: 515104k/524224k available (1748k kernel code, 8732k reserved, 439k data, 336k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
per-CPU timeslice cutoff: 1463.48 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2346.18 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU - S         1400MHz stepping 04
Total of 2 processors activated (4685.82 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 25.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1173.8847 MHz.
..... host bus clock speed is 111.7985 MHz.
cpu: 0, clocks: 1117985, slice: 372661
CPU0<T0:1117984,T1:745312,D:11,S:372661,C:1117985>
cpu: 1, clocks: 1117985, slice: 372661
CPU1<T0:1117984,T1:372656,D:6,S:372661,C:1117985>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3101] at 00:00.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 11
PCI->APIC IRQ transform: (B0,I11,P0) -> 10
PCI->APIC IRQ transform: (B0,I12,P0) -> 5
PCI->APIC IRQ transform: (B0,I13,P0) -> 11
PCI->APIC IRQ transform: (B0,I14,P0) -> 10
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I17,P3) -> 5
PCI->APIC IRQ transform: (B0,I18,P0) -> 11
PCI->APIC IRQ transform: (B1,I0,P0) -> 11
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).
Starting kswapd
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD4000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xac00, 00:A0:CC:21:A1:AC, IRQ 5.
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth1: VIA VT6102 Rhine-II at 0xda022000, 00:d0:68:00:5a:8b, IRQ 11.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 00:0d.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:pio
HPT370A: IDE controller at PCI slot 00:0f.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xd800-0xd807, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xd808-0xd80f, BIOS settings: hdk:DMA, hdl:pio
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 33073H3, ATA DISK drive
blk: queue c03df440, I/O limit 4095Mb (mask 0xffffffff)
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G120J6, ATA DISK drive
hdf: Maxtor 4G120J6, ATA DISK drive
blk: queue c03dfd60, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03dfebc, I/O limit 4095Mb (mask 0xffffffff)
hdg: IBM-DTLA-307045, ATA DISK drive
blk: queue c03e01f0, I/O limit 4095Mb (mask 0xffffffff)
hdi: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue c03e0680, I/O limit 4095Mb (mask 0xffffffff)
hdk: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue c03e0b10, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb000-0xb007,0xb402 on irq 11
ide3 at 0xb800-0xb807,0xbc02 on irq 11
ide4 at 0xc800-0xc807,0xcc02 on irq 10
ide5 at 0xd000-0xd007,0xd402 on irq 10
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdf: host protected area => 1
hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
hdg: host protected area => 1
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdi: host protected area => 1
hdi: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
hdk: host protected area => 1
hdk: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
ide-cd: passing drive hdc to ide-scsi emulation.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
 hde: hde1 hde2
 hdf: hdf1 hdf2
 hdg:<6> [PTBL] [5606/255/63] hdg1 hdg2
 hdi: hdi1 hdi2
 hdk: hdk1 hdk2
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 11 function 0 irq 10
sym53c860-0: ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
sr1: scsi-1 drive
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 247x/48x writer cd/rw xa/form2 cdda tray
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2163.600 MB/sec
   32regs    :   965.200 MB/sec
   pIII_sse  :  2747.200 MB/sec
   pII_mmx   :  2602.400 MB/sec
   p5_mmx    :  2755.200 MB/sec
raid5: using function: pIII_sse (2747.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000066]
 [events: 00000063]
 [events: 00000066]
 [events: 00000063]
md: autorun ...
md: considering hdk2 ...
md:  adding hdk2 ...
md:  adding hdi2 ...
md: created md1
md: bind<hdi2,1>
md: bind<hdk2,2>
md: running: <hdk2><hdi2>
md: hdk2's event counter: 00000063
md: hdi2's event counter: 00000063
md1: max total readahead window set to 512k
md1: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at hdi2
raid0:   comparing hdi2(7590656) with hdi2(7590656)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdk2
raid0:   comparing hdk2(7590656) with hdi2(7590656)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hdi2 ... contained as device 0
  (7590656) is smallest!.
raid0: checking hdk2 ... contained as device 1
raid0: zone->nb_dev: 2, size: 15181312
raid0: current zone offset: 7590656
raid0: done.
raid0 : md_size is 15181312 blocks.
raid0 : conf->smallest->size is 15181312 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md1 RAID superblock on device
md: hdk2 [events: 00000064]<6>(write) hdk2's sb offset: 7590656
md: hdi2 [events: 00000064]<6>(write) hdi2's sb offset: 7590656
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hdi1 ...
md: created md0
md: bind<hdi1,1>
md: bind<hdk1,2>
md: running: <hdk1><hdi1>
md: hdk1's event counter: 00000066
md: hdi1's event counter: 00000066
md0: max total readahead window set to 512k
md0: 2 data-disks, max readahead per data-disk: 256k
raid0: looking at hdi1
raid0:   comparing hdi1(70559872) with hdi1(70559872)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdk1
raid0:   comparing hdk1(70559872) with hdi1(70559872)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hdi1 ... contained as device 0
  (70559872) is smallest!.
raid0: checking hdk1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 141119744
raid0: current zone offset: 70559872
raid0: done.
raid0 : md_size is 141119744 blocks.
raid0 : conf->smallest->size is 141119744 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdk1 [events: 00000067]<6>(write) hdk1's sb offset: 70559872
md: hdi1 [events: 00000067]<6>(write) hdi1's sb offset: 70559872
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 336k freed
Adding Swap: 1574328k swap-space (priority -1)
Real Time Clock Driver v1.10e
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro 266T chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo Pro 266T @ 0xd0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 20:20:33 Feb  4 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usbscanner
scanner.c: 0.4.10:USB Scanner Driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NTFS driver v1.1.22 [Flags: R/O MODULE]
udf: registering filesystem
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:0b) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0c) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:42) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII#1 link partner capability of 05e1.
-- 
The Swedish Chef has been assimilated. "Borg borg borg!"
GNU/Linux 2.4.21-pre3-ac5 SMP/ReiserFS 2x2339 bogomips load av: 3.22 3.33 2.41
