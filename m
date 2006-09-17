Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWIQPSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWIQPSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWIQPSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:18:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58246 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964799AbWIQPSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:18:43 -0400
Date: Sun, 17 Sep 2006 17:09:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917150953.GB20225@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171651370.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4997]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Sun, 17 Sep 2006, Ingo Molnar wrote:
> 
> > > This thread would be much better off talking about how to go about 
> > > implementing lightweight markers rather than spent on mindless rants.
> > 
> > i agree, as long as it's lightweight markers for _dynamic tracers_, so 
> > that we keep our options open - as per the arguments above.
> 
> Could you please explain, why we can't have markers which are usable 
> by any tracer?

the main reason for that i explained in the portion of the email you 
snipped:

> > On the other hand, if we accept static tracers into the mainline 
> > kernel, we have to decide in favor of tracepoint-maintainance model
> > #1 _FOREVER_. It will be a point of no return for a likely long
> > time. Moving a static tracepoint or even breaking it will cause 
> > end-user pain that needs an _upstream kernel fix_. It needs a new 
> > stable kernel, etc., etc. It is very inflexible, and fundamentally
> > so.

of course it's easy to have static markup that is usable for both types 
of tracers - but that is of little use. Static tracers also need the 
guarantee of a _full set_ of static markups. It is that _guarantee_ of a 
full set that i'm arguing against primarily. Without that guarantee it's 
useless to have markups that can be used by static tracers as well: you 
wont get a full set of tracepoints and the end-user will complain. 
(partial static markups are of course still very useful to dynamic 
tracers)

( furthermore, there are other reasons as well: i explained my position 
  in some of those replies that you did not want to "further dvelve 
  into". I'm happy to give you Message-IDs if you'd like to follow up on 
  them, there's no need to repeat them here. )

	Ingo
