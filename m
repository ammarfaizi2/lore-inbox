Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVAUHm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVAUHm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAUHm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:42:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262298AbVAUHm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:42:26 -0500
Date: Fri, 21 Jan 2005 08:42:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050121074203.GH2755@suse.de>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120171544.GN12647@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20 2005, Andrea Arcangeli wrote:
> On Thu, Jan 20, 2005 at 02:15:56PM +0100, Andries Brouwer wrote:
> > On Thu, Jan 20, 2005 at 01:34:06PM +0100, Jens Axboe wrote:
> > 
> > > Using current BK on my x86-64 workstation, it went completely nuts today
> > > killing tasks left and right with oodles of free memory available.
> > 
> > Yes, the fact that the oom-killer exists is a serious problem.
> > People work on trying to tune it, instead of just removing it.
> 
> I'm working on fixing it, not just tuning it. The bugs in mainline
> aren't about the selection algorithm (which is normally what people
> calls oom killer). The bugs in mainline are about being able to kill a
> task reliably, regardless of which task we pick, and every linux kernel
> out there has always killed some task when it was oom. So the bugs are
> just obvious regressions of 2.6 if compared to 2.4.
> 
> But this is all fixed now, I'm starting sending the first patches to
> Anderw very shortly (last week there was still the oracle stuff going
> on). Now I can fix the rejects.
> 
> I will guarantee nothing about which task will be picked (that's the old
> code at works, I changed not a bit in what normally people calls "the oom
> killer", plus the recent improvement from Thomas), but I guarantee the
> VM won't kill tasks right and left like it does now (i.e. by invoking the
> oom killer multiple times).

And especially not with 500MB of zone normal free, thanks :)

2.6.11-rc1-xx vm behaviour is looking a _lot_ worse than 2.6.10 btw, I
haven't looked closer at what has changed yet it's just a subjective
feeling. I regularly have to run a fillmem.c hog to prune caches or it
runs like an old dog.

-- 
Jens Axboe

