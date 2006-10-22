Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWJVKwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWJVKwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWJVKwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 06:52:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2714 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932351AbWJVKwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 06:52:07 -0400
Date: Sun, 22 Oct 2006 03:51:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Martin Bligh <mbligh@google.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061022035135.2c450147.pj@sgi.com>
In-Reply-To: <4537D6E8.8020501@google.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> We (Google) are planning to use it to do some partitioning, albeit on
> much smaller machines. I'd really like to NOT use cpus_allowed from
> previous experience - if we can get it to to partition using separated
> sched domains, that would be much better.

Why not use cpus_allowed for this, via cpusets and/or sched_setaffinity?

In the followup to this between Paul M. and myself, I wrote:
> As best as I can tell, the two motivations for explicity setting
> sched domain partitions are:
>  1) isolating cpus for real time uses very sensitive to any interference,
>  2) handling load balancing on huge CPU counts, where the worse than linear
>     algorithms start to hurt.
> ...
> How many CPUs are you juggling?

And Paul M. replied:
> Not many by your standards - less than eight in general.

So ... it would seem you have neither huge CPU counts nor real time
sensitivities.

So why not use cpus_allowed?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
