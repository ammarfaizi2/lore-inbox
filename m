Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTH3I5K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTH3I5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:57:10 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:25278 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S263439AbTH3I4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:56:54 -0400
Subject: Re: PROBLEM: JVC MP-XP7210 hangs on boot with 2.6.0-test4
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Mario Lang <mlang@delysid.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87k78wsip0.fsf@lexx.delysid.org>
References: <87k78wsip0.fsf@lexx.delysid.org>
Content-Type: text/plain
Message-Id: <1062233791.1482.2.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sat, 30 Aug 2003 10:56:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've tried 2.6.0-test4 on my XP7210 and it works just
happily. Everything is working: ACPI, PCMCIA, ALSA, SISFB the works...

Maybe it's your version of GCC? I use GCC 3.2.2 which comes with RH9.

Cheers,

Jurgen

On Fri, 2003-08-29 at 15:21, Mario Lang wrote:
> Hi.
> 
> I just tried 2.6.0-test4 on my Laptop (JVC MP-XP7210, 256MB RAM, IDE).
> However, it hangs on boot.  I tried booting with acpi=off and also
> with "acpi=off noapic".  Both options seem to help nothing,
> and the same output appears on all attempts to boot.
> 
> I compiled the kernel with gcc 3.3.2.
> 
> Here is the output I get:
> 
> [<c0 10 92 69>] Kernel_thread_helper+0x5/0xc
> Code: 0f ba 6e 24 00 c7 44 24 04 00 00 00 00 89 34 24 e8 25 fa ff
> <0> Kernel Panic: Fatal Exception in Interrupt
> in interrupt handler - not syncing
> 
> (and here it hangs)
> 
> P.S.: I am not subscribed, please CC.
> 
> Here is also the output of lspci -vv run under 2.4.20-pre7-acpi:
> 
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 32
> 	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
> 	Capabilities: [c0] AGP version 2.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 
> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
> 	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 16
> 	Region 4: I/O ports at d800 [size=16]
> 
> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 
> 00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 82)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1455
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (13000ns min, 2750ns max)
> 	Interrupt: pin C routed to IRQ 5
> 	Region 0: I/O ports at d400 [size=256]
> 	Region 1: Memory at d3800000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=160mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
> 	Subsystem: Silicon Integrated Systems [SiS] SiS7001 USB Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (20000ns max), cache line size 08
> 	Interrupt: pin D routed to IRQ 4
> 	Region 0: Memory at d3000000 (32-bit, non-prefetchable) [size=4K]
> 
> 00:01.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 07) (prog-if 10 [OHCI])
> 	Subsystem: Silicon Integrated Systems [SiS] Onboard USB Controller
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (20000ns max), cache line size 08
> 	Interrupt: pin D routed to IRQ 4
> 	Region 0: Memory at d2800000 (32-bit, non-prefetchable) [size=4K]
> 
> 00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1473
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 6000ns max)
> 	Interrupt: pin B routed to IRQ 7
> 	Region 0: I/O ports at d000 [size=256]
> 	Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1616
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (13000ns min, 2750ns max)
> 	Interrupt: pin C routed to IRQ 5
> 	Region 0: I/O ports at b800 [size=256]
> 	Region 1: I/O ports at b400 [size=128]
> 	Capabilities: [48] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000a000-0000afff
> 	Memory behind bridge: d1800000-d1ffffff
> 	Prefetchable memory behind bridge: d8000000-e7efffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1674
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 000de000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
> 	Memory window 0: 10400000-107ff000 (prefetchable)
> 	Memory window 1: 10800000-10bff000
> 	I/O window 0: 00004000-000040ff
> 	I/O window 1: 00004400-000044ff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1674
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
> 	Memory window 0: 10c00000-10fff000 (prefetchable)
> 	Memory window 1: 11000000-113ff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 00:09.2 System peripheral: Ricoh Co Ltd: Unknown device 0576
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1674
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=256]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=2 PME+
> 
> 00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1677
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (500ns min, 1000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 4
> 	Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=2K]
> 	Region 1: Memory at d0800000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> 
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 1672
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	BIST result: 00
> 	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
> 	Region 1: Memory at d1800000 (32-bit, non-prefetchable) [size=128K]
> 	Region 2: I/O ports at a800 [size=128]
> 	Capabilities: [40] Power Management version 1
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [50] AGP version 2.0
> 		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 

