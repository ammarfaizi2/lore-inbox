Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbSKKRjN>; Mon, 11 Nov 2002 12:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSKKRjN>; Mon, 11 Nov 2002 12:39:13 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:32730 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266723AbSKKRjL>; Mon, 11 Nov 2002 12:39:11 -0500
Cc: Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk>
	<87k7jkg969.fsf@goat.bogus.local> <3DCF1593.CB9C7AA4@digeo.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: programming for preemption (was: [PATCH] 2.5.46: access
 permission filesystem)
Date: Mon, 11 Nov 2002 18:45:33 +0100
Message-ID: <87znsgov9e.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Olaf Dietsche wrote:
>> 
>> Ben Clifford <benc@hawaga.org.uk> writes:
>> 
>> > I still get those stack traces, though...
>> 
>> I retested with CONFIG_PREEMPT=y and now I get those stack traces,
>> too. So, it seems my code is not preempt safe.
>> 
>
> It's not that your code is unsafe with preemption.  It's just that
> CONFIG_PREEMPT=y turns on the debugging infrastructure which allows
> us to detect things like calling kmalloc(GFP_KERNEL) inside spinlock.

Thanks for this hint. So this means kmalloc(GFP_KERNEL) inside
spinlock is not necessarily dangerous, but should be avoided if
possible? Is using a semaphore better than using spinlocks? Is
there a list of dos and don'ts for preempt kernels beside
Documentation/preempt-locking.txt?

And btw, who is "us"?

Regards, Olaf.
