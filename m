Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVLCTUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVLCTUX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLCTUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:20:23 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:59846 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751185AbVLCTUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:20:23 -0500
Message-ID: <4391EFDE.3000102@ru.mvista.com>
Date: Sat, 03 Dec 2005 22:19:58 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Underwood <basicmark@yahoo.com>
CC: vitalhome@rbcmail.ru, linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       david-b@pacbell.net, akpm@osdl.org, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH 2.6-git] SPI core refresh
References: <20051203171037.94369.qmail@web36914.mail.mud.yahoo.com>
In-Reply-To: <20051203171037.94369.qmail@web36914.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Underwood wrote:

>--- vitalhome@rbcmail.ru wrote:
>
>  
>
>>Mark,
>>
>>    
>>
>>>>>I still do not see why you are stating this.  Why do you say this?
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>Due to possible priority inversion problems in David's core.
>>>>        
>>>>
>>>Which you still haven't proven, in fact you now seem to be changing your mind and saying 
>>>that
>>>there might be a problem if an adapter driver was implemented badly although I still 
>>>don't see how
>>>this could happen (the priority inversion I mean not the badly implemented driver ;).
>>>      
>>>
>>Truly admiring your deep understanding of the real-time technology, I should remind you 
>>that within the real-time conditions almost each event may happen and may not happen, for 
>>instance, two calls from different context to the same funtion may happen at the same or 
>>almost the same time, and may not happen that way. Therefore I used the word "possible". 
>>Hope I clarified that a bit for you.
>>
>>Please also see my previous emails for the explanation of how priority inversion can 
>>happen. This is not gonna be a rare case, BTW.
>>    
>>
>
>Vitaly, 
> 
>First, please can you not change the CC list in the midle of a thread.
>
Yeah, sorry for that. You see, I was emailing not from my computer.

> 
>OK, looking through the code after a cup of coffe I can see the problem you are pointing out,
>thank you :), for some reason I thought that that code was protected by a spin_lock :/. 
> 
>How to fix this? 
> 
>David, how would you feel about adding a NOT_DMAABLE flag in the spi_message structure? This
>helper routine could then use this thus solving the one buffer to many callers problem (well
>moving into the adapter driver, but as that serialise's transfers anyway I think this would remove
>the priority inversion problem, Vitaly?) 
> 
>The other solution is to do a kmalloc for each caller (would could try to be smart and only do
>that if the buffer is being used). 
>  
>
And each one of the techniques suggested will make David's core closer 
to ours :)

Vitaly
