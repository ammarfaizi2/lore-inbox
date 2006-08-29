Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWH2FTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWH2FTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWH2FTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:19:30 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:5764 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751100AbWH2FT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:19:29 -0400
From: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [2.6.17.11] strange pcie errors/warnings on Abit KN9-SLI mainboard
Date: Tue, 29 Aug 2006 07:19:21 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200608280554_MC3-1-C993-608@compuserve.com>
In-Reply-To: <200608280554_MC3-1-C993-608@compuserve.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z588ESdik1jawM8"
Message-Id: <200608290719.21777.ml_linuxkernel_20060528@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Z588ESdik1jawM8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 28 August 2006 11:50, Chuck Ebbert wrote:
> In-Reply-To: <200608280755.56015.ml_linuxkernel_20060528@kcore.org>
>
> On Mon, 28 Aug 2006 07:55:55 +0200, Jan De Luyck wrote:
> > Aug 27 15:35:04 whocares kernel: PCI: Setting latency timer of device 0000:00:0a.0 to 64 
> > Aug 27 15:35:04 whocares kernel: pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS 
> > Aug 27 15:35:04 whocares kernel: assign_interrupt_mode Found MSI capability
> > Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie00] 
> > Aug 27 15:35:04 whocares kernel: Allocate Port Service[0000:00:0a.0:pcie03]
>
> Any other messages?  In addition to the above, I get:
>
> PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:04.0
> PCI: Cannot allocate resource region 9 of bridge 0000:00:04.0
> PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0

Nope, I'm not seeing those.

I have the messages for all my pcie bridges. Here's the lspci output:

00:0a.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fa000000-fcffffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40b9
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s L1, Port 5
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x8
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: fdc00000-fdcfffff
	Prefetchable memory behind bridge: 00000000fdb00000-00000000fdbfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40c1
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x4
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: fda00000-fdafffff
	Prefetchable memory behind bridge: 00000000fd900000-00000000fd9fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40c9
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x4
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fd800000-fd8fffff
	Prefetchable memory behind bridge: 00000000fd700000-00000000fd7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40d1
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x4
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fd600000-fd6fffff
	Prefetchable memory behind bridge: 00000000fd500000-00000000fd5fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40d9
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x8
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f7000000-f9ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device 0000
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
		Address: 00000000fee00000  Data: 40e1
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel

Full dmesg and lspci attached.

Kind regards,

Jan
-- 
f u cn rd ths, u cn gt a gd jb n cmptr prgrmmng.

--Boundary-00=_Z588ESdik1jawM8
Content-Type: application/x-gzip;
  name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.gz"

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
G2l1pN4quhPa5t+rXZETZmsAAA==

