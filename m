Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSKKBBi>; Sun, 10 Nov 2002 20:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKKBBi>; Sun, 10 Nov 2002 20:01:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:34181 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265276AbSKKBBi>;
	Sun, 10 Nov 2002 20:01:38 -0500
Date: Mon, 11 Nov 2002 02:08:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111010811.GA5343@x30.random>
References: <20021110024451.GE2544@x30.random> <Pine.LNX.4.44L.0211101727230.8133-100000@imladris.surriel.com> <20021110201045.GA4056@x30.random> <3DCEC801.D742F973@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCEC801.D742F973@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 12:56:33PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > So if 2.4.19-ck9 is so
> > much faster under dbench and so much more responsive with the contest
> > that seems to benchmark basically only the read latency under writeback
> > flushing flood, then it is definitely worthwhile to produce a patch
> > against mainline that generates this boost. If it has the preemption
> > patch that could hardly explain it too, the improvement from 45 MB/sec
> > to 65 MB/sec there's quite an huge difference and we have all the
> > schedule points in the submit_bh too, so it's quite unlikely that
> > preempt could explain that difference, it might against a mainline, but
> > not against my tree.
> > 
> > Anyways this is all guessing, once I'll check the code after I
> > reproduced the numbers things should be much more clear.
> 
> Well if I understand it correctly, compressed caching, umm, compresses
> the cache ;)
> 
> And dbench writes 01 01 01 01 01 everywhere.  Enormously compressible.
> 
> So it's basically fitting vastly more pagecache into the machine.
> 
> That would be my guessing, anyway.  Changing dbench to write random
> stuff might change the picture.

yes, it may be the pagecache compression that makes the difference here.
My hardware has lots of disk and ram bandwidth so it should benefit less
from compression. the results on my tree are finished, I'm starting a
new run on ck10.

Andrea
