Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTAFTR5>; Mon, 6 Jan 2003 14:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTAFTR5>; Mon, 6 Jan 2003 14:17:57 -0500
Received: from [63.162.183.250] ([63.162.183.250]:44433 "EHLO
	emgw2ksrv001.emgdom001.emageon.com") by vger.kernel.org with ESMTP
	id <S267101AbTAFTRz>; Mon, 6 Jan 2003 14:17:55 -0500
Message-ID: <3E19D857.4030403@emageon.com>
Date: Mon, 06 Jan 2003 13:26:15 -0600
From: Brian Tinsley <btinsley@emageon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
References: <Pine.LNX.3.96.1030106132528.10550A-100000@gatekeeper.tmr.com> <23239.1041880161@www5.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 19:26:28.0306 (UTC) FILETIME=[8283FB20:01C2B5B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been able to distribute IRQ servicing to other processors on P4 
Xeon HT systems as described in the IRQ-affinity.txt file in the 
kernel-source Documentation directory. Well, it shows up as doing so in 
/proc/interrupts anyway! Looks like CPUs 0, 2, 4, etc.. are the real 
processors and 1,3,5, etc.. are the logical processors (which do not 
handle interrupts).


Daniel Blueman wrote:

>Even with HT turned off on this dual-Xeon box, all IRQs are routed to CPU 0.
>
>Kernel here is the latest RedHat 2.4.18 one.
>
>Just curious what kernel Avery is running...
>
>Dan
>
>  
>
>>On 4 Jan 2003, Daniel Blueman wrote:
>>
>>    
>>
>>>It's interesting you have IRQs balanced over the two logical
>>>processors. I can't get this on HT Xeons with stock RedHat 7.3 kernel.
>>>      
>>>
>>I think he's using two physical processors, if by "logical processors" you
>>are thinking HT... I also recall he has HT off, but the original post
>>isn't handy.
>>
>>    
>>
>>>Can you post the exact kernel version string, please?
>>>
>>>TIA,
>>>  Dan
>>>
>>>"Avery Fay" <avery_fay@symantec.com> wrote in message
>>>      
>>>
>news:<OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>...
>  
>
>>>>Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load
>>>>        
>>>>
>>balancing as 
>>    
>>
>>>>shown below (seems to be applied to Red Hat's kernel). Here's 
>>>>/proc/interrupts:
>>>>        
>>>>
>>-- 
>>bill davidsen <davidsen@tmr.com>
>>  CTO, TMR Associates, Inc
>>Doing interesting things with little computers since 1979.
>>
>>    
>>
>
>  
>

-- 

-[========================]-
-[      Brian Tinsley     ]-
-[ Chief Systems Engineer ]-
-[        Emageon         ]-
-[========================]-




