Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTBJEhr>; Sun, 9 Feb 2003 23:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTBJEhq>; Sun, 9 Feb 2003 23:37:46 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:51859 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261854AbTBJEhp>; Sun, 9 Feb 2003 23:37:45 -0500
Date: Mon, 10 Feb 2003 02:47:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: David Lang <david.lang@digitalinsight.com>, "" <andrea@suse.de>,
       "" <ckolivas@yahoo.com.au>, "" <linux-kernel@vger.kernel.org>,
       "" <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <20030209203343.06608eb3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L.0302100245310.12742-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
 <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
 <20030209203343.06608eb3.akpm@digeo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Andrew Morton wrote:
> David Lang <david.lang@digitalinsight.com> wrote:
> >
> > note that issuing a fsync should change all pending writes to 'syncronous'
> > as should writes to any partition mounted with the sync option, or writes
> > to a directory with the S flag set.
>
> We know, at I/O submission time, whether a write is to be waited upon.
> That's in writeback_control.sync_mode.

An fsync might change already submitted asynchronous writes
into synchronous writes, but this is not something I'm going
to lose sleep over. ;)

> That, combined with an assumption that "all reads are synchronous" would
> allow the outgoing BIOs to be appropriately tagged.
>
> It's still approximate.

Sounds like a good enough approximation to me.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
