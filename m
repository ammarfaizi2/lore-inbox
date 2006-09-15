Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWIOQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWIOQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIOQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:59:19 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:49312 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750910AbWIOQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:59:18 -0400
X-BigFish: V
Message-ID: <450ADC65.5020802@am.sony.com>
Date: Fri, 15 Sep 2006 10:01:25 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>	 <20060914171320.GB1105@elte.hu>	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>	 <1158320406.29932.16.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4caldomain>
In-Reply-To: <1158332324.29932.82.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-09-15 am 10:35 -0400, ysgrifennodd Karim Yaghmour:
>> @@ -1709,6 +1712,7 @@ switch_tasks:
>>    		++*switch_count;
>>
>>    		prepare_arch_switch(rq, next);
>> +		TRACE_SCHEDCHANGE(prev, next);
>>    		prev = context_switch(rq, prev, next);
>>    		barrier();
>
> All we appear to lack is systemtap ability to parse debug data so it can
> be told "trace on line 9 of sched.c and record rq and next"

If the latter is a suggestion for how an out-of-tree rule for a
tracepoint definition should look, it's a terrible one.
Alan's example is much more fragile, from a maintenance perspective,
than Karim's.  Plus, it's much more difficult to implement, whether
you plan to inject no-ops at compile time, just record locations and
stack offsets, or actually place some tracing code (heaven forbid)
that the compiler could optimize for that context.

I still think that this is off-topic for the patch posted.  I think we
should debate the implementation of tracepoints/markers when someone posts a
patch for some.  I think it's rather scurrilous to complain about
code NOT submitted.  Ingo has even mis-characterized the not-submitted
instrumentation patch, by saying it has 350 tracepoints when it has no
such thing.  I counted 58 for one architecture (with only 8 being
arch-specific).
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

