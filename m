Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSGLPgC>; Fri, 12 Jul 2002 11:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGLPgA>; Fri, 12 Jul 2002 11:36:00 -0400
Received: from [208.33.57.99] ([208.33.57.99]:45789 "EHLO
	radioflyer.ibocradio.com") by vger.kernel.org with ESMTP
	id <S316591AbSGLPfx>; Fri, 12 Jul 2002 11:35:53 -0400
Message-ID: <3D2EF7F2.1070107@homemail.com>
Date: Fri, 12 Jul 2002 11:38:26 -0400
From: "D. Sen" <dsen@homemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "PCI: Cannot allocate resource region" messages at boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jul 2002 15:38:35.0098 (UTC) FILETIME=[2F1E83A0:01C229BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting these messages during bootup time on an IBM Thinkpad T30:

Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region 0 
of device 02:00.0
Jul 11 17:17:24 calliope kernel: PCI: Cannot allocate resource region 0 
of device 02:00.1

lspci -vv identifies these devices as:

02:00.0 CardBus bridge: Texas Instruments: Unknown device ac55 (rev 01)
         Subsystem: IBM: Unknown device 0512
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168, cache line size 20
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at d0201000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=03, subordinate=05, sec-latency=176
         Memory window 0: f0000000-f03ff000 (prefetchable)
         Memory window 1: d0400000-d07ff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments: Unknown device ac55 (rev 01)
         Subsystem: IBM: Unknown device 0512
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168, cache line size 20
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at d0202000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=02, secondary=06, subordinate=08, sec-latency=176
         Memory window 0: f0400000-f07ff000 (prefetchable)
         Memory window 1: d0800000-d0bff000
         I/O window 0: 00004800-000048ff
         I/O window 1: 00004c00-00004cff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ 
PostWrite+
         16-bit legacy interface ports at 0001



We are also seeing weird PCMCIA behaviour whereby cardmgr does not 
detect the insertion and removal of PCMCIA devices. Using the Yenta 
socket in the 2.4.18 kernel. Perhaps the boot messages and this 
behaviour is related?

DS

