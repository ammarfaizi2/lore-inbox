Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTGIITC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbTGIITC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:19:02 -0400
Received: from joel.ist.utl.pt ([193.136.198.171]:12226 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S265779AbTGIITA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 04:19:00 -0400
Date: Wed, 9 Jul 2003 09:33:30 +0100 (WEST)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74-bk5 + IEEE1394: ohci1394 doesn't work.
Message-ID: <Pine.LNX.4.44.0307090908260.1552-100000@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get FireWire/IEEE1394 working on kernel 2.5 (on 2.4 works fine).

When I load ohci1394 module, I get:

ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[e4800000-e48007ff]  Max Packet=[2048]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 e4cd0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 e4cd0404

And /proc/bus/ieee1394/ is empty.

lspci -vv info:
--------------
00:0e.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

If you need more info (kernel .config, /proc output, etc), just ask.

Regards,
  Rui Saraiva

PS: Please CC me any reply, as I'm not subscribed to LKML.

