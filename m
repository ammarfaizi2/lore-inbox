Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUHSTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUHSTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267295AbUHSTU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:20:56 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:48302 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267313AbUHSTR0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:17:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: vherva@viasys.com
Subject: Re: 2.6.8.1-mm2
Date: Thu, 19 Aug 2004 15:17:22 -0400
User-Agent: KMail/1.6.82
References: <20040819014204.2d412e9b.akpm@osdl.org> <200408191245.46726.gene.heskett@verizon.net> <20040819182752.GA3024@viasys.com>
In-Reply-To: <20040819182752.GA3024@viasys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408191517.23082.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 14:17:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 14:27, Ville Herva wrote:

And I've added the lkml to the CC: list because of the question I ask.

>On Thu, Aug 19, 2004 at 12:45:46PM -0400, you [Gene Heskett] wrote:
>> > I would suggest you run memtest86 for at least a day, and you
>> > can also try memburn and cpuburn.
>>
>> How did you guess :)  Yes, and a rerun of my makeit script worked
>> just fine.
>
>I've seen that before :-/.
>
>> The dcache bug has now turned into an icache bug it seems.
>
>My point was that if the bugs you were seeing were happening on this
> same machine with broken (or at least suspectible) hardware, all
> the oopses cannot the be trusted. And I would advice you to inform
> the kernel developers working on that issue on the suspectibility
> of your hardware, so that they will not end up wasting days of
> their time by chasing ghosts.

In retrospect, I have to agree that this problem, and I because of it,
are being a pain in the ass.  Unforch, I may have to find another
supplier and eat this 400 dollar investment, it seems tcwo has found
their warehouse has been cleaned out by a robbery, or at least thats
the story posted on the front page of their web pages 2 days ago.
We've delt with Dan Thompsons Computer Warehouse firm (in Tampa FL FWTW)
for 7 years now, always with excellent results, but since the hurricane,
he has been unreachable in terms of getting a reply back from an rma
request, its been about 30 hours now.  The web page is alive again, but
the phone is not, all voicemail slots are full or otherwise invalid.

The lights are on, but nobody is home.

>>   And I play with some item in the bios everytime I reboot,
>> turning off the 'external cache' that last time.  This boards bios
>> is the poorestly documented of any I've had in a while.
>
>Ummh.
>
>Please try to find a stable configuration before reporting more
> oopses. memtest86 (www.memtest86.org), cpuburn and memburn (use
> google) should be of great help making sure the hardware is not
> acting up.
>
>> In my own mind, I keep coming back to the fact that linux had a
>> hell of a time figuring out the nforce2 chipset, and I've often
>> wondered if the current implementaion is 'spot on' as they say. 
>> But I fugured too, when I ordered it, that the hullabaloo about it
>> was almost a year ago, and it really, really should have
>> stabilized by now.  At least that was my theory when I ordered it.
>
>You may just have a faulty memory chip. If I were you I'd try
> memtest 86 first.
>
It has probably been run here, for an aggregate total of 40+ hours
in 5 sessions.  Longest was 12 full passes so far.

>> I've applied for an rma on all 3 items, asking for direct
>> replacements, prefereably by an athlon thats a stepping newer than
>> this 00 one.
>
>Broken CPU's are not that common. Memory is much more often faulty.
>Misdesigned / broken motherboards are not unheard of, either, but
> usually you will a host of complaints in the different internet
> forums in that case (like with the notorious Via KT133.)

Which is why I question the nforce2 support, it was quite a battle
making it work when it was new less than a year ago, recorded for
all to read in the lkml archives.  And now I find that things that
don't work with the bios 'external cache' on, do work with it off,
but slower than a frozen bottle of corn syrup.  Seriously, the
machine is almost unusable.

Then on checking dmesg's in the logs, I find that the initial memory
table handed to linux does not change when this cache is turned off/disabled!

Example: cache enabled in the bios:
----------
Aug 19 13:51:00 coyote kernel: Linux version 2.6.8.1-mm2 (root@coyote.coyote.den) (gcc version 3.3.3 20040412 (Red
Hat Linux 3.3.3-7)) #2 Thu Aug 19 13:10:29 EDT 2004
Aug 19 13:51:00 coyote kernel: BIOS-provided physical RAM map:
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 19 13:51:00 coyote kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 19 13:51:00 coyote kernel: 127MB HIGHMEM available.
Aug 19 13:51:00 coyote syslog: klogd startup succeeded
Aug 19 13:51:00 coyote kernel: 896MB LOWMEM available.
----------------------
>From previous, cache disabled boot:
Aug 19 06:22:42 coyote kernel: Linux version 2.6.8-rc4 (root@coyote.coyote.den) (gcc version 3.3.3 20040412 (Red Ha
t Linux 3.3.3-7)) #11 Tue Aug 17 17:06:29 EDT 2004
Aug 19 06:22:42 coyote kernel: BIOS-provided physical RAM map:
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 19 06:22:42 coyote kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 19 06:22:42 coyote kernel: 127MB HIGHMEM available.
Aug 19 06:22:42 coyote syslog: klogd startup succeeded
Aug 19 06:22:42 coyote kernel: 896MB LOWMEM available.
-----------
which looks identical to my first glance.  How is the 
bios telling the kernel that such and such a block of memory
its assigning for L2 cache is reserved and not available for
cacheing/buffering/executables?  It does seem to be a valid question.
 
Then, all boots have been showing this which gets my
attention, but probably isn't related in any way:
Aug 19 13:51:02 coyote kernel: NFORCE2: IDE controller at PCI slot 0000:00:09.0
Aug 19 13:51:02 coyote kernel: NFORCE2: chipset revision 162
Aug 19 13:51:02 coyote kernel: NFORCE2: not 100%% native mode: will probe irqs later
Aug 19 13:51:02 coyote kernel: NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Aug 19 13:51:02 coyote kernel: NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
Aug 19 13:51:02 coyote kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Aug 19 13:51:02 coyote kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

There also is not an hdd.  Not yet anyway.

>> ?? Can you suggest a mobo thats as well equipt as this one, but is
>> known to work 100%?  This is a Biostar M7NCD-Pro, with everything
>> but sata, video and firewire built in.  400mhz fsb, and 400mhz
>> dual channel DDR, so the memory bandwidth is something above 1.3
>> Gb/second.
>
>Sorry, no idea. I have an Abit ST6R that works very well, but this
> is a couple of years old stuff. Try to check the linux hardware
> forums an see what people are using.
>
>
>-- v --
>
Thanks

>v@iki.fi

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
