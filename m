Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271714AbTHHRKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHHRKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:10:11 -0400
Received: from mail1.scram.de ([195.226.127.111]:47629 "EHLO mail1.scram.de")
	by vger.kernel.org with ESMTP id S271714AbTHHRKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:10:04 -0400
Date: Fri, 8 Aug 2003 19:09:15 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <dahinds@users.sourceforge.net>
Subject: Re: PCI1410 Interrupt Problems
In-Reply-To: <20030808095126.B32585@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308081905210.7087-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: ---- Start SpamAssassin results
  -0.10 points, 5 required;
  * -0.5 -- Has a In-Reply-To header
  *  0.0 -- Message-Id indicates a non-spam MUA (Pine)
  * -0.5 -- BODY: Contains what looks like a quoted email text
  *  0.9 -- RBL: Received via a relay in dnsbl.njabl.org
  [RBL check: found 181.23.224.217.dnsbl.njabl.org., type: 127.0.0.3]
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> Grumble.

Sorry. It was too early in the morning after too little time for sleep
:-(.

> Ok, so no subvendor/subdevice IDs to identify the hardware variant.
> Hmm, this isn't going to be an easy one to automatically fix up.
> Maybe we can pick up on the host bridge IDs - can you send me the
> complete output of lspci -vv please?

The particular piece of hardware is a PCI card which can be installed in
any PIC PC, so i guess the host bridge ID might vary depending on the host
where the card is installed...

rt1-sp:~# lspci -vv
00:00.0 Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

00:07.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at ff000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:11.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

--jochen

