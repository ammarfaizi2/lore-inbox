Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267307AbSLEM1j>; Thu, 5 Dec 2002 07:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbSLEM1j>; Thu, 5 Dec 2002 07:27:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56242 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267307AbSLEM1i>; Thu, 5 Dec 2002 07:27:38 -0500
Date: Thu, 5 Dec 2002 18:11:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: yodaiken@fsmlabs.com
Cc: Andrew Morton <akpm@digeo.com>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205181153.C12588@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <20021205042312.A12616@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205042312.A12616@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Thu, Dec 05, 2002 at 11:33:15AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:33:15AM +0000, yodaiken@fsmlabs.com wrote:
> 
> > 
> > Well, kernel objects may not be that small, but one would expect
> > the per-cpu parts of the kernel objects to be sometimes small, often down to
> > a couple of counters counting statistics.
> 
> 
> Doesn't your allocator increase chances of cache conflict on the same
> cpu ?
> 

You mean by increasing the footprint and the chance of eviction ? It
is a compromise. Or you would face NR_CPUS bloat and non-NUMA-node-local 
accesses for all CPUs outside the NUMA node where your NR_CPUS array
is located.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
