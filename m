Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUHIJ5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUHIJ5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 05:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbUHIJ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 05:57:55 -0400
Received: from [195.23.16.24] ([195.23.16.24]:18399 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266445AbUHIJ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 05:57:46 -0400
Message-ID: <41174A95.3050705@grupopie.com>
Date: Mon, 09 Aug 2004 10:57:41 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hamie <hamish@travellingkiwi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs using 100% CPU
References: <40FA4328.4060304@travellingkiwi.com>	 <20040806202747.H13948@flint.arm.linux.org.uk>	 <4113DD20.1010808@travellingkiwi.com> <1091917597.19077.38.camel@localhost.localdomain> <4115EC6C.5040608@travellingkiwi.com>
In-Reply-To: <4115EC6C.5040608@travellingkiwi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.64; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamie wrote:
> Alan Cox wrote:
> 
>> On Gwe, 2004-08-06 at 20:33, Hamie wrote:
>>  
>>
>>> Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU 
>>> doing the same job as quick, or even slightly faster...
>>>   
>>
>>
>> PCMCIA IDE is PIO only so it burns CPU. This is one case where
>> hyperthreading is nice. Cardbus IDE is a lot better but very little
>> exists and we don't currently support hotplug IDE controllers.
>>
>>  
>>
> 
> Ah right. But would a CF memory card be cardbus anyway?

I've never seen a CF card that supported DMA (and I've worked with 
several brands). Compact Flash cards have several modes of operation and 
only one of this modes is "IDE-compatible".

> 
>>> And should it not use system CPU rather than user CPU?
>>>   
>>
>>
>> Yes - but figure out please if the kernel or userspace is getting that
>> wrong ;)
>>
>>  
>>
> 
> My apologies. It was gkrellm leading me up the garden path on that 
> one... Copying about 100MB from a 512MB CF card (25+ photos from my 
> camera) vmstat 5 reports 4% usercpu, 96% system cpu. And the response on 
> the system is sluggish to say the least. (Moving the pointer in X is 
> painful :). gkrell meanwhile on it's cpu graph shows about 30% system, 
> and the rest as userCPU. No idea why, I guess till I find out I'll just 
> regard gkrellm's cpu graph as a waste of space (To differentiate system 
> & user cpu anyway :).

I think this is more of a scheduler/priorities problem. Maybe all the 
work that is being done with staircase / low-latency will help you on 
this :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
