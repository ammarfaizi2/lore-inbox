Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270047AbTGUNV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbTGUNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:20:37 -0400
Received: from dynagate4.dynamica.it ([81.208.25.146]:33974 "EHLO
	dyna.dynamica.it") by vger.kernel.org with ESMTP id S270047AbTGUNTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:19:36 -0400
Date: Mon, 21 Jul 2003 13:07:09 +0200
From: "Luigi Montella V." <luigi@dynamica.it>
To: davies@maniac.ultranet.com
Subject: PROBLEM: de4x5.o module ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S270065AbTGUNUh/20030721132037Z+4368@vger.kernel.org>

Hi.
I use de4x5.o kernel module for my ethernet card and i've encountered
a problem during translation of a big file ( ~2Gb) .
If I start my transfer and after turn-on or turn-off 'iptraf' machine
crash : no error log or dump reported neither in consolle or in any
log file ... simply HALT.
In my opinion the problem begin when try to setting eth to promiscuos
mode.
I'm sure that the trasfer run on eth1 : DECchip 2114
My kernel version is 2.4.20. 
I can paste you my lspci output:


00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev
 c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AG
P] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ded00000-dfdfffff
        Prefetchable memory behind bridge: dcb00000-debfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22
)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8
a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UH
CI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UH
CI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        BIST result: 00
        Region 0: I/O ports at dc00 [disabled] [size=256]
        Region 1: Memory at dffff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at dffc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [Faster
Net] (rev 22)
        Subsystem: Kingston Technologies KNE100TX Fast Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 96 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at d000 [size=128]
        Region 1: Memory at dfffef00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at dff40000 [disabled] [size=256K]

