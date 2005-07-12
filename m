Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGLQUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGLQUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVGLQSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:18:38 -0400
Received: from relay01.pair.com ([209.68.5.15]:63503 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261544AbVGLQQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:16:56 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42D3ECF3.9050001@cybsft.com>
Date: Tue, 12 Jul 2005 11:16:51 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712142828.GA20798@elte.hu> <42D3D7ED.7000805@cybsft.com> <20050712160150.GA23943@elte.hu>
In-Reply-To: <20050712160150.GA23943@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>* Daniel Walker <dwalker@mvista.com> wrote:
>>>
>>>
>>>
>>>>I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on, 
>>>>would actually cause spurious interrupts. It was odd cause it's 
>>>>suppose to stop them .. If there was a lot of interrupt traffic on one 
>>>>IRQ , it would cause interrupt traffic on another IRQ. This would 
>>>>result in "nobody cared" messages , and the storming IRQ line would 
>>>>get shutdown.
>>>>
>>>>This would only happen in PREEMPT_RT .
>>>
>>>
>>>does it happen with the latest kernel too? There were a couple of things 
>>>broken in the IOAPIC code in various earlier versions.
>>>
>>>	Ingo
>>
>>Is this why I have been able to boot the latest versions without the 
>>noapic option (and without noticeable keyboard repeat problems) or has 
>>it just been dumb luck?
> 
> 
> yes, i think it's related - the IO-APIC code is now more robust than 
> ever, and that's why any known-broken system would be important to 
> re-check.
> 
> 	Ingo
> 

Well I have booted -27 a couple of times and -28 once now without 
supplying the noapic boot option and I haven't seen any of the keyboard 
repeat problems that I reported late last week. This was on my dual 2.6 
Xeon w/HT. I have never seen this behavior on any of my older systems. 
Because of the fact that the problem showed up sporadically, I can't say 
for sure that it is gone. However, so far so good. I will report any 
changes that I see.

-- 
    kr
