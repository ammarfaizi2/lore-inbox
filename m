Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267477AbUG3Wpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267477AbUG3Wpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUG3Wos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:44:48 -0400
Received: from web61207.mail.yahoo.com ([216.155.196.131]:46421 "HELO
	web61207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267477AbUG3Wmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:42:49 -0400
Message-ID: <20040730224245.56872.qmail@web61207.mail.yahoo.com>
Date: Fri, 30 Jul 2004 15:42:45 -0700 (PDT)
From: Stormy Waters <stormy420waters@yahoo.com>
Subject: 2.4.26 XFS file space reporting bug
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I think I found a bug in the 2.4.26 kernel,  I have a
logical partition (see below) that is partitioned for
20 gig's.  when i use df it reports it as 278MB. 
Which is not even close to 20gb.  This Machine is
Running a 2.4.26 kernel, it's a Dual p3 1.4ghz, and as
you can see from the dmesg down below, it is on a
hardware raid setup.  Below I've tryed to include
every piece of information I can think of.  If  you
need any more information please let me know.

--Scott
If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.

Linux g2dev 2.4.26-gentoo-r6 #5 SMP Fri Jul 30
14:10:33 EST 2004 i686 Intel(R) Pentium(R) III CPU - S
        1400MHz GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
xfsprogs               2.6.3
Linux C Library        2.3.3
head: `-1' option is obsolete; use `-n 1' since this
will be removed in the future
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         bonding



cfdisk 2.12

Disk Drive: ./disc
Size: 54628712448 bytes, 54.6 GB
Heads: 255   Sectors per Track: 63   Cylinders: 6641

Name        Flags      Part Type  FS Type       
[Label]        Size (MB)
------------------------------------------------------------------------------
    disc1       Boot        Primary   Linux ext2      
                  254.99
    disc2       Boot        Primary   Linux ReiserFS  
                10001.95
    disc3                   Primary   Linux swap      
                 1019.94
                            Logical   Free Space      
                23343.35
    disc5                   Logical   Linux           
                20003.89


Filesystem            Size  Used Avail Use% Mounted on
/dev/rd/disc0/part2   9.4G  2.1G  7.3G  23% /
none                  504M     0  504M   0% /dev/shm
/dev/rd/disc1/part1    60G   33M   60G   1% /mnt/www
/dev/rd/disc0/part5   278M  144K  278M   1% /mnt/sql

7 at 0xFEC01000.
Enabling APIC mode: Flat.       Using 2 I/O APICs
Processors: 2
Kernel command line: auto BOOT_IMAGE=gentoo ro
root=3002
Initializing CPU#0
Detected 1395.652 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2785.28 BogoMIPS
Memory: 1031652k/1048576k available (2831k kernel
code, 16536k reserved, 343k da
ta, 164k init, 131072k highmem)
Dentry cache hash table entries: 131072 (order: 8,
1048576 bytes)
Inode cache hash table entries: 65536 (order: 7,
524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096
bytes)
Buffer cache hash table entries: 65536 (order: 6,
262144 bytes)
Page-cache hash table entries: 262144 (order: 8,
1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU0: Intel(R) Pentium(R) III CPU - S         1400MHz
stepping 04
per-CPU timeslice cutoff: 1462.52 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2785.28 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU1: Intel(R) Pentium(R) III CPU - S         1400MHz
stepping 04
Total of 2 processors activated (5570.56 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-3, 4-5, 4-9, 4-11, 5-0,
5-1, 5-2, 5-3, 5-8, 5-9, 5-
10, 5-12, 5-13, 5-14, 5-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  0    0    0   0   0    1    1    41
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    49
 07 003 03  0    0    0   0   0    1    1    51
 08 003 03  0    0    0   0   0    1    1    59


 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    61
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    89
 05 003 03  1    1    0   1   0    1    1    91
 06 003 03  1    1    0   1   0    1    1    99
 07 003 03  1    1    0   1   0    1    1    A1
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 003 03  1    1    0   1   0    1    1    A9
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ27 -> 1:11
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1395.6539 MHz.
..... host bus clock speed is 132.9190 MHz.
cpu: 0, clocks: 1329190, slice: 443063
CPU0<T0:1329184,T1:886112,D:9,S:443063,C:1329190>
cpu: 1, clocks: 1329190, slice: 443063
CPU1<T0:1329184,T1:443056,D:2,S:443063,C:1329190>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last
bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at
00:0f.0
PCI->APIC IRQ transform: (B0,I1,P0) -> 22
PCI->APIC IRQ transform: (B0,I4,P0) -> 20
PCI->APIC IRQ transform: (B0,I5,P0) -> 21
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I2,P0) -> 27
PCI->APIC IRQ transform: (B2,I8,P0) -> 23
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.14
<tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem
bounces
devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
SGI XFS with no debug enabled
SGI XFS Quota Management subsystem
vesafb: framebuffer at 0xfd000000, mapped to
0xf8800000, size 4096k
vesafb: mode is 1024x768x24, linelength=3072, pages=0
vesafb: protected mode interface info at c000:4cae
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device
128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Redundant entry in serial pci_table.  Please send the
output of
lspci -vv, this message (134d,7891,134d,0001)
and the manufacturer and name of serial board or modem
board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
Real Time Clock Driver v1.10f
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11
October 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff
<lnz@dandelion.com>
DAC960#0: Configuring Mylex DAC1164P PCI RAID
Controller
DAC960#0:   Firmware Version: 5.08-0-88, Channels: 3,
Memory Size: 64MB
DAC960#0:   PCI Bus: 2, Device: 8, Function: 0, I/O
Address: Unassigned
DAC960#0:   PCI Address: 0xFEAEFC00 mapped at
0xF8C01C00, IRQ Channel: 23
DAC960#0:   Controller Queue Depth: 128, Maximum
Blocks per Command: 512
DAC960#0:   Driver Queue Depth: 127, Scatter/Gather
Limit: 33 of 33 Segments
DAC960#0:   Stripe Size: 32KB, Segment Size: 32KB,
BIOS Geometry: 128/32
DAC960#0:   Physical Devices:
DAC960#0:     0:0  Vendor: SEAGATE   Model: SX118202LS
       Revision: B808
DAC960#0:          Serial Number: LKJ75165    1925HFG1
DAC960#0:          Disk Status: Online, 35565568
blocks
DAC960#0:     0:1  Vendor: SEAGATE   Model: SX118202LS
       Revision: B807
DAC960#0:          Serial Number: LK680192    292907CQ
DAC960#0:          Disk Status: Online, 35565568
blocks
DAC960#0:     0:2  Vendor: SEAGATE   Model: SX118202LS
       Revision: B808
DAC960#0:          Serial Number: LK791857    29310F2C
DAC960#0:          Disk Status: Online, 35565568
blocks
DAC960#0:     0:3  Vendor: SEAGATE   Model: SX118202LS
       Revision: B808
DAC960#0:          Serial Number: LKG46985    2938H4HK
DAC960#0:          Disk Status: Online, 35565568
blocks
DAC960#0:     0:7  Vendor: MYLEX     Model: DAC1164P  
       Revision: 0508
DAC960#0:          Serial Number:
DAC960#0:     1:0  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       6800DA48QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:1  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       13600131QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:2  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       13600198QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:3  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       13600176QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:4  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       13850104QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:5  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       6803B6B7QA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:6  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       680C9DACSA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     1:7  Vendor: MYLEX     Model: DAC1164P  
       Revision: 0508
DAC960#0:          Serial Number:
DAC960#0:     1:8  Vendor: IBM       Model: DRVS09D   
       Revision: 0370
DAC960#0:          Serial Number:       6801E32AQA
DAC960#0:          Disk Status: Online, 17928192
blocks
DAC960#0:     2:7  Vendor: MYLEX     Model: DAC1164P  
       Revision: 0508
DAC960#0:          Serial Number:
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 106696704
blocks, Write Thru
DAC960#0:     /dev/rd/c0d1: RAID-5, Online, 125497344
blocks, Write Thru
Partition check:
 rd/c0d0: p1 p2 p3 p4 < p5 p6 >
 rd/c0d1: p1
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by
Andrey V. Savochkin <saw@sa
w.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100],
00:E0:81:20:A8:40, IRQ 20.
  Board assembly 567812-052, Physical connectors
present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2),
00:E0:81:20:A8:41, IRQ 21.
  Board assembly 567812-052, Physical connectors
