Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWFAHqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFAHqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWFAHqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:46:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:19214 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750764AbWFAHqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:46:22 -0400
Message-ID: <447E9ADA.90805@sw.ru>
Date: Thu, 01 Jun 2006 11:44:26 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447E26AC.7010102@bigpond.net.au>
In-Reply-To: <447E26AC.7010102@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>>>> of an overhead. Given that there could be 10s of thousands of tasks.
>>>
>>>
>>>
>>> The more runnable tasks there are the less likely it is that any of 
>>> them is exceeding its hard cap due to normal competition for the 
>>> CPUs.  So I think that it's unlikely that there will ever be a very 
>>> large number of tasks in the sinbin at the same time.
>>
>> for containers this can be untrue...
> 
> 
> Why will this be untrue for containers?
if one container having 100 running tasks inside exceeded it's credit, 
it should be delayed. i.e. 100 tasks should be placed in sinbin if I 
understand your algo correctly. the second container having 100 tasks as 
well will do the same.

Kirill
