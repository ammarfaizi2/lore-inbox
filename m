Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSKJUtz>; Sun, 10 Nov 2002 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265172AbSKJUtz>; Sun, 10 Nov 2002 15:49:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:56004 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265171AbSKJUty>;
	Sun, 10 Nov 2002 15:49:54 -0500
Message-ID: <3DCEC801.D742F973@digeo.com>
Date: Sun, 10 Nov 2002 12:56:33 -0800
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
X-OriginalArrivalTime: 10 Nov 2002 20:56:34.0394 (UTC) FILETIME=[A73FCBA0:01C288FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> So if 2.4.19-ck9 is so
> much faster under dbench and so much more responsive with the contest
> that seems to benchmark basically only the read latency under writeback
> flushing flood, then it is definitely worthwhile to produce a patch
> against mainline that generates this boost. If it has the preemption
> patch that could hardly explain it too, the improvement from 45 MB/sec
> to 65 MB/sec there's quite an huge difference and we have all the
> schedule points in the submit_bh too, so it's quite unlikely that
> preempt could explain that difference, it might against a mainline, but
> not against my tree.
> 
> Anyways this is all guessing, once I'll check the code after I
> reproduced the numbers things should be much more clear.

Well if I understand it correctly, compressed caching, umm, compresses
the cache ;)

And dbench writes 01 01 01 01 01 everywhere.  Enormously compressible.

So it's basically fitting vastly more pagecache into the machine.

That would be my guessing, anyway.  Changing dbench to write random
stuff might change the picture.
