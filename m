Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbWAGVEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbWAGVEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWAGVEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:04:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752586AbWAGVEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:04:23 -0500
Date: Sat, 7 Jan 2006 16:04:13 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060107210413.GL9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C0172E.7040607@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 02:31:58PM -0500, Brice Goglin wrote:
 > Andrew Morton wrote:
 > 
 > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/
 > >
 > >This should be somewhat less buggy than 2.6.15-mm1.
 > >  
 > >
 > Hi Andrew,
 > 
 > I get several problems on my Thinkpad T43:
 > 1) agpgart does not load, it looks like something it returning ENODEV.
 > Reverting git-agpgart fixes it.

Are you sure you actually this device ...

 > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon Mobility M300] (prog-if 00 [VGA])
 > 	Subsystem: IBM: Unknown device 056e
 > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
 > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 > 	Latency: 0, Cache Line Size: 0x08 (32 bytes)
 > 	Interrupt: pin A routed to IRQ 169
 > 	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
 > 	Region 1: I/O ports at 2000 [size=256]
 > 	Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
 > 	Expansion ROM at a8120000 [disabled] [size=128K]
 > 	Capabilities: <available only to root>
 > 00: 02 10 60 54 07 01 10 00 00 00 00 03 08 00 00 00
 > 10: 08 00 00 c0 01 20 00 00 00 00 10 a8 00 00 00 00
 > 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6e 05
 > 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

is actually AGP ? (lspci -vvv of that device [as root] will tell you)

		Dave

