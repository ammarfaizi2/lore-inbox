Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSCOLSx>; Fri, 15 Mar 2002 06:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSCOLR1>; Fri, 15 Mar 2002 06:17:27 -0500
Received: from pD952FB5C.dip.t-dialin.net ([217.82.251.92]:57872 "EHLO
	darktim.dyndns.org") by vger.kernel.org with ESMTP
	id <S290796AbSCOLPq>; Fri, 15 Mar 2002 06:15:46 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel does not boot with Machine Check Exeption
Message-ID: <1016190918.3c91d7c69aacd@darktim.dyndns.org>
Date: Fri, 15 Mar 2002 12:15:18 +0100 (CET)
From: darktim@darktim.dyndns.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 194.55.63.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After I have upgraded mey Kernel from 2.4.19-pre2-ac4 to 2.4.19-pre3
the machine hangs while checking the CPU. 

The last message on the screen was:

CPU: L1 I cache: 16k, L1 D cache: 16k
CPU: L2 cache: 512k
Intel machine check architecture supported

After that the system hangs.

After unchecking /Processor type and features/Machine Check Exeption
and recompiling the kernel the machine boots normally.

System is debian_sid on IBM Thinkpad 600

I hope you have enough information to handle this report.

Kindest regards,
Andre Timmermann

Additional info:

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 0
cpu MHz         : 265.272
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips        : 529.20

-----

lspci -vvv:

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP
disabled) (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:02.0 CardBus bridge: Texas Instruments PCI1250 (rev 02)
        Subsystem: IBM: Unknown device 0092
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 20301000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=176
        Memory window 0: 10000000-103ff000 (prefetchable)
        Memory window 1: 10400000-107ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1250 (rev 02)
        Subsystem: IBM: Unknown device 0092
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 20300000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=04, subordinate=06, sec-latency=176
        Memory window 0: 10800000-10bff000 (prefetchable)
        Memory window 1: 10c00000-10fff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:03.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
128XD] (rev 01) (prog-if 00 [VGA])
        Subsystem: IBM MagicGraph 128XD
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at 20000000 (32-bit, non-prefetchable) [size=2M]
        Region 2: Memory at 20200000 (32-bit, non-prefetchable) [size=1M]

00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00
[UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 48
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 8400 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9



-----

ver_linux:
Linux schleppi666 2.4.19-pre3 #3 Fri Mar 15 11:03:48 CET 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.27
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         3c589_cs nls_iso8859-1 nls_cp437


