Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUGXF7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUGXF7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUGXF7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:59:00 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:43198 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S268304AbUGXF65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:58:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
Date: Sat, 24 Jul 2004 01:58:56 -0400
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org> <20040722184938.GA5232@hobbes.itsari.int> <1090630549.1471.17.camel@mindpipe>
In-Reply-To: <1090630549.1471.17.camel@mindpipe>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407240158.56434.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.55.188] at Sat, 24 Jul 2004 00:58:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2004 20:55, Lee Revell wrote:
>On Thu, 2004-07-22 at 14:49, Nuno Monteiro wrote:
>> On 2004.07.22 13:49, Gene Heskett wrote:
>> > 00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
>> > Controller (rev a1)
>> >         Subsystem: Biostar Microtech Int'l Corp: Unknown device
>> > 2301
>> >
>> > However, this, nor the xconfig helps, still don't indicate which
>> > driver I should be using, or where to get it if its not in the
>> > kernel's tree yet a/o 2.6.8-rc2.  So thats the next piece of
>> > data I need.
>>
>> Hi Gene,
>>
>>
>> I believe you'll need forcedeth.c for this one. It's called
>> "Reverse Engineered nForce Ethernet support", under Device Driver
>> -> Networking -> Ethernet 10/100 Mbit.
>
>Wow, nVidia won't release the specs for a *10/100 ethernet
> controller*? Having to reverse engineer a network driver is
> ridiculous in this day and age.  I can understand binary-only
> graphics drivers, there is a lot of valuable IP in there, but this
> is a freaking network card.  What do they expect people to do?
>
>Maybe some bad press would set them straight.
>
>Lee

Well, I have it working now.  The real problem is an arp cacheing 
problem I believe.  It works exactly as expected when I give that 
device the same MAC address in the machines bios settings as the 
D-Link card had.  And I don't know howto force arp to refresh its 
cache before it times out, which it didn't do in something like 14 
hours.  It would have been something I would have had to do on a 
RH7.3 box, which has so far been dead stable with over a 70 day 
uptime now.  For all I know, maybe a reboot would have fixed it as I 
have NDI where this 'arp cache' is located, and if in memory only, a 
powerdown would have forced a refresh.  I can think of a lot of "what 
if's" :-)

Nvidia is immune to bad press, and probably cannot release a thing 
other than some API help due to copyright contracts with the coders 
who wrote their winderz drivers for them,  The only cure would be for 
them to hired a couple of dozen programmers of the minimum quality 
the open source programmers exhibit, which I happen to think is top 
notch, and the CEO can only see outgo without compensatory income for 
all that salary, so they contract it out for a known cost, and get 
tied up in restrictive contracts.

Fscking copyright problems will be the end of any resemblance of 
civilization before the Warren Hatches have fallen by the wayside.  
Its happening right before our eyes.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