present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
942M
agpgart: unable to determine aperture size.
[drm] Initialized r128 2.2.0 20010917 on minor 0
Uniform Multi-Platform E-IDE driver Revision:
7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k
scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
mice: PS/2 mouse device common for all mice
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2575.600 MB/sec
   32regs    :  1351.200 MB/sec
   pIII_sse  :  3295.200 MB/sec
   pII_mmx   :  3110.000 MB/sec
   p5_mmx    :  3297.200 MB/sec
raid5: using function: pIII_sse (3295.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.8(17/11/2003)
Initializing Cryptographic API
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind
65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
RAMDISK: Couldn't find valid RAM disk image starting
at 0.
Freeing initrd memory: 40k freed
reiserfs: found format "3.6" with standard journal
reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
reiserfs:warning: - it is slow mode for debugging.
reiserfs: checking transaction log (device
dac960(48,2)) ...
for (dac960(48,2))
dac960(48,2): journal-1153: found in header:
first_unflushed_offset 2676, last_f
lushed_trans_id 10232
dac960(48,2): journal-1206: Starting replay from
offset 2676, trans_id 10233
dac960(48,2): journal-1299: Setting newest_mount_id to
41
dac960(48,2):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 164k freed
Adding Swap: 996020k swap-space (priority -1)
Ethernet Channel Bonding Driver: v2.6.0 (January 14,
2004)
bonding: MII link monitoring set to 100 ms
bonding: bond0: enslaving eth0 as an active interface
with an up link.
eth0: freeing mc frame.
bonding: bond0: enslaving eth1 as an active interface
with an up link.
eth1: freeing mc frame.
bond0: duplicate address detected!
bond0: duplicate address detected!
eth0: no IPv6 routers present
eth1: no IPv6 routers present
reiserfs: found format "3.6" with standard journal
reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
reiserfs:warning: - it is slow mode for debugging.
reiserfs: checking transaction log (device
dac960(48,9)) ...
for (dac960(48,9))
dac960(48,9): journal-1153: found in header:
first_unflushed_offset 162, last_fl
ushed_trans_id 25
dac960(48,9): journal-1206: Starting replay from
offset 162, trans_id 26
dac960(48,9): journal-1299: Setting newest_mount_id to
12
dac960(48,9):Using r5 hash to sort names
XFS mounting filesystem dac960(48,5)
Ending clean XFS mount for filesystem: dac960(48,5)
XFS mounting filesystem dac960(48,5)
Ending clean XFS mount for filesystem: dac960(48,5)



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