00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30
)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at d400 [size=128]
        Region 1: Memory at dfffef80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at dffa0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 07)
        Subsystem: Giga-byte Technology: Unknown device 2060
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03) (
prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at dd000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at dfdfc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at dfde0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

... and my boot syslog :

Jul 20 20:29:08 dynagate4 syslogd 1.4.1#10: restart.
Jul 20 20:29:08 dynagate4 kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Jul 20 20:29:08 dynagate4 kernel: Inspecting /boot/System.map-2.4.20
Jul 20 20:29:09 dynagate4 kernel: Loaded 20121 symbols from /boot/System.map-2.4.20.
Jul 20 20:29:09 dynagate4 kernel: Symbols match kernel version 2.4.20.
Jul 20 20:29:09 dynagate4 kernel: Loaded 384 symbols from 29 modules.
Jul 20 20:29:09 dynagate4 kernel: Linux version 2.4.20 (root@dynagate4) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 SMP Mon Jun 30 13:08:55 CEST 2003
Jul 20 20:29:09 dynagate4 kernel: BIOS-provided physical RAM map:
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jul 20 20:29:09 dynagate4 kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jul 20 20:29:09 dynagate4 kernel: 127MB HIGHMEM available.
Jul 20 20:29:09 dynagate4 kernel: 896MB LOWMEM available.
Jul 20 20:29:09 dynagate4 kernel: found SMP MP-table at 000fb260
Jul 20 20:29:09 dynagate4 kernel: hm, page 000fb000 reserved twice.
Jul 20 20:29:09 dynagate4 kernel: hm, page 000fc000 reserved twice.
Jul 20 20:29:09 dynagate4 kernel: hm, page 000f5000 reserved twice.
Jul 20 20:29:09 dynagate4 kernel: hm, page 000f6000 reserved twice.
Jul 20 20:29:09 dynagate4 kernel: On node 0 totalpages: 262128
Jul 20 20:29:09 dynagate4 kernel: zone(0): 4096 pages.
Jul 20 20:29:09 dynagate4 kernel: zone(1): 225280 pages.
Jul 20 20:29:09 dynagate4 kernel: zone(2): 32752 pages.
Jul 20 20:29:09 dynagate4 kernel: Intel MultiProcessor Specification v1.1
Jul 20 20:29:09 dynagate4 kernel:     Virtual Wire compatibility mode.
Jul 20 20:29:09 dynagate4 kernel: OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
Jul 20 20:29:09 dynagate4 kernel: Processor #0 Pentium(tm) Pro APIC version 17
Jul 20 20:29:09 dynagate4 kernel: Processor #1 Pentium(tm) Pro APIC version 17
Jul 20 20:29:09 dynagate4 kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jul 20 20:29:09 dynagate4 kernel: Processors: 2
Jul 20 20:29:09 dynagate4 kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=803
Jul 20 20:29:09 dynagate4 kernel: Initializing CPU#0
Jul 20 20:29:09 dynagate4 kernel: Detected 797.265 MHz processor.
Jul 20 20:29:09 dynagate4 kernel: Console: colour VGA+ 80x25
Jul 20 20:29:09 dynagate4 kernel: Calibrating delay loop... 1589.24 BogoMIPS
Jul 20 20:29:09 dynagate4 kernel: Memory: 1032780k/1048512k available (1703k kernel code, 15344k reserved, 706k data, 124k init, 131008k highmem)
Jul 20 20:29:09 dynagate4 kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jul 20 20:29:09 dynagate4 kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 20 20:29:09 dynagate4 kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Jul 20 20:29:09 dynagate4 kernel: Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 20 20:29:09 dynagate4 kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Jul 20 20:29:09 dynagate4 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 20 20:29:09 dynagate4 kernel: CPU: L2 cache: 256K
Jul 20 20:29:09 dynagate4 kernel: Intel machine check architecture supported.
Jul 20 20:29:09 dynagate4 kernel: Intel machine check reporting enabled on CPU#0.
Jul 20 20:29:09 dynagate4 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: Enabling fast FPU save and restore... done.
Jul 20 20:29:09 dynagate4 kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 20 20:29:09 dynagate4 kernel: Checking 'hlt' instruction... OK.
Jul 20 20:29:09 dynagate4 kernel: POSIX conformance testing by UNIFIX
Jul 20 20:29:09 dynagate4 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 20 20:29:09 dynagate4 kernel: mtrr: detected mtrr type: Intel
Jul 20 20:29:09 dynagate4 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 20 20:29:09 dynagate4 kernel: CPU: L2 cache: 256K
Jul 20 20:29:09 dynagate4 kernel: Intel machine check reporting enabled on CPU#0.
Jul 20 20:29:09 dynagate4 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: CPU0: Intel Pentium III (Coppermine) stepping 06
Jul 20 20:29:09 dynagate4 kernel: per-CPU timeslice cutoff: 731.12 usecs.
Jul 20 20:29:09 dynagate4 kernel: enabled ExtINT on CPU#0
Jul 20 20:29:09 dynagate4 kernel: ESR value before enabling vector: 00000084
Jul 20 20:29:09 dynagate4 kernel: ESR value after enabling vector: 00000000
Jul 20 20:29:09 dynagate4 kernel: Booting processor 1/1 eip 2000
Jul 20 20:29:09 dynagate4 kernel: Initializing CPU#1
Jul 20 20:29:09 dynagate4 kernel: masked ExtINT on CPU#1
Jul 20 20:29:09 dynagate4 kernel: ESR value before enabling vector: 00000000
Jul 20 20:29:09 dynagate4 kernel: ESR value after enabling vector: 00000000
Jul 20 20:29:09 dynagate4 kernel: Calibrating delay loop... 1592.52 BogoMIPS
Jul 20 20:29:09 dynagate4 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 20 20:29:09 dynagate4 kernel: CPU: L2 cache: 256K
Jul 20 20:29:09 dynagate4 kernel: Intel machine check reporting enabled on CPU#1.
Jul 20 20:29:09 dynagate4 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Jul 20 20:29:09 dynagate4 kernel: CPU1: Intel Pentium III (Coppermine) stepping 06
Jul 20 20:29:09 dynagate4 kernel: Total of 2 processors activated (3181.77 BogoMIPS).
Jul 20 20:29:09 dynagate4 kernel: ENABLING IO-APIC IRQs
Jul 20 20:29:09 dynagate4 kernel: Setting 2 in the phys_id_present_map
Jul 20 20:29:09 dynagate4 kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Jul 20 20:29:09 dynagate4 kernel: init IO_APIC IRQs
Jul 20 20:29:09 dynagate4 kernel:  IO-APIC (apicid-pin) 2-0, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
Jul 20 20:29:09 dynagate4 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jul 20 20:29:09 dynagate4 kernel: number of MP IRQ sources: 24.
Jul 20 20:29:09 dynagate4 kernel: number of IO-APIC #2 registers: 24.
Jul 20 20:29:09 dynagate4 kernel: testing the IO APIC.......................
Jul 20 20:29:09 dynagate4 kernel: 
Jul 20 20:29:09 dynagate4 kernel: IO APIC #2......
Jul 20 20:29:09 dynagate4 kernel: .... register #00: 02000000
Jul 20 20:29:09 dynagate4 kernel: .......    : physical APIC id: 02
Jul 20 20:29:09 dynagate4 kernel: .... register #01: 00170011
Jul 20 20:29:09 dynagate4 kernel: .......     : max redirection entries: 0017
Jul 20 20:29:09 dynagate4 kernel: .......     : PRQ implemented: 0
Jul 20 20:29:09 dynagate4 kernel: .......     : IO APIC version: 0011
Jul 20 20:29:09 dynagate4 kernel: .... register #02: 00000000
Jul 20 20:29:09 dynagate4 kernel: .......     : arbitration: 00
Jul 20 20:29:09 dynagate4 kernel: .... IRQ redirection table:
Jul 20 20:29:09 dynagate4 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul 20 20:29:09 dynagate4 kernel:  00 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel:  01 003 03  0    0    0   0   0    1    1    39
Jul 20 20:29:09 dynagate4 kernel:  02 003 03  0    0    0   0   0    1    1    31
Jul 20 20:29:09 dynagate4 kernel:  03 003 03  0    0    0   0   0    1    1    41
Jul 20 20:29:09 dynagate4 kernel:  04 003 03  0    0    0   0   0    1    1    49
Jul 20 20:29:09 dynagate4 kernel:  05 003 03  0    0    0   0   0    1    1    51
Jul 20 20:29:09 dynagate4 kernel:  06 003 03  0    0    0   0   0    1    1    59
Jul 20 20:29:09 dynagate4 kernel:  07 003 03  0    0    0   0   0    1    1    61
Jul 20 20:29:09 dynagate4 kernel:  08 003 03  0    0    0   0   0    1    1    69
Jul 20 20:29:09 dynagate4 kernel:  09 003 03  0    0    0   0   0    1    1    71
Jul 20 20:29:09 dynagate4 kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jul 20 20:29:09 dynagate4 kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jul 20 20:29:09 dynagate4 kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jul 20 20:29:09 dynagate4 kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jul 20 20:29:09 dynagate4 kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jul 20 20:29:09 dynagate4 kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jul 20 20:29:09 dynagate4 kernel:  10 003 03  1    1    0   1   0    1    1    A9
Jul 20 20:29:09 dynagate4 kernel:  11 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel:  12 003 03  1    1    0   1   0    1    1    B1
Jul 20 20:29:09 dynagate4 kernel:  13 003 03  1    1    0   1   0    1    1    B9
Jul 20 20:29:09 dynagate4 kernel:  14 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel:  15 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel:  16 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel:  17 000 00  1    0    0   0   0    0    0    00
Jul 20 20:29:09 dynagate4 kernel: IRQ to pin mappings:
Jul 20 20:29:09 dynagate4 kernel: IRQ0 -> 0:2
Jul 20 20:29:09 dynagate4 kernel: IRQ1 -> 0:1
Jul 20 20:29:09 dynagate4 kernel: IRQ3 -> 0:3
Jul 20 20:29:09 dynagate4 kernel: IRQ4 -> 0:4
Jul 20 20:29:09 dynagate4 kernel: IRQ5 -> 0:5
Jul 20 20:29:09 dynagate4 kernel: IRQ6 -> 0:6
Jul 20 20:29:09 dynagate4 kernel: IRQ7 -> 0:7
Jul 20 20:29:09 dynagate4 kernel: IRQ8 -> 0:8
Jul 20 20:29:09 dynagate4 kernel: IRQ9 -> 0:9
Jul 20 20:29:09 dynagate4 kernel: IRQ10 -> 0:10
Jul 20 20:29:09 dynagate4 kernel: IRQ11 -> 0:11
Jul 20 20:29:09 dynagate4 kernel: IRQ12 -> 0:12
Jul 20 20:29:09 dynagate4 kernel: IRQ13 -> 0:13
Jul 20 20:29:09 dynagate4 kernel: IRQ14 -> 0:14
Jul 20 20:29:09 dynagate4 kernel: IRQ15 -> 0:15
Jul 20 20:29:09 dynagate4 kernel: IRQ16 -> 0:16
Jul 20 20:29:09 dynagate4 kernel: IRQ18 -> 0:18
Jul 20 20:29:09 dynagate4 kernel: IRQ19 -> 0:19
Jul 20 20:29:09 dynagate4 kernel: .................................... done.
Jul 20 20:29:09 dynagate4 kernel: Using local APIC timer interrupts.
Jul 20 20:29:09 dynagate4 kernel: calibrating APIC timer ...
Jul 20 20:29:09 dynagate4 kernel: ..... CPU clock speed is 797.1692 MHz.
Jul 20 20:29:09 dynagate4 kernel: ..... host bus clock speed is 132.8612 MHz.
Jul 20 20:29:09 dynagate4 kernel: cpu: 0, clocks: 1328612, slice: 442870
Jul 20 20:29:09 dynagate4 kernel: CPU0<T0:1328608,T1:885728,D:10,S:442870,C:1328612>
Jul 20 20:29:09 dynagate4 kernel: cpu: 1, clocks: 1328612, slice: 442870
Jul 20 20:29:09 dynagate4 kernel: CPU1<T0:1328608,T1:442864,D:4,S:442870,C:1328612>
Jul 20 20:29:09 dynagate4 kernel: checking TSC synchronization across CPUs: passed.
Jul 20 20:29:09 dynagate4 kernel: Waiting on wait_init_idle (map = 0x2)
Jul 20 20:29:09 dynagate4 kernel: All processors have done init_idle
Jul 20 20:29:09 dynagate4 kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Jul 20 20:29:09 dynagate4 kernel: mtrr: probably your BIOS does not setup all CPUs
Jul 20 20:29:09 dynagate4 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
Jul 20 20:29:09 dynagate4 kernel: PCI: Using configuration type 1
Jul 20 20:29:09 dynagate4 kernel: PCI: Probing PCI hardware
Jul 20 20:29:09 dynagate4 kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> 19
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 16
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B0,I14,P0) -> 18
Jul 20 20:29:09 dynagate4 kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Jul 20 20:29:09 dynagate4 kernel: PCI: Enabling Via external APIC routing
Jul 20 20:29:09 dynagate4 kernel: PCI: Via IRQ fixup for 00:07.3, from 9 to 3
Jul 20 20:29:09 dynagate4 kernel: PCI: Via IRQ fixup for 00:07.2, from 9 to 3
Jul 20 20:29:09 dynagate4 kernel: isapnp: Scanning for PnP cards...
Jul 20 20:29:09 dynagate4 kernel: isapnp: No Plug & Play device found
Jul 20 20:29:09 dynagate4 kernel: Linux NET4.0 for Linux 2.4
Jul 20 20:29:09 dynagate4 kernel: Based upon Swansea University Computer Society NET3.039
Jul 20 20:29:09 dynagate4 kernel: Initializing RT netlink socket
Jul 20 20:29:09 dynagate4 kernel: Starting kswapd
Jul 20 20:29:09 dynagate4 kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Jul 20 20:29:09 dynagate4 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Jul 20 20:29:09 dynagate4 kernel: Journalled Block Device driver loaded
Jul 20 20:29:09 dynagate4 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jul 20 20:29:09 dynagate4 kernel: ACPI: Core Subsystem version [20011018]
Jul 20 20:29:09 dynagate4 kernel: ACPI: Subsystem enabled
Jul 20 20:29:09 dynagate4 kernel: pty: 256 Unix98 ptys configured
Jul 20 20:29:09 dynagate4 kernel: Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 20 20:29:09 dynagate4 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 20 20:29:09 dynagate4 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jul 20 20:29:09 dynagate4 kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Jul 20 20:29:09 dynagate4 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 20 20:29:09 dynagate4 kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Jul 20 20:29:09 dynagate4 kernel: VP_IDE: detected chipset, but driver not compiled in!
Jul 20 20:29:09 dynagate4 kernel: VP_IDE: chipset revision 16
Jul 20 20:29:09 dynagate4 kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jul 20 20:29:09 dynagate4 kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
Jul 20 20:29:09 dynagate4 kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Jul 20 20:29:09 dynagate4 kernel: hda: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
Jul 20 20:29:09 dynagate4 kernel: hdb: IC35L090AVV207-0, ATA DISK drive
Jul 20 20:29:09 dynagate4 kernel: hdc: IC35L090AVV207-0, ATA DISK drive
Jul 20 20:29:09 dynagate4 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 20 20:29:09 dynagate4 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 20 20:29:09 dynagate4 kernel: hdb: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=10011/255/63
Jul 20 20:29:09 dynagate4 kernel: hdc: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=10011/255/63
Jul 20 20:29:09 dynagate4 kernel: hda: ATAPI 52X CD-ROM drive, 128kB Cache
Jul 20 20:29:09 dynagate4 kernel: Uniform CD-ROM driver Revision: 3.12
Jul 20 20:29:09 dynagate4 kernel: Partition check:
Jul 20 20:29:09 dynagate4 kernel:  hdb:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
Jul 20 20:29:09 dynagate4 kernel:  hdb1
Jul 20 20:29:09 dynagate4 kernel:  hdc:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
Jul 20 20:29:09 dynagate4 kernel:  hdc1
Jul 20 20:29:09 dynagate4 kernel: Floppy drive(s): fd0 is 1.44M
Jul 20 20:29:09 dynagate4 kernel: FDC 0 is a post-1991 82077
Jul 20 20:29:09 dynagate4 kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Jul 20 20:29:09 dynagate4 kernel: agpgart: Maximum main memory to use for agp memory: 941M
Jul 20 20:29:09 dynagate4 kernel: agpgart: Detected Via Apollo Pro chipset
Jul 20 20:29:09 dynagate4 kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Jul 20 20:29:09 dynagate4 kernel: SCSI subsystem driver Revision: 1.00
Jul 20 20:29:09 dynagate4 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Jul 20 20:29:09 dynagate4 kernel:         <Adaptec 29160 Ultra160 SCSI adapter>
Jul 20 20:29:09 dynagate4 kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jul 20 20:29:09 dynagate4 kernel: 
Jul 20 20:29:09 dynagate4 kernel: blk: queue f7ee4c18, I/O limit 4095Mb (mask 0xffffffff)
Jul 20 20:29:09 dynagate4 kernel:   Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
Jul 20 20:29:09 dynagate4 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul 20 20:29:09 dynagate4 kernel: blk: queue f7ee4a18, I/O limit 4095Mb (mask 0xffffffff)
Jul 20 20:29:09 dynagate4 kernel: (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
Jul 20 20:29:09 dynagate4 kernel:   Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
Jul 20 20:29:09 dynagate4 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul 20 20:29:09 dynagate4 kernel: blk: queue f7e26a18, I/O limit 4095Mb (mask 0xffffffff)
Jul 20 20:29:09 dynagate4 kernel: (scsi0:A:8): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
Jul 20 20:29:09 dynagate4 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Jul 20 20:29:09 dynagate4 kernel: scsi0:A:8:0: Tagged Queuing enabled.  Depth 253
Jul 20 20:29:09 dynagate4 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul 20 20:29:09 dynagate4 kernel: Attached scsi disk sdb at scsi0, channel 0, id 8, lun 0
Jul 20 20:29:09 dynagate4 kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Jul 20 20:29:09 dynagate4 kernel:  sda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
Jul 20 20:29:09 dynagate4 kernel:  sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Jul 20 20:29:09 dynagate4 kernel: SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
Jul 20 20:29:09 dynagate4 kernel:  sdb:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
Jul 20 20:29:09 dynagate4 kernel:  sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Jul 20 20:29:09 dynagate4 kernel: Linux Kernel Card Services 3.1.22
Jul 20 20:29:09 dynagate4 kernel:   options:  [pci] [cardbus] [pm]
Jul 20 20:29:09 dynagate4 kernel: usb.c: registered new driver usbdevfs
Jul 20 20:29:09 dynagate4 kernel: usb.c: registered new driver hub
Jul 20 20:29:09 dynagate4 kernel: Initializing USB Mass Storage driver...
Jul 20 20:29:09 dynagate4 kernel: usb.c: registered new driver usb-storage
Jul 20 20:29:09 dynagate4 kernel: USB Mass Storage support registered.
Jul 20 20:29:09 dynagate4 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 20 20:29:09 dynagate4 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jul 20 20:29:09 dynagate4 kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Jul 20 20:29:09 dynagate4 kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jul 20 20:29:09 dynagate4 kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 20 20:29:09 dynagate4 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Jul 20 20:29:09 dynagate4 kernel: ds: no socket drivers loaded!
Jul 20 20:29:09 dynagate4 kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Jul 20 20:29:09 dynagate4 kernel: EXT3-fs: write access will be enabled during recovery.
Jul 20 20:29:09 dynagate4 kernel: kjournald starting.  Commit interval 5 seconds
Jul 20 20:29:09 dynagate4 kernel: EXT3-fs: recovery complete.
Jul 20 20:29:09 dynagate4 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 20 20:29:09 dynagate4 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jul 20 20:29:09 dynagate4 kernel: Freeing unused kernel memory: 124k freed
Jul 20 20:29:09 dynagate4 kernel: Adding Swap: 979956k swap-space (priority -1)
Jul 20 20:29:09 dynagate4 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
Jul 20 20:29:09 dynagate4 kernel: Real Time Clock Driver v1.10e
Jul 20 20:29:09 dynagate4 kernel: eth0: DC21140 at 0xd000 (PCI bus 0, device 11), h/w address 00:20:18:59:3b:1a,
Jul 20 20:29:09 dynagate4 kernel: eth0: Using generic MII device control. If the board doesn't operate, 
Jul 20 20:29:09 dynagate4 kernel: please mail the following dump to the author:
Jul 20 20:29:09 dynagate4 kernel: 
Jul 20 20:29:09 dynagate4 kernel: MII device address: 1
Jul 20 20:29:09 dynagate4 kernel: MII CR:  3100
Jul 20 20:29:09 dynagate4 kernel: MII SR:  7809
Jul 20 20:29:09 dynagate4 kernel: MII ID0: 181
Jul 20 20:29:09 dynagate4 kernel: MII ID1: b800
Jul 20 20:29:09 dynagate4 kernel: MII ANA: 5e1
Jul 20 20:29:09 dynagate4 kernel: MII ANC: 0
Jul 20 20:29:09 dynagate4 kernel: MII 16:  640
Jul 20 20:29:09 dynagate4 kernel: MII 17:  f010
Jul 20 20:29:09 dynagate4 kernel: MII 18:  6800
Jul 20 20:29:09 dynagate4 kernel: 
Jul 20 20:29:09 dynagate4 kernel:       and requires IRQ19 (provided by PCI BIOS).
Jul 20 20:29:09 dynagate4 kernel: de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
Jul 20 20:29:09 dynagate4 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Jul 20 20:29:09 dynagate4 kernel: 00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.16
Jul 20 20:29:09 dynagate4 kernel: Power Resource: found
Jul 20 20:29:09 dynagate4 last message repeated 3 times
Jul 20 20:29:09 dynagate4 kernel: ACPI: System firmware supports S0 S1 S4 S5
Jul 20 20:29:09 dynagate4 kernel: ACPI: Power Button (FF) found
Jul 20 20:29:09 dynagate4 kernel: ACPI: Multiple power buttons detected, ignoring fixed-feature
Jul 20 20:29:09 dynagate4 kernel: ACPI: Power Button (CM) found
Jul 20 20:29:09 dynagate4 kernel: ACPI: Sleep Button (CM) found
Jul 20 20:29:09 dynagate4 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul 20 20:29:09 dynagate4 kernel: md: raid0 personality registered as nr 2
Jul 20 20:29:09 dynagate4 kernel: CSLIP: code copyright 1989 Regents of the University of California
Jul 20 20:29:09 dynagate4 kernel: PPP generic driver version 2.4.2
Jul 20 20:29:09 dynagate4 kernel: SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256) (6 bit encapsulation enabled).
Jul 20 20:29:09 dynagate4 kernel: SLIP linefill/keepalive option.
Jul 20 20:29:09 dynagate4 kernel: PPP BSD Compression module registered
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: $Revision: 1.275 $ time 13:20:23 Jun 30 2003
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: High bandwidth mode enabled
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 19
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: Detected 2 ports
Jul 20 20:29:09 dynagate4 kernel: usb.c: new USB bus registered, assigned bus number 1
Jul 20 20:29:09 dynagate4 kernel: hub.c: USB hub found
Jul 20 20:29:09 dynagate4 kernel: hub.c: 2 ports detected
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 19
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: Detected 2 ports
Jul 20 20:29:09 dynagate4 kernel: usb.c: new USB bus registered, assigned bus number 2
Jul 20 20:29:09 dynagate4 kernel: hub.c: USB hub found
Jul 20 20:29:09 dynagate4 kernel: hub.c: 2 ports detected
Jul 20 20:29:09 dynagate4 kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Jul 20 20:29:09 dynagate4 kernel: Linux video capture interface: v1.00
Jul 20 20:29:09 dynagate4 kernel: pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module version 8.6 loaded.
Jul 20 20:29:09 dynagate4 kernel: pwc Also supports the Askey VC010, Logitech Quickcam 3000 Pro, Samsung MPC-C10 and MPC-C30,
Jul 20 20:29:09 dynagate4 kernel: pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
Jul 20 20:29:09 dynagate4 kernel: pwc Default framerate set to 30.
Jul 20 20:29:09 dynagate4 kernel: pwc Default image size set to vga [640x480].
Jul 20 20:29:09 dynagate4 kernel: usb.c: registered new driver Philips webcam
Jul 20 20:29:09 dynagate4 kernel: pwc Philips webcam decompressor routines version 8.2
Jul 20 20:29:09 dynagate4 kernel: pwc Supports all cameras supported by the main module (pwc).
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 645.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 646.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 675.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 680.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 690.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 730.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 740.
Jul 20 20:29:09 dynagate4 kernel: pwc Adding decompressor for model 750.
Jul 20 20:29:09 dynagate4 kernel:  [events: 0000001c]
Jul 20 20:29:09 dynagate4 kernel:  [events: 0000001c]
Jul 20 20:29:09 dynagate4 kernel: md: autorun ...
Jul 20 20:29:09 dynagate4 kernel: md: considering hdc1 ...
Jul 20 20:29:09 dynagate4 kernel: md:  adding hdc1 ...
Jul 20 20:29:09 dynagate4 kernel: md:  adding hdb1 ...
Jul 20 20:29:09 dynagate4 kernel: md: created md0
Jul 20 20:29:09 dynagate4 kernel: md: bind<hdb1,1>
Jul 20 20:29:09 dynagate4 kernel: md: bind<hdc1,2>
Jul 20 20:29:09 dynagate4 kernel: md: running: <hdc1><hdb1>
Jul 20 20:29:09 dynagate4 kernel: md: hdc1's event counter: 0000001c
Jul 20 20:29:09 dynagate4 kernel: md: hdb1's event counter: 0000001c
Jul 20 20:29:09 dynagate4 kernel: md0: max total readahead window set to 496k
Jul 20 20:29:09 dynagate4 kernel: md0: 2 data-disks, max readahead per data-disk: 248k
Jul 20 20:29:09 dynagate4 kernel: raid0: looking at hdb1
Jul 20 20:29:09 dynagate4 kernel: raid0:   comparing hdb1(80413248) with hdb1(80413248)
Jul 20 20:29:09 dynagate4 kernel: raid0:   END
Jul 20 20:29:09 dynagate4 kernel: raid0:   ==> UNIQUE
Jul 20 20:29:09 dynagate4 kernel: raid0: 1 zones
Jul 20 20:29:09 dynagate4 kernel: raid0: looking at hdc1
Jul 20 20:29:09 dynagate4 kernel: raid0:   comparing hdc1(80413248) with hdb1(80413248)
Jul 20 20:29:09 dynagate4 kernel: raid0:   EQUAL
Jul 20 20:29:09 dynagate4 kernel: raid0: FINAL 1 zones
Jul 20 20:29:09 dynagate4 kernel: raid0: zone 0
Jul 20 20:29:09 dynagate4 kernel: raid0: checking hdb1 ... contained as device 0
Jul 20 20:29:09 dynagate4 kernel:   (80413248) is smallest!.
Jul 20 20:29:09 dynagate4 kernel: raid0: checking hdc1 ... contained as device 1
Jul 20 20:29:09 dynagate4 kernel: raid0: zone->nb_dev: 2, size: 160826496
Jul 20 20:29:09 dynagate4 kernel: raid0: current zone offset: 80413248
Jul 20 20:29:09 dynagate4 kernel: raid0: done.
Jul 20 20:29:09 dynagate4 kernel: raid0 : md_size is 160826496 blocks.
Jul 20 20:29:09 dynagate4 kernel: raid0 : conf->smallest->size is 160826496 blocks.
Jul 20 20:29:09 dynagate4 kernel: raid0 : nb_zone is 1.
Jul 20 20:29:09 dynagate4 kernel: raid0 : Allocating 8 bytes for hash.
Jul 20 20:29:09 dynagate4 kernel: md: updating md0 RAID superblock on device
Jul 20 20:29:09 dynagate4 kernel: md: hdc1 [events: 0000001d]<6>(write) hdc1's sb offset: 80413248
Jul 20 20:29:09 dynagate4 kernel: md: hdb1 [events: 0000001d]<6>(write) hdb1's sb offset: 80413248
Jul 20 20:29:09 dynagate4 kernel: md: ... autorun DONE.
Jul 20 20:29:09 dynagate4 kernel: hub.c: new USB device 00:07.2-1, assigned address 2
Jul 20 20:29:09 dynagate4 kernel: pwc Sotec Afina Eye USB webcam detected.
Jul 20 20:29:09 dynagate4 kernel: pwc Registered as /dev/video0.


