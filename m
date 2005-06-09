Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVFIWOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVFIWOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVFIWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:14:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38133 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262486AbVFIWOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:14:36 -0400
Message-ID: <42A8BF18.80706@mvista.com>
Date: Thu, 09 Jun 2005 15:13:44 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
References: <20050509073702.GA13615@elte.hu> <427FBFE1.5020204@mvista.com> <20050524075927.GA20462@elte.hu> <429339CC.1080705@mvista.com> <20050527072119.GA7267@elte.hu>
In-Reply-To: <20050527072119.GA7267@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>* George Anzinger <george@mvista.com> wrote:
>>>
>>>
>>>
>>>>Also, I think that del_timer_sync and friends need to be turned on if 
>>>>soft_irq is preemptable.
>>>
>>>
>>>you mean the #ifdef CONFIG_SMP should be:
>>>
>>>	#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
>>>
>>>?
>>
>>Yes, exactly.
> 
> 
> i have done this in -47-09 and it seems to work fine - is it sufficient?

I think so.  Time will tell...

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
