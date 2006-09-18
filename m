Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWIRBsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWIRBsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWIRBsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:48:20 -0400
Received: from opersys.com ([64.40.108.71]:28432 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965217AbWIRBsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:48:19 -0400
Message-ID: <450DFFC8.5080005@opersys.com>
Date: Sun, 17 Sep 2006 22:09:12 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu>
In-Reply-To: <20060918005624.GA30835@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> are you saying that if i replaced half of the static markups with 
> function attributes (which would still provide equivalent functionality 
> to dynamic tracers), or if i removed a few dozen static markups with 
> dynamic scripts (which change too would be transparent to users of 
> dynamic tracers), that in this case users of static tracers would /not/ 
> claim that tracing broke?

Is this is a 3-for-1 combo? Here's an answer to each:

1- static markup replaced by function attributes:

Verbatim answer from earlier email
> What is sufficient for tracing a given set of events by means
> of binary editing *that-does-not-require-out-of-tree-maintenance*
> can be made to be sufficient for the tracing of events using
  ^^^^^^^^^^^^^^
> direct inlined static calls.

But since you insist on nitpicking ... nothing precludes earlier
mentioned build-time script from being instructed to act in a
similar fashion with regards to generating alternate build files
as described earlier but with using function attributes as the
cue instead of static markup.

2- removed markups are not transparent to "static" tracers:

False. LTTng couldn't care less. Though you'd have a point if
we talked about the *old* ltt, but we aren't.

3- users of tracing will *only* complain if they're using
"static" tracers:

False. You've quite elegantly stated that users don't give a damn
about *mechanism*. So the potential for complaint is, therefore,
no different. More practically: LTTng/SystemTap/LKET is aimed at
the same crowd. There's no factual basis to support the claim
that users of LKET or SystemTap are less likely to complain about
broken tracing that users of LTTng. In fact, there is ample
factual evidence to the contrary. And, *again*, LTTng will not
*break* because of missing events simply because it's a
framework for the analysis of large event sets, which the *old*
ltt never was.

> i fully understand that you can _teach_ the removal of static 
> tracepoints to LTT (and i'd expect no less from a tracer), but will 
> users accept the regression? I claim that they wont, and that's the 
> important issue.

You can claim to be Santa Claus if it makes you happy, but the
factual record does not support the claim that LKET or SystemTap
users are less likely to complain than LTTng users. Again, the
factual record actual supports quite the opposite. And yet *again*,
LTTng is a framework for the analysis of large event sets. It
does *not* need to be *taught* about the removal of anything,
it presents what information it does have. Any fixing of
existing analysis plugins that depend on given event sets, _if
at all required_, is no different from the requirement to fix
scripts which analyze a fixed set of events collected by
SystemTap. LTTng is, in fact, less susceptible to breakage
than LKET, which does depend on a given set of events, even
if it's using a "dynamic" trace mechanism.

> Frankly, i find it highly amusing that such seemingly 
> simple points have to be argued for such a long time. Is this really 
> necessary?

I'm afraid it is. And the reason I think it's necessary is that
you've been advertising yourself as an expert about everything
tracing, and *that* is: a) just untrue (and therefore misleading),
b) absolutely insulting to all those -- and forget me from the
picture -- who invested *considerable* resources into developing
any form of tracing for Linux, especially considering the
*extremely* tight framework given to them by kernel developers. If
you would care to ask *and* listen, Ingo, those people who you so
blatantly choose to ignore would be more than happy to present
their work and ideas to you. Just try it: ask *and* listen.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
