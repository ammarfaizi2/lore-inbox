Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUHEEbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUHEEbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbUHEEbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:31:50 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:31874 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267476AbUHEEbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:31:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 00:31:21 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <20040804204640.64cd65fc.akpm@osdl.org>
In-Reply-To: <20040804204640.64cd65fc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408050031.21366.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.11.172] at Wed, 4 Aug 2004 23:31:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 23:46, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Monday 02 August 2004 09:14, Brett Charbeneau wrote:
>>  >Greetings,
>>  >
>>  >	I am getting the oops below - twice since 7/26, but I haven't a
>>  >clue what's causing it.
>>  >	I am not a subscriber, so any replies directed to me would be
>>  >gratefully received.
>>  >	Thank you for your hard work on this!
>>
>>  The attachment this gentleman included specifically points to
>>  prune_dcache().  Thats nice.  It also means I'm not alone.  See
>> the 'prune_dcache() Oops, the saga continues' thread.
>
>Except he's running a 2.4 kernel.
>
>Is there any reason why I'm wrong in thinking that you have dodgy
>hardware?

Well, it has, in the past week, ran memtest86-3a for 12 full passes 
over the whole gig of ram with no errors.  This was the longest test, 
I gave it a 2 hour, 5 pass test before I ever booted linux the first 
time on this motherboard over 2 weeks ago now, a new Biostar 
M7NCD-Pro, with an nforce2(3?) chipset.  I did that because I was 
comeing from an older board whose memory had been overstressed by a 
failing video card and I wanted to make sure this new memory, nearly 
$210 worth of it, was good. I gave it another, probably 4 hour test 
after the first couple of crashes, which it also passed.  And it got 
worse as the kernel versions incremented from 2.6.7.  I can have the 
same fault in prune_dcache() while running a 2.6.7 kernel without an 
instant lockup, but it will eventually die, maybe half an hour later.  
Move to 2.6.7-mm1, which has a patch to fs/dcache.c that remains 
untouched thru 2.6.8-rc2, and those kernels, if they lock up, do it 
totally, often with nothing in the logs at all.  That was the case 
today, on 2.6.8-rc3, which has a new dcache.c patch in it if I read 
the release notes correctly.

If this is dodgy hardware, give me something to take to tcwo.com when 
I ask for an rma.  Not having M$ windows of any kind here, I frankly 
haven't had the inclination to look at the cd's that came with the 
board.  Should I?

Or does linux have a hardware test suite I've not heard about?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
