Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVCWJry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVCWJry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCWJry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:47:54 -0500
Received: from bay10-f42.bay10.hotmail.com ([64.4.37.42]:46743 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261224AbVCWJrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:47:39 -0500
Message-ID: <BAY10-F42DB434C4A842D9EB1D3AAD94F0@phx.gbl>
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <42411CAC.5000808@yahoo.com.au>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related questions?
Date: Wed, 23 Mar 2005 15:17:38 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Mar 2005 09:47:38.0912 (UTC) FILETIME=[598B4200:01C52F8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

few more trivial Q's (bear with me  I'm a newbie to kernel world):

1) As I said I have a process that spawns 2 threads(thread A and B).I am 
trying to measure the exact time @ which they are being scheduled.For this I 
am using the rdtsc() (when threads A and B come)  in enqueue_task()..where 
they are being inserted into the priority array.
Is this a correct way of measuring?

2) also in task_struct.....is "tgid" the id of my process and each of 
threads hav a unique pid??

3) I saw frm the kernel docs tht realtime tasks hav priority 0 to 99. So 
using setscheduler means do I have to enforce a priority in one of these 
ranges to make my threads as soft/hard realtime task.

thanks in advance for your patience.

>From: Nick Piggin <nickpiggin@yahoo.com.au>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related 
>questions?
>Date: Wed, 23 Mar 2005 18:37:16 +1100
>
>Arun Srinivas wrote:
>>If the SMT (apart from SMP) support is enabled in the  .config file, does 
>>the kernel recogonize the 2 logical processor as 2 logical or 2 physical 
>>processors?
>>
>
>You shouldn't be able to select SMT if SMP is not enabled.
>If SMT and SMP is selected, then the scheduler will recognise
>the 2 processors as logical ones.
>
>>Also, as the hyperthreaded processor may schedule 2 threads in the 2 
>>logical cpu's, and it may not necessarily be form the same process i.e., 
>>the 2 thread it schedules may be from the same or from the different 
>>process.
>>
>
>Yes.
>
>>So, is there any way I can tell the scheduler (assuming I make the 
>>scheduler recogonize my 2 threads..i.e., it knows their pid) to schedule 
>>always my 2 threads @ the same time? How do I go abt it?
>>
>
>Use sched_setaffinity to force each thread onto the particular
>CPU. Use sched_setscheduler to acquire a realtime scheduling
>policy. Then use mutexes to synchronise your threads so they
>run the desired code segment at the same time.
>

_________________________________________________________________
Screensavers unlimited! http://www.msn.co.in/Download/screensaver/ Download 
now!

