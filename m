Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTBYQFa>; Tue, 25 Feb 2003 11:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTBYQFa>; Tue, 25 Feb 2003 11:05:30 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:18415 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id <S264992AbTBYQF2>; Tue, 25 Feb 2003 11:05:28 -0500
Date: Tue, 25 Feb 2003 17:15:40 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues (2)
Message-ID: <20030225171540.A12884@smp.colors.kwc>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030225131328.A8651@smp.colors.kwc> <20030225153213.GI29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225153213.GI29467@dualathlon.random>
User-Agent: Mutt/1.3.23i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 14 36 39 40 41 45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea:

On Tue, Feb 25, 2003 at 04:32:13PM +0100, Andrea Arcangeli wrote:
> On Tue, Feb 25, 2003 at 01:13:28PM +0100, Dejan Muhamedagic wrote:
> > 
> > The aa kernel keeps ~200MB out of 6GB of memory unused.  I'm not
> > sure, but if we could reduce it perhaps there would be much less
> > swapping.  Is there a way to achieve this?
> 
> that is a feature, it guarantees highmem unfreeable allocations like
> pagetables can't eat all your normal zone. You can reduce the 200MB with
> this boot command:
> 
> 	lower_zone_reserve=256,256

But isn't 200MB too much?  Where would the new setting put the
reserve mark?

> As to decrease the swapping I just told you how to do that tweaking
> vm_mapped_ratio.

Well, it has been set to 500, but it didn't make any difference
(at least no obvious difference).  Is there anything more one
could do about that?  The current level of swapping hurts
performance quite a bit.  This is what the meminfo looks
like:

        total:    used:    free:  shared: buffers:  cached:
Mem:  6341447680 6134513664 206934016        0 66162688 5240639488
Swap: 12582862848 5967990784 6614872064
MemTotal:      6192820 kB
MemFree:        202084 kB
MemShared:           0 kB
Buffers:         64612 kB
Cached:        1982052 kB
SwapCached:    3135760 kB
Active:         304668 kB
Inactive:      4878072 kB
HighTotal:     5358496 kB
HighFree:         2528 kB
LowTotal:       834324 kB
LowFree:        199556 kB
SwapTotal:    12287952 kB
SwapFree:      6459836 kB
BigFree:             0 kB

Cheers!

Dejan
