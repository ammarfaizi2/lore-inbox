Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264548AbTLKIiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTLKIiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:38:23 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:11533 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S264548AbTLKIht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:37:49 -0500
Date: Thu, 11 Dec 2003 09:37:38 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [2.6.0-test11: PCMCIA] i82365: No such device...
Message-ID: <Pine.LNX.4.33.0312110920090.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short: under 2.4 the i82365 detects and serves the chip, under 2.6 - it
doesn't.

It's the same Toshiba Satellite 300CDT (lspci -vv below). pcmcia_core
compiled with cardbus support. In BIOS one can configure PCMCIA as 16bit
PCIC compatible, in which case it "works" - without hot-plugging. So, if
you boot with a card in the slot, it will be recognised, otherwise - not.
Next possibility "Auto-selected" (didn't really try, but didn't look too
promising), and 16bit card-bus. The latter option works under 2.4 with
i82365 and cardbus support. Under 2.6 it says: "Intel PCIC probe: not
found". Or should I be using yenta? It's not 32bit, so, didn't even try.
Ideas?

# lspci -vv
00:00.0 Host bridge: Toshiba America Info Systems 601 (rev 2c)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0, cache line size 08

...

00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=0
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

00:13.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=0
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
	16-bit legacy interface ports at 0001

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

