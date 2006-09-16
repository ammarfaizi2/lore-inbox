Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWIPI35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWIPI35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWIPI35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:29:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56198 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932321AbWIPI3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:29:55 -0400
Date: Sat, 16 Sep 2006 10:21:54 +0200
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
Message-ID: <20060916082154.GC6317@elte.hu>
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

> > > > > This is simply not true, at the source level you can remove a 
> > > > > static tracepoint as easily as a dynamic tracepoint, the 
> > > > > effect of the missing trace information is the same either way.
> > > >
> > > > this is not true. I gave you one example already a few mails ago
> > > > [...]
> > >
> > > Function attributes also doesn't provide information local to the 
> > > function.
> > 
> > of course, but where does the above tracepoint i quoted use 
> > information local to the function? A fair number of markups use 
> > global functions because, surprise, alot of interesting activity 
> > happens along global functions. So a healthy reduction in markups 
> > can be achieved.
> 
> But not completely, which is the whole point.

the point was what you said above, which i claimed and still claim to be 
false: "at the source level you can remove a static tracepoint as easily 
as a dynamic tracepoint, the effect of the missing trace information is 
the same either way."

Your point is still incorrect. I gave you an example of how half of the 
tracepoints could be removed under a dynamic scheme - while they couldnt 
be removed under a static scheme. Hence that directly contradicts your 
contention that "you can remove a static tracepoint as easily as a 
dynamic tracepoint". Nothing more, nothing less. I just pointed out the 
point in your thinking that i believe to be incorrect.

Reality is that you can remove a dynamic tracepoint much easier, due to 
the fundamental flexibility of dynamic tracers. While with static 
tracers, every tracepoint has to be _somewhere_ in the source code, 
otherwise people like you will complain just like you did in this mail: 
"you make life more difficult for static tracers for no reason".

You can concede my point or you can dispute that argument - but what you 
did above was neither: you snipped all the quotations and you claimed a 
totally new point. (which new point i never argued with: _of course_ i 
never claimed that __trace function attributes can remove _all_ markups. 
They can "only" remove half of them.)

	Ingo
