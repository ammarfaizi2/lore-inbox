Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVJJN25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVJJN25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJJN25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:28:57 -0400
Received: from [66.45.247.194] ([66.45.247.194]:11926 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750781AbVJJN25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:28:57 -0400
Message-ID: <434A699A.1050504@linuxtv.org>
Date: Mon, 10 Oct 2005 17:16:10 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <200510101403.02578@bilbo.math.uni-mannheim.de> <434A6334.4090407@linuxtv.org> <200510101525.27913@bilbo.math.uni-mannheim.de>
In-Reply-To: <200510101525.27913@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:

>Am Montag, 10. Oktober 2005 14:48 schrieben Sie:
>  
>
>>Rolf Eike Beer wrote:
>>    
>>
>>>IIRC the call to pci_enable_device() must be the first thing you do. This
>>>will do the things like assigning memory regions to the device and so on.
>>>      
>>>
>>I fixed this one
>>
>>    
>>
>>>Returning 0 in error cases is just wrong. And you free the assignments even
>>>in case of success AFAICS. Try the return I introduced above and see what
>>>happens.
>>>      
>>>
>>I fixed this one too ..
>>
>>
>>I have fixed most of the stuff, it is partly working, not ready yet as
>>there are some more things to be added to  ..
>>I have attached what i was working on.
>>    
>>
>
>If the kmalloc() fails in mantis_pci_probe() you don't call 
>pci_disable_device(). And you should kzalloc() instead of kmalloc() and 
>memset().
>
>  
>

Yep, thanks for pointing it out ..

>It looks like you never use "__u16 vendor_id;" and "__u16 device_id;" in 
>struct mantis_pci.
>
>  
>

I was working on that part, not yet finished on that ..


Thanks,
Manu

