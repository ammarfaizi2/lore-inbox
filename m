Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbRGYB2h>; Tue, 24 Jul 2001 21:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbRGYB23>; Tue, 24 Jul 2001 21:28:29 -0400
Received: from sunfish.linuxis.net ([64.71.162.66]:41110 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S268537AbRGYB2M>; Tue, 24 Jul 2001 21:28:12 -0400
Date: Tue, 24 Jul 2001 18:25:12 -0700
From: Adam McKenna <adam-dated-996283107.318d97@flounder.net>
To: linux-kernel@vger.kernel.org
Subject: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
Message-ID: <20010724182512.B4614@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have a Penguin Computing 1U server with a ServerWorks OSB4 chipset.  I'm
running Linux 2.4.6-xfs on it (although this happened with non-XFS 2.4.5 as
well).

When the system is booting, I get the following errors:

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA

>From what I've been able to find on Google, there are several other people
with this problem;  Has anyone come up with a solution?  I have ServerWorks
OSB4 support compiled into the kernel, but this happens with or without it.

Full dmesg output:

Linux version 2.4.6-xfs (root@kahlua) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #2 SMP Wed Jul 25 01:04:17 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: AMI      Product ID: CNB20HE      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    PSN  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    PSN  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is PCI   
Bus #3 is ISA   
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 5, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 4, APIC INT 0a
Int: type 0, pol 3, trig 3, bus 0, IRQ 18, APIC ID 5, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 10, APIC ID 5, APIC INT 0c
Int: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID 4, APIC INT 00
Int: type 0, pol 1, trig 1, bus 3, IRQ 01, APIC ID 4, APIC INT 01
Int: type 0, pol 1, trig 1, bus 3, IRQ 00, APIC ID 4, APIC INT 02
Int: type 0, pol 1, trig 1, bus 3, IRQ 03, APIC ID 4, APIC INT 03
Int: type 0, pol 1, trig 1, bus 3, IRQ 04, APIC ID 4, APIC INT 04
Int: type 0, pol 1, trig 1, bus 3, IRQ 06, APIC ID 4, APIC INT 06
Int: type 0, pol 1, trig 1, bus 3, IRQ 07, APIC ID 4, APIC INT 07
Int: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 4, APIC INT 08
Int: type 0, pol 1, trig 1, bus 3, IRQ 0c, APIC ID 4, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 3, IRQ 0d, APIC ID 4, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 3, IRQ 0e, APIC ID 4, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 3, IRQ 0f, APIC ID 4, APIC INT 0f
Lint: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec01000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 BOOT_FILE=/vmlinuz
Initializing CPU#0
Detected 866.303 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1730.15 BogoMIPS
Memory: 1028048k/1048576k available (1625k kernel code, 20140k reserved, 531k data, 200k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 730.81 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1730.15 BogoMIPS
Stack at about c2119fbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 0a
CPU has booted.
Before bogomips.
Total of 2 processors activated (3460.30 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 4 ... ok.
...changing IO-APIC physical APIC ID to 5 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-13 not connected.
..TIMER: vector=31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
activating NMI Watchdog ... done.
number of MP IRQ sources: 16.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 07000000
.......     : arbitration: 07
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
 0c 003 03  1    1    0   1   0    1    1    91
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  1    1    0   1   0    1    1    99
 0f 003 03  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ10 -> 10
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ28 -> 12
IRQ30 -> 14
IRQ31 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 866.1198 MHz.
..... host bus clock speed is 133.2491 MHz.
cpu: 0, clocks: 1332491, slice: 444163
CPU0<T0:1332480,T1:888304,D:13,S:444163,C:1332491>
cpu: 1, clocks: 1332491, slice: 444163
CPU1<T0:1332480,T1:444144,D:10,S:444163,C:1332491>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
querying PCI -> IRQ mapping bus:0, slot:4, pin:0.
PCI->APIC IRQ transform: (B0,I4,P0) -> 28
querying PCI -> IRQ mapping bus:0, slot:6, pin:0.
PCI->APIC IRQ transform: (B0,I6,P0) -> 31
querying PCI -> IRQ mapping bus:0, slot:15, pin:0.
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
PCI->APIC IRQ transform: (B1,I0,P0) -> 30
PCI: Cannot allocate resource region 1 of device 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 683117kB/552045kB, 2048 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
hdb: QUANTUM FIREBALLP AS30.0, ATA DISK drive
hdc: SR242S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=3649/255/63, UDMA(33)
hdb: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=3649/255/63, UDMA(33)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1 hdb2 hdb3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:11:52:FE, IRQ 31.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:30:48:11:52:FD, IRQ 28.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
Start mounting filesystem: ide0(3,1)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
Ending clean XFS mount for filesystem: ide0(3,1)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 2000084k swap-space (priority -1)
Start mounting filesystem: ide0(3,65)
Ending clean XFS mount for filesystem: ide0(3,65)
Start mounting filesystem: ide0(3,66)
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
Ending clean XFS mount for filesystem: ide0(3,66)
Start mounting filesystem: ide0(3,67)
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x50 { DriveReady SeekComplete }
Starting XFS recovery on filesystem: ide0(3,67) (dev: 3/67)
Ending XFS recovery on filesystem: ide0(3,67) (dev: 3/67)
Start mounting filesystem: ide0(3,3)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
Ending clean XFS mount for filesystem: ide0(3,3)
eth0: 0 multicast blocks dropped.

Thanks,

--Adam

-- 
Adam McKenna <adam@flounder.net>   | Help stop animal abuse at Petco!
http://flounder.net/publickey.html | http://www.mickaboofriends.org
GPG: 17A4 11F7 5E7E C2E7 08AA      |
     38B0 05D0 8BF7 2C6D 110A      |
