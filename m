Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUC3Vfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUC3Vfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:35:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:32201 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbUC3VfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:35:22 -0500
Subject: Re: 2.6.4-mm2
From: Mary Edie Meredith <maryedie@osdl.org>
Reply-To: maryedie@osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1080086848.10670.203.camel@localhost>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <200403181737.i2IHbCE09261@mail.osdl.org>
	 <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de>
	 <20040318191530.34e04cb2.akpm@osdl.org>
	 <20040318194150.4de65049.akpm@osdl.org>
	 <20040319183906.I8594@osdlab.pdx.osdl.net>
	 <1079975940.23641.580.camel@localhost>
	 <20040322162729.2f2ddbe4.akpm@osdl.org>
	 <1080069704.10668.122.camel@localhost>
	 <20040323113219.506a7581.akpm@osdl.org>
	 <1080086848.10670.203.camel@localhost>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1080682252.6492.467.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 13:30:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.5-rc2-mm5 kernel has vastly improved the 
performance issue with dbt3-pgsql throughput numbers
(bigger is better):

Runid...Metric.PLM..Kernel........diff%
290357  141.84 2788 2.6.5-rc2.....  base 
290576   91.18 2814 2.6.5-rc2-mm2 -35.72
290856   60.02 2842 2.6.5-rc2-mm4 -57.68
290953  134.10 2849 2.6.5-rc2-mm5  -5.46 <-------

Thanks to Nick and Ingo. 

On Tue, 2004-03-23 at 16:07, Mary Edie Meredith wrote:
> On Tue, 2004-03-23 at 11:32, Andrew Morton wrote:
> > Mary Edie Meredith <maryedie@osdl.org> wrote:
> > >
> > > > 36% regression due to the CPU scheduler changes?  ow.
> > >  > 
> > >  > And that machine is a PIII, so presumably the setting of CONFIG_SCHED_SMT
> > >  > makes no difference.
> > >  > 
> > >  > >From a quick look at the material you have there it appears that this
> > >  > workload also is very I/O bound.  It's a little surprising that the CPU
> > >  > scheduler could make so much difference.
> > >  I'm not sure why you think this is IO bound. For 
> > >  the throughput phase of the test (from which the 
> > >  metric above is taken) there is very little physical 
> > >  IO except at the start when the updates occur.  They
> > >  finish in a few minutes, after which there is very
> > >  little.
> > > 
> > >  http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat_io.png
> > >  http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat.txt
> > 
> > There seems to be a large amount of idle time in the profiles and in the
> > vmstat trace.
> Yes.  There is considerably more idle time in the bad run:
> Good one:
> http://khack.osdl.org/stp/290298/results/plot/thuput.sar_cpu_all.png
> Bad one:
> http://khack.osdl.org/stp/290304/results/plot/thuput.sar_cpu_all.png
> 
> I am concerned with the drop in CPU utilization relative to
> the other run.     
-- 
Mary Edie Meredith 
maryedie@osdl.org
503-626-2455 x42
Open Source Development Labs

