Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTBJVeP>; Mon, 10 Feb 2003 16:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTBJVeP>; Mon, 10 Feb 2003 16:34:15 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:32647 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265211AbTBJVeN>; Mon, 10 Feb 2003 16:34:13 -0500
Date: Mon, 10 Feb 2003 19:43:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Kurt Garloff <garloff@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       Jakob Oestergaard <jakob@unthought.net>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>, "" <ckolivas@yahoo.com.au>,
       "" <linux-kernel@vger.kernel.org>, "" <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <20030210203353.GA13976@nbkurt.casa-etp.nl>
Message-ID: <Pine.LNX.4.50L.0302101942420.29614-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
 <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
 <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net>
 <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random>
 <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random>
 <3E476287.8070407@cyberone.com.au> <20030210090248.GP31401@dualathlon.random>
 <20030210203353.GA13976@nbkurt.casa-etp.nl>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Kurt Garloff wrote:

> Readahead kills seeks and command overhead at the expense of maybe
> transfering data needlessly over the bus and consuming RAM.
>
> AS kills seeks. (At the expense of delaying some IO a tiny bit.)
>
> If unecessary seeks are the main problem, with AS smaller READA is
> possible. If command overhead is a problem, READA needs to be large.

Think about reading inode blocks or a bunch of related .h
files.  We can't nicely do readahead in either of these
scenarios, but AS should take care of them nicely...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
