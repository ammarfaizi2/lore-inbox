Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUGJRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUGJRfr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUGJRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 13:35:47 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:39640 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266310AbUGJRfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 13:35:41 -0400
Subject: Integrated ethernet on SiS chipset doesn't work
From: Jean Francois Martinez <jfm512@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-J01mCkJpSG0IZ7SPVWAk"
Message-Id: <1089480939.2779.22.camel@agnes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 19:35:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J01mCkJpSG0IZ7SPVWAk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have a friend who owns a computer manufactured by Medion and who
sports an MSI motherboard who has a SiS chipset.  The MSI motherboard 
seems to have ben made specially for Medion since it isn't 
referenced on MSI's site.  The problems is that the integrated ethernet
doesn't work at all under Linux be it with 2.4 or 2.6 kernel.  He can't 
ping or connect to other boxes.  His ethernet works when he boots
Windows.

I include the output of lspci



--=-J01mCkJpSG0IZ7SPVWAk
Content-Disposition: attachment; filename=lspcin.txt
Content-Type: text/plain; name=lspcin.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Class 0600: 1039:0648 (rev 50)
00:01.0 Class 0604: 1039:0003
00:02.0 Class 0601: 1039:0008 (rev 14)
00:02.3 Class 0c00: 1039:7007
00:02.5 Class 0101: 1039:5513
00:02.7 Class 0401: 1039:7012 (rev a0)
00:03.0 Class 0c03: 1039:7001 (rev 0f)
00:03.1 Class 0c03: 1039:7001 (rev 0f)
00:03.2 Class 0c03: 1039:7001 (rev 0f)
00:03.3 Class 0c03: 1039:7002
00:04.0 Class 0200: 1039:0900 (rev 91)
00:07.0 Class 0780: 8086:1040
01:00.0 Class 0300: 10de:0314 (rev a1)

--=-J01mCkJpSG0IZ7SPVWAk
Content-Disposition: attachment; filename=lspciv.txt
Content-Type: text/plain; name=lspciv.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS 645xx (rev 50)
	Subsystem: Silicon Integrated Systems [SiS] SiS 645xx
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 0003 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 14)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 785d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 3000ns max)
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at eb405000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin ? routed to IRQ 5
	Region 4: I/O ports at 4000 [size=16]
	Capabilities: <available only to root>

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 3
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e400 [size=128]
	Capabilities: <available only to root>

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at eb400000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 3
	Region 0: Memory at eb401000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at eb402000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at eb403000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 785c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at eb404000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:07.0 Communication controller: Intel Corp. 536EP Data Fax Modem
	Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at eb000000 (32-bit, non-prefetchable) [size=4M]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0314 (rev a1) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 9306
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>


--=-J01mCkJpSG0IZ7SPVWAk--

