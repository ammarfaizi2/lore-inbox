Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVE0L4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVE0L4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 07:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVE0L4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 07:56:47 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:49783 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262396AbVE0L4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 07:56:42 -0400
Message-ID: <42970AF2.2010607@m1k.net>
Date: Fri, 27 May 2005 07:56:34 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
References: <429684E7.2060609@m1k.net> <200505262217.00886.dtor_core@ameritech.net> <42969CB1.3010005@m1k.net> <200505262350.03307.dtor_core@ameritech.net>
In-Reply-To: <200505262350.03307.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Thursday 26 May 2005 23:06, Michael Krufky wrote:
>  
>
>>Dmitry Torokhov wrote:
>>
>>    
>>
>>>On Thursday 26 May 2005 21:47, Andrew Morton wrote:
>>> 
>>>
>>>      
>>>
>>>>Michael Krufky <mkrufky@m1k.net> wrote:
>>>>   
>>>>
>>>>        
>>>>
>>>>>In 2.6.12-rc5-mm1, I can't use my psaux mouse, but it worked perfectly 
>>>>>fine in both 2.6.12-rc5 and in 2.6.12-rc4-mm2.
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Not much point in telling me - I don't work on input code ;)
>>>>
>>>>Cc's added...
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>In 2.6.12-rc5-mm1 , dmesg says:
>>>>>
>>>>>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>>>>Failed to disable AUX port, but continuing anyway... Is this a SiS?
>>>>>If AUX port is really absent please use the 'i8042.noaux' option.
>>>>>serio: i8042 KBD port at 0x60,0x64 irq 1
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Did you try the 'i8042.noaux' option?
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>This is what dmesg says in both 2.6.12-rc4-mm2 and 2.6.12-rc5 :
>>>>>
>>>>>PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>>>>serio: i8042 AUX port at 0x60,0x64 irq 12
>>>>>serio: i8042 KBD port at 0x60,0x64 irq 1
>>>>>
>>>>>I am using a Shuttle FT61 motherboard.  Is there any more information 
>>>>>necessary to debug this?
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>I'd agree that this is a regression and that we should identify the code
>>>>change which caused this and fix it up.
>>>>
>>>>Guys?
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>I plead innocence - bk-input.patch has not changed for at least a month...
>>>
>>>Michael, could you please try applying:
>>>
>>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/broken-out/bk-input.patch
>>>
>>>directly to 2.6.12-rc5 and see if it still breaks?
>>>
>>> 
>>>
>>>      
>>>
>>I applied bk-input.patch directly to 2.6.12-rc5, and it did NOT break it 
>>this time.  Looks like either a different patch is the culprit, or the 
>>combination of this patch and another.
>>
>>    
>>
>
>Please try adding bk-acpi to the mix.
>
>  
>
Combination of both bk-input and bk-acpi applied to 2.6.12-rc5 still 
doesn't break it.  What next?

-- 
Michael Krufky

