Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbULVCR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbULVCR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULVCR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:17:28 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:63433 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261942AbULVCRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:17:09 -0500
References: <20041221230726.51621.qmail@web52604.mail.yahoo.com>
Message-ID: <cone.1103681814.594077.28853.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: jesse <jessezx@yahoo.com>
Cc: Con Kolivas <kernel@kolivas.org>, Paulo Marques <pmarques@grupopie.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
Date: Wed, 22 Dec 2004 13:16:54 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse writes:

> 
> --- Con Kolivas <kernel@kolivas.org> wrote:
> 
>> jesse wrote:
>> > Paulo:
>> >  
>> >    I already said in the messsage that my user
>> space
>> > application has a low nice priority, i set it to
>> 10.
>> > since my application has low priority compared to
>> > other user space applications, it is supposed to
>> be
>> > interrupted. but it is not.
>> 
>> If your task is better priority the scheduler will
>> make it preempt the 
>> worse priority task. It sounds to me like you are
>> complaining that the 
>> worse priority task is still getting cpu? If so, you
>> misunderstand 
>> priority - it orders tasks according to priority
>> giving lower latency 
>> and preemptive behaviour to the better task, and
>> gives _more_ cpu but 
>> not all the cpu. The cpu must still be shared, but
>> with more cpu 
>> distributed to the better priority task. If you want
>> your better 
>> priority task to get _all_ the cpu you have to use
>> real time scheduling.
>> 
>> Cheers,
>> Con
>> 
> 
> ok, Con, your explaining makes some sense to me , but
> still not very well.
> 
>    suppose I have five high process: A1, A2, A3, A4,
> A5 all have nice = 0. and I also have a low priority
> process B with nice = 10.
> 
>     a) when process B is scheduled to run, it is given
> a short time slot based on its priority, for example 5
> secs. because at that point, A1/2/3/4/5 are not
> started yet. B will get CPU and run at full speed. 
>     b) at the end of time slot(5 secs), scheduler
> finds higher priority A1/A2/A3/A4/A5 are ready,
> scheduler will interrupt process B and starts to pick 
> a process from group A, even though B still needs CPU
> cycle.
>     c)unfortunately, process A1/2/3/4/5 are so active,
> thus process B should never get opportunity to run
> again, in consequence, CPU Usage% of Process B should
> be very Low.
>     
>    However, The above theretic assumption is in
> contrary to what i observed. in my LAB, the low
> priority process B seems to hold the CPU forever and
> Top command always shows Process B with a 90% CPU
> usage.
>   
>   If _more_ cpu but not _all_ the cpu are given to
> Process A1/2/3/4/5, Process B shouldn't have a 90% CPU
> usage.   
> 
>   Thus, i can't help asking why low priority process B
> gets most CPU cycle.

What you are describing is completely wrong behaviour. Please post output of 
top running during this workload to demonstrate/prove this is happening. 
Easiest thing to do is get your workload running and do 'top -b -n 1 > 
top.log' and post top.log please.

Cheers,
Con

