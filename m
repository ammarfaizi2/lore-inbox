Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUHHJED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUHHJED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUHHJED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:04:03 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:64106 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265215AbUHHJEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:04:00 -0400
Message-ID: <4115EC6C.5040608@travellingkiwi.com>
Date: Sun, 08 Aug 2004 10:03:40 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs using 100% CPU
References: <40FA4328.4060304@travellingkiwi.com>	 <20040806202747.H13948@flint.arm.linux.org.uk>	 <4113DD20.1010808@travellingkiwi.com> <1091917597.19077.38.camel@localhost.localdomain>
In-Reply-To: <1091917597.19077.38.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2004-08-06 at 20:33, Hamie wrote:
>  
>
>>Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
>>the same job as quick, or even slightly faster...
>>    
>>
>
>PCMCIA IDE is PIO only so it burns CPU. This is one case where
>hyperthreading is nice. Cardbus IDE is a lot better but very little
>exists and we don't currently support hotplug IDE controllers.
>
>  
>

Ah right. But would a CF memory card be cardbus anyway?

>>And should it not use system CPU rather than user CPU?
>>    
>>
>
>Yes - but figure out please if the kernel or userspace is getting that
>wrong ;)
>
>  
>

My apologies. It was gkrellm leading me up the garden path on that 
one... Copying about 100MB from a 512MB CF card (25+ photos from my 
camera) vmstat 5 reports 4% usercpu, 96% system cpu. And the response on 
the system is sluggish to say the least. (Moving the pointer in X is 
painful :). gkrell meanwhile on it's cpu graph shows about 30% system, 
and the rest as userCPU. No idea why, I guess till I find out I'll just 
regard gkrellm's cpu graph as a waste of space (To differentiate system 
& user cpu anyway :).


>  
>

