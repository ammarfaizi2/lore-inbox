Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129840AbRBAMxK>; Thu, 1 Feb 2001 07:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRBAMxA>; Thu, 1 Feb 2001 07:53:00 -0500
Received: from [64.160.188.242] ([64.160.188.242]:6407 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129714AbRBAMw4>; Thu, 1 Feb 2001 07:52:56 -0500
Date: Thu, 1 Feb 2001 04:51:03 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <3A786E7E.781C910@the-rileys.net>
Message-ID: <Pine.LNX.4.21.0102010442070.15634-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I'm seriously beginning to think it's a board specific issue. If I
drop the RAM count down to 768MB I get far less drops in app deaths
now. I'm living in Sunnyvale CA which is part of the Rolling Blackouts
designated spots in CA. Ever since the power companies have been
instituting this I've seen equipment that otherwise ran great all of a
sudden start flaking.

I've got this particular machine connected to a UPS so I figured the
voltage regulation would be right on the money. Now, I'm not so sure since
a number of people have brought this up. I'm going to drop her down to
768MB and then try a 128MB DIMM in there. I want to see if it can handle
that. Since the 128s have less draw than the 256s do, maybe this will
work.

Right now I've got the full 1GB in there. What I'm seeing now is
application deaths, occational X11 lockups, but SUPRIZE! SUPRIZE! no more
drive corruptions since I removed the DMA flag from the drives, disabled
DMA use in the BIOS and replaced the ATA66 cable with an ATA33.

For everyone out there that's assisted in tracking this down and assisted
in getting a working fix going.. .THANK YOU!

For now, I'm going to have to play keep in step with the kernel, patches,
and the VIA driver. Voj, can you directly add me to whatever ANNOUNCE list
you use for announcing the latest release of the driver?

Once again thanks folks. It's still not totally stable here, but it's a
DAMN sight farther than it was before. While not TOTALLY convinced that
it's a local hardware issue, I do thank folks for their 2 cents. :-)


On Wed, 31 Jan 2001, David Riley
wrote:

> Mark Hahn wrote:
> > 
> > >>From what I gather this chipset on 2.4.x is only stable if you cripple just about everything that makes
> > > it worth having (udma, 2nd ide channel  etc etc)  ?    does it even work when all that's done now or is
> > > it fully functional?
> > 
> > it seems to be fully functional for some or most people,
> > with two, apparently, reporting major problems.
> > 
> > my via (kt133) is flawless in 2.4.1 (a drive on each channel,
> > udma enabled and in use) and has for all the 2.3's since I got it.
> 
> Not to make a "mee too" post but...
> 
> It's worked flawlessly for me.  Always.  Since it seems to work fine for
> just about everyone else, I'd venture to say that it's a board specific
> issue, quite likely with the BIOS.  Some other problems seem to have to
> do with the memory; I remember the KX133 had some definite problems with
> memory timing, especially with large amounts (3 DIMMS were a problem on
> some motherboards that were loosely laid out).
> 
> My 2 cents,
> 	David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
