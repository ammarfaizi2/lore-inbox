Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264758AbSKEKaO>; Tue, 5 Nov 2002 05:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSKEKaO>; Tue, 5 Nov 2002 05:30:14 -0500
Received: from web20506.mail.yahoo.com ([216.136.226.141]:16801 "HELO
	web20506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264758AbSKEKaK>; Tue, 5 Nov 2002 05:30:10 -0500
Message-ID: <20021105103645.70818.qmail@web20506.mail.yahoo.com>
Date: Tue, 5 Nov 2002 02:36:45 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: Re: Machine's high load when HIGHMEM is enabled
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DC6CA38.1B027BD7@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yes, mtrr driver is enabled in kernel config.
I have not tried to pass mem=2G at kernel boot,
because it can see the whole memory without this
option (or should I ? will it change something ?)


And here is the requested information from that box:
# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB:
write-back, count=1
reg01: base=0x40000000 (1024MB), size= 512MB:
write-back, count=1
reg02: base=0x60000000 (1536MB), size= 256MB:
write-back, count=1
reg03: base=0x70000000 (1792MB), size= 128MB:
write-back, count=1
reg04: base=0x78000000 (1920MB), size=  64MB:
write-back, count=1
reg05: base=0x7c000000 (1984MB), size=  32MB:
write-back, count=1



# dmesg
Linux version 2.4.18-17.7asp (vasya@hostname.com*)
(gcc version 2.96 20000731 (ASPLinux 7.3 2.96-112)) #2
SMP 2
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000007f800000
(usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000
(reserved)
1144MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fb4f0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 522240
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 292864 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at:
0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=17.7aspSMP3 ro
root=801
Initializing CPU#0
Detected 551.260 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 1095.84 BogoMIPS
Memory: 2051820k/2088960k available (1660k kernel
code, 32528k reserved, 1072k data, 144k init, 1171456k
highme)
Dentry cache hash table entries: 262144 (order: 9,
2097152 bytes)
Inode cache hash table entries: 131072 (order: 8,
1048576 bytes)
Mount cache hash table entries: 32768 (order: 6,
262144 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=257005 max_file_pages=0 max_inodes=0
max_dentries=257005
Buffer cache hash table entries: 131072 (order: 7,
524288 bytes)
Page-cache hash table entries: 524288 (order: 9,
2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: After vendor init, caps: 0383fbff 00000000
00000000 00000000
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
mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: After vendor init, caps: 0383fbff 00000000
00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 91.41 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1099.39 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: After vendor init, caps: 0383fbff 00000000
00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000
00000000 00000000
CPU:             Common caps: 0383fbff 00000000
00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2194.23 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-18, 2-19,
2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
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
 02 002 02  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    79
 0d 003 03  0    0    0   0   0    1    1    81
 0e 003 03  0    0    0   0   0    1    1    89
 0f 003 03  0    0    0   0   0    1    1    91
 10 003 03  1    1    0   1   0    1    1    99
 11 003 03  1    1    0   1   0    1    1    A1
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
IRQ10 -> 0:16
IRQ11 -> 0:17
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 551.0245 MHz.
..... host bus clock speed is 100.0399 MHz.
cpu: 0, clocks: 195699, slice: 65233
CPU0<T0:195696,T1:130448,D:15,S:65233,C:195699>
cpu: 1, clocks: 195699, slice: 65233
CPU1<T0:195696,T1:65216,D:14,S:65233,C:195699>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last
bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem
bounces
VFS: Disk quotas vdquot_6.5.1
SGI XFS CVS-09/19/02:05 with ACLs, quota, no debug
enabled
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP
enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
oprofile: APIC was already enabled
oprofile 0.2 loaded, major 254
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
hdc:DMA, hdd:pio
hdc: ASUS CD-S400/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets,
128Kbytes
TCP: Hash tables configured (established 262144 bind
65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 231k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k
scsi_hostadapter, errno = 2
megaraid: v1.15 (Release Date: Thu Apr 19 09:39:35 EDT
2001)
megaraid: found 0x8086:0x1960:idx 0:bus 0:slot 15:func
1
scsi0 : Found a MegaRAID controller at 0xf884e000,
IRQ: 10
megaraid: [GH8E:1.48] detected 2 logical drives
scsi0 : AMI MegaRAID GH8E 254 commands 16 targs 3
chans 8 luns
scsi0: scanning channel 1 for devices.
scsi0: scanning channel 2 for devices.
scsi0: scanning channel 3 for devices.
scsi0: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID0 17494R  Rev: GH8E
  Type:   Direct-Access                      ANSI SCSI
revision: 02
  Vendor: MegaRAID  Model: LD1 RAID0 52482R  Rev: GH8E
  Type:   Direct-Access                      ANSI SCSI
revision: 02
Attached scsi disk sda at scsi0, channel 3, id 0, lun
0
Attached scsi disk sdb at scsi0, channel 3, id 0, lun
1
SCSI device sda: 35827712 512-byte hdwr sectors (18344
MB)
Partition check:
 sda: sda1 sda2
SCSI device sdb: 107483136 512-byte hdwr sectors
(55031 MB)
 sdb: sdb1
reiserfs: checking transaction log (device 08:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Freeing unused kernel memory: 144k freed
Adding Swap: 1044216k swap-space (priority -1)
3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
00:10.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00.
Vers LK1.1.16
divert: allocating divert_blk for eth0





--- Andrew Morton <akpm@digeo.com> wrote:
>
> Please ensure that the mtrr driver is enabled in
> kernel config,
> boot with mem=2G and send the output of `cat
> /proc/mtrr'.
> 
> Also, `dmesg | head -120' would be interesting.


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
