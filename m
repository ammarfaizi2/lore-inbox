Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317119AbSFBDIV>; Sat, 1 Jun 2002 23:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317120AbSFBDIU>; Sat, 1 Jun 2002 23:08:20 -0400
Received: from china.patternbook.com ([216.254.75.60]:60298 "EHLO
	china.patternbook.com") by vger.kernel.org with ESMTP
	id <S317119AbSFBDIS>; Sat, 1 Jun 2002 23:08:18 -0400
Date: Sat, 1 Jun 2002 23:07:43 -0400
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops in 2.4.19-pre8 - supplement: lspci output
Message-ID: <20020601230743.A7130@china.patternbook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, here's spci output to go with my message this morning
on the "kernel BUG at page_alloc.c:106!" Oops. I've since gone to
2.4.19-pre9-ac3, just in case that's improved in a way that matters, but
since this Oops took awhile to show up after going to 2.4.19-pre8 (done
after 2.4.16 did a hard crash without recoverable information, after being
stable for many months ... hmm, 2 crashes ... hardware, obscure bug, or
coincidence?)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e9000000-e97fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at b400 [size=16]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10) (prog-if 00 [Normal decode])
	!!! Invalid class 0604 for header type 00
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at e9800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at e6000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at bc00 [size=128]
	Region 1: Memory at e9803000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at e7000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c875 (rev 26)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4250ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at e9801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e9802000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e8000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: CardExpert Technology: Unknown device 6326
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e9000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 9000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

Thanks to whoever looks at this!

Whit
