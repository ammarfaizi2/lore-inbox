Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVEXO2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVEXO2C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEXO2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:28:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53749 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261404AbVEXO14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:27:56 -0400
Message-ID: <429339CC.1080705@mvista.com>
Date: Tue, 24 May 2005 07:27:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
References: <20050509073702.GA13615@elte.hu> <427FBFE1.5020204@mvista.com> <20050524075927.GA20462@elte.hu>
In-Reply-To: <20050524075927.GA20462@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>Also, I think that del_timer_sync and friends need to be turned on if 
>>soft_irq is preemptable.
> 
> 
> you mean the #ifdef CONFIG_SMP should be:
> 
> 	#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
> 
> ?
Yes, exactly.

> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
