Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSIXC4Q>; Mon, 23 Sep 2002 22:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSIXC4Q>; Mon, 23 Sep 2002 22:56:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:11416 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261324AbSIXC4P>;
	Mon, 23 Sep 2002 22:56:15 -0400
Message-ID: <3D8FD580.F1320237@digeo.com>
Date: Mon, 23 Sep 2002 20:01:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca> <1032835551.3d8fd1df2fba0@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2002 03:01:21.0102 (UTC) FILETIME=[A8EA66E0:01C26376]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> n=5 for number of samples
> 
> Kernel          Mean    CI(95%)
> 2.5.38          411     344-477
> 2.5.39-gcc32    371     224-519
> 2.5.38-mm2      95      84-105
> 
> The mean is a simple average of the results, and the CI(95%) are the 95%
> confidence intervals the mean lies between those numbers. These numbers seem to
> be the most useful for comparison.
> 
> Comparing 2.5.38(gcc2.95.3) with 2.5.38(gcc3.2) there is NO significant
> difference (p 0.56)
> 
> Comparing 2.5.38 with 2.5.38-mm2 there is a significant diffence (p<0.001)
> [SNIP...]
> 
> when I've run dozens of tests previously on the same kernel I've found that even
> with a mean of 400 rarely a value of 80 will come up. Clearly this lowest score
> does not give us the information we need.
> 

I think this is really going way too far.  I mean, the datum which
we take away from the above result is that 2.5.38 sucks. No more
accuracy is required.

Yes, if the differences are small then a few extra runs may be needed
to drill down into the finer margins.  The tester should be able to
judge that during the test.  You get a feel for these things.

I believe that your time would be better spent developing and incorporating
more tests (wider coverage) than worrying about super-high accuracy.

(And if there's more than a 1% variation between same kernel, compiled
with different compilers then the test is bust.  Kernel CPU time is
dominated by cache misses and runtime is dominated by IO wait.
Quality of code generation is of tiny significance)
