Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVFHDuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVFHDuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVFHDuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:50:46 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:63580 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262088AbVFHDug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:50:36 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       mbligh@mbligh.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200506081333.18511.kernel@kolivas.org>
References: <1004450000.1118188239@flay>
	 <20050607170853.3f81007a.akpm@osdl.org>
	 <1118200638.10122.6.camel@npiggin-nld.site>
	 <200506081333.18511.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 13:50:28 +1000
Message-Id: <1118202628.10122.24.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 13:33 +1000, Con Kolivas wrote:
> On Wed, 8 Jun 2005 01:17 pm, Nick Piggin wrote:

> > To start with, it looks like the smp-nice patches are broken. Even if
> > they weren't I think it might be a good idea just to put them on hold
> > until we work out what to do with the other sched patches... 
> 
> I originally said I'd wait till the sched patches settled down before tackling 
> it but it didn't look like that was ever going to happen and broken nice on 
> SMP is a real bug biting people now so I figured I should just tackle it 
> anyway. I don't mind if we just work on it later though.
> 

Well I agree with you that it would be nice to fix it. I
think your approach has good potential, and it is along
the same lines as what I had in mind.

> > Anyway, Con, this is what it is doing on a 64-way Altix running aim7:
> > (compare imbalances, task move rates, wakeup move rates, etc).
> 
> Definitely different I agree. As for the performance impact the statistics 
> alone don't tell us if they're for good or evil, but we can look at it again 
> separately when we tackle smp nice again. It is a real issue for users now, 
> though so it would be good if we can have a calmer period in the future to do 
> this (smp nice) by itself.
> 

True. Fortunately this seems to only come up once a year or so.
Although I guess with the rise and rise of multi threaded and
multi cored CPUs it could become a bigger issue.

> These are the four patches Andrew:
> sched-implement-nice-support-across-physical-cpus-on-smp.patch
> sched-change_prio_bias_only_if_queued.patch
> sched-account_rt_tasks_in_prio_bias.patch
> sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
> 

Thanks.

> The other HT patch by me is separate and a bugfix so please leave that in.
> 

Yep.


Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
