Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUH0OBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUH0OBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUH0OBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:01:43 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:10188 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265106AbUH0OBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:01:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 27 Aug 2004 10:01:37 -0400
User-Agent: KMail/1.6.82
Cc: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040825014937.GC15901@zero> <200408242233.55583.gene.heskett@verizon.net>
In-Reply-To: <200408242233.55583.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408271001.37706.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.62.54] at Fri, 27 Aug 2004 09:01:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 August 2004 22:33, Gene Heskett wrote:
(going for the longest running thread on lkml)
>On Tuesday 24 August 2004 21:49, Tom Vier wrote:
>>On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
>>> >are you translating virt->phys?
>>>
>>> No, this is straight out of the memburn output (after I'd fixed
>>> the
>>
>>that's weird that you're finding that pattern in virtual addresses.
>> i wouldn't expect that. even if you're booting to single user,
>> certain variables might change during boot and cause different
>> physical pages to be mapped. maybe single user is more
>> deterministic than i think, though.
>
>Well, FWIW, and not knowing a hell of a lot about it, I would assume
>(there's *that* word again) that even the virtual addresses would be
>long word aligned with reality even if otherwise totally bogus.  I
>mean you'd really have to go out of your way to make it otherwise on
>x86 hardware wouldn't you?
>
>ATM I'm running on one stick, with memburn hacking away at 128 megs
>worth of it, Passed round 5683, elapsed 23530.67 at the moment.  And
>about 100 megs into swap, darnit.  And it isn't running anything
> else unusual, x/kde/kmail/mozilla & an occasional game of sol.
>
>If it runs till tommorrow morning, I'll assume this stick is good,
> and put the other one in the same socket for a similar test.  If it
> passes, then I try the other socket one stick at a time.

Ok, I've now shuffled both sticks thru both "B" sockets on this mobo, 
and neither one could run memburn more than 20 minutes, and again, 
the errors are all in the xx of nnnnxxnn in hex display formats.
So, I've put both sticks back in, in the A and B2 sockets ATM.  That 
ran about 25 minutes before memburn got a tummy ache.  In the 
meantime I'd rebuilt 2.6.9-rc1-mm1 with hi-mem support again, and the 
last reboot I took a detour thru the bios and turned the memory 
voltage up 100mv to 2.6 volts.  Running memburn against 400 megs of 
it has now been running for around 40 minutes.

So, my question for the hardware folks is: Whats the proper voltage to 
run a bank of DDR400 dimms in Dual Channel mode?

Humm, I spoke too soon, memburn has exited, with this:
Ahh, fudge, one cannot copy/paste from a virtual term.  Suffice to say 
that the address is odd, that the error is in the usual 3rd byte of 4 
position within the 32 bit read.

Since it appears that TCWO is gone, bankrupt or whatever, and I like 
the features of this board otherwise, can someone suggest howto go 
about getting a warranty replacement direct from Biostar?  I'll go 
visit the web page again, but I don't recall seeing any suitable 
links the last time I was there checking on updated bios files.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
