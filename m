Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131991AbRAKOfr>; Thu, 11 Jan 2001 09:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAKOfh>; Thu, 11 Jan 2001 09:35:37 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:53157 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130878AbRAKOfX>; Thu, 11 Jan 2001 09:35:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: James Brents <James@nistix.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
Date: Thu, 11 Jan 2001 09:38:26 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <3A5DB638.1050809@nistix.com>
In-Reply-To: <3A5DB638.1050809@nistix.com>
MIME-Version: 1.0
Message-Id: <01011109382601.29363@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2001 08:33 am, James Brents wrote:

| Since this looks like either a chipset, drive, or driver problem, I
| am submitting this.
| I have recently started using DMA mode on my harddisk. However, I
| occasionally (not often/constant, but sometimes) get CRC errors:
| hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
| hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

welcome to the club. if you are given an answer off-list to this, i'd 
love a copy, because i've had the same issue for six months now. some 
have said that it's crosstalk in the cable -- in which case, all 
three of the 80-conductor cables i've tried are insufficiently 
shielded and we're in need of premium 80-conductor cables. and i 
found this in the november 200 linux journal, page 82, last 
paragraph, in an article on the ultimate linux box written by don 
marti:

"earlier this year, kernel hacker andre hedrick, the maintainer of 
linux's ide driver, tracked a user's problem to the fact that western 
digital drives don't do error checking correctly. he posted to 
linux-kernel, 'wdc drives blow off the crc check of udma . . . . this 
is bad and stupid.' western digital fired back on their web site 
with, 'if there's a problem using these drives in linux the problem 
most likely lies with the software driver and not the hard drive 
itself.' i'm going to believe the kernel hacker over the hardware 
vendor and stay away from western digital drives for awhile."

this suggests a.) that we need to gently pressure the w.d. people to 
come up with a fix or provide the specs necessary to fashion one -- 
the latter being preferable -- and b.) that we need to figure out 
some sort of hack that does -- what? in my experience, these error 
messages actually signify nothing, but they're using up cycles. can 
they be safely supressed? beats me. but they sold a hell of a lot of 
these things.

though i've noticed that the problem seems to be limited to those of 
us who have via chipset motherboards, suggesting that it is limited 
to that chipset, that chipset is ubiquitous, or via chipset 
motherboard owners are generally the complaining type. no idea which 
applies there, either.

-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
