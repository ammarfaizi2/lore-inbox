Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWIOVIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWIOVIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWIOVIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:08:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:19855 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932268AbWIOVId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:08:33 -0400
Message-ID: <450B164B.7090404@us.ibm.com>
Date: Fri, 15 Sep 2006 16:08:27 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal>
In-Reply-To: <20060915202233.GA23318@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> Please Ingo, stop repeating false argument without taking in account people's
> corrections :
>
> * Ingo Molnar (mingo@elte.hu) wrote:
> > sorry, but i disagree. There _is_ a solution that is superior in every 
> > aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
> > 
>
> I am sorry to have to repeat myself, but this is not true for heavy loads.
>   

This thread has already discuss the merits of static instrumentation 
when it comes to the performance impacts.  The key is now to find a 
balance between static vs dynamic probes.  While it is true that static 
probes will provide less overhead compared to dynamic probes, some probe 
point will see less of an impact in measurable performance impact of 
dynamic probes due to the nature of the probe.  We need to find what 
that balance is.

To some people performance is the #1 priority and to other it is 
flexibility.  I would like to come up with a list of those probe point 
that absolutely need to be inserted into the code statically.  Those 
that are not absolutely critical to have statically should be 
implemented dynamically.

-JRS
