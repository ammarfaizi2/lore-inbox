Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRJHR2h>; Mon, 8 Oct 2001 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277013AbRJHR22>; Mon, 8 Oct 2001 13:28:28 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:1028 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277012AbRJHR2J>; Mon, 8 Oct 2001 13:28:09 -0400
Posted-Date: Mon, 8 Oct 2001 11:19:01 GMT
Date: Mon, 8 Oct 2001 12:19:01 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA errors [was: Some ext2 errors]
In-Reply-To: <20011007173237.A30930@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.21.0110081207060.4085-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike.

>>>>> As far as I can tell, it's a problem with the PSU in the computer
>>>>> in question, as I can swap ANYTHING else in there, motherboard
>>>>> included, without the problem going away on that drive, but as
>>>>> soon as I swap the PSU, the problems vanish - even if I put a PSU
>>>>> with a lower rating in its place.

>>> It may not be your MB or drive, but an interaction between them.
>>> I.E. Your bios could've told the linux driver to use a higher dma
>>> level than the drive likes.

>> Always possible, but I'd consider it unlikely that using the SAME
>> motherboard and drive, but with a different PSU would have any
>> affect whatsoever if such was the reason.

>> I would presume that the old PSU was just too noisy for that
>> particular drive, and the new PSU is rather quieter in that regard.

> But we don't know what is happening with David's system.

Only David can know that - I can only comment on what I experienced
here, and suggest that he consider that his problem MIGHT be the same.

> To rule out some possible causes David, you should run these tests:

>	memtest86
>	badblocks -s /dev/hda

> The former can be downloaded from http://www.memtest86.org and the
> latter is a standard read only hard drive test, newer versions have
> a -p option for safe write mode tests too.

I would certainly agree with both of those, which I regard as being
standard tests - the former for ANY problem that isn't an obvious
compilation problem, and the latter for anything hard drive related.

>>> Try running "hdparm -d0 /dev/hda" (since your drive is hda in
>>> this case...) And see if the problem goes away. If it does, then
>>> try Multimode dma, if (-X34) you get errors, try single mode
>>> (probably -X31), if you get no errors there, try UDMA mode 2
>>> (-X66, also make sure you have a 80 line ide cable) and see if
>>> any of the problems come back.

>> Unfortunately, none of that is relevant in my case...see below...

> But maybe for David...

Agreed.

> David, try the tests above with read only badblocks...

Agreed.

>>>>>> Yeah. If you can't figure out hdparm, leave it alone.

>>>>> Who says hdparm has anything to do with it?

>>>> He says, it seems he has very deep knowledge of hdparm 'secrets'.

>>> Again, sorry for being presumptuous. I've only been able to cause
>>> this with hdparm. Maybe I'm just not using new enough hardware...

>> The system in question is my network printserver, which has a
>> 386sx/16 processor and a very definitely 40 line cable with no
>> support for anything else. The hard drive is an antique Maxtor 800M
>> one, and I have no problem assuring you that it's not possible to
>> buy that model new, and hasn't been for some years now...

> It would probably recognize a 2gb drive, which you could easily raid
> 1 for your server, assuming that there are two ide connectors on
> that old 386 MB.

Just one connector, with the hard drive on hda and a 250M IDE-ZIP on hdb
occupying the master and slave slots respectively. I probably could put
2G drives on it, but it does what I need as it stands, so I've no reason
to do so - besides, none of the local shops sell 2G drives anyway (the
smallest I can lay my hands on is 10G nowadays).

> This just adds another possible test...  Buying a new power supply.

Unfortunately, even PSU's fail given enough time...

> David, let us know what you find...

I'll be interested as well...

Best wishes from Riley.

