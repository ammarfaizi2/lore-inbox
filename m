Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRFKAlc>; Sun, 10 Jun 2001 20:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbRFKAlX>; Sun, 10 Jun 2001 20:41:23 -0400
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:25024 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S263318AbRFKAlM>; Sun, 10 Jun 2001 20:41:12 -0400
Message-ID: <008401c0f20f$4458dec0$643b090a@sulaco>
From: "Michael Johnson" <johnsom@home.com>
To: "John Fremlin" <vii@users.sourceforge.net>
Cc: "Jens Axboe" <axboe@suse.de>, <Andries.Brouwer@cwi.nl>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <001801c09e3a$4a189270$653b090a@sulaco><m27l29tj87.fsf@boreas.yi.org.> <m28zj05j7y.fsf@boreas.yi.org.>
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Date: Sun, 10 Jun 2001 17:41:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, the patch you are proposing will always consider the tray open, even if
it is closed.  Why do you need this behavior?

Why is checking CDS_TRAY_OPEN, to see if the tray is open, broken?

The code in cdrom.c looks fine to me.

Michael

----- Original Message -----
From: "John Fremlin" <vii@users.sourceforge.net>
To: "Michael Johnson" <johnsom@home.com>
Cc: "Jens Axboe" <axboe@suse.de>; <Andries.Brouwer@cwi.nl>; "Alan Cox"
<alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Sunday, June 10, 2001 10:37 AM
Subject: Re: Changes to ide-cd for 2.4.1 are broken?


>
> Hi all, this is an old thread. It was started because the return value
> from cd info was changed in 2.4.1 in the case when the tray might be
> open or there simply be no disc in the drive for an IDE
> CD-ROM.
>
> John Fremlin <chief@bandits.org> writes:
>
> > "Michael Johnson" <johnsom@home.com> writes:
>
> [...]
>
> > > >Right, old ATAPI has 3a/02 as the only possible condition, so we
> > > >can't really tell between no disc and tray open. I guess the safest
> > > >is to just keep the old behaviour for !ascq and report open.
> >
> > > I don't understand why the current(2.4.1) behavior is a problem...
>
> Unfortunately changing the return code means that the generic cdrom.c
> code is broekn, in particular wrt to having the cdrom drive open
> automatically when umounted, and to close when attempted to be
> mounted.
>
> (You can set this mode with "cdd auto" if you have my asm-toys installed
>         http://ape.n3.net/programs/linux/asm-toys
> )
>
> The following patch fixes that. I also attempted to fix up similar
> problems (where checking CDS_TRAY_OPEN is used to see if the tray is
> open, which is obviously broekn).
>
>


----------------------------------------------------------------------------
----


>
> --
>
> http://ape.n3.net
>

