Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTENKyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTENKyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:54:51 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:32973 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261851AbTENKyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:54:47 -0400
Date: Wed, 14 May 2003 07:07:33 -0400
From: David Caplan <david@david.ath.cx>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALi M5451/Trident sound module -> video corruption
Message-ID: <20030514110733.GA2951@euphoria>
References: <20030514041227.GB2925@euphoria> <20030514044237.GP11374@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20030514044237.GP11374@actcom.co.il>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


When I build it into the kernel it does the same thing, except on boot
up :/ 
When I tried using the alsa drivers (last night) the exact same thing
happend, I think it may be a hardware/memory conflict between the sound
card and the video, but I'm not sure.

-David





* Muli Ben-Yehuda (mulix@mulix.org) wrote:
> On Wed, May 14, 2003 at 12:12:27AM -0400, David Caplan wrote:
> > Hello,
> > 
> > I have a Sharp Actius MM10 "sub-notebook", on which I'm running kernel
> > 2.4.21-rc1.
> > When I load the trident.o sound module, the lcd begins flashing blue
> > stripes continuously. I am not up to date on the current issues with
> > this driver, am I doing something wrong? could there be some sort of
> > hardware
> > conflict? or is it a kernel problem?
> 
> There aren't any outstanding issues that I know of, the driver has
> been stable for a long time. Could you send the output of lspci -vvv?
> Also, could you try it with trident built into the kernel? 
> 
> Thanks, 
> Muli. 
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org
> 


--
David Caplan {david@david.ath.cx|dcaplan@polycode.net}
gpg fingerprint:: B586 07D3 6EC0 EB36 6866  18C8 79B3 3A94 5898 39A0	  

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspcivv.txt"

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev c1) (prog-if 00 [VGA])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster- SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=1 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=<none>
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at f4101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: AMBIT Microsystem Corp.: Unknown device 0200
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f4104000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at 000da000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 7
	Region 0: Memory at 000db000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 132 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at f4101400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if ea)
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Sharp corporation: Unknown device 102b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-


--vkogqOf2sHV7VnPd--
