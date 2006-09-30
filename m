Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWI3ABS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWI3ABS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWI3ABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:01:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11747 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932325AbWI3ABR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:01:17 -0400
Subject: Re: [Lse-tech] [RFC][PATCH 02/10] Task watchers v2 Benchmark
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: sekharan@us.ibm.com, jtk@us.ibm.com, jes@sgi.com,
       linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       viro@zeniv.linux.org.uk, lse-tech@lists.sourceforge.net,
       sgrubb@redhat.com, hch@lst.de
In-Reply-To: <20060929131350.ef1bd156.pj@sgi.com>
References: <20060929020232.756637000@us.ibm.com>
	 <20060929021300.034805000@us.ibm.com> <20060928193243.c6766a2a.pj@sgi.com>
	 <1159558733.3286.64.camel@localhost.localdomain>
	 <20060929131350.ef1bd156.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 29 Sep 2006 17:01:13 -0700
Message-Id: <1159574473.3286.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 13:13 -0700, Paul Jackson wrote:
> Matt wrote:
> > Heh, sorry about that. I do have some initial kernbench numbers.
> 
> Thanks.  You mention that one of the patches, Benchmark, reduced
> time spent in user space.  I guess that means that patch hurt
> something ... though I'm confused ... wouldn't these patches risk
> spending more time in system space, not less in user space?

I would have thought so too, but it also appears to consistently reduce
time spent in the kernel. This seems to imply that the performance
improves for the first task watcher that gets added. I'd randomly guess
there's a branch misprediction when no watchers are registered.

My latest results will be more rigorous in that they show what a pure
2.6.18-mm1 run looks like. I've also removed the benchmark patch from
the series of runs. Unfortunately it takes approximately 24 hours to run
so it'll be a little while before I have the numbers.

> Do you have any analysis of the other runs?  Just looking at raw
> numbers, when it's not a benchmark I've used recently, kinda fuzzes
> over my feeble brain.

Nope, sorry. I'll see what I can put together.

Cheers,
	-Matt Helsley

