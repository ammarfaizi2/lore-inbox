Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVHNCuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVHNCuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHNCuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:50:50 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:20124 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932410AbVHNCuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:50:50 -0400
Subject: Re: 2.6.13-rc6-git5 : PCI mem resource alloc failure == PCMCIA
	Busted
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1123982870.2779.7.camel@localhost.localdomain>
References: <1123982870.2779.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 13 Aug 2005 22:50:40 -0400
Message-Id: <1123987840.2712.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 21:27 -0400, Parag Warudkar wrote:
> With 2.6.13-rc6-git5 I started getting the below errors. Despite of the
> errors everything works fine. (only problem is that I have to
> disconnect /reconnect the usb mouse for it to get detected..)
Another problem is that PCMCIA is busted - I get the below errors and my
wireless pcmcia card no longer works with -rc6-git5.

Starting PCMCIA services: cardmgr[2929]: watching 2 sockets
cardmgr[2929]: could not adjust resource: IO ports 0x3d3-0x3d3:
Input/output error

dmesg | grep -i pcmcia
[  249.156295] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
[  249.156304] pcmcia: parent PCI bridge Memory window: 0xe0100000 -
0xe17fffff
[  249.156311] pcmcia: parent PCI bridge Memory window: 0x60000000 -
0x63ffffff
[  249.736632] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
[  249.736639] pcmcia: parent PCI bridge Memory window: 0xe0100000 -
0xe17fffff
[  249.736646] pcmcia: parent PCI bridge Memory window: 0x60000000 -
0x63ffffff

lspci -vv | grep CardBus

02:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
(rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 006d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size 10
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at e0106000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 60000000-61fff000 (prefetchable)
        Memory window 1: e0400000-e07ff000
        I/O window 0: 00003000-00003fff
        I/O window 1: 00004000-00004fff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

02:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller
(rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 006d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size 10
        Interrupt: pin B routed to IRQ 185
        Region 0: Memory at e0107000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 62000000-63fff000 (prefetchable)
        Memory window 1: e0c00000-e0fff000
        I/O window 0: 00005000-00005fff
        I/O window 1: 00006000-00006fff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001



