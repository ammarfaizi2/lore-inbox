Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSHVB37>; Wed, 21 Aug 2002 21:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSHVB37>; Wed, 21 Aug 2002 21:29:59 -0400
Received: from umdgrb.umd.edu ([129.2.41.9]:37587 "EHLO umdgrb.umd.edu")
	by vger.kernel.org with ESMTP id <S319274AbSHVB3z>;
	Wed, 21 Aug 2002 21:29:55 -0400
Date: Wed, 21 Aug 2002 21:33:55 -0400 (EDT)
From: Andy Smith <asmith@umdgrb.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ENOMEM in do_get_write_access, retrying. 
Message-ID: <Pine.LNX.4.33.0208212133070.7748-100000@umdgrb.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in journal_alloc_journal_head, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.

Hi All,

I am getting a bunch of these in my messages file while cp'ing 
files from one computer 2 another. Both machines have 3c996 gigabit
and large disk arrays. The computer with the errors is receiving the 
files. 

The computer with the errors has:

Tyan S2462 Mobo with dual AMD Athlon 1900+ MP cpus
2GB Memory
3c996 gigabit card
1.76TB scsi raid array attached to onboard adaptec U160 SCSI card.
Redhat Linux 7.3 with updates running 2.4.18-5smp

Below is the output of dmesg.

What's Up?

Thanks -Andy

---------

Linux version 2.4.18-5smp (bhcompile@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Mon Jun 10 15:01:05 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff6c00 (ACPI data)
 BIOS-e820: 000000007fff6c00 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f74d0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: ro root=/dev/sda2
Initializing CPU#0
Detected 1592.928 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3178.49 BogoMIPS
Memory: 2064568k/2097088k available (1225k kernel code, 32132k reserved, 851k data, 316k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
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
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 1900+ stepping 02
per-CPU timeslice cutoff: 731.57 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3185.04 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6363.54 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
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
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
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
..... CPU clock speed is 1592.8588 MHz.
..... host bus clock speed is 265.4764 MHz.
cpu: 0, clocks: 2654764, slice: 884921
CPU0<T0:2654752,T1:1769824,D:7,S:884921,C:2654764>
cpu: 1, clocks: 2654764, slice: 884921
CPU1<T0:2654752,T1:884896,D:14,S:884921,C:2654764>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD7411: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: FX54++W, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 244k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor:           Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 2, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 >
(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
SCSI device sdb: -773160960 512-byte hdwr sectors (-395857 MB)
 sdb: unknown partition table
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 316k freed
Adding Swap: 1020116k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc00dc000, IRQ 11
usb-ohci.c: usb-00:07.4, Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_conntrack (8192 buckets, 65536 max)
tg3.c:v0.98 (Mar 28, 2002)
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:f4:f1:53
eth0: Link is up at 100 Mbps, full duplex.
eth0: Flow control is on for TX and on for RX.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0f.0: 3Com PCI 3c980C Python-T at 0x1c00. Vers LK1.1.17
00:10.0: 3Com PCI 3c980C Python-T at 0x1c80. Vers LK1.1.17
SCSI device sdb: -773160960 512-byte hdwr sectors (-395857 MB)
 sdb: sdb1
SCSI device sdb: -773160960 512-byte hdwr sectors (-395857 MB)
 sdb: sdb1
(scsi1:A:2:0): Locking max tag count at 123
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Link is down.
eth0: Link is up at 1000 Mbps, full duplex.
eth0: Flow control is on for TX and on for RX.
nfs: server cetus08 is not responding
nfs: server cetus08 OK
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in journal_alloc_journal_head, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in journal_alloc_journal_head, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.
ENOMEM in do_get_write_access, retrying.


-------------------------------------------------------------------------
Andrew Smith                                        (301) 405-2152
Department of Physics                               asmith@umdgrb.umd.edu
University of Maryland
College Park, MD 20742-4111
-------------------------------------------------------------------------



