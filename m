Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVGZOat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVGZOat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGZOao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:30:44 -0400
Received: from mail.tmr.com ([64.65.253.246]:54987 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261808AbVGZOal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:30:41 -0400
Message-ID: <42E64B11.6030908@tmr.com>
Date: Tue, 26 Jul 2005 10:39:13 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Baer <lnx1@gmx.net>
CC: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net> <42E55012.5040307@tmr.com> <42E55ECB.2070703@gmx.net>
In-Reply-To: <42E55ECB.2070703@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Baer wrote:

>
>
> Bill Davidsen wrote:
>
>>
>> One other oddment about this motherboard, Forgive if I have 
>> over-snipped this trying to make it relevant...
>>
>> Andreas Baer wrote:
>>
>>>
>>> Willy Tarreau wrote:
>>>
>>>> On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
>>>
>>
>>
>>>> There clearly is a problem on the system installed on this machine. 
>>>> You should
>>>> use strace to see what this machine does all the time, it is 
>>>> absolutely not
>>>> expected that the user/system ratios change so much between two nearly
>>>> identical systems. So there are system calls which eat all CPU. You 
>>>> may want
>>>> to try strace -Tttt on the running process during a few tens of 
>>>> seconds. I
>>>> guess you'll immediately find the culprit amongst the syscalls, and 
>>>> it might
>>>> give you a clue.
>>>
>>>
>>>
>>>
>>> I hope you are talking about a hardware/kernel problem and not a 
>>> software
>>> problem, because I tried it also with LiveCD's and they showed the 
>>> same results
>>> on this machine.
>>> I'm not a linux expert, that means I've never done anything like 
>>> that before,
>>> so it would be nice if you give me a hint what you see in this 
>>> results. :)
>>>
>>
>> Am I misreading this, or is your program doing a bunch of seeks not 
>> followed by an i/o operation? I would doubt that's important, but 
>> your vmstat showed a lot of system time, and I just wonder if 
>> llseek() is more expensive in Linux than Windows. Or if your code is 
>> such that these calls are not optimized away by gcc.
>
>
> I don't know what exactly produces this _llseek calls, but I ran the 
> compiled binaries on both machines (desktop + notebook) without any 
> recompilation and so I think they should do the same (even if this is 
> bad or not optimized), but I see a time difference of more than 2:30 
> :) This _llseek calls also don't seem to be faster or slower if you 
> compare the times on the notebook and the desktop. 


If the program and test data is not proprietary, would it help to have 
me run the test on my P4P800, P4-2.8, HT on, and see if that's an issue 
with your particular board or BIOS? I have the 1086 BIOS from my notes 
on that machine, I think you were running a later BIOS? 1091 or so, from 
memory?

Anyway, I would run a test that takes 3 minutes if it helps as a data point.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

