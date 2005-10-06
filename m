Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVJFRSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVJFRSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJFRSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:18:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2557 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751243AbVJFRSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:18:14 -0400
In-Reply-To: <1c190f10510060947s5e6099d4pe9bed56e360551f4@mail.gmail.com>
References: <20051004084405.GA24296@elte.hu> <1c190f10510060947s5e6099d4pe9bed56e360551f4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2C6B8752-368D-11DA-882A-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Felix Oxley <lkml@oxley.org>, Todd.Kneisel@bull.com,
       Thomas Gleixner <tglx@linutronix.de>
From: david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
Date: Thu, 6 Oct 2005 10:18:12 -0700
To: Todd Kneisel <todd.kneisel@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 6, 2005, at 9:47 AM, Todd Kneisel wrote:

> On 10/4/05, Ingo Molnar <mingo@elte.hu> wrote:
>>
>> i have released the 2.6.14-rc3-rt2 tree, which can be downloaded from
>> the usual place:
>>
>>   http://redhat.com/~mingo/realtime-preempt/
>>
>> the biggest change in this release is the long-anticipated merge of a
>> streamlined version of the "robust futexes/mutexes with priority
>> queueing and priority inheritance" code into the -rt tree. The 
>> original
>> upstream patch is from Todd Kneisel, with further improvements, 
>> cleanups
>> and -RT integration done by David Singleton.
>>
>
> My original patch implemented robust futexes using the existing futex
> wait queue mechanisms, because the project I'm working on does not
> need priority inheritance or other realtime features. David's changes
> replaced the wait queue mechanisms with rt_mutexes. I'm working on
> a patch to add my implementation back in, so the kernel will support
> both robust wait-queue futexes and robust rt_mutex futexes. Does
> anyone else see the need for this?
>
> Also, my patch implemented only shared robust futexes. David's work
> was based on mine, so the current code only supports shared robust
> futexes that may or may not be priority inheritance. It doesn't support
> priority inheritance mutexes that are not robust, or that are not 
> shared.


The latest changes to the 2.6.14-rc3-rt10 patch is to make robust and
priority inheritance independent.  The code now supports mutexes
that are robust or priority inheriting or both.

I hope to have glibc patches out soon for the new separation of 
robustness
and priority inheritance.

David

Please note that robust mutexes works with other flavors of kernel 
besides
realtime.  The code works with all flavors of kernel,  PREEMPT_NONE,  
PREEMPT_DESKTOP or PREEMPT_RT.



>
> Todd.

