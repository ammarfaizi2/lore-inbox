Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272480AbTGZMtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 08:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272478AbTGZMtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 08:49:55 -0400
Received: from mail.netg.se ([212.91.134.131]:3847 "EHLO nautilus.netg.se")
	by vger.kernel.org with ESMTP id S272480AbTGZMt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 08:49:26 -0400
Date: Sat, 26 Jul 2003 15:04:38 +0200 (CEST)
From: =?ISO-8859-1?Q?Jacob_Hall=E9n?= <jacob@netg.se>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ACPI hangs when invoked from keyboard
Message-ID: <Pine.LNX.4.44.0307261454210.12851-100000@elvegris.netg.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I press the "Fn" key and some other key on my laptop, it almost
comes to a total freeze and the error messages shown below are written
to the console over and over again. Th "Fn" key on an IBM laptop is
used to invoke functionality like switching between builtin screen and
external screen, changing lights and suspending the machine.

This behaviour is different from the one I had with 2.5.73, where the
machine did not react at all to any Fn-Key combination.

Do I have a problem with my config, is it a bug or simply
unimplemented hardware support? Any help appreciated. Please CC me on
any replies.

Thanks in advance

Jacob Hallén
______________________________________________________________________________
Hardware:
=========
IBM Thinkpad X30

Kernel version:
===============
Linux version 2.6.0-test1 (root@nell)
(gcc version 3.3.1 20030626 (Debian prerelease)) #1
tis jul 22 04:21:17 CEST 2003

Error message:
==============
ACPI-0297 *** Error: AE_TIME while evaluating method [_L18] for GPE[ 0]
ACPI-0345 *** Error: Handler for [EmbeddedControl] returned AE_TIME
ACPI-1121 *** Error: Method execution failed [\_GPE._L18](Node c15f1fa0)

ACPI related parts of config:
=============================
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
...
CONFIG_HOTPLUG_PCI_ACPI=y

CPU Info:
=========
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Mobile Intel(R) Pentium(R) III CPU - M  1200MHz
stepping        : 4
cpu MHz         : 1196.132
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr sse
bogomips        : 2367.48

Modules:
========
irda 132092 0 - Live 0xe0155000

/proc/ioports:
==============
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #02
1400-14ff : PCI CardBus #02
1800-181f : Intel Corp. 82801CA/CAM USB (Hub
1820-183f : Intel Corp. 82801CA/CAM USB (Hub
1840-185f : Intel Corp. 82801CA/CAM USB (Hub
1860-186f : Intel Corp. 82801CAM IDE U100
1880-189f : Intel Corp. 82801CA/CAM SMBus
18c0-18ff : Intel Corp. 82801CA/CAM AC'97 Au
  18c0-18ff : Intel 82801CA-ICH3 - Controller
1c00-1cff : Intel Corp. 82801CA/CAM AC'97 Au
  1c00-1cff : Intel 82801CA-ICH3 - AC'97
2000-207f : Intel Corp. 82801CA/CAM AC'97 Mo
2400-24ff : Intel Corp. 82801CA/CAM AC'97 Mo
2800-28ff : PCI CardBus #06
2c00-2cff : PCI CardBus #06
7000-703f : Intel Corp. 82801CAM (ICH3) PRO/
  7000-703f : eepro100

/proc/iomem:
============
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000ce000-000cefff : Extension ROM
000cf000-000cffff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1f76ffff : System RAM
  00100000-00365d25 : Kernel code
  00365d26-00457b3f : Kernel data
1f770000-1f77dfff : ACPI Tables
1f77e000-1f77ffff : ACPI Non-volatile Storage
1f780000-1fffffff : reserved
20000000-200003ff : Intel Corp. 82801CAM IDE U100
20400000-207fffff : PCI CardBus #02
20800000-20bfffff : PCI CardBus #02
20c00000-20ffffff : PCI CardBus #06
21000000-213fffff : PCI CardBus #06
50000000-50000fff : Ricoh Co Ltd RL5c476 II
50100000-50100fff : Ricoh Co Ltd RL5c476 II (#2)
d0000000-d007ffff : Intel Corp. 82830 CGC [Chipset G
d0080000-d00fffff : Intel Corp. 82830 CGC [Chipset G (#2)
d0200000-d0200fff : Intel Corp. 82801CAM (ICH3) PRO/
  d0200000-d0200fff : eepro100
d0201000-d02017ff : Ricoh Co Ltd R5C552 IEEE 1394 Con
e0000000-e7ffffff : Intel Corp. 82830 CGC [Chipset G
e8000000-efffffff : Intel Corp. 82830 CGC [Chipset G (#2)
f8000000-f8000fff : Harris Semiconductor Prism 2.5 Wavelan ch
ff800000-ffffffff : reserved

lspci -vvv:
===========
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [2105]

00:02.0 VGA compatible controller: Intel Corp. 82830 CGC [Chipset Graphics
Controller] (rev 04) (prog-if 00 [VGA])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at d0000000 (32-bit, non-prefetchable)
[size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics
Controller]         Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at d0080000 (32-bit, non-prefetchable)
[size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=07, sec-latency=64
        I/O behind bridge: 00003000-00007fff
        Memory behind bridge: d0200000-dfffffff
        Prefetchable memory behind bridge: f0000000-f80fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [disabled]
[size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
(rev 02)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00
[Generic])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]

01:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

01:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00002800-000028ff
        I/O window 1: 00002c00-00002cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

01:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(prog-if 10 [OHCI])
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at d0201000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:02.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset
(rev 01)
        Subsystem: Intel Corp. Wireless 802.11b MiniPCI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM)
Ethernet Controller (rev 42)
        Subsystem: IBM ThinkPad A/T/X Series
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 7000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


