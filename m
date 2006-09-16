Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWIPIbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWIPIbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWIPIbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:31:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6023 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932321AbWIPIbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:31:13 -0400
Date: Sat, 16 Sep 2006 10:23:10 +0200
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
Message-ID: <20060916082310.GE6317@elte.hu>
References: <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609160139130.6761@scrub.home>
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

> > > > > >  - a marker for dynamic tracing has lower performance impact
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > >    than a static tracepoint, on systems that are not being
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > >    traced. (but which have the tracing infrastructure enabled
               ^^^^^^
> > > > > >    otherwise)
> > > > >
> > > > > Anyone using static tracing intents to use, which makes this point
> > > > > moot.
> > > >
> > > > that's not at all true, on multiple grounds:
> > > >
> > > > Firstly, many people use distro kernels. A Linux distribution
> > > > typically wants to offer as few kernel rpms as possible (one per
> > > > arch to be precise), but it also wants to offer as many features
> > > > as possible. So if there was a static tracer in there, a distro
> > > > would enable it - but 99.9% of the users would never use it - still
> > > > they would see the overhead. Hence the user would have it enabled,
> > > > but does not intend to use it - which contradicts your statement.
> > >
> > > So if dynamic tracing is available use it, as distributions 
> > > already do. OTOH the barrier to use static tracing is drastically 
> > > different whether the user has to deal with external patches or 
> > > whether it's a simple kernel option. Again, static tracing doesn't 
> > > exclude the possibility of dynamic tracing, that's something you 
> > > constantly omit and thus make it sound like both options were 
> > > mutually exlusive.
> > 
> > how does this reply to my point that: "a marker for dynamic tracing has 
> > lower performance impact than a static tracepoint, on systems that are 
> > not being traced", which point you claimed moot?
> 
> Because it's pretty much an implementation issue. [...]

No, that's my point, it's not an "implementational issue" of static 
tracers, the overhead of markups for static tracers is:

   _inherent to their concept of being compile-time and static_

ok?

> [...] The point is about adding markers at all, it's about the choice 
> being able to use static tracers in the first place. [...]

your characterization of "the point" is at odds with the specific point 
that we are discussing - see the underlined sentence above, right at the 
top of the quotes:

> > > > > >  - a marker for dynamic tracing has lower performance impact
> > > > > >    than a static tracepoint, on systems that are not being
> > > > > >    traced. (but which have the tracing infrastructure enabled

Please either concede the point or dispute it, before shifting to new 
grounds. Thanks,

	Ingo
