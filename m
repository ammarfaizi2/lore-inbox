Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWINUmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWINUmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWINUmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:42:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20661 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751159AbWINUmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:42:35 -0400
Date: Thu, 14 Sep 2006 22:34:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914203430.GB9252@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509BAD4.8010206@mbligh.org>
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


* Martin Bligh <mbligh@mbligh.org> wrote:

> >if there are lots of tracepoints (and the union of _all_ useful 
> >tracepoints that i ever encountered in my life goes into the thousands) 
> >then the overhead is not zero at all.
> >
> >also, the other disadvantages i listed very much count too. Static 
> >tracepoints are fundamentally limited because:
> >
> >  - they can only be added at the source code level
> >
> >  - modifying them requires a reboot which is not practical in a
> >    production environment
> >
> >  - there can only be a limited set of them, while many problems need
> >    finegrained tracepoints tailored to the problem at hand
> >
> >  - conditional tracepoints are typically either nonexistent or very
> >    limited.
> >
> >for me these are all _independent_ grounds for rejection, as a generic 
> >kernel infrastructure.
> 
> I don't think anyone is saying that static tracepoints do not have 
> their limitations, or that dynamic tracepointing is useless. But 
> that's not the point ... why can't we have one infrastructure that 
> supports both? Preferably in a fairly simple, consistent way.

primarily because i fail to see any property of static tracers that are 
not met by dynamic tracers. So to me dynamic tracers like SystemTap are 
a superset of static tracers.

So my position is that what we should concentrate on is to make the life 
of dynamic tracers easier (be that a handful of generic, parametric 
hooks that gather debuginfo information and add NOPs for easy patching), 
while realizing that static tracers have no advantage over dynamic 
tracers.

i.e. why add infrastructure for the sake of something that is clearly 
inferior? I have no problem with adding infrastructure for SystemTap, 
but i am asking the question: is it worth adding a static tracer?

I would of course accept static tracers too if someone proved it that 
they offer something that dynamic tracers cannot do.

(Just like i would accept the reintroduction of the Big Kernel Lock too, 
if someone proved it that it's the right thing to do.)

	Ingo
