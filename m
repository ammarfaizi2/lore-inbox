Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbUJYQW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUJYQW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbUJYQUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:20:48 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:65041 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262060AbUJYQTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:19:53 -0400
Date: Mon, 25 Oct 2004 18:19:45 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jim Nelson <james4765@verizon.net>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041025161945.GA82114@stud.fit.vutbr.cz>
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <417AB69E.8010709@verizon.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Jim,

  thank you for reply! Nice to hear that you have similar problem. You
have right, my notebook is same old as yours, pentium 166, maybe
1994-1997. I have TI PCI1130 cardbus bridge. You have right, pin is
routed to IRQ 255. See attach file. But i see same behaviour on IDE
device. Strange is that this works fine under window$ :-( which says
somethink as "interrupts table get from PCI 1.2 bios". I don't know how
far i can believe it.

> I've got the same problem with the Cardbus bridge on my old Thinkpad 760ED 
> - I think your laptop is as old as mine (Pentium 166 - 1996 or thereabouts).
> 
> The problem with mine is that the Cardbus bridge doesn't get a vaild IRQ 
> written into the chip by the BIOS, and Linux relies on the BIOS to do it on 
> older machines.  I haven't found an answer yet - I'm just getting into this 
> stuff myself, and don't understand PCI well enough to code a fix.  It is 
> good to know that it is not an IBM-only problem.
> 
> Just out of curiosity - does lspci -vvb show the interrupt pins on the 
> Cardbus bridge routed to IRQ 255?
> 
> If so, it might be a problem with the TI bridge chip.  IIRC, that's the 
> same model chip as in my laptop.
  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=LSPCI

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1521 [Aladdin III] (rev 1c)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1521 Aladdin III CPU Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1523 (rev 07)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1523 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:02.1 IDE interface: Acer Laboratories Inc. [ALi] M5219 (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at fcf0

00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin B routed to IRQ 255
	Region 0: Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:06.0 VGA compatible controller: Chips and Technologies F65550 (rev 45) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fd000000 (32-bit, non-prefetchable)

06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 4800
	Region 1: Memory at 11000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--cNdxnHkX5QqsyA0e--
