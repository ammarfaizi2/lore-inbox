Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282769AbRLOQFq>; Sat, 15 Dec 2001 11:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282778AbRLOQFg>; Sat, 15 Dec 2001 11:05:36 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:4480 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282769AbRLOQFZ>; Sat, 15 Dec 2001 11:05:25 -0500
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
From: Chris Chabot <chabotc@reviewboard.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20011215152446.P2431@athlon.random>
In-Reply-To: <1008419776.6780.0.camel@gandalf.chabotc.com> 
	<20011215152446.P2431@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 17:05:20 +0100
Message-Id: <1008432321.13025.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, rc1-aa1 is installed, up and running. Since it took a little more
then a day last time for this behavour to be displayed, i'll have to
wait before i can report back anything usefull.

Ps, a side question. if this is 'inode' and 'dentry' cache, why isnt it
reported as 'used by cache' in free, top, gtop, etc?

Also, why is this such a progressive problem? Even if i do a find on the
full +/- 400 gigs, create and remove 2 gig files, create 1000 temp
files, etc, in the first day the memory isnt 'disapearing' yet.
(ofcource it uses a lot of mem for cache/buffers, but no 'unaccounted
for in free or top' memory.

Will report back soon,

	-- Chris


On Sat, 2001-12-15 at 15:24, Andrea Arcangeli wrote:
> On Sat, Dec 15, 2001 at 01:36:11PM +0100, Chris Chabot wrote:
> > inode_cache       686896 686896    480 85862 85862    1 :  124   62
> > dentry_cache      696810 696810    128 23227 23227    1 :  252  126
> 
> this is an icache/dcache problem, can you reproduce on 2.4.17rc1aa1, it
> will shrink more aggressively.
> 
> really to get an even better balance we should add the icache/dcache
> slab pages into the lru as well... that would trigger the icache/dcache
> flushes more easily when too much ram is in those caches.
> 
> Andrea


