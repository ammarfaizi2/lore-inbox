Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbSIXJ25>; Tue, 24 Sep 2002 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbSIXJ25>; Tue, 24 Sep 2002 05:28:57 -0400
Received: from bohnice2.netroute.lam.cz ([212.71.169.62]:2296 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261620AbSIXJ2z>;
	Tue, 24 Sep 2002 05:28:55 -0400
Date: Tue, 24 Sep 2002 11:34:02 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020924093402.GB27205@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca> <1032835551.3d8fd1df2fba0@kolivas.net> <3D8FD580.F1320237@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8FD580.F1320237@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:01:20PM -0700, Andrew Morton wrote:
> Con Kolivas wrote:
> > 
> > ...
> > n=5 for number of samples
> > 
> > Kernel          Mean    CI(95%)
> > 2.5.38          411     344-477
> > 2.5.39-gcc32    371     224-519
> > 2.5.38-mm2      95      84-105
> > 
> > The mean is a simple average of the results, and the CI(95%) are the 95%
> > confidence intervals the mean lies between those numbers. These numbers seem to
> > be the most useful for comparison.
> > 
> > Comparing 2.5.38(gcc2.95.3) with 2.5.38(gcc3.2) there is NO significant
> > difference (p 0.56)
> > 
> > Comparing 2.5.38 with 2.5.38-mm2 there is a significant diffence (p<0.001)
> > [SNIP...]
> > 
> > when I've run dozens of tests previously on the same kernel I've found that even
> > with a mean of 400 rarely a value of 80 will come up. Clearly this lowest score
> > does not give us the information we need.
> > 
> 
> I think this is really going way too far.  I mean, the datum which
> we take away from the above result is that 2.5.38 sucks. No more
> accuracy is required.

5 samples is about the minimum where you can compute the confidence
intervals and trust them to reasonable extent. We see, that it's enough
samples to compare to the -mm2. But we can't say anything about gcc32
compiled version.

> Yes, if the differences are small then a few extra runs may be needed
> to drill down into the finer margins.  The tester should be able to
> judge that during the test.  You get a feel for these things.
> 
> I believe that your time would be better spent developing and incorporating
> more tests (wider coverage) than worrying about super-high accuracy.

Accuracy is increased by just geting more samples. More tests are of
course important, but each must be run enough times so the results are
statisticaly significant.

> (And if there's more than a 1% variation between same kernel, compiled
> with different compilers then the test is bust.  Kernel CPU time is
> dominated by cache misses and runtime is dominated by IO wait.
> Quality of code generation is of tiny significance)

So we will need a lot runs to see if there is a difference...

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
