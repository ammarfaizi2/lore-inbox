Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272068AbRHVRwF>; Wed, 22 Aug 2001 13:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272059AbRHVRv6>; Wed, 22 Aug 2001 13:51:58 -0400
Received: from h24-68-82-46.vc.shawcable.net ([24.68.82.46]:28934 "HELO
	brewt.org") by vger.kernel.org with SMTP id <S272072AbRHVRvm>;
	Wed, 22 Aug 2001 13:51:42 -0400
Date: Wed, 22 Aug 2001 10:52:01 -0700 (PDT)
From: BH <xcp@brewt.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9 smp classic pentium boot message
Message-ID: <Pine.LNX.4.30.0108221042390.20344-100000@stinky.brewt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual P120 board, dual socket 5 Intel Neptune chipset, the Asus
PCI/E-P54NP4.

I've had it for a few years, and up until recently the linux kernel hasn't
said anything alarming about it, and it ran just fine.  With 2.4.9 it is
now barfing on PCI->IRQ mappings, something to do with nonexistant busses.
It's actually *working* just as before, I'm just wondering what these
messages actually mean, and if there is something I need to do to correct it.

lspci -vv:

00:00.0 Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:02.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:05.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:07.0 Unknown mass storage controller: Promise Technology, Inc. 20262
(rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at e000 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at c800 [size=64]
        Region 5: Memory at fbfa0000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]


dmesg:

Linux version 2.4.9 (root@mandelbrot) (gcc version 2.95.3 20010315
(release)) #1 SMP Thu Aug 16 15:22:28 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f8360
hm, page 000f8000 reserved twice.
hm, page 000f9000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f9000 reserved twice.
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTEK0 Product ID: P54NP4000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #1 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is EISA
Bus #1 is PCI
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 0, pol 0, trig 0, bus 0, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 0, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 0, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 0, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 0, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 0, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 0, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 0, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 0, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 0, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 0, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 0, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 0f, APIC ID 2, APIC INT 0f
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=2103 idebus=30
ide_setup: idebus=30
Initializing CPU#0
Detected 120.001 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 239.20 BogoMIPS
Memory: 191060k/196608k available (1023k kernel code, 5156k reserved, 324k
data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
CPU:             Common caps: 000003bf 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
CPU:             Common caps: 000003bf 00000000 00000000 00000000
CPU0: Intel Pentium 75 - 200 stepping 0c
per-CPU timeslice cutoff: 159.74 usecs.
Getting VERSION: 30010
Getting VERSION: 30010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
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
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
mtrr: SMP support incomplete for this vendor
Calibrating delay loop... 239.20 BogoMIPS
Stack at about c13c7fbc
CPU: Before vendor init, caps: 000003bf 00000000 00000000, vendor = 0
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 000003bf 00000000 00000000 00000000
CPU:     After generic, caps: 000003bf 00000000 00000000 00000000
CPU:             Common caps: 000003bf 00000000 00000000 00000000
OK.
CPU1: Intel Pentium 75 - 200 stepping 0c
CPU has booted.
Before bogomips.
Total of 2 processors activated (478.41 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
..TIMER: vector=31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  1    1    0   0   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 119.9983 MHz.
..... host bus clock speed is 59.9987 MHz.
cpu: 0, clocks: 599987, slice: 199995
CPU0<T0:599984,T1:399984,D:5,S:199995,C:599987>
cpu: 1, clocks: 599987, slice: 199995
CPU1<T0:599984,T1:199984,D:10,S:199995,C:599987>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.00 entry at 0xfb620, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware
querying PCI -> IRQ mapping bus:0, slot:4, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
querying PCI -> IRQ mapping bus:0, slot:5, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
querying PCI -> IRQ mapping bus:0, slot:7, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 30MHz system bus speed for PIO modes
PDC20262: IDE controller on PCI bus 00 dev 38
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:pio
hde: Maxtor 32049H2, ATA DISK drive
ide2 at 0xe000-0xe007,0xd802 on irq 15
hde: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=39704/16/63,
UDMA(66)
Partition check:
 hde: [PTBL] [2491/255/63] hde2 hde3 hde4
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack (1536 buckets, 12288 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 21:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 522104k swap-space (priority -1)
inserting floppy driver for 2.4.9
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:04.0: 3Com PCI 3c900 Boomerang 10baseT at 0xe800. Vers LK1.1.16
00:05.0: 3Com PCI 3c900 Boomerang 10baseT at 0xe400. Vers LK1.1.16

