Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264548AbSIWK6v>; Mon, 23 Sep 2002 06:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265485AbSIWK6v>; Mon, 23 Sep 2002 06:58:51 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:9992 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S264548AbSIWK6u>; Mon, 23 Sep 2002 06:58:50 -0400
Date: Mon, 23 Sep 2002 04:03:55 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020923110355.GF10841@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain> <1032777021.3d8eed3d55f53@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032777021.3d8eed3d55f53@kolivas.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> Quoting Ingo Molnar <mingo@elte.hu>:
> 
> > On Mon, 23 Sep 2002, Con Kolivas wrote:
> > 
> > > IO Full Load:
> > > 2.5.38                  170.21          42%
> > > 2.5.38-gcc32            230.77          30%
> > 
> > how many times are you running each test? You should run them at least
> > twice (ideally 3 times at least), to establish some sort of statistical
> > noise measure. Especially IO benchmarks tend to fluctuate very heavily
> > depending on various things - they are also very dependent on the initial
> > state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
> > measurement result would be something like:
> 
> Yes you make a very valid point and something I've been stewing over privately
> for some time. contest runs benchmarks in a fixed order with a "priming" compile
> to try and get pagecaches etc back to some sort of baseline (I've been trying
> hard to make the results accurate and repeatable). 
> 
> Despite that, you're correct in assuming the IO load will fluctuate widely. My
> initial tests show that noload and process_load (not surprisingly) vary very
> little. Mem_load varies a little. IO Loads can vary wildly, and the worse the
> average performance is, the greater the variation (I mean percentage variation
> not just absolute).
> 
> >  IO Full Load:
> >  2.5.38                  170.21 +- 55.21 sec        42%
> >  2.5.38-gcc32            230.77 +- 60.22 sec        30%
> > 
> > where the first column is the average of two measurements, the second
> > column is the delta of the two measurements divided by 2. This way we can
> > see the 'spread' of the results.
> 
> I'll create some results based on 3 runs soon. 
> 
> > I simply cannot believe that gcc32 can produce any visible effect in any
> > of the IO benchmarks, the only explanation would be heavy fluctuation of
> > IO results.
> 
> Agreed. There probably is no statistically significant difference in the
> different gcc versions.
> 
> Contest is very new and I appreciate any feedback I can get to make it as
> worthwhile a benchmark as possible to those who know.

What hapened to the relative improvement (ratio against
baseline)?  In this test it didn't matter much because the
baselines were almost identical but others lately especially
between different platforms it would have helped.

Perhaps someone who is a statistician could give Con a hand?
This looks like a good test but Ingo is right.  We need
p-values and/or confidence intervals and enough runs to get
them to at least 90% if possible.  I only know enough to
look at them when reported and say (non)random or
(in)significant correlation.  I couldn't begin to calculate
them.  Of course we don't want the measured data smothered in
analytical data, just enough to see if the numbers
are meaningfull.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
