Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbSIXCkl>; Mon, 23 Sep 2002 22:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSIXCkl>; Mon, 23 Sep 2002 22:40:41 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:64153 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261538AbSIXCkk>;
	Mon, 23 Sep 2002 22:40:40 -0400
Message-ID: <1032835551.3d8fd1df2fba0@kolivas.net>
Date: Tue, 24 Sep 2002 12:45:51 +1000
From: Con Kolivas <conman@kolivas.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Hahn <hahn@physics.mcmaster.ca>:

> > Yes. Definitely the outliers appear to make the difference to the results.
> The
> 
> best score is clearly the most important, along with some measure of
> spread.
> 
> best-worst is a lousy measure of spread; stdev is not bad for that
> (or closely related measures like absdev, or stdev-from-mean, etc.)
> 
> for contests, best is definitely the first score you want.
> 

Normally yes. This is quite different. We want to know if there can be periods
where the machine is busy doing file IO to the exclusion of everything else. If
anything, the worst is the measure we want. Even the worst performing kernels
I've tried can have the occasional very good score, but look at these results
how I've presented them in the follow up and you'll see what I mean:

from the new thread I've started entitled  
[BENCHMARK] Statistical representation of IO load results with contest

[...SNIP]
n=5 for number of samples

Kernel          Mean    CI(95%)
2.5.38          411     344-477
2.5.39-gcc32    371     224-519
2.5.38-mm2      95      84-105


The mean is a simple average of the results, and the CI(95%) are the 95%
confidence intervals the mean lies between those numbers. These numbers seem to
be the most useful for comparison.

Comparing 2.5.38(gcc2.95.3) with 2.5.38(gcc3.2) there is NO significant
difference (p 0.56)

Comparing 2.5.38 with 2.5.38-mm2 there is a significant diffence (p<0.001)
[SNIP...]

when I've run dozens of tests previously on the same kernel I've found that even
with a mean of 400 rarely a value of 80 will come up. Clearly this lowest score
does not give us the information we need.

Con.
