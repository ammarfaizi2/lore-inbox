Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbRB1QQB>; Wed, 28 Feb 2001 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRB1QPv>; Wed, 28 Feb 2001 11:15:51 -0500
Received: from [138.6.98.137] ([138.6.98.137]:19984 "EHLO
	caspian.prebus.uppsala.se") by vger.kernel.org with ESMTP
	id <S130247AbRB1QPk>; Wed, 28 Feb 2001 11:15:40 -0500
Message-ID: <E44E649C7AA1D311B16D0008C73304460933B1@caspian.prebus.uppsala.se>
From: Per Erik Stendahl <PerErik@onedial.se>
To: "'James A. Sutherland'" <jas88@cam.ac.uk>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Unmounting and ejecting the root fs on shutdown.
Date: Wed, 28 Feb 2001 17:12:03 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I almost missed this one. High-volume mailinglists... :-)

> > 	Hello Per ,  Has anyone gotten back to you on this subject ?
> > 	I as well am very interested in any information about releiving
> > 	this difficulty .  Tia ,  JimL
> >
> Such a CD would be very nice; one or two people do have this already,
> though. Have you tried using a ramdisk for root, and mounting 
> the CD as
> /usr?

Well, doing this on your own certainly will teach you a lot about
Linux I tell you. :-)

I still dont know how to make the kernel unlock and eject the CD on
shutdown. I haven't been able to pinpoint the shutdown sequence in
the kernel sources yet. :-)

What I do know now is how to make the kernel not lock the CD in the
first place. Simply ioctl(/dev/cdrom, CDROM_CLEAR_OPTIONS, CDO_LOCK)
from /linuxrc in the initrd. This way I can remove the CD anytime
I please which is enough for me. And I dont have to patch the kernel.

Mounting a ramdisk for / is doable (I think) but kludgy since you have
to symlink or mount so many subdirectories. Right now I only have /var
in a ramdisk (and why _WHY_ is /etc/mtab located in /etc and not
in /var??).

Anyways the CD works - and yes, being able to boot Linux w/o touching
the harddrives or the network is nice! :-) I might even put it on the
web once I get it cleaned up. Though the ISO is ~200 Mb.

Cheers
/Per Erik Stendahl
