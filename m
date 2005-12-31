Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVLaBQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVLaBQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLaBQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:16:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62910 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932075AbVLaBQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:16:17 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <5bdc1c8b0512301659m5d4431bu6915dbe10d9aaa79@mail.gmail.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
	 <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
	 <5bdc1c8b0512301659m5d4431bu6915dbe10d9aaa79@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 20:16:15 -0500
Message-Id: <1135991776.31111.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 16:59 -0800, Mark Knecht wrote:
> On 12/30/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-12-30 at 09:00 +0100, Ingo Molnar wrote:
> > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > > It seems that debug_smp_processor_id is being called a lot, even
> > > > though I have a UP config, which I didn't see with the -rt kernel:
> > >
> > > do you have CONFIG_DEBUG_PREEMPT enabled? (if yes then disable it)
> > >
> > > > Was this optimized out on UP before?
> > >
> > > no, because smp_processor_id() debugging is useful on UP too: it checks
> > > whether smp_processor_id() is every called with preemption enabled, and
> > > reports such bugs.
> >
> > It seems that the networking code's use of RCU can cause 10ms+
> > latencies:
> >
> 
> 
> Hi,
>    I've noted for awhile that on my AMD64 machine that has xrun issues
> that at least annecdotally it has always seemed that the network
> interface was somehow involved. I wonder if this may turn out to be
> true?
> 
> Q: Did the latency trace stuff ever get fixed for AMD64? I'm running
> 2.6.15-rc7-rt1 as of today. I've had xruns all afternoon while working
> inside of MythTV. (Start, stop, rewind, pause all over the place...)

Yes, it should have.  What happens when you try it?

Lee

