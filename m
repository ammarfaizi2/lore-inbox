Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWDAApL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWDAApL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWDAApL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:45:11 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:5034 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932432AbWDAApJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:45:09 -0500
Message-ID: <442DCD13.1020804@bigpond.net.au>
Date: Sat, 01 Apr 2006 11:45:07 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck@vds.kolivas.org, Thorsten Will <thor_w@arcor.de>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: Staircase test patch
References: <200603312307.58507.kernel@kolivas.org> <200604010917.09413.kernel@kolivas.org> <442DC7DB.10406@bigpond.net.au> <200604011031.41849.kernel@kolivas.org>
In-Reply-To: <200604011031.41849.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 1 Apr 2006 00:45:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 01 April 2006 10:22, Peter Williams wrote:
>> Con Kolivas wrote:
>>> On Saturday 01 April 2006 07:31, Thorsten Will wrote:
>>>> On Friday 31 March 2006 23:07 +1000, Con Kolivas wrote:
>>>>> Hi Thorsten et al
>>>> Hi, Con.
>>>>
>>>>> Thorsten could you please test to see if this fixes the problem for
>>>>> you?
>>>> Oh boy, oh boy, oh boy.
>>>>
>>>> Against a bash loop:
>>>> |# dd bs=1M count=2048 </dev/hdb >/dev/null
>>>> |2048+0 records in
>>>> |2048+0 records out
>>>> |2147483648 bytes transferred in 35.497603 seconds (60496582 bytes/sec)
>>>>
>>>> Yes! Success! And the crowd goes wild! :-)
>>>>
>>>> I think you finally nailed it. Thank you so much!
>>> No, thank _you_ for bringing it to my attention and testing :)
>> Should I apply this to staircase in PlugSched?
> 
> I plan to make staircase v15 which is just this change, which would then need 
> to be resunc with plugsched. Unfortunately this needs code in 
> account_system_time which is not open to the schedulers in plugsched 
> currently so it needs more plugsched code to go in. I suspect other 
> schedulers may want to hook into this function, but I know you're currently 
> busy with smp nice to hack this in. I may look at doing it myself when I have 
> time if you don't have time.

OK.  I'm currently porting PlugSched to 2.6.16-mm2 which requires adding 
priority inheritance to each scheduler.  I'm modifying staircase and 
nicksched myself but would appreciate a code review after I release it.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
