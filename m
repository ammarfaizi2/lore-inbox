Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDBFCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDBFCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 00:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDBFCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 00:02:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:41403 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751136AbWDBFCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 00:02:10 -0500
Date: Sun, 2 Apr 2006 10:34:00 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures dynamically
Message-ID: <20060402050400.GA13423@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060401185644.GC25971@in.ibm.com> <442F2B52.6000205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442F2B52.6000205@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 11:39:30AM +1000, Nick Piggin wrote:
> Srivatsa Vaddagiri wrote:
> > 
> >+		if (!sched_group_phys) {
> >+			sched_group_phys
> >+				= kmalloc(sizeof(struct sched_group) * 
> >NR_CPUS,
> >+					  GFP_KERNEL);
> >+			if (!sched_group_phys) {
> >+				printk (KERN_WARNING "Can not alloc phys 
> >sched"
> >+						     "group\n");
> >+				goto error;
> >+			}
> >+			sched_group_phys_bycpu[i] = sched_group_phys;
> >+		}
> 
> Doesn't the last assignment have to be outside the if statement?

I dont think so. The assignment can happen once (when we allocate
successfully) and not every time in the for loop?


-- 
Regards,
vatsa
