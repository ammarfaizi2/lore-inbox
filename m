Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTERQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTERQ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:58:41 -0400
Received: from moe.greenepa.net ([65.173.148.67]:38018 "EHLO moe.greenepa.net")
	by vger.kernel.org with ESMTP id S262131AbTERQ6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:58:34 -0400
Date: Sun, 18 May 2003 13:11:24 -0400 (EDT)
From: Brad Stockdale <brad@greenepa.net>
X-X-Sender: <brad@shinji.priderock.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: APIC Errors on a SuperMicro P6DBE
Message-ID: <Pine.LNX.4.33.0305181300080.22341-100000@shinji.priderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (moe.greenepa.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

   I've had an interesting event start happening on my SuperMicro P6DBE 
based system.... I was wondering if anyone could shed some light on it...

   First, a little info about the system:

	o SuperMicro P6DBE motherboard
	o Two Intel Pentium III 800 MHz Slot 1 stepping 06 processors
	o Four IDE channels, all used
	o Adaptec 2940 SCSI card
	o SoundBlaster AWE 64 audio card
	o Matrox G200 Quad MMS video card (four-heads)
	o Kernel version 2.4.20-xfs

   Now, as I said I had an interesting problem creep up... For some reason 
over the past week I have started getting APIC errors on this setup... I 
never had them before... I havent upgraded the kernel at all... And I have 
not added any new hardware in a month now...

   Can anyone think of any reason I would be getting them all of the 
sudden? Because I havent changed anything on this system in at least a 
month, my only guess is possibly the APIC is flaking out on the board 
itself or some such... 

   Any ideas would be much appreciated... They arent causing any system 
instability (yet), but I have a feeling they are only going to get worse 
unless I figure out what is causing them...

   Attached to the end of this message is my dmesg... Maybe someone can 
see something I missed when I looked over it...

Thanks,
Brad

-----[ Begin dmesg ]-----
Linux version 2.4.20-xfs (root@megatron.greenepa.net) (gcc version 2.96 
20000731
 (Red Hat Linux 7.1 2.96-98)) #1 SMP Fri Dec 27 00:48:11 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000012000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
288MB LOWMEM available.
found SMP MP-table at 000fb4c0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 73728
zone(0): 4096 pages.
zone(1): 69632 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: root=/dev/hdc1
Initializing CPU#0
Detected 801.833 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1599.07 BogoMIPS
Memory: 287168k/294912k available (2207k kernel code, 7356k reserved, 
1392k data
, 112k init, 0k highmem)
kdb version 2.5 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights 
Reserve
d
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
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
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 732.15 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1602.35 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3201.43 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-18, 2-20, 2-21, 2-22, 2-23 
not con
nected.
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
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    89
 0f 003 03  0    0    0   0   0    1    1    91
 10 003 03  1    1    0   1   0    1    1    99
 11 003 03  1    1    0   1   0    1    1    A1
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    A9
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
IRQ9 -> 0:17
IRQ10 -> 0:16
IRQ11 -> 0:19
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 801.8676 MHz.
..... host bus clock speed is 100.2329 MHz.
cpu: 0, clocks: 1002329, slice: 334109
CPU0<T0:1002320,T1:668208,D:3,S:334109,C:1002329>
cpu: 1, clocks: 1002329, slice: 334109
CPU1<T0:1002320,T1:334096,D:6,S:334109,C:1002329>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS snapshot 2.4.20-2002-11-29_01:21_UTC with ACLs, quota, no debug 
enabled
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: CD-ROM CDU711, ATAPI CD/DVD-ROM drive
hdb: ST360021A, ATA DISK drive
hdc: ST360020A, ATA DISK drive
hdd: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c04f7ef0, I/O limit 4095Mb (mask 0xffffffff)
hdb: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, 
UDMA(33)
blk: queue c04f8108, I/O limit 4095Mb (mask 0xffffffff)
hdc: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, 
UDMA(33)
blk: queue c04f8254, I/O limit 4095Mb (mask 0xffffffff)
hdd: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, 
UDMA(33)
Partition check:
 hdb: hdb1
 hdc: [PTBL] [7297/255/63] hdc1 hdc2 hdc3
 hdd: [PTBL] [4865/255/63] hdd1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:10.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xef00. Vers LK1.1.16
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 233M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] AGP 0.99 on Intel 440BX @ 0xf4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
[drm] AGP 0.99 on Intel 440BX @ 0xf4000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 1
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: IBM       Model: DGVS09U           Rev: 0350
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: C5683A            Rev: C104
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-ROM CDU711     Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 
16
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17829870 512-byte hdwr sectors (9129 MB)
 sda: sda1
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 14x/14x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 5, dma 1, 5
sb: 1 Soundblaster PnP card(s) found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Real Time Clock Driver v1.10e
Adding Swap: 265064k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
XFS mounting filesystem sd(8,1)
Ending clean XFS mount for filesystem: sd(8,1)
Loading 1.2 (16[1] devices)...
xsvc: v3.0 (devrel@xig.com) [$XiGDate: 2003/02/17 23:48:43 $]
xsvc: Intel 440BX/ZX, 64MB at 0xf4000000 (1f000203/01)
APIC error on CPU1: 00(01)
APIC error on CPU0: 00(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
unexpected IRQ trap at vector 1c
unexpected IRQ trap at vector ac
unexpected IRQ trap at vector 1c
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
unexpected IRQ trap at vector d8
unexpected IRQ trap at vector 1c
unexpected IRQ trap at vector ac
unexpected IRQ trap at vector 1c
unexpected IRQ trap at vector 1c
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
unexpected IRQ trap at vector 1c
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
unexpected IRQ trap at vector ac
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
unexpected IRQ trap at vector ac
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(08)
APIC error on CPU0: 08(02)
APIC error on CPU1: 01(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(06)
APIC error on CPU0: 06(02)
APIC error on CPU1: 02(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(04)
APIC error on CPU0: 04(02)
APIC error on CPU1: 01(01)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)


