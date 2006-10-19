Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWJSImf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWJSImf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWJSImf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:42:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51667 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030323AbWJSIme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:42:34 -0400
Date: Thu, 19 Oct 2006 01:42:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061019014225.fdff9917.pj@sgi.com>
In-Reply-To: <453735D8.5040100@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
	<20061018231559.8d3ede8f.pj@sgi.com>
	<45371CBB.2030409@yahoo.com.au>
	<20061018235746.95343e77.pj@sgi.com>
	<4537238A.7060106@yahoo.com.au>
	<20061019003405.15a4dd8c.pj@sgi.com>
	<45373241.5060203@yahoo.com.au>
	<20061019011152.752f9657.pj@sgi.com>
	<453735D8.5040100@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> It is this non overlapping property that we can take advantage of, and
> partition the scheduler.

You want non-overlapping versus all other CPUs on the system.

You want to partition the systems CPUs, in the mathematical sense of
the word 'partition', a non-overlapping cover.  Fine.  That's an
honorable goal.

But cpu_exclusive gives you non-overlapping versus sibling cpusets.

Wrong tool for the job.  Close - sounded right - has that nice long
word 'exclusive' in there somewhere.  Wrong one however.  It made
good sense to anyone that came at this from the kernel/sched.c side,
as it was obvious to them what was needed.  To myself and my cpuset
users, it made no bleeping sense whatsoever.

What actual needs do we have here?  Lets figure that out, then if that
leads to adding mechanism of the right shape to fit the needs, fine.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
