Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWE1X13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWE1X13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 19:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWE1X13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 19:27:29 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:50510 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751045AbWE1X13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 19:27:29 -0400
Message-ID: <447A31DE.3060601@bigpond.net.au>
Date: Mon, 29 May 2006 09:27:26 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>	 <4479A71C.4060604@bigpond.net.au> <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com>
In-Reply-To: <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 28 May 2006 23:27:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On 5/28/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
> <snip>
> 
>> >
>> > That behaviour would be fair.
>>
>> Caps aren't about being fair.  In fact, giving a task a cap is an
>> explicit instruction to the scheduler that the task should be treated
>> unfairly in some circumstances (namely when it's exceeding that cap).
>>
>> Similarly, the interactive bonus mechanism is not about fairness either.
>>   It's about giving tasks that are thought to be interactive an unfair
>> advantage so that the user experiences good responsiveness.
>>
> 
> I understand that, I was talking about fairness between capped tasks
> and what might be considered fair or intutive between capped tasks and
> regular tasks. Of course, the last point is debatable ;)

Well, the primary fairness mechanism in the scheduler is the time slice 
allocation and the capping code doesn't fiddle with those so there 
should be a reasonable degree of fairness (taking into account "nice") 
between capped tasks.  To improve that would require allocating several 
new priority slots for use by tasks exceeding their caps and fiddling 
with those.  I don't think that it's worth the bother.

When capped tasks aren't exceeding their cap they are treated just like 
any other task and will get the same amount of fairness.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
