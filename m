Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWGFXuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWGFXuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGFXuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:50:15 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:46422 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751078AbWGFXuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:50:13 -0400
Message-ID: <44ADA1B3.1080506@bigpond.net.au>
Date: Fri, 07 Jul 2006 09:50:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>	 <1152099752.8684.198.camel@Homer.TheSimpsons.net>	 <44ABC5B7.2090707@bigpond.net.au> <1152110907.8594.19.camel@Homer.TheSimpsons.net>
In-Reply-To: <1152110907.8594.19.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Jul 2006 23:50:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Wed, 2006-07-05 at 23:59 +1000, Peter Williams wrote:
>> Mike Galbraith wrote:
>>> The task in the expired array could also be a !safe_to_background() task
>>> who already had a chance to run, and who's slice expired.
>> If it's !safe_to_background() it's in our interest to let it run in 
>> order to free up the resource that it's holding.
> 
> Only if there are waiters (or you know there will be some before the
> holder gets a chance to run again).  Even then, they might be background
> tasks, so it could still be ~wrong.
> 
> (yeah, comprehensive PI would be mucho tidier than tick time)

Yes.  Unfortunately, in Ingo's opinion, even if we have comprehensive PI 
it's unlikely to be reliable enough to guarantee putting tasks into the 
background is safe.  Of course, this wouldn't detract from its general 
usefulness -- just makes it no good for SCHED_BGND/SCHED_IDLEPRIO purposes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
