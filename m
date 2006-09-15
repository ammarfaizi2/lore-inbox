Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWIOV2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWIOV2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWIOV2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:28:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57256 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932282AbWIOV2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:28:24 -0400
Date: Fri, 15 Sep 2006 23:27:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915204812.GA6909@elte.hu>
Message-ID: <Pine.LNX.4.64.0609152314250.6761@scrub.home>
References: <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
 <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
 <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com>
 <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home>
 <20060915204812.GA6909@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> > Nobody is taking dynamic tracing away!
> > You make it sound that tracing is only possible via dynamic traces.
> > If I want to use static tracepoints, why shouldn't I?
> 
> because:
> 
>  - static tracepoints, once added, are very hard to remove - up until
>    eternity. (On the other hand, markers for dynamic tracers are easily 
>    removed, either via making the dynamic tracer smarter, or by 
>    detaching the marker via the patch(1) method. In any case, if a 
>    marker goes away then hell does not break loose in dynamic tracing 
>    land - but it does in static tracing land.

This is simply not true, at the source level you can remove a static 
tracepoint as easily as a dynamic tracepoint, the effect of the missing 
trace information is the same either way.

>  - the markers needed for dynamic tracing are different from the LTT
>    static tracepoints.

What makes the requirements so different? I would actually think it 
depends on the user independent of the tracing is done.

>  - a marker for dynamic tracing has lower performance impact than a 
>    static tracepoint, on systems that are not being traced. (but which 
>    have the tracing infrastructure enabled otherwise)

Anyone using static tracing intents to use, which makes this point moot.

>  - having static tracepoints dillutes the incentive for architectures to
>    implement proper kprobes support.

Considering the level of work needed to support efficient dynamic tracing 
it only withholds archs from tracing support for no good reason.

> > > > there are separate project teams is because managers in key 
> > > > positions made the decision that they'd rather break from existing 
> > > > projects which had had little success mainlining and instead use 
> > > > their corporate bodyweight to pressure/seduce kernel developers 
> > > > working for them into pushing their new great which-aboslutely- 
> > > > has-nothing-to-do-with-this-ltt-crap-(no,no, we actually agree 
> > > > with you kernel developers that this is crap, this is why we're 
> > > > developing this new amazing thing). That's the truth plain and 
> > > > simple.
> > >
> > > Stop whining!
> > 
> > So we're back to personal attacks now. :-(
> 
> hm, so you dont consider the above paragraph a whine. How would you 
> characterize it then? A measured, balanced, on-topic technical comment? 
> I'm truly curious.

It's sarcastic, but considering the disrespect towards Karim, I don't 
blame him. At some point the "whining" argument was funny, but lately it's 
only used to descredit people.

bye, Roman
