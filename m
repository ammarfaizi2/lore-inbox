Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVHAVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVHAVDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVHAVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:00:48 -0400
Received: from mail.tmr.com ([64.65.253.246]:45009 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261161AbVHAU7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:59:07 -0400
Message-ID: <42EE8F68.4050107@tmr.com>
Date: Mon, 01 Aug 2005 17:08:56 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lgb@lgb.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
References: <003401c58ea2$4dfd76f0$5601010a@ashley> <20050722132523.GJ20995@vega.lgb.hu> <42E517B6.1010704@tmr.com> <20050801103835.GE28346@vega.lgb.hu>
In-Reply-To: <20050801103835.GE28346@vega.lgb.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt wrote:

>On Mon, Jul 25, 2005 at 12:47:50PM -0400, Bill Davidsen wrote:
>  
>
>>Gábor Lénárt wrote:
>>    
>>
>>>On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
>>>
>>>      
>>>
>>>> I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
>>>>is used to run  applications which will comsume huge memory,
>>>>the problem is: when this aplications exits,  the free memory of the 
>>>>server is still very low(accroding to the output of "top"), and
>>>>        
>>>>
>>>>from the output of command "free", I can see that many GB memory was 
>>>      
>>>
>>>>cached by kernel. Does anyone know how to free the kernel cached
>>>>memory? thanks in advance.
>>>>        
>>>>
>>>It's a very - very - very old and bad logic (at least nowdays) from the
>>>stone age to free up memory.
>>>      
>>>
>>It's very Microsoft to claim that the OS always knows best, and not let 
>>the user tune the system the way they want it tuned. And if that means 
>>to leave a bunch of free memory for absolute fastest availability, the 
>>admin should have that option.
>>    
>>
>
>Sure, sorry if my comment can be treated in this way ... I mean surprising
>amount of people I've met criticised Linux (well, some years ago when DOS
>was popular) that he/she want to see that 'free memory' field reported eg by
>'top' should be the maximum all the time ... I mean this way: this is the
>behaviour which is quite wrong, I've written about this.
>
>Sure, because of my not too good English, I may have missed the real meaning
>of the mail, sorry about it!
>
Well, I thought I understood "from the stone age" but I may have taken 
it slightly too literally. But I really would like to have more control 
over Linux memory use, because it does cause bad behaviour at times. If 
I have 4GB of RAM, I'd like to set 200MB or so aside for programs, and 
never page out the window I'm going to uncover later. Likewise when I 
write a DVD image, I would like to avoid buffering a few GB without i/o 
and then driving the disk totally busy while it gets written out (after 
it has pushed out things I will use again).

The old 2.4.x-aa kernels had some tunables to make the kernel aggressive 
about writing pages to disk quickly, and I haven't been able to match 
that behaviour without patches in 2.6. I may be missing a tunable, but 
swappiness doesn't seem to be the one I want. I have a patch I'm playing 
with, but it's not ready for prime time, and is probably counter to the 
current philosophy of memory management.

Thanks for clarifying.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