--Boundary-00=_Z588ESdik1jawM8
Content-Type: application/x-gzip;
  name="lspci.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci.gz"

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
/8bR/y1D3C6M+/raQOVKxgGuqR64HgTsehmqld6pBK5pIkmeTh1zr1uthBfzixe3gyr5D4Uqxxmq
vB2qrHufVnw9qCxNMhdARdkCqBQ+M6ikDBoWQIVkoJISVLTnJL6NxxETd00CjFZ96XpDzd5p7rse
S8gclpCtYckhjqHfU2hZDrvhv1FbigyDp4D669NiKZEWS/NpsbAyK2ZBBc+Kj9dlxVp4/4mpm+mz
4thqaFSSyQnTTJklP1uzO82RZWEuR15ix2mSZLm07URpV5iXDn0WnqeJcdi1DH3YD2Rn0UcWBseL
sCKsh5VlvxGJgaPnugHq18PwRLVRGV851zKEq0ePG9TxiHVJDSb/Y1d7sl3NAKS40NEOoXuvOcHZ
2NGZQzYeg752R2baR+4KLcGHk4IoOdikJcKJPPZnavEfNjPQcPF26UGo9kvkxjOct82sjBdXjh+L
MztGz340Op6Ri4efysRtoPvLY51xBMvNNJuZjyiV4vng2R7VjB79CShuDCf8994z2mAwiZ/SUeF8
8A1bfbeM4B4eS4dQUbttPtuWeBiqtjBpvl4ZYR3evm75TAcG9GrVCaixQHGIVs7nqT45+j2ZCrZc
HGbTeF+x18CpBg5q5pdXCzxUZbvXIuxs0zH4WV5euEHXHjNQH3sjy+eUGLYPf87NbjH3xpY1tAIQ
jiY0HdYKTdmYHe3MDqLBEAT9OoOM2tCojdjpi27T+0lmZOTiQMc0DyORoONEI/KlDC6rtsFGljqn
KKDRX1teMEYmrKF1ONQO+XaQ8e3O+Taf4Nt8Wr4txURYWvsUWo/41tCfz7emMZjnWzyR8W3GtxHf
6mLGtzvg25n5vIpvxWV8K2+Zb0lqvpUzvt3Et3rGtzvnWznBt3Javi3GRFhcy7dazLfaS/j2OMm3
xxnfZnwb822W3346vs1nfPtx+dbI+HbnfFtI8G0hLd8qMREqa/m2FPNt6SV8W0zybTHj24xvI741
svz20/GtlPHtx+VbmvHtzvlWSfCtkpZvCzERFtbyrRLzrfISvi0k+baQ8W3GtzHfZvntp+Nb8d34
Nnt/u5FvzYxvd863xQTfFtPyrRwTobyOb8MEFfn2+AW/lzKicsK3xkf6vVQu49v35Vua5bcf+fdS
orKMcIV3+8GUqGSMu4FxRbaYiu3zO4HiivGgOTpOom3pnguhufhwU2nXb+HvEh4E97brKPK3zgi9
23WS/gd9qt87ru3ePUXb4I5DyHvDnQF3wr1LkCSJPFyTLt+PICKr2U2Xv3z5gjfT962B/QSWo7vD
kU2DaCEzB6vpvszfNW/Y8xEq6wO7Ee4XO7tx8cpti9fsu7w/tzfx3NbKM1sqT09Ozu0v7jssxdYj
vtp6ItxniP32e0du1UIilUivVkmd7ds53fviz1BL/tVqaVu+Tm1bc6g79mP9/GGoYvLtlE24EQSR
b6cshgtezyyPfsc/OGg2Gg0Q88fy1zJC7aPmo8f7gTdmwaEPfbUq5ytVSfpWAVaTsJoaYcub53ZT
6V789xtDgx3tU/oWy8s33IfNuwqsyq0w4phbYS5MFratTbo2rHkryivWvLHtFoRUS9Hm17zNd5F2
eet7boX6zG1Ocmj+UvjfRaClAONLDCRYFqmv3xX1nO0Wd07PXA+Ns6igYs7V2yX7T7IHBNhzwuA5
IBEU0wvZ2+GdssDJPcKANTCO4PJf1uu5SvpSHbOBxsVnR6FNe2mvWq8ZrY5aa3hGFM3fTmywvcKO
4+VScKDIYXcbukLdt1etzhwk+3quaMntwI/5rkQLTSS2xvTmIQyueXKJ4SBr3+u0uSB6JMiypku8
UXnZrq/vsOmQUnpR0v+C3SSSK1JL0yQeg+ORa6GK0uXuM7nuc3J3NLTluXuc6iVSyf+b7H7FcqgF
fa3K7ifSvWg9VJo0d6GSNHmqVh1jKBqEq3WLn5Fo/tgH2On/b4d5Piqm4KMNJBQ/g15JQhuZp5SC
eTbTjTyzreVGjjnOOCbjmD+VY1Y8QX4LjmGPkLdHMv8D+eualP1uAAA=

--Boundary-00=_Z588ESdik1jawM8--
