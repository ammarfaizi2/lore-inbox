Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTFMIma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTFMIm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:42:29 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:26381 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S265265AbTFMImM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:42:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: HyperThreading not working in 2.4.21-rc6-ac2
Date: Fri, 13 Jun 2003 09:49:24 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306130949.24402.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following is a dmesg from a Dell PowerEdge 2650 server with 2 2.4Ghx HT 
capable processors.
To the best of my knowledge, I have HT enabled in the bios but I still only 
see the physical processors (no siblings) even though the cpus are numbered 
as if I have siblings.

Any suggestions?

Mark.


[root@mail1 root]# dmesg
Linux version 2.4.21-rc6-ac2 (root@samantha.eris.qinetiq.com) (gcc version 
3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #12 SMP Wed Jun 4 13:58:30 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fffec00 (ACPI data)
 BIOS-e820: 000000007fffec00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: PE 0121      APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Processor #2 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
I/O APIC #6 Version 17 at 0xFEC02000.
Processors: 2
xAPIC support is present
Enabling APIC mode: Flat.       Using 3 I/O APICs
Kernel command line: auto BOOT_IMAGE=2421rc6ac2 ro root=801 devfs=mount 
hda=ide-scsi acpi=off
ide_setup: hda=ide-scsi
Initializing CPU#0
Detected 2392.318 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 2069080k/2097088k available (1493k kernel code, 27624k reserved, 551k 
data, 112k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 2 processors activated (9555.14 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
Setting 6 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 6 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-7, 4-10, 4-11, 4-13, 6-0, 6-1, 6-2, 6-3, 6-4, 
6-5, 6-6, 6-7, 6-8, 6-9, 6-10, 6-11, 6-12, 6-13, 6-14, 6-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 33.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
number of IO-APIC #6 registers: 16.
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
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 0FF 0F  0    0    0   0   0    1    1    31
 01 0FF 0F  0    0    0   0   0    1    1    39
 02 002 02  1    0    0   0   0    0    0    00
 03 0FF 0F  0    0    0   0   0    1    1    41
 04 0FF 0F  0    0    0   0   0    1    1    49
 05 0FF 0F  1    1    0   1   0    1    1    51
 06 0FF 0F  0    0    0   0   0    1    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 0FF 0F  0    0    0   0   0    1    1    61
 09 0FF 0F  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 0FF 0F  0    0    0   0   0    1    1    79
 0f 0FF 0F  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 05000000
.......     : arbitration: 05
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 0FF 0F  1    1    0   1   0    1    1    89
 01 0FF 0F  1    1    0   1   0    1    1    91
 02 0FF 0F  1    1    0   1   0    1    1    99
 03 0FF 0F  1    1    0   1   0    1    1    A1
 04 0FF 0F  1    1    0   1   0    1    1    A9
 05 0FF 0F  1    1    0   1   0    1    1    B1
 06 0FF 0F  1    1    0   1   0    1    1    B9
 07 0FF 0F  1    1    0   1   0    1    1    C1
 08 0FF 0F  1    1    0   1   0    1    1    C9
 09 0FF 0F  1    1    0   1   0    1    1    D1
 0a 0FF 0F  1    1    0   1   0    1    1    D9
 0b 0FF 0F  1    1    0   1   0    1    1    E1
 0c 0FF 0F  1    1    0   1   0    1    1    E9
 0d 0FF 0F  1    1    0   1   0    1    1    32
 0e 0FF 0F  1    1    0   1   0    1    1    3A
 0f 0FF 0F  1    1    0   1   0    1    1    42

IO APIC #6......
.... register #00: 06000000
.......    : physical APIC id: 06
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 06000000
.......     : arbitration: 06
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
IRQ26 -> 1:10
IRQ27 -> 1:11
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
IRQ31 -> 1:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2392.3527 MHz.
..... host bus clock speed is 99.6812 MHz.
cpu: 0, clocks: 996812, slice: 332270
CPU0<T0:996800,T1:664528,D:2,S:332270,C:996812>
cpu: 1, clocks: 996812, slice: 332270
CPU1<T0:996800,T1:332256,D:4,S:332270,C:996812>
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xfc97e, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Discovered primary peer bus 03 [IRQ]
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI->APIC IRQ transform: (B0,I4,P0) -> 19
PCI->APIC IRQ transform: (B0,I4,P1) -> 23
PCI->APIC IRQ transform: (B0,I4,P2) -> 27
PCI->APIC IRQ transform: (B1,I6,P0) -> 16
PCI->APIC IRQ transform: (B1,I6,P1) -> 17
PCI->APIC IRQ transform: (B3,I6,P0) -> 28
PCI->APIC IRQ transform: (B3,I8,P0) -> 29
PCI->APIC IRQ transform: (B4,I8,P0) -> 30
PCI->APIC IRQ transform: (B5,I6,P0) -> 30
PCI->APIC IRQ transform: (B5,I6,P1) -> 31
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:DMA
hda: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 163k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1.2 Jun  4 2003 13:34:53)
AAC0: kernel 2.7.4 build 3170
AAC0: monitor 2.7.4 build 3170
AAC0: bios 2.7.0 build 3170
AAC0: serial 8cd810d3fafaf001
scsi0 : percraid
  Vendor: DELL      Model: PERCRAID RAID5    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: BNCHMARK  Model: DLT1              Rev: 5032
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi1:A:6): 20.000MB/s transfers (10.000MHz, offset 15, 16bit)
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 430071552 512-byte hdwr sectors (220197 MB)
sda: Write Protect is off
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
Adding Swap: 1044184k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
st: Version 20030406, bufsize 32768, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
tg3.c:v1.5 (March 21, 2003)
eth0: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 
10/100/1000BaseT Ethernet 00:06:5b:fd:36:b3
eth1: Tigon3 [partno(BCM95701A10) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 
10/100/1000BaseT Ethernet 00:06:5b:fd:36:b4
bonding.c:v2.4.20-20030320 (March 20, 2003)

- -- 
Mark Watts
Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6ZAUBn4EFUVUIO0RAlJoAJ0Q6IzGfmhNyan2SppavevoJrFOQACg9xOJ
rMj9hU94bgKnYauguIpWzxE=
=6W1S
-----END PGP SIGNATURE-----

