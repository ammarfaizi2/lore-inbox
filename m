Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSK0DT5>; Tue, 26 Nov 2002 22:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSK0DT5>; Tue, 26 Nov 2002 22:19:57 -0500
Received: from guru.webcon.net ([66.11.168.140]:31666 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S261456AbSK0DTv>;
	Tue, 26 Nov 2002 22:19:51 -0500
Date: Tue, 26 Nov 2002 22:27:07 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Asus P4PE onboard AD1980 sound?
Message-ID: <Pine.LNX.4.50.0211262214550.16919-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Analog Devices 1980, onboard Asus P4PE (845PE/ICH4).

I've tried a number of patches based on my google-based research (2.5.x ALSA
patches and the like), but no matter what I do, I can't get any sound out of
this thing. Yes, I've tried the obvious things (headphones). Everything
about it _appears_ to work (from the application POV), just no sound.

I have tried kernel 2.4.19 - 2.4.20-rc2-ac3. Anybody know how to get this
thing working?

Kernel messages:

Intel 810 + AC97 Audio, version 0.24, 10:51:14 Nov 18 2002
PCI: Enabling device 00:1f.5 (0004 -> 0007)
i810: Intel ICH4 found at IO 0x9400 and 0x9800, MEM 0xf0800000 and 0xf0000000, IRQ 11
i810: Intel ICH4 mmio at 0xe0e39000 and 0xe0e3b000
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS112(Analog Devices AD1980)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 6

# lspci -vvv
 
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [6105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f3000000-f3dfffff
	Prefetchable memory behind bridge: f3f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at b400 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at b000 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at f2800000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f1000000-f27fffff
	Prefetchable memory behind bridge: f3e00000-f3efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 8089
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80b0
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 9800 [disabled] [size=256]
	Region 1: I/O ports at 9400 [disabled] [size=64]
	Region 2: Memory at f0800000 (32-bit, non-prefetchable) [disabled] [size=512]
	Region 3: Memory at f0000000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at f3fe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: SCM Microsystems: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:0b.0 Non-VGA unclassified device: LSI Logic / Symbios Logic 53c810 (rev 01)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at a800 [disabled] [size=256]
	Region 1: Memory at f2000000 (32-bit, non-prefetchable) [disabled] [size=256]

02:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at f1800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

02:0d.0 Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 25)
	Subsystem: National Datacomm Corp: Unknown device 8110
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at f1000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

