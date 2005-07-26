Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVGZQ1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVGZQ1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVGZQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:12:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:60896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261926AbVGZQLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:11:17 -0400
X-Authenticated: #28678167
Message-ID: <42E66124.7020709@gmx.net>
Date: Tue, 26 Jul 2005 18:13:24 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net> <42E55012.5040307@tmr.com> <42E55ECB.2070703@gmx.net> <42E64B11.6030908@tmr.com>
In-Reply-To: <42E64B11.6030908@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Davidsen wrote:
> Andreas Baer wrote:
> 
>>
>>
>> Bill Davidsen wrote:
>>
>>>
>>> One other oddment about this motherboard, Forgive if I have 
>>> over-snipped this trying to make it relevant...
>>>
>>> Andreas Baer wrote:
>>>
>>>>
>>>> Willy Tarreau wrote:
>>>>
>>>>> On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
>>>>
>>>>
>>>
>>>
>>>>> There clearly is a problem on the system installed on this machine. 
>>>>> You should
>>>>> use strace to see what this machine does all the time, it is 
>>>>> absolutely not
>>>>> expected that the user/system ratios change so much between two nearly
>>>>> identical systems. So there are system calls which eat all CPU. You 
>>>>> may want
>>>>> to try strace -Tttt on the running process during a few tens of 
>>>>> seconds. I
>>>>> guess you'll immediately find the culprit amongst the syscalls, and 
>>>>> it might
>>>>> give you a clue.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> I hope you are talking about a hardware/kernel problem and not a 
>>>> software
>>>> problem, because I tried it also with LiveCD's and they showed the 
>>>> same results
>>>> on this machine.
>>>> I'm not a linux expert, that means I've never done anything like 
>>>> that before,
>>>> so it would be nice if you give me a hint what you see in this 
>>>> results. :)
>>>>
>>>
>>> Am I misreading this, or is your program doing a bunch of seeks not 
>>> followed by an i/o operation? I would doubt that's important, but 
>>> your vmstat showed a lot of system time, and I just wonder if 
>>> llseek() is more expensive in Linux than Windows. Or if your code is 
>>> such that these calls are not optimized away by gcc.
>>
>>
>>
>> I don't know what exactly produces this _llseek calls, but I ran the 
>> compiled binaries on both machines (desktop + notebook) without any 
>> recompilation and so I think they should do the same (even if this is 
>> bad or not optimized), but I see a time difference of more than 2:30 
>> :) This _llseek calls also don't seem to be faster or slower if you 
>> compare the times on the notebook and the desktop. 
> 
> 
> 
> If the program and test data is not proprietary, would it help to have 
> me run the test on my P4P800, P4-2.8, HT on, and see if that's an issue 
> with your particular board or BIOS? I have the 1086 BIOS from my notes 
> on that machine, I think you were running a later BIOS? 1091 or so, from 
> memory?
> 
> Anyway, I would run a test that takes 3 minutes if it helps as a data 
> point.

Properly a good idea, but you have a completely different chipset related to 
the Asus Website. I think it's a i865 and I have i875. I'm also running BIOS 
1019(!).

That's the driver page for my Board:
http://support.asus.com/download/download.aspx?Type=All&model=P4C800%20Deluxe

It would be better if someone has at least the same board.

Does anyone have a Asus P4C800-Deluxe with a P4 around 2.4 GHz running on this 
mailing list and would sacrifice himself/herself to run a little test with my 
software for a maximum of 4 minutes? Would be approx. 10 MB for data transmission.

