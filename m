Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUCXALT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUCXALT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:11:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:36058 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S262932AbUCXALK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:11:10 -0500
Subject: Re: 2.6.4-mm2
From: Mary Edie Meredith <maryedie@osdl.org>
Reply-To: maryedie@osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20040323113219.506a7581.akpm@osdl.org>
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
Content-Type: text/plain
Organization: OSDL
Message-Id: <1080086848.10670.203.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 16:07:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 11:32, Andrew Morton wrote:
> Mary Edie Meredith <maryedie@osdl.org> wrote:
> >
> > > 36% regression due to the CPU scheduler changes?  ow.
> >  > 
> >  > And that machine is a PIII, so presumably the setting of CONFIG_SCHED_SMT
> >  > makes no difference.
> >  > 
> >  > >From a quick look at the material you have there it appears that this
> >  > workload also is very I/O bound.  It's a little surprising that the CPU
> >  > scheduler could make so much difference.
> >  I'm not sure why you think this is IO bound. For 
> >  the throughput phase of the test (from which the 
> >  metric above is taken) there is very little physical 
> >  IO except at the start when the updates occur.  They
> >  finish in a few minutes, after which there is very
> >  little.
> > 
> >  http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat_io.png
> >  http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat.txt
> 
> There seems to be a large amount of idle time in the profiles and in the
> vmstat trace.
Yes.  There is considerably more idle time in the bad run:
Good one:
http://khack.osdl.org/stp/290298/results/plot/thuput.sar_cpu_all.png
Bad one:
http://khack.osdl.org/stp/290304/results/plot/thuput.sar_cpu_all.png

I am concerned with the drop in CPU utilization relative to
the other run.     

-- 
Mary Edie Meredith 
maryedie@osdl.org
503-626-2455 x42
Open Source Development Labs

