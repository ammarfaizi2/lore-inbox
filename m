Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTBOLjg>; Sat, 15 Feb 2003 06:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTBOLjg>; Sat, 15 Feb 2003 06:39:36 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:14572 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261523AbTBOLjf>; Sat, 15 Feb 2003 06:39:35 -0500
Date: Sat, 15 Feb 2003 09:49:15 -0200 (BRST)
From: Rik van Riel <riel@imladris.surriel.com>
To: Mike Galbraith <efault@gmx.de>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CFQ scheduler, #2
In-Reply-To: <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net>
Message-ID: <Pine.LNX.4.50L.0302150947570.20371-100000@imladris.surriel.com>
References: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
 <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net> <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Mike Galbraith wrote:

> >Judging from your log, it ends up stalling kswapd and
> >dramatically increases the number of times that normal
> >processes need to go into the pageout code.
> >
> >If this provides an anti-thrashing benefit, something's
> >wrong with the VM in 2.5 ;)
>
> Which number are you looking at?

pgscan             2751953        5328260  <== ? hmm

kswapd_steal        380282         522126
pageoutrun            1107           1956
allocstall            3472           1238

- we scan far less pages
- kswapd reclaims less pages
- we go into the pageout code less often
- allocations stall more often for a lack of free memory

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
