Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTL3CDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTL3CDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:03:52 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:15065 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264290AbTL3CDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:03:51 -0500
Date: Mon, 29 Dec 2003 18:03:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230020336.GM1882@matchmail.com>
Mail-Followup-To: Thomas Molina <tmolina@cablespeed.com>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain> <1072741422.25741.67.camel@nosferatu.lan> <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain> <20031230012715.GA30369@redhat.com> <1072748264.25741.79.camel@nosferatu.lan> <Pine.LNX.4.58.0312292043420.6227@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312292043420.6227@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:49:07PM -0500, Thomas Molina wrote:
> On Tue, 30 Dec 2003, Martin Schlemmer wrote:
> 
> > > It's not uncommon for a laptop to have a hard disk which supports
> > > higher DMA modes than what the IDE chipset supports.
> > > My aging Intel 440BX based VAIO has a disk in the same configuration
> > > as yours, supports udma4, but chipset only goes up to udma2.
> > > 
> > 
> > Right, or as somebody else pointed out, it might not be a 80-pin cable.
> > 
> > Lets rephrase - does it also run in udma2 mode with 2.4 ?  And did
> > you check readahead?  In 2.6 it seems that a bigger value is better -
> > I for instance have to set it to 8192 to have the same performance as
> > in 2.4 ...
> 
> 8192 will be my next test.  I'm doing a compile at the moment.  It runs in 
> udma2 under both 2.4 and 2.6.  If I need an 80-pin cable then udma4 is not 
> possible for this system.  If I read the following, it is only capable of 
> 66MHz anyway:
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) 
> (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-

66Mhz has nothing to do with the DMA factor (33, 66, 100, 133, etc.).
That's talking about the PCI bus, and I doubt you have a 66Mhz bus in a
laptop.
