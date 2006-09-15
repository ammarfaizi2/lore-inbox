Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWIOVmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWIOVmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWIOVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:42:00 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:59367 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932295AbWIOVl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:41:59 -0400
X-BigFish: V
Message-ID: <450B1ED1.3060508@am.sony.com>
Date: Fri, 15 Sep 2006 14:44:49 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>	 <1158327696.29932.29.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151523050.6761@scrub.home>	 <1158331277.29932.66.camel@localhost.localdomain>	 <450ABA2A.9060406@opersys.com>	 <1158332324.29932.82.camel@localhost.localdomain>	 <y0mmz91f46q.fsf@ton.toronto.redhat.com>	 <1158345108.29932.120.camel@localhost.localdomain>	 <20060915181208.GA17581@elte.hu>	 <Pine.LNX.4.64.0609152046350.6761@scrub.home> <1158350716.5724.488.camel@localhost.localdomain>
In-Reply-To: <1158350716.5724.488.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2006 21:41:58.0418 (UTC) FILETIME=[C5479F20:01C6D90F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2006-09-15 at 21:10 +0200, Roman Zippel wrote:
> 
>>>this is being worked on actively: there's the "djprobes" patchset, which 
>>>includes a simplified disassembler to analyze common target code and can 
>>>thus insert much faster, call-a-trampoline-function based tracepoints 
>>>that are just as fast as (or faster than) compile-time, static 
>>>tracepoints.
>>
>>Who is going to implement this for every arch?
>>Is this now the official party line that only archs, which implement all 
>>of this, can make use of efficient tracing?
>  
> In the reverse you are enforcing an ugly - but available for all archs -
> solution due to the fact that there is nobody interested enough to
> implement it ?

????

If there's a solution people are willing to implement, and one
they aren't - doesn't that say something?  Static tracepoint
patches for numerous architectures have existed and been maintained
out-of-tree for years.

> If there is no interest to do that, then this arch can probably live w/o
> instrumentation for the next decade too.

The arches already have instrumentation - just not dynamic 
instrumentation.  The reason static tracepoints have been
implemented and kprobes haven't is that static tracepoints
are sufficient for what those people are doing, and dynamic
tracepoints are a pain to implement.

Let me repeat that, just in case people missed it:
"Static tracepoints work for what I need."  If other people
want to implement something fancier that works for them,
then feel free.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

