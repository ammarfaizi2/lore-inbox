Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUHPLrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUHPLrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUHPLrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:47:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:29382 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267553AbUHPLrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:47:42 -0400
Date: Mon, 16 Aug 2004 12:47:16 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040816120801.A9862@infradead.org>
Message-ID: <Pine.LNX.4.58.0408161218520.32584@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
 <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org>
 <Pine.LNX.4.58.0408161101050.21177@skynet> <20040816113848.A9683@infradead.org>
 <Pine.LNX.4.58.0408161142490.21177@skynet> <20040816120801.A9862@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes and that is the final goal but you are dodging the point we cannot
> > jump to a fully finished state in one simple transition, it is great to
> > hear "fbdrv/drm into a common driver" it's a simple sentence surely coding
> > it must be simple, well its not and we are taking the route that should
>
> It _is+ simple.  Look at drivers/message/fusion/ for a driver doing multiple
> protocol on a single pci_driver.  I don't demand full-blown memory management
> integration or anything pother fancy.  Just get your crap sorted out.
>
> ou could propably have done a prototype in the time you wasted arguing here.

we could write one quick enough for one card but now make it work on
combinations of mach64/i810/radeon/r128/i830/i915/mga cards and tested so
that it doesn't break current setups, its just not going to happen, this
change doesn't break near as many setups (I'd be surprised if it broke any
real world setups at all...) I don't have the hardware to test this on all
those cards, the hope is to get the DRM into a state that we can start
proving the shared idea on one card.. it will also make changes to fb
drivers which I'm not comfortable with doing and will cause more hassles..

> I want you a) to back out this particular broken change in your current
> mega-patch.  and b) submit small reviewable changes in the future, as every
> other driver maintainer does.

I'm considering your argument and have taken it on-board, I await Linus's
decision for now, I'll start looking into the info you've given me and
I'll talk to the DRM people actually doing the work (not one line of this
is orignally from me!!..)

All DRM changes are available in small chunks in DRM CVS and DRM bk trees,
the -mm tree picks up the DRM changes and I fix the bugs that come up in
the -mm tree and then I submit the bk tree to Linus, I thought this was
how kernel development worked these days,

The patch you are against is
http://drm.bkbits.net:8080/drm-2.6/patch@1.1784.4.4?nav=index.html|tags|ChangeSet@1.1722.154.18..|cset@1.1784.4.4

with a couple of bugfixes on top of it from testing in -mm.. if I'm
missing the kernel development process somehow please inform me.. I'm new
to this maintainer job and the drm hasn't been maintained in years so I'm
not starting from a good place...

Thanks,
Dave.

