Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUHPLIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUHPLIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUHPLIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:08:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:22277 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267531AbUHPLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:08:08 -0400
Date: Mon, 16 Aug 2004 12:08:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040816120801.A9862@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org> <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org> <Pine.LNX.4.58.0408161019040.21177@skynet> <20040816105014.A9367@infradead.org> <Pine.LNX.4.58.0408161101050.21177@skynet> <20040816113848.A9683@infradead.org> <Pine.LNX.4.58.0408161142490.21177@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408161142490.21177@skynet>; from airlied@linux.ie on Mon, Aug 16, 2004 at 12:02:15PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 12:02:15PM +0100, Dave Airlie wrote:
> > 	You do stop fb from beeing loaded after drm
> > and thus break perfectly working setups during stable series.  And you
> 
> I doubt anyone has a system that does it and they should have a broken one
> if they do it.. drm has also said you should load fb before it.. and
> having both fb and drm loaded on the same hardware is a hack anyways..

So fix it properly instead of making it even more broken.

> Yes and that is the final goal but you are dodging the point we cannot
> jump to a fully finished state in one simple transition, it is great to
> hear "fbdrv/drm into a common driver" it's a simple sentence surely coding
> it must be simple, well its not and we are taking the route that should

It _is+ simple.  Look at drivers/message/fusion/ for a driver doing multiple
protocol on a single pci_driver.  I don't demand full-blown memory management
integration or anything pother fancy.  Just get your crap sorted out.

ou could propably have done a prototype in the time you wasted arguing here.

> You seem to want us to go down the finished unmergeable mega-patch road
> to avoid breaking something that is broken and might work, the benefits
> don't outweight the costs.. so it makes no sense..

I want you a) to back out this particular broken change in your current
mega-patch.  and b) submit small reviewable changes in the future, as every
other driver maintainer does.

