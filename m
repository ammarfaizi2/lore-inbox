Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315935AbSEGSkM>; Tue, 7 May 2002 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315936AbSEGSkL>; Tue, 7 May 2002 14:40:11 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16835 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315934AbSEGSkK>; Tue, 7 May 2002 14:40:10 -0400
Date: Tue, 7 May 2002 12:40:01 -0600
Message-Id: <200205071840.g47Ie1m32403@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205071114200.975-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> 
> On Tue, 7 May 2002, Alan Cox wrote:
> >
> > > > Fugly. What's wrong with readlink(2) as this "magic syscall"?
> > > Ehh - like the fact that it doesn't work on device files?
> >
> > I can't find anything in Posix/SuS that says it isnt allowed to however 8)
> 
> We can certainly do it, it just doesn't buy us much of anything, since
> none of the standard tools (ie "ls") will actually do the readlink() for
> anything but a symlink.
> 
> So at that point it's just another magic syscall, except we've overloaded
> an old one.
> 
> Which may certainly be acceptable, of course.

I wasn't suggesting a magic readlink(2). I was suggesting a *real*
one. Device nodes get stored in the physical tree (what you call
driverfs), and the entries in the logical tree are symlinks. Such as:

	/dev/scsi/host0  symlink to  /dev/bus/pci0/slot1/function2

or something like that. Easy to implement, easy to understand, easy to
manage.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
