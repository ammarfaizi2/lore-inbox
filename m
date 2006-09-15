Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWIOU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWIOU43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWIOU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:56:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14736 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932262AbWIOU42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:56:28 -0400
Date: Fri, 15 Sep 2006 22:48:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915204812.GA6909@elte.hu>
References: <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152236010.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Fri, 15 Sep 2006, Thomas Gleixner wrote:
> 
> > So this has to be changed. And requiring to recompile the kernel is the
> > wrong answer. Having some nifty tool, which allows you to define the set
> > of dynamic trace points or use a predefined one is the way to go.
> 
> Nobody is taking dynamic tracing away!
> You make it sound that tracing is only possible via dynamic traces.
> If I want to use static tracepoints, why shouldn't I?

because:

 - static tracepoints, once added, are very hard to remove - up until
   eternity. (On the other hand, markers for dynamic tracers are easily 
   removed, either via making the dynamic tracer smarter, or by 
   detaching the marker via the patch(1) method. In any case, if a 
   marker goes away then hell does not break loose in dynamic tracing 
   land - but it does in static tracing land.

 - the markers needed for dynamic tracing are different from the LTT
   static tracepoints.

 - a marker for dynamic tracing has lower performance impact than a 
   static tracepoint, on systems that are not being traced. (but which 
   have the tracing infrastructure enabled otherwise)

 - having static tracepoints dillutes the incentive for architectures to
   implement proper kprobes support.

> > > there are separate project teams is because managers in key 
> > > positions made the decision that they'd rather break from existing 
> > > projects which had had little success mainlining and instead use 
> > > their corporate bodyweight to pressure/seduce kernel developers 
> > > working for them into pushing their new great which-aboslutely- 
> > > has-nothing-to-do-with-this-ltt-crap-(no,no, we actually agree 
> > > with you kernel developers that this is crap, this is why we're 
> > > developing this new amazing thing). That's the truth plain and 
> > > simple.
> >
> > Stop whining!
> 
> So we're back to personal attacks now. :-(

hm, so you dont consider the above paragraph a whine. How would you 
characterize it then? A measured, balanced, on-topic technical comment? 
I'm truly curious.

	Ingo
