Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbTBWIEH>; Sun, 23 Feb 2003 03:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268059AbTBWIEH>; Sun, 23 Feb 2003 03:04:07 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:23980 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S268057AbTBWIEG>;
	Sun, 23 Feb 2003 03:04:06 -0500
Date: Sun, 23 Feb 2003 09:13:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: make the sl82c105 work again
Message-ID: <20030223091330.A31359@ucw.cz>
References: <E18lCZa-0006Ec-00@the-village.bc.nu> <20030218185309.C9785@flint.arm.linux.org.uk> <1045601367.570.56.camel@zion.wanadoo.fr> <1045620358.25795.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1045620358.25795.24.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 19, 2003 at 02:05:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 02:05:59AM +0000, Alan Cox wrote:

> On Tue, 2003-02-18 at 20:49, Benjamin Herrenschmidt wrote:
> > and when setting xfer mode. Not on hdparm -d1. I'm still wondering
> > what is the best fix for that. For ide-pmac, I did the later
> > (only do the job in check()), but I also think we should change
> > ide.c to actually call hwif->ide_dma_check() when DMA is turned
> > ON with hdparm instead of ide_dma_on().
> 
> I think thats the right change for 2.5 at least

I think it'd be VERY good for 2.4 as well. Older 2.4's did setup the
DMA timing when -d1 only was used.

-- 
Vojtech Pavlik
SuSE Labs
