Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVG3DN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVG3DN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 23:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVG3DN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 23:13:57 -0400
Received: from pop-borzoi.atl.sa.earthlink.net ([207.69.195.70]:8873 "EHLO
	pop-borzoi.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262742AbVG3DN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 23:13:56 -0400
Message-ID: <42EAF070.5050001@earthlink.net>
Date: Fri, 29 Jul 2005 23:13:52 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sclark46@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 sound problem
References: <42E6C8DB.4090608@earthlink.net>	<s5hr7dklko4.wl%tiwai@suse.de>	<42E7A8D8.1030809@earthlink.net> <20050729014150.6e97dfd2.akpm@osdl.org>
In-Reply-To: <20050729014150.6e97dfd2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>(Please do reply-to-all when dealing with kernel stuff)
>
>Stephen Clark <stephen.clark@earthlink.net> wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    
>>
>>>At Tue, 26 Jul 2005 19:35:55 -0400,
>>>Stephen Clark wrote:
>>> 
>>>
>>>      
>>>
>>>>Hello List,
>>>>
>>>>
>>>>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
>>>>to 2.6.12. As a result of
>>>>doing this my sound no longer works correctly. It plays the same thing
>>>>repeatedly some number
>>>>of times - if it plays at all.
>>>>
>>>>Any ideas on how to debug this would be appreciated.
>>>>
>>>>Additional info I don't see any interrupts in /proc/interrupts for the
>>>>Allegro which is on int 5.
>>>>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
>>>>works great and I do
>>>>see interrupts for Allegro on int 5.
>>>>   
>>>>
>>>>        
>>>>
>>>The irq problem is likely related with ACPI.
>>>Try to boot once with pci=noacpi.
>>>
>>>
>>>Takashi
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>> 
>>>
>>>      
>>>
>>Hi Takashi,
>>
>>I have boot the 2.6.12 kernel with acpi=off pci=noacpi,usepirqmask or I
>>get a panic or a hang.
>>    
>>
>
>It's just really awful that 2.4 simply worked and 2.6 requires a sprinkle
>of obscure kernel parameters.  I shudder to think how long it took you to
>work them out.
>
>  
>
>>I don't have to do this with 2.4.27, anybody know why?
>>
>>    
>>
>
>Perhaps you could send the `dmesg -s 1000000' output?
>
>  
>
Hi Andrew,

Thanks for the response.

I found a better solution to my problem with my HP N5430 laptop over on 
the alsa-devel list, my sound had quit working also. The new
solution, which was pointed out to me by Henry Yuan was to boot with 
lapic. I had noticed in the dmesg output that a lapic existed but was 
turned off by the bios, and a pseudo local apic was being used, this 
caused problems with APCI and my sound.

If you would still like the dmesg I would be glad to send it.

Steve
