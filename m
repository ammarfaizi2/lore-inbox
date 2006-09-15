Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWIOWwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWIOWwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWIOWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:52:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22181 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932348AbWIOWwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:52:30 -0400
Date: Sat, 16 Sep 2006 00:43:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915224338.GA22126@elte.hu>
References: <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B29FB.7000301@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > that is not true at all. Yes, an INT3 based kprobe might be expensive if 
> > +0.5 usecs per tracepoint (on a 1GHz CPU) is an issue to you - but that 
> > is "only" an implementation detail, not a conceptual property. 
> > Especially considering that help (djprobes) is on the way. And in the 
> 
> djprobes has been "on the way" for some time now. Why don't you at 
> least have the intellectual honesty to use the same rules you've 
> repeatedly used against ltt elsewhere in this thread -- i.e. what it 
> does today is what it is, and what it does today isn't worth bragging 
> about. [...]

i actually think djprobes are pretty darn inventive. I also think that 
the tracebuffer management portion of LTT is better than the hacks in 
SystemTap, and that LTT's visualization tools are better (for example 
they do exist :-) - so clearly there's synergy possible. But i have no 
faith at all, for the many reasons outlined before, in the concept of 
static tracing, because i see no possible future path out of its many 
limitations and because i see no possible future way to get rid of their 
dependencies. So i'd rather wait some time for dynamic tracers to 
outgrow static tracers in even the last final area, than let static 
tracing into the kernel - which would add dependencies that we'd have to 
live with almost until eternity.

> But, sarcasm aside, even if this mechanism existed it still wouldn't 
> resolve the need for static markup. It would just make djprobe a 
> likelier candidate for tools that cannot currently rely on kprobes.

it would clearly reduce the number of places where static markup would 
still be necessary. With static tracers i see no such mechanism that 
gradually moves the markups out of the kernel.

> > NOTE: i still accept the temporary (or non-temporary) introduction 
> > of static markers, to help dynamic tracing. But my expectation is 
> > that these markers will be less intrusive than static tracepoints, 
> > and a lot more flexible.
> 
> Chalk one up for nice endorsement and another for arbitrary 
> distinction.

So you dispute that markups for dynamic tracing will be more flexible 
and you dispute that they will be less intrusive than markups for static 
tracing?

	Ingo
