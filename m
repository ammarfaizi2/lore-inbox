Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTBYQ5o>; Tue, 25 Feb 2003 11:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268084AbTBYQ5o>; Tue, 25 Feb 2003 11:57:44 -0500
Received: from [195.223.140.107] ([195.223.140.107]:49798 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268060AbTBYQ5f>;
	Tue, 25 Feb 2003 11:57:35 -0500
Date: Tue, 25 Feb 2003 18:08:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues (2)
Message-ID: <20030225170830.GL29467@dualathlon.random>
References: <20030225131328.A8651@smp.colors.kwc> <20030225153213.GI29467@dualathlon.random> <20030225171540.A12884@smp.colors.kwc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225171540.A12884@smp.colors.kwc>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 05:15:40PM +0100, Dejan Muhamedagic wrote:
> Andrea:
> 
> On Tue, Feb 25, 2003 at 04:32:13PM +0100, Andrea Arcangeli wrote:
> > On Tue, Feb 25, 2003 at 01:13:28PM +0100, Dejan Muhamedagic wrote:
> > > 
> > > The aa kernel keeps ~200MB out of 6GB of memory unused.  I'm not
> > > sure, but if we could reduce it perhaps there would be much less
> > > swapping.  Is there a way to achieve this?
> > 
> > that is a feature, it guarantees highmem unfreeable allocations like
> > pagetables can't eat all your normal zone. You can reduce the 200MB with
> > this boot command:
> > 
> > 	lower_zone_reserve=256,256
> 
> But isn't 200MB too much?  Where would the new setting put the

no, on a 6GB it isn't too much compared to risk wasting several giga of
highmem.

> reserve mark?

the new reserve mark will turn it to around 25mbyte, of course your risk
to run in normal zone shortages increases that way.

> > As to decrease the swapping I just told you how to do that tweaking
> > vm_mapped_ratio.
> 
> Well, it has been set to 500, but it didn't make any difference
> (at least no obvious difference).  Is there anything more one
> could do about that?  The current level of swapping hurts
> performance quite a bit.  This is what the meminfo looks
> like:

you can try 10000.

Andrea
