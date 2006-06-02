Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWFBIh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWFBIh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWFBIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:37:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29131 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751336AbWFBIh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:37:58 -0400
Message-ID: <447FF7BB.9000104@in.ibm.com>
Date: Fri, 02 Jun 2006 14:02:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
Cc: sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@openvz.org,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au>	<447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com>	<447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra>	<447F77A4.3000102@bigpond.net.au>	<1149213759.10377.7.camel@linuxchandra> <447FAEB0.3060103@aurema.com>
In-Reply-To: <447FAEB0.3060103@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
<snip>

>>>
>>>But you don't need something as complex as CKRM either.  This capping
>>
>>All CKRM^W Resource Groups does is to group unrelated/related tasks to a
>>group and apply resource limits. 
>>
>>
>>> 
>>>functionality coupled with (the lamented) PAGG patches (should have been 
>>>called TAGG for "task aggregation" instead of PAGG for "process 
>>>aggregation") would allow you to implement a kernel module that could 
>>>apply caps to arbitrary groups of tasks.
>>
>>I do not follow how PAGG + this cap feature can be used to put cap of
>>related/unrelated tasks. Can you provide little more explanation,
>>please.
> 
> 
> I would have thought it was fairly obvious.  PAGG supplies the task 
> aggregation mechanism, these patches provide per task caps and all 
> that's needed is the code that marries the two.
> 

The problem is that with per-task caps, if I have a resource group A
and I want to limit it to 10%, I need to limit each task in resource
group A to 10% (which makes resource groups not so useful). Is my
understanding correct? Is there a way to distribute the group limit
across tasks in the resource group?

> 
>>Also, i do not think it can provide guarantees to that group of tasks.
>>can it ?
> 
> 
> It could do that by manipulating nice which is already available in the 
> kernel.
> 
> I.e. these patches plus improved statistics (which are coming, I hope) 
> together with the existing policy controls provide all that is necessary 
> to do comprehensive CPU resource control.  If there is an efficient way 
> to get the statistics out to user space (also coming, I hope) this 
> control could be exercised from user space.

Could you please provide me with a link to the new improved statistics.
What do the new statistics contain - any heads up on them?

> 
> Peter


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
