Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267390AbUHDTc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267390AbUHDTc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHDTc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:32:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42449 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267390AbUHDTaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:30:07 -0400
Date: Fri, 6 Aug 2004 00:57:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: ak@suse.de, maneesh@in.ibm.com, shemminger@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Improve readability by hiding read_barrier_depends() calls
Message-ID: <20040805192756.GE3935@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040804142845.GB1865@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804142845.GB1865@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 07:28:46AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Updated based on feedback, and merged forward to 2.6.8-rc3.
> 
> This patch introduced an rcu_dereference() macro that replaces most
> uses of smp_read_barrier_depends().  The new macro has the advantage
> of explicitly documenting which pointers are protected by RCU -- in
> contrast, it is sometimes difficult to figure out which pointer is
> being protected by a given smp_read_barrier_depends() call.
> 

I have a series of 3 patches in my stack that applies on existing
3 RCU patches in -mm2 -

rcu-code-cleanup : Major cleanup removing per_cpu() calculations and use				pointers to RCU global and per-cpu data.

call-rcu-bh : Introduce call_rcu_bh() for faster grace periods with
		softirq-only code.

use-call-rcu-bh : use call_rcu_bh in ipv4 route cache. This helps avoid
  			dst cache overflows during DoS testing [as
			explained in my OLS presentation ]

It will be easier to stick the two patches from Paul on top of these,
so I will merge these with my patchset and send the entire set
of 5 patches for -mm testing.

Thanks
Dipankar
