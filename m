Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFAGcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFAGcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFAGcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:32:04 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:60064 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261297AbVFAGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:32:01 -0400
Subject: Re: [patch] improve SMP reschedule and idle routines
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, piggin@cyberone.com.au,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050531231553.786a2994.akpm@osdl.org>
References: <4296CA7A.4050806@cyberone.com.au>
	 <20050527085726.GA20512@elte.hu> <4296EA77.2030605@yahoo.com.au>
	 <20050531231553.786a2994.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 16:31:56 +1000
Message-Id: <1117607516.5188.28.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 23:15 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >  Make some changes to the NEED_RESCHED and POLLING_NRFLAG to reduce
> >  confusion, and make their semantics rigid. Also have preempt explicitly
> >  disabled in idle routines. Improves efficiency of resched_task and some
> >  cpu_idle routines.
> 
> This patch, with or without sched-resched-optimisation-fix.patch causes my
> x86_64 box to soil its pants.  
> 

Sorry about that. I probably have broken something since last
testing x86-64. It looks like a simple mismatched preempt_
operation, so I'll try to get that fixed up shortly.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
