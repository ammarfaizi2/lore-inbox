Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVJ1HV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVJ1HV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVJ1HV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:21:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39819 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965163AbVJ1HV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:21:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.* unable to allocate resource region
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Oct 2005 17:20:37 +1000
Message-ID: <5111.1130484037@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.1[34] on i386.  Compaq Evo N800v.

PCI: Cannot allocate resource region 8 of bridge 0000:00:1e.0
PCI: Cannot allocate resource region 0 of device 0000:02:0e.2

lspci -vvv extract.

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 32000000-34ffffff
        Prefetchable memory behind bridge: 30000000-31ffffff
        Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-


02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Compaq Computer Corporation: Unknown device 004a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), Cache Line Size 20
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at 34000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Devices with memory regions.

00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Region 0: Memory at a0000000 (32-bit, prefetchable) [size=256M]
00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Memory behind bridge: 80300000-803fffff
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Memory behind bridge: 32000000-34ffffff
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Region 5: Memory at 35000000 (32-bit, non-prefetchable) [size=1K]
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Region 0: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at 80380000 (32-bit, non-prefetchable) [size=64K]
02:04.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
        Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=64K]
02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
        Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 32000000-33fff000 (prefetchable)
02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
        Region 0: Memory at 80180000 (32-bit, non-prefetchable) [size=4K]
02:0e.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Region 0: Memory at 80200000 (32-bit, non-prefetchable) [size=4K]
02:0e.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Region 0: Memory at 80280000 (32-bit, non-prefetchable) [size=4K]
02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Region 0: Memory at 34000000 (32-bit, non-prefetchable) [size=256]


