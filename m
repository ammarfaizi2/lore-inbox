Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVAUIra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVAUIra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAUIrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:47:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51081 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262324AbVAUIqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:46:08 -0500
Date: Fri, 21 Jan 2005 09:46:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050121084606.GE2763@suse.de>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050121074203.GH2755@suse.de> <20050121080520.GA7703@dualathlon.random> <20050121080940.GA2763@suse.de> <20050121084111.GB7703@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121084111.GB7703@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21 2005, Andrea Arcangeli wrote:
> On Fri, Jan 21, 2005 at 09:09:41AM +0100, Jens Axboe wrote:
> > Jan 20 13:22:15 wiggum kernel: oom-killer: gfp_mask=0xd1
> 
> This was a GFP_KERNEL|GFP_DMA allocation triggering this. However it
> didn't look so much out of DMA zone, there's 4M of ram free. Could be
> the ram was relased by another CPU in the meantime if this was SMP (or
> even by an interrupt in UP too).

It is/was UP.

> Could very well be you'll get things fixed by the lowmem_reserve patch,
> that will reserve part of the dma zone, so with it you're sure it
> couldn't have gone below 4M due slab allocs like skb.
> 
> I recommend trying again with the patches applied, the oom stuff is so
> buggy right now that it's better you apply the fixes and try again, and
> if it still happens we know it's a regression.

I've added all 6 of the OOM patches (I didn't notice that thread until
now).

-- 
Jens Axboe

