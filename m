Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVASXSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVASXSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVASXRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:17:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36348 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261966AbVASXOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:14:49 -0500
Message-ID: <41EEE9E4.4070105@mvista.com>
Date: Wed, 19 Jan 2005 15:14:44 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VST patches ported to 2.6.11-rc1
References: <20050113132641.GA4380@elf.ucw.cz> <20050114001118.GA1367@elf.ucw.cz> <41E71A78.8050507@mvista.com>
In-Reply-To: <41E71A78.8050507@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Pavel Machek wrote:
> 
>> Hi!
>>
>>
>>> I really hate sf download system... Here are those patches (only
>>> common+i386) ported to 2.6.11-rc1.
>>
>>
>>
>> Good news is it booted. But I could not measure any powersavings by
>> turning it on. (I could measure difference between HZ=100 and
>> HZ=1000).
>>
>> Hmm, it does not want to do anything. threshold used to be 1000, does
>> it mean that it would not use vst unless there was one second of quiet
>> state? I tried to lower it to 10 ("get me HZ=100 power consumption")
>> but it does not seem to be used, anyway:

I wonder if the problem is that we are not disabling the PIT interrupt.  I have 
a PIII SMP system so the interrupt path may be different and the code to stop 
interrupts may be wrong.  The normal system does not admit to stopping the time 
base so it is possible that this is wrong.

-g


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

