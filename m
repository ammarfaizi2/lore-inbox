Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSIXJNj>; Tue, 24 Sep 2002 05:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSIXJNj>; Tue, 24 Sep 2002 05:13:39 -0400
Received: from bohnice2.netroute.lam.cz ([212.71.169.62]:20989 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261330AbSIXJNi>;
	Tue, 24 Sep 2002 05:13:38 -0400
Date: Tue, 24 Sep 2002 11:18:45 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020924091845.GA27205@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com> <1032791089.3d8f2431231ac@kolivas.net> <20020923163452.GF9726@waste.org> <1032817665.3d8f8c0156b2e@kolivas.net> <20020924011234.GC15156@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924011234.GC15156@pegasys.ws>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 06:12:34PM -0700, jw schultz wrote:
> On Tue, Sep 24, 2002 at 07:47:45AM +1000, Con Kolivas wrote:
> > Quoting Oliver Xymoron <oxymoron@waste.org>:
> > 
> > > On Tue, Sep 24, 2002 at 12:24:49AM +1000, Con Kolivas wrote:
> > > > 
> > > > That is the system I was considering. I just need to run enough
> > > > benchmarks to make this worthwhile though. That means about 5 for
> > > > each it seems - which may take me a while. A basic mean will suffice
> > > > for a measure of central tendency. I also need to quote some measure
> > > > of variability. Standard deviation?
> > > 
> > > No, standard deviation is inappropriate here. We have no reason to
> > > expect the distribution of problem cases to be normal or even smooth.
> > > What we'd really like is range and mean. Don't throw out the outliers
> > > either, the pathological cases are of critical interest.
> > 
> > Yes. Definitely the outliers appear to make the difference to the results. The
> > mean and range appear to be the most important on examining this data. The only
> > purpose to quoting other figures would be for inferential statistics to
> > determine if there is a statistically significant difference to the groups. My
> > overnight benchmarking has generated a few results and I will publish something
> > soon.
> 
> Happy am i to be wrong in suggesting you would benefit from
> the help of a statistician.  My apologies.
> 
> Sounds like we are getting to relative performance and
> confidence interval (much bettern than +/- x) which would be
> useful for those doing performance improvements and for us
> who must tune or are watching the improvments take place.

There is no reason, why separate tests should be distributed normally.
But acoording to central limit theorem, distribution of the mean
converges to normal with increasing number of tests. So standart
deviation will tell to what precision we can trust the mean, that is to
compute the confidence interval.

We should have a bit more than 3 tests (first run can't be considered,
it has different starting conditions).  About 5 would do, 10 would be
perfect.

I would like to see the complete set of results anyway. There may be
some more interesting things to compute.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
