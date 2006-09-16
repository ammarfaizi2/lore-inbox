Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWIPPHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWIPPHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 11:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWIPPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 11:07:55 -0400
Received: from opersys.com ([64.40.108.71]:62225 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751759AbWIPPHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 11:07:54 -0400
Message-ID: <450C1821.5010709@opersys.com>
Date: Sat, 16 Sep 2006 11:28:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com> <450AB408.8020904@opersys.com> <450AB90C.9000403@sgi.com> <450AC2FA.70203@opersys.com> <450BD4C7.8030000@sgi.com>
In-Reply-To: <450BD4C7.8030000@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen wrote:
> A personal question?, do you feel that being patronising and insulting
> is in any way going to put your LTT project in a better light? It
> certainly makes it a  lot harder for many of us to take your arguments
> serious.

ltt isn't *mine* anymore, somebody else is maintaining it at this point,
and it remains to be seen whether any of my input in this thread is:
a) appreciated by them, b) agreed by them.

With regards to the tone of the thread, then please at least read other
people's approach to me, including yourself. I think the casual observer
will see that there was a great deal of animosity aimed at me personally.
I'll admit to being sarcastic and biting back. But that's hardly alien
to lkml.

> And how is this going to solve the case where trace code in the syscall
> path has a negative impact on cacheline utilization and alignment, even
> when the trace data is not being used?

Hmm... and then compare that to the negative impact of kprobes at runtime.
Of course if we could override the syscall table your point disappears.
That's not how ltt does it now, but it could easily be done otherwise.
All implementations I've looked at so far of syscall in Linux involve
a table. If the base of this table was a dynamically modifiable entry,
then the problem is solved. Wouldn't it?

> So you are back to saying that trace data other people wish to collect
> are uninteresting and therefore should just be ignored? If not, what you
> are saying there otherwise just backs up the argument that if LTT or
> something similar goes into mainline, we will see the amount of
> tracepoints grow significantly.

I've explained earlier the difference in between these things.

> Please read what I wrote above! Touching the syscall path with static
> tracepoints is costly and has side effects! The argument that things can
> be compiled out is just pointless, end users do not recompile kernels at
> random and many of the 'end user' cases where people wish to vizualize
> trace data, are running on precompiled vendor kernels. Recompiling the
> kernel and rebooting is not an option here!

It is for some. And please stop repeating the syscall path stuff. It can
be solved elegantly. The fact that it hasn't up to this point is only an
excuse to keep working harder on it. There is, in fact, no reason that
the solution may not just be a combination of static markup and dynamic
modification.

> In fact, the users who wish to trace data in self-compiled kernels are a
> tiny subset of the potential userbase for this stuff which is primarily
> useful to developers .... which in terms makes your argument about debug
> tracepoints irrelevant since you are turning all the tracepoints into
> debug tracepoints :)

How many embedded Linux projects did you personally work on?

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