.. my cpuinfo :

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.265
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1589.24

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.265
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1592.52

...and my /proc/modules

ppp_deflate             2976   0 (autoclean)
zlib_deflate           17536   0 (autoclean) [ppp_deflate]
ppp_async               6944   0 (autoclean)
tun                     3872   3 (autoclean)
ipx                    19572   1 (autoclean)
ipt_MASQUERADE          1440   3 (autoclean)
ipt_state                640  16 (autoclean)
ipt_LOG                 3328   1 (autoclean)
iptable_filter          1792   1 (autoclean)
ip_nat_ftp              3136   0 (unused)
iptable_nat            15572   2 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_irc        3168   0 (unused)
ip_conntrack_ftp        4000   1 [ip_nat_ftp]
ip_conntrack           19724   4 [ipt_MASQUERADE ipt_state ip_nat_ftp iptable_na
t ip_conntrack_irc ip_conntrack_ftp]
ip_tables              11328   7 [ipt_MASQUERADE ipt_state ipt_LOG iptable_filte
r iptable_nat]
pwcx-i386              87104   1
pwc                    44320   1 [pwcx-i386]
videodev                4096   2 [pwc]
usb-uhci               22116   0 (unused)
vfat                    9404   0 (unused)
msdos                   4956   0 (unused)
fat                    30264   0 [vfat msdos]
bsd_comp                4032   0
slip                    9408   0 (unused)
ppp_generic            19660   0 [ppp_deflate ppp_async bsd_comp]
slhc                    4512   0 [slip ppp_generic]
raid0                   3264   1
md                     56768   2 [raid0]
ospm_button             3136   0 (unused)
ospm_system             5964   0 (unused)
ospm_busmgr            11744   0 [ospm_button ospm_system]
3c59x                  25800   1
de4x5                  39360   1
rtc                     6684   0 (autoclean)

..and SCSI info :
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03


This is a know problem/bug ? 
I hope u understand my (bad) english ,
regards Luigi Montella Velluti

-- 
##################################################################
            "Don't take the name of the root in vain"

Luigi Montella Velluti alternate e-mail address: luigi_m_v@yahoo.it
ICQ number 170412042
Dynamica Software Factory  via G.Sidoli,7 20129 - Milano  -Italy-
WEB: http://www.dynamica.it Tel:+39 2 70124402 Fax: +39 2 70120357
 


