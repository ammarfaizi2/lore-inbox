Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSKJUp3>; Sun, 10 Nov 2002 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265170AbSKJUp3>; Sun, 10 Nov 2002 15:45:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:51396 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265168AbSKJUp2>;
	Sun, 10 Nov 2002 15:45:28 -0500
Message-ID: <3DCEC6F7.E5EC1147@digeo.com>
Date: Sun, 10 Nov 2002 12:52:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <20021110024451.GE2544@x30.random> <Pine.LNX.4.44L.0211101727230.8133-100000@imladris.surriel.com> <20021110201045.GA4056@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 20:52:08.0428 (UTC) FILETIME=[08B89AC0:01C288FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > Whether the IO is synchronous or asynchronous shouldn't matter much,
> 
> the fact the I/O is sync or async makes the whole difference. with sync
> reads the vmstat line in the read column will be always very small
> compared to the write column under a write flood. This can be fixed either:
> 
> 1) with hacks in the elevator ala read-latency that are not generic and
>    could decrease performance of other workloads

read-latency will only do the front-insertion if it was unable to find a
merge or insert on the tail-to-head search.

And the problem it desparately addresses is severe.
