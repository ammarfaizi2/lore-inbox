Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290918AbSASHKc>; Sat, 19 Jan 2002 02:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290919AbSASHKY>; Sat, 19 Jan 2002 02:10:24 -0500
Received: from intbg-piocommers.internet-bg.net ([212.124.67.90]:38873 "HELO
	ns.top.bg") by vger.kernel.org with SMTP id <S290918AbSASHKL>;
	Sat, 19 Jan 2002 02:10:11 -0500
Message-ID: <3C49A8AD.2BBC7F7A@top.bg>
Date: Sat, 19 Jan 2002 09:11:09 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Sharing Interrupt+HPT366 Problem on BP6
Content-Type: multipart/mixed;
 boundary="------------30FEC27F11B9A6A0F8AE2D64"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------30FEC27F11B9A6A0F8AE2D64
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There some problems with HPT366 maybe

I used 3 disks for raid level 5
2 on the one of the channels
1 on the other channel

Few second after starting raid (it start background recovery) the system
locks totaly
not even the Magic SysRq key works, only reset

The HPT366 uses IRQ sharing (same IRQ on both chnnes)

When i use only one channel, everiting is OK:
2 on the one of the channels
1 on the ordinary PIIX ide controler

The configuration is:
Abit BP6 MB
Single Celeron 366 processor
1X10G hdd
3X60G hdd
256MB ram
Davicom 100MB/s NIC
S3 Trio3D AGP VGA
Attached both dmesg:


--------------30FEC27F11B9A6A0F8AE2D64
Content-Type: text/plain; charset=us-ascii;
 name="dmesk.works.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesk.works.txt"

Linux version 2.4.16 (root@matrix) (gcc version 2.95.3 20010315 (release)) #9 SMP Sat Jan 19 08:29:12 EET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=linux ro root=301
Initializing CPU#0
Detected 367.508 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 734.00 BogoMIPS
Memory: 255480k/262144k available (1207k kernel code, 6280k reserved, 319k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.30 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-16, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
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
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    79
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
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
IRQ10 -> 0:19
IRQ11 -> 0:18
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 367.4860 MHz.
..... host bus clock speed is 66.8155 MHz.
cpu: 0, clocks: 668155, slice: 334077
CPU0<T0:668144,T1:334064,D:3,S:334077,C:668155>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:DMA, hdh:DMA
hda: Maxtor 2B010H1, ATA DISK drive
hdc: Maxtor 4W060H4, ATA DISK drive
hdg: Maxtor 4W060H4, ATA DISK drive
hdh: Maxtor 4W060H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xe400-0xe407,0xe802 on irq 11
hda: 19541088 sectors (10005 MB) w/2048KiB Cache, CHS=1216/255/63, UDMA(33)
hdc: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(33)
hdg: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(66)
hdh: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: [PTBL] [7471/255/63] hdc1
 hdg: hdg1
 hdh: hdh1
dmfe: Davicom DM9xxx net driver, version 1.36.3 (2001-11-06)
eth0: Davicom DM9102 at pci00:11.0, 00:80:ad:00:69:5d, irq 10.
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   635.600 MB/sec
   32regs    :   451.200 MB/sec
   pII_mmx   :   825.200 MB/sec
   p5_mmx    :   866.400 MB/sec
raid5: using function: p5_mmx (866.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000001]
 [events: 00000001]
 [events: 00000001]
md: autorun ...
md: considering hdh1 ...
md:  adding hdh1 ...
md:  adding hdg1 ...
md:  adding hdc1 ...
md: created md0
md: bind<hdc1,1>
md: bind<hdg1,2>
md: bind<hdh1,3>
md: running: <hdh1><hdg1><hdc1>
md: hdh1's event counter: 00000001
md: hdg1's event counter: 00000001
md: hdc1's event counter: 00000001
md: device name has changed from [dev 21:41] to hdh1 since last import!
md: device name has changed from [dev 21:01] to hdg1 since last import!
md: device name has changed from hdg1 to hdc1 since last import!
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid5: device hdh1 operational as raid disk 1
raid5: device hdg1 operational as raid disk 0
raid5: device hdc1 operational as raid disk 2
raid5: allocated 3291kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdg1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdh1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdc1
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdg1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdh1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdc1
md: updating md0 RAID superblock on device
md: hdh1 [events: 00000002]<6>(write) hdh1's sb offset: 60016704
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 60010688 blocks.
md: hdg1 [events: 00000002]<6>(write) hdg1's sb offset: 60016704
md: hdc1 [events: 00000002]<6>(write) hdc1's sb offset: 60010688
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 891596k swap-space (priority -1)
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------30FEC27F11B9A6A0F8AE2D64
Content-Type: text/plain; charset=us-ascii;
 name="dmesg.lockups.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.lockups.txt"

Linux version 2.4.16 (root@matrix) (gcc version 2.95.3 20010315 (release)) #8 Sat Jan 19 08:03:53 EET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=301
Initializing CPU#0
Detected 367.508 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 734.00 BogoMIPS
Memory: 255816k/262144k available (1105k kernel code, 5944k reserved, 298k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 10 for device 00:07.2
PCI: Sharing IRQ 10 with 00:11.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:DMA
HPT366: IDE controller on PCI bus 00 dev 99
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 2B010H1, ATA DISK drive
hde: Maxtor 4W060H4, ATA DISK drive
hdf: Maxtor 4W060H4, ATA DISK drive
hdg: Maxtor 4W060H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd800-0xd807,0xdc02 on irq 11
ide3 at 0xe400-0xe407,0xe802 on irq 11
hda: 19541088 sectors (10005 MB) w/2048KiB Cache, CHS=1216/255/63, UDMA(33)
hde: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(66)
hdf: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(66)
hdg: 120033900 sectors (61457 MB) w/2048KiB Cache, CHS=119081/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hde: hde1
 hdf: hdf1
 hdg: [PTBL] [7471/255/63] hdg1
dmfe: Davicom DM9xxx net driver, version 1.36.3 (2001-11-06)
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:07.2
eth0: Davicom DM9102 at pci00:11.0, 00:80:ad:00:69:5d, irq 10.
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   635.600 MB/sec
   32regs    :   451.200 MB/sec
   pII_mmx   :   825.600 MB/sec
   p5_mmx    :   867.200 MB/sec
raid5: using function: p5_mmx (867.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000001]
 [events: 00000001]
 [events: 00000001]
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hdf1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1,1>
md: bind<hdf1,2>
md: bind<hdg1,3>
md: running: <hdg1><hdf1><hde1>
md: hdg1's event counter: 00000001
md: hdf1's event counter: 00000001
md: hde1's event counter: 00000001
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid5: device hdg1 operational as raid disk 2
raid5: device hdf1 operational as raid disk 1
raid5: device hde1 operational as raid disk 0
raid5: allocated 3291kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdf1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdg1
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdf1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdg1
md: updating md0 RAID superblock on device
md: hdg1 [events: 00000002]<6>(write) hdg1's sb offset: 60010688
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 60010688 blocks.
md: hdf1 [events: 00000002]<6>(write) hdf1's sb offset: 60016704
md: hde1 [events: 00000002]<6>(write) hde1's sb offset: 60016704
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 891596k swap-space (priority -1)
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------30FEC27F11B9A6A0F8AE2D64--

