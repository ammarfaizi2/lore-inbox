Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266483AbRGMCG2>; Thu, 12 Jul 2001 22:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbRGMCGS>; Thu, 12 Jul 2001 22:06:18 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:5393 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S266483AbRGMCGM>; Thu, 12 Jul 2001 22:06:12 -0400
Date: Fri, 13 Jul 2001 02:06:07 +0000 (GMT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
In-Reply-To: <20010712173641.C11719@work.bitmover.com>
Message-ID: <Pine.LNX.4.10.10107130131390.3018-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the amount of data/instructions needed by all 5 processes fits in the 
> cache and you pin all the processes to the same CPU you'll get much 
> better performance than simply letting them float.

interesting.  I remember that around 2.3.40, the scheduler handled
"frequent-schedulers" (like lat_ctx) differently, based on how long 
a timeslice the proc used, relative to the estimated time to flush cache.

as I recall, it let them stay on their current CPU.  like letting 
someone with 1 item go ahead of you in a grocery store checkout ;)

that code is mostly gone (only cacheflush_time remains);  I think it
morphed into the current migrate-to-longest-idle heuristic.

does anyone remember why the frequent-schedulers code was killed?
just because it conflated cache-affinity with timeslice?

regards, mark hahn.

