Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130023AbRBFTsR>; Tue, 6 Feb 2001 14:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130173AbRBFTsH>; Tue, 6 Feb 2001 14:48:07 -0500
Received: from www.topmail.de ([212.255.16.226]:15530 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S130023AbRBFTre> convert rfc822-to-8bit;
	Tue, 6 Feb 2001 14:47:34 -0500
Message-ID: <033601c09075$a60e43e0$de00a8c0@homeip.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "Michael D. Crawford" <crawford@goingware.com>,
        "Peter Samuelson" <peter@cadcamlab.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3A7E1942.5090903@goingware.com> <20010205180646.B32155@cadcamlab.org>
Subject: Re: OK to mount multiple FS in one dir?
Date: Tue, 6 Feb 2001 19:47:11 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Peter Samuelson" <peter@cadcamlab.org>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, 6. February 2001 00:06
Subject: Re: OK to mount multiple FS in one dir?


> 
> [Michael D. Crawford]
> > I found I could mount three partitions on /mnt
> 
> Yes.  New feature, appeared in the 2.4.0test series, or shortly before.
> 
> > and they'd all show up as mounted at /mnt in the "mount" command, but
> > if I unmounted one of them (only tried with the currently visible
> > one), then it appeared that there were no filesystems mounted there,
> > but I could continue umounting until the other two were gone.
> 
> util-linux gets rather confused by this feature.  They say newer
> versions fix this.
> 
> > But I had the 2.10r util-linux sources on my machine and installed
> > mount and umount from it, and I find that it gets it right mostly
> > when I mount and unmount multiple things, with the exception that if
> > /dev/sda5 was mounted before /dev/sda1, then if I give the command
> > "umount /dev/sda5", sda1 is the one that gets unmounted rather than
> > sda5, so it takes the most recently mounted filesystem rather than
> > the one you specify.
> 
> I think this is a kernel limitation.  'umount' takes '/dev/sda5' and
> turns it into '/mnt/test' and calls umount("/mnt/test").  The kernel
> then unmounts whatever is on "top" of /mnt/test.
> 
> I don't think there's anything umount can do about this behavior.

What about userland umount checking which device is umounted and
refusing to umount it or at least issuing a printf warning?

> 
> Peter

-mirabilos

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
