Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVFPUiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVFPUiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFPUiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:38:01 -0400
Received: from relay02.pair.com ([209.68.5.16]:40457 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261555AbVFPUhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:37:43 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42B1E316.2040406@cybsft.com>
Date: Thu, 16 Jun 2005 15:37:42 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <42B1BDF7.1000700@cybsft.com>
In-Reply-To: <42B1BDF7.1000700@cybsft.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Ingo Molnar wrote:
> 
>> * K.R. Foley <kr@cybsft.com> wrote:
>>
>>
>>>> could you uncomment the IO_APIC_CACHE define in 
>>>> arch/i386/kernel/io_apic.c, and could you uncomment line 1109 in 
>>>> drivers/ide/ide-io.c - does this fix things? (in apic mode)
>>
>>
>>
>>> Couple of things: 1) I could not find IO_APIC_CACHE anywhere. I could 
>>> find IOAPIC_CACHE but the define was not commented in io_apic.c. Also 
>>> the BUG_ON at line 1109 in ide-io.c was not commented out either. So 
>>> I made the mental leap that you actually meant to comment these out 
>>> instead of uncomment them??? [...]
>>
>>
>>
>> yeah, sorry :-|
>>
> 
> OK so there really was no mental leap. It was more like a 
> trip,stumble,roll,grasp :-) I actually discovered the real meaning of 
> the above after commenting out only one of the above and failed boot. 
> Only then did it dawn on me what you were trying for. Hence the last 
> line of my email not being finished.
> 
>>
>>> [...] That works to get the system booted. Although I am getting many 
>>> soft lockups now, minutes after the boot. Log attached. [...]
>>
>>
>>
>> hm, do you get actual lockups, or only the messages about them? I.e.  
>> does the system work fine if you [the sounds of careful thinking to 
>> get the word right] disable CONFIG_DETECT_SOFTLOCKUP, or does it lock 
>> up silently?
> 

Just had an opportunity to check this. Everything does indeed seem to be 
working OK with this disabled. No lock up messages, no perceived problems.

> 
> There doesn't seem to be any actual lockups, just messages. I will try 
> disabling the above when I get home this evening. Can't get to the 
> system right now.
> 
>>
>>
>>> [...] 2) In my infinite wisdom before :-) I failed to attach my 
>>> config as I should have done before. Also, commenting out
>>
>>
>>
>> this looks like a sentence worth finishing? :)
> 
> Actually see my comment above about the "trip,stumble,roll,grasp" The 
> line above is the point at which I realized what was going on. :-D
> 
>>
>>     Ingo
>>
> 
> 


-- 
    kr
