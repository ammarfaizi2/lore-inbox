Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTBJNQo>; Mon, 10 Feb 2003 08:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTBJNQo>; Mon, 10 Feb 2003 08:16:44 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:50373 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267845AbTBJNQn>; Mon, 10 Feb 2003 08:16:43 -0500
Date: Mon, 10 Feb 2003 11:26:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Piggin <piggin@cyberone.com.au>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@digeo.com>, "" <jakob@unthought.net>,
       "" <david.lang@digitalinsight.com>, "" <ckolivas@yahoo.com.au>,
       "" <linux-kernel@vger.kernel.org>, "" <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <20030210120006.GC31401@dualathlon.random>
Message-ID: <Pine.LNX.4.50L.0302101123270.12742-100000@imladris.surriel.com>
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random>
 <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com>
 <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au>
 <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au>
 <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au>
 <20030210120006.GC31401@dualathlon.random>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2003 at 10:45:59PM +1100, Nick Piggin wrote:
> > perspective it does nullify the need for readahead (though
> > it is obivously still needed for other reasons).
>
> I'm guessing that physically it may be needed from a head prospective
> too, I doubt it only has to do with the in-core overhead.  Seeing it all
> before reaching the seek point might allow the disk to do smarter things

> NOTE: just to be sure, I'm not at all against anticpiatory scheduling,

Most disks seem to have a large cache, but with the cache unit
for most of the cache being one _track_ at a time.

This has the effect of the disk reading one track in at a time,
but only being able to cache a few of these tracks in its cache.

Anticipatory scheduling should reduce any thrashing of this disk
cache.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
