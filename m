Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWHUAmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWHUAmL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWHUAmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:42:10 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:30542 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932391AbWHUAmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:42:09 -0400
Message-ID: <44E9015E.4030808@bigpond.net.au>
Date: Mon, 21 Aug 2006 10:42:06 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Regression with hyper threading scheduling
References: <20060819223910.fef3bdea.akpm@osdl.org> <44E81770.8080408@bigpond.net.au>
In-Reply-To: <44E81770.8080408@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Mon, 21 Aug 2006 00:42:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
>> fyi..  (if replying, please be sure to do it on-list)
>>
>> Begin forwarded message:
>>
>> Date: Thu, 17 Aug 2006 13:40:42 +0200
>> From: Wolfgang Erig <Wolfgang.Erig@gmx.de>
>> To: linux-kernel@vger.kernel.org
>> Cc: andreas.friedrich@fujitsu-siemens.com
>> Subject: Regression with hyper threading scheduling
>>
>>
>> Hello kernel hacker,
>>
>> I have a regression with Hyper-Threading in my box.
>>
>> If I try e.g. 'while true; do ((ii+=1)); done' on two xterms
>>    - with 2.6.8 both CPUs are running (looking at gkrellm or /proc/stat)
>>    - with 2.6.15/2.6.17 etc. only one CPU is running, sometimes CPU0, 
>> sometimes CPU1
>>
>> Any idea? If you need more info, let me know,
>> Wolfgang
>>
>>
>> Kernel 2.6.8.1: Hyper-Threading works:
>> ======================================
>> uname -a
>> Linux oak 2.6.8.1 #1 SMP Wed May 10 13:24:21 CEST 2006 i686 GNU/Linux
>>
>> cat /proc/stat
>> cpu  22709 4502 2543 1008491 2881 92 1475
>> cpu0 12800 2428 1426 501276 1859 92 1472
>> cpu1 9909 2074 1117 507215 1021 0 2
>> intr 5909520 5214423 7297 0 2 2 0 2 1 0 0 0 0 92935 0 7422 13 0 224861 
>> 42603 0 0 0 319959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>> ctxt 6553093
>> btime 1155801409
>> processes 2525
>> procs_running 3
>> procs_blocked 0
>>
>> Kernel 2.6.17.8 etc.: Hyper-Threading does not work:
>> ====================================================
>> uname -a
>> Linux oak 2.6.17.8 #2 SMP PREEMPT Thu Aug 17 11:40:04 CEST 2006 i686 
>> GNU/Linux
>>
>> cat /proc/stat
>> cpu  5049 0 744 137292 3113 18 3 0
>> cpu0 36 0 53 72732 282 18 1 0
>> cpu1 5012 0 690 64560 2831 0 2 0
>> intr 221093 182798 880 0 3 4 0 3 1 0 0 0 0 28863 0 6718 12 1811 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
>> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>> ctxt 458461
>> btime 1155807757
>> processes 3203
>> procs_running 1
>> procs_blocked 0
[bits deleted]
> 
> I'm unable to reproduce this problem with 2.6.18-rc4 on my HT system. 
> I'm using top with the "last processor" field enabled to observe (rather 
> than the methods described) and the two bash shells are both getting 
> 100% and are each firmly affixed to different CPUs.

Doing a "cat /proc/stat" also indicates that the problem is not present.

I wonder if the two xterms and/or their shells are have different nice 
values (or scheduling policies)?

Also is the presence of PREEMPT in the uname output for the 2.6.17.8 
kernel (not present in the 2.6.8.1 kernel's output) significant? 
Presuming that this signifies the CONFIG_PREEMPT option is selected it 
is worth noting that I do not have this selected in the kernel I tested.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
