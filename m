Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935606AbWK3FM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935606AbWK3FM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 00:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933883AbWK3FM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 00:12:59 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:13228 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S935606AbWK3FM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 00:12:58 -0500
Message-ID: <456E8181.4060109@in.ibm.com>
Date: Thu, 30 Nov 2006 12:30:17 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Linda Walsh <lkml@tlinx.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PM-Timer clock source is slow. Try something else: How slow?
 What other source(s)?
References: <456E2C2C.40303@tlinx.org> <1164850329.5426.33.camel@localhost.localdomain>
In-Reply-To: <1164850329.5426.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2006-11-29 at 16:56 -0800, Linda Walsh wrote:
>   
>> I recently noticed this message in my bootup that I don't remember
>> from before:
>>
>> PCI: Probing PCI hardware (bus 00)
>> * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
>> * this clock source is slow. Consider trying other clock sources
>>     
>
> This basically means that your chipset has a bug which requires the ACPI
> PM timer to be read three times in order to get a valid reading.
>
> This will cause gettimeofday/clock_gettime to take longer to execute,
> which is what is meant by "slow" (rather then the counter's frequency
> being incorrect).
>
>   
>>     How would this affect my clock?  It says to try another
>> clock source, what type of clock source would it be suggesting I
>> use? Another chip already in the computer? 
Yes.
>> It is an Intel 440BX
>> chipset; on an Dell motherboard. Would that be likely to have
>> another chip source that is compensating?
>>     
You can change the clock source using "clock=" kernel parameter. Please 
refer to  Documentation/kernel-parameters.txt file of kernel source.
>> I don't notice a significant clock slowdown, but I'm running NTP,
>> so that could be masking the problem.
>>     
>
> Unless you're running performance critical programs that utilize
> gettimeofday/clock_gettime, you probably won't notice anything. Time
> should still function properly.  If you are having performance issues,
> you can try using a different clocksource (the TSC is probably safe, but
> not necessarily).
>
> thanks
> -john
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   
Thanks
 Srinivasa DS
