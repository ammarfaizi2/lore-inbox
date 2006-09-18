Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbWIRCLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWIRCLl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWIRCLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:11:41 -0400
Received: from opersys.com ([64.40.108.71]:38672 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965233AbWIRCLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:11:40 -0400
Message-ID: <450E053B.1070908@opersys.com>
Date: Sun, 17 Sep 2006 22:32:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
In-Reply-To: <20060918011352.GB30835@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> Karim, i dont usually reply if you insult me (and you've grown a habit 
> of that lately ), but this one is almost parodic.

FWIW, Ingo, my own appreciation of events is that I've shown much
restraint and patience with you than you'll ever acknowledge.

FWIW, Ingo, I have nothing against you personally. I've said it
before in unrelated threads and I'll say it again: I have a lot
of respect for your abilities, as a Linux user on a daily basis
I silently profit from immense contributions you have made time
and again.

FWIW, Ingo, I've been more than a good sport on other issues
where we've disagreed. Case-in-point: while I disagreed with you
on your choice to pursue preemption, I made it a point to
personally go out of my way to congratulate every single
preemption supporter I had disagreed with in the past at this
year's OLS: Thomas, Steven, Sven, Manas, etc. I didn't see you
personally, so here's a belated congratulations.

>        MARK(event, a);
...
> 	MARK(event, a, x);

You assume these are mutually exclusive. Your argument can only
be made to be believable if people promoting direct inline
instrumentation were fascists -- which may be convenient for
some to believe. There is no reason why if the *default* inline
marker is insufficient that a user or developer cannot
circumvent it at runtime using a dynamic probe mechanism.

But if you look at the *facts*, you'll see that once a given
set of events is identified as being interesting, they usually
remain unchanged. Which is, in fact, the feedback given by
Jose's experience with LKET -- which, again, is based on
Systemtap.

For a given known-to-be-useful valid marker, information deficit
is the exception, not the rule.

> hence, in this specific example, there is a real difference between the 
> markup needed for dynamic tracers, compared to the markup needed for 
> static tracers - to achieve the same end-result of passing (event,a,x) 
> to the tracer.

No. This is true only if you conceive that tool engineers
actually want to restrict themselves to obtaining events
from a given *mechanism*. And *that* is not substantiated
by any historical record. In fact, quite the opposite.
Even if you were to consider but the *old* ltt, here's
from previous correspondence:

> Subsequently, I initiated discussions with the IBM DProbes
> team back in 2000 and thereafter implemented facilities for
> enabling dynamically-inserted probes to route their events
> through ltt -- all of which was functional as of November
> 2000.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
