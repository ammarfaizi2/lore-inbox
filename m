Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269008AbTBWXXk>; Sun, 23 Feb 2003 18:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269012AbTBWXXk>; Sun, 23 Feb 2003 18:23:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18187 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269008AbTBWXXi>; Sun, 23 Feb 2003 18:23:38 -0500
Date: Sun, 23 Feb 2003 18:29:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ben Greear <greearb@candelatech.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <3E57FD42.7030606@candelatech.com>
Message-ID: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Ben Greear wrote:

> Mark Hahn wrote:

> > oh, come on.  the issue is whether memory is fast and flat.
> > most "scalability" efforts are mainly trying to code around the fact
> > that any ccNUMA (and most 4-ways) is going to be slow/bumpy.
> > it is reasonable to worry that optimizations for imbalanced machines
> > will hurt "normal" ones.  is it worth hurting uni by 5% to give
> > a 50% speedup to IBM's 32-way?  I think not, simply because 
> > low-end machines are more important to Linux.
> > 
> > the best way to kill Linux is to turn it into an OS best suited 
> > for $6+-digit machines.
> 
> Linux has a key feature that most other OS's lack:  It can (easily, and by all)
> be recompiled for a particular architecture.  So, there is no particular reason why
> optimizing for a high-end system has to kill performance on uni-processor
> machines.

This is exactly correct, although build just the optimal kernel for a
machine is still somewhat art rather than science. You have to choose the
trade-offs carefully.

> For instance, don't locks simply get compiled away to nothing on
> uni-processor machines?

Preempt causes most of the issues of SMP with few of the benefits. There
are loads for which it's ideal, but for general use it may not be the
right feature, and I ran it during the time when it was just a patch, but
lately I'm convinced it's for special occasions.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

