Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVCWGIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVCWGIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVCWGIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:08:10 -0500
Received: from bay10-f59.bay10.hotmail.com ([64.4.37.59]:20127 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262803AbVCWGIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:08:00 -0500
Message-ID: <BAY10-F5987CA2A1E1D6C406F5371D94F0@phx.gbl>
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <4240A744.1000306@yahoo.com.au>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related questions?
Date: Wed, 23 Mar 2005 11:37:58 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Mar 2005 06:07:59.0281 (UTC) FILETIME=[A9DF2A10:01C52F6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the SMT (apart from SMP) support is enabled in the  .config file, does 
the kernel recogonize the 2 logical processor as 2 logical or 2 physical 
processors?

Also, as the hyperthreaded processor may schedule 2 threads in the 2 logical 
cpu's, and it may not necessarily be form the same process i.e., the 2 
thread it schedules may be from the same or from the different process.

So, is there any way I can tell the scheduler (assuming I make the scheduler 
recogonize my 2 threads..i.e., it knows their pid) to schedule always my 2 
threads @ the same time? How do I go abt it?

Pls. help.Thanks in Advance.

>From: Nick Piggin <nickpiggin@yahoo.com.au>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related 
>questions?
>Date: Wed, 23 Mar 2005 10:16:20 +1100
>
>Arun Srinivas wrote:
>>Pls. help me.  I went through the sched.c for kernel 2.6 and saw that it 
>>supports
>>hyperthreading.I would be glad if someone could answer this 
>>question....(if
>>am not wrong a HT processor has 2 architectural states and one execution
>>unit...i.e., two pipeline streams)
>>
>>1)when there are 2 processes a parent and child(created by fork()) do they
>>get scheduled @ the same time...ie., when the parent process is put into 
>>one
>>pipeline, do the child also gets scheduled the same time?
>>
>
>No.
>
>>2) what abt in the case of threads(I read tht as opposed to 
>>kernel2.4,where
>>threads are treated as processes) ..kernel 2.6 treats threads as threads.
>>So, when two paired threads get into execution are they always scheduled 
>>at
>>the same time?
>>
>
>No.
>
>>Also, it would be helpful if someone could suggest which part of sched.c
>>shud i look into to find out how threads are scheduled for a normal
>>processor and for a hyperthreaded processor
>>
>
>It is pretty tricky. Basically processes on different CPUs are
>scheduled completely independently of one another. The only time
>when they may get moved from one CPU to another is with
>load_balance, load_balance_newidle, active_load_balance,
>try_to_wake_up, sched_exec, wake_up_new_task.
>

_________________________________________________________________
News, views and gossip. http://www.msn.co.in/Cinema/ Get it all at MSN 
Cinema!

