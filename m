Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVHTPOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHTPOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 11:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVHTPOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 11:14:20 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47054 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932308AbVHTPOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 11:14:19 -0400
Message-ID: <430748B2.1090703@us.ibm.com>
Date: Sat, 20 Aug 2005 08:13:54 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, "lkml," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-rt9
References: <20050818060126.GA13152@elte.hu>  <4306596D.1000403@us.ibm.com> <1124492403.23647.543.camel@tglx.tec.linutronix.de>
In-Reply-To: <1124492403.23647.543.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2005-08-19 at 15:13 -0700, Darren Hart wrote:
> 
>>I was trying to use another HRT clock source and couldn't get menuconfig 
>>to let me select acpi-pm-timer, turns out it has been disabled in 
>>arch/i386/Kconfig, but the description is still in the help...
>>
>>
>># config HIGH_RES_TIMER_ACPI_PM
>>#       bool "ACPI-pm-timer"
>>
>>Is the pm timer incompatible with the RT portion of this patch?
> 
> 
> The only timesource I came around to fixup is TSC in combination with
> PIT or preferred Local APIC. Add "lapic" to your kernel command line for
> UP boxen. Therefor it is disabled for now.
> 
> 
>>I'm looking into getting HRT and RT booting on a SUMMIT NUMA machine 
>>(cyclone timer), but after s/error/warning/ in arch/i386/timers/timer.c 
>>for the HRT cyclone ifdef, I still get the following link error:
> 
> 
> It should be simple to fix this. Just not right now. I have no such box
> and restricted time resources. Can you test a patch when I find a slot?

Absolutely.

> But of course you are heartely invited to fix it yourself :)

As always :-)

> 
> tglx


Thanks for the response, I wanted to hear your take on this rather than making 
any assumptions as to the state of the patch.

> 
> 
> 


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
