Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRALIGd>; Fri, 12 Jan 2001 03:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRALIGX>; Fri, 12 Jan 2001 03:06:23 -0500
Received: from styx.suse.cz ([195.70.145.226]:56564 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129183AbRALIGL>;
	Fri, 12 Jan 2001 03:06:11 -0500
Date: Fri, 12 Jan 2001 09:05:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dep <dennispowell@earthlink.net>
Cc: James Brents <James@nistix.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
Message-ID: <20010112090552.A812@suse.cz>
In-Reply-To: <3A5DB638.1050809@nistix.com> <01011109382601.29363@depoffice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01011109382601.29363@depoffice.localdomain>; from dennispowell@earthlink.net on Thu, Jan 11, 2001 at 09:38:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm the current maintainer of the VIA driver. I'm pretty sure the
version in 2.4.0 programs the chips correctly for harddrives at various
speeds, even leaving some margins where it shouldn't need to.

I think there is not any problem with Western Digital drives, I've got
many reports of them working OK with different chipsets, including those
made by VIA.

However, I'm getting many many problem reports on Abit KT7's. It might
be that this is a very popular board, but nevertheless, I think at least
its earlier revisions had trouble with UDMA transfers.

At least on one of these boards a drive did work correctly, without CRC
errors on the secondary interface, and gave constant errors on the
primary. All other known problem causes were eliminated.

I think it's Abit this time who's to blame.

-----

Anyway, you can try disabling VIA support in kernel, and if BIOS sets up
things correctly, you should be able to use UDMA as well. If it works
then, it would mean that my driver is a problem. I'd like to hear in
either case.

Vojtech

On Thu, Jan 11, 2001 at 09:38:26AM -0500, dep wrote:
> On Thursday 11 January 2001 08:33 am, James Brents wrote:
> 
> | Since this looks like either a chipset, drive, or driver problem, I
> | am submitting this.
> | I have recently started using DMA mode on my harddisk. However, I
> | occasionally (not often/constant, but sometimes) get CRC errors:
> | hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> | hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> welcome to the club. if you are given an answer off-list to this, i'd 
> love a copy, because i've had the same issue for six months now. some 
> have said that it's crosstalk in the cable -- in which case, all 
> three of the 80-conductor cables i've tried are insufficiently 
> shielded and we're in need of premium 80-conductor cables. and i 
> found this in the november 200 linux journal, page 82, last 
> paragraph, in an article on the ultimate linux box written by don 
> marti:
> 
> "earlier this year, kernel hacker andre hedrick, the maintainer of 
> linux's ide driver, tracked a user's problem to the fact that western 
> digital drives don't do error checking correctly. he posted to 
> linux-kernel, 'wdc drives blow off the crc check of udma . . . . this 
> is bad and stupid.' western digital fired back on their web site 
> with, 'if there's a problem using these drives in linux the problem 
> most likely lies with the software driver and not the hard drive 
> itself.' i'm going to believe the kernel hacker over the hardware 
> vendor and stay away from western digital drives for awhile."
> 
> this suggests a.) that we need to gently pressure the w.d. people to 
> come up with a fix or provide the specs necessary to fashion one -- 
> the latter being preferable -- and b.) that we need to figure out 
> some sort of hack that does -- what? in my experience, these error 
> messages actually signify nothing, but they're using up cycles. can 
> they be safely supressed? beats me. but they sold a hell of a lot of 
> these things.
> 
> though i've noticed that the problem seems to be limited to those of 
> us who have via chipset motherboards, suggesting that it is limited 
> to that chipset, that chipset is ubiquitous, or via chipset 
> motherboard owners are generally the complaining type. no idea which 
> applies there, either.
> 
> -- 
> dep
> --
> bipartisanship: an illogical construct not unlike the idea that
> if half the people like red and half the people like blue, the 
> country's favorite color is purple.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
