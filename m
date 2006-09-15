Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWIOU14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWIOU14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIOU14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:27:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:20383 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751336AbWIOU1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:27:55 -0400
Message-ID: <450B0CC3.9060303@us.ibm.com>
Date: Fri, 15 Sep 2006 15:27:47 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915200009.GB7133@Krystal>
In-Reply-To: <20060915200009.GB7133@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Of course, it they are properly designed, the one set of tracepoints could
> > be used by different tracing backends - that allows us to separate the
> > concepts of "tracepoints" and "tracing backends".
>
> If I try to develop your idea a little further, we could this of dividing the
> tracing problem into four layers :
>
> - tracepoints (where the code is instrumented)
>   - identifying code
>   - accessing data surrounding the code
> - tracing backend (how to add the tracepoints)
> - tracing infrastructure (what code will serialize the information)
> - data extraction (getting the data out to disk, network, ...)
>   

I think you missing user-space post processing which should be also 
considered part of the problem since the capabilities of post-processing 
will be limited by the "tracepoints" available.  Tracepoints and 
post-processing are also the problems which need to be address first 
between the other established tracing projects before going forward with 
in-kernel solutions.

> I think that, if we agree on this segmentation of the problem, this thread is
> generally debating on the tracing backends and their respective limitations.
> I just want to point out that the patch I have submitted adresses mainly the
> "tracing infrastructure" and "data extraction" topics.
>   

This seem like a good idea to dissect the problem since it seem like 
other important issues relevant to general tracing are being ignore 
simply because of a dislike of the way LTTng has chosen to implement trace.

-JRS
