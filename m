Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUHUSzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUHUSzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUHUSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:55:44 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:30914 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S267669AbUHUSzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:55:21 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sat, 21 Aug 2004 14:55:13 -0400
User-Agent: KMail/1.6.82
Cc: V13 <v13@priest.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040821092556.GA14991@ip68-4-98-123.oc.oc.cox.net> <200408212131.38019.v13@priest.com>
In-Reply-To: <200408212131.38019.v13@priest.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408211455.14118.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.54] at Sat, 21 Aug 2004 13:55:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 14:31, V13 wrote:
>On Saturday 21 August 2004 12:25, Barry K. Nathan wrote:
>> > Memtest86 may not know howto enable it if its an
>> > nforce2 option.  Whatever cache shown as switchable in the bios,
>> > turning it off makes a very sick bird out of the machine, like a
>> > 33mhz 386sx?
>>
>> Yeah, disabling the L2 cache on a modern CPU makes it really slow.
>> But, it's still a useful troubleshooting option...
>
>When I had the problem described in my previous mail I came to the
> conclussion that it was related with cache *BUT* it seemed that the
> cache was just caching wrong data. Disabling the cache would just
> reduce the problem.
>
>One reason for this is that when the program detected errors in a
> buffer (i.e. 0x1234 instead of 0x1111) then they would NOT go away
> if the program was reading from this buffer all the time. This
> means that the cache always returned the same data. The error was
> 'gone' every time the program was suspended for a while or when
> something else used a lot of memory (i.e. another instance of this
> program).
>
>So, I'm not suggesting that his cache is faulty but that there can
> be a CPU (or even a M/B) problem that corrupts data when they are
> transfered from memory to the processor.
>
>> -Barry K. Nathan <barryn@pobox.com>
>
><<V13>>
Latest memburn results here, this after swapping the memory sticks for 
each other, running over 512 megs, half my ram:

Passed round 2308, elapsed 41225.98.
FAILED at round 2309/40220063: got ff000000, expected 00000000!!!
REREAD: ff000000, ff000000, ff000000!!!

So not only has the problem moved from the 2nd LSB to the MSB of the 
fetch, but it is a lot more severe in terms of the amount of time to 
catch one error, now nearly 17 hours.  I'm now up 25 hours and the 
machine feels good, no Oops so far and I've restarted memburn in 
addition to konstruct working on kde-3.3 final.  I'm over 100 megs 
into the swap, and 2.6.8.1-mm2 seems to handling the situation 
admirably so far.  That knocking sound?  Thats me, knocking on wood 
for good luck.  :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
