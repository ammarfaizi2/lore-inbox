Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTKFNGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTKFNGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:06:08 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:65154 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263541AbTKFNGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:06:03 -0500
Message-ID: <3FAA4737.3060906@cyberone.com.au>
Date: Fri, 07 Nov 2003 00:05:59 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de> <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de>
In-Reply-To: <20031106130030.GC1145@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Thu, Nov 06 2003, Nick Piggin wrote:
>
>>
>>Prakash K. Cheemplavam wrote:
>>
>>
>>>>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>>>>----cpu----
>>>>>r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>>>>>sy id wa
>>>>>2  0      0 579472  13976 308572    0    0   425    85 1255   645  5 
>>>>>3 84  9
>>>>>2  0      0 579456  13976 308572    0    0     0     0  725   521  5 
>>>>>5 91  0
>>>>>1  0      0 579448  13976 308572    0    0     0     0  736   523  2 
>>>>>5 94  0
>>>>>0  0      0 579448  13976 308572    0    0     0    25  745   439  2 
>>>>>
>>>>
>>>>
>>>>[snip]
>>>>
>>>>This looks good, from a system utilization point of view. I'm wondering
>>>>whether you have the iso image cached? There's no block io going on.
>>>>
>>>>It does like more like a CPU scheduler problem at this point.
>>>>
>>>
>>>
>>>Ok, then it is Nick's turn, I guess. :-) Yeah most probably the iso is 
>>>cached, as it was not the first time I burnt the iso when I did the 
>>>vmstat, furthermore I have 1 GB of RAM... The other thing which 
>>>doesn't speack for i/o problems, I guess: Just the first seconds when 
>>>I start erasing the CD-RW the mouse hangs and heavily stutters, then 
>>>it is OK until actual burning of image begins, then the mouse slightly 
>>>stutters. All this was not with test9-mm1.
>>>
>>>
>>I don't think the scheduler is the problem if you didn't have these problems
>>in mm1. The scheduler is quite good when nothing is reniced. Whats funny
>>though is it looks like you're losing timer interrupts, this is a sign that
>>something is holding interrupts off for too long, and would also cause
>>problems with your mouse.
>>
>
>sys time is usually pretty high if that is the case, and it's hovering
>around 5% here... Prakash, are you sure that dma is enabled on the
>drive? When you see the problem, do a vmstat 1 for 10 seconds so you are
>absolutely sure you are sending the info from when the problem occurs.
>

Although have a look at the interrupts field in vmstat 1255, 725, 736 ...

>
>>I guess its over to Andrew.
>>
>
>Back to you, Kent! :-)
>

:)

