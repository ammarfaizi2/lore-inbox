Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157666AbQGaOf3>; Mon, 31 Jul 2000 10:35:29 -0400
Received: by vger.rutgers.edu id <S159984AbQGaOfS>; Mon, 31 Jul 2000 10:35:18 -0400
Received: from pec-58-36.tnt4.b2.uunet.de ([149.225.58.36]:2602 "EHLO router.abc") by vger.rutgers.edu with ESMTP id <S157666AbQGaOeO>; Mon, 31 Jul 2000 10:34:14 -0400
Message-ID: <3985919F.3ADB81AD@baldauf.org>
Date: Mon, 31 Jul 2000 16:47:59 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en,de-DE
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org> <39858A9F.C272E4E8@baldauf.org> <20000731163127.G2224@lxMA.mediaways.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu



Matthias Andree wrote:

> On Mon, 31 Jul 2000, Xuan Baldauf wrote:
>
> > > > does not necessarily spin up the disk!
> > >
> > > Because you have to issue a drive reset.
> >
> > This is my intent, not to spin up the disk. (In my previous case, sync
> > always spun up the disk because the filesystem was not mounted with
> > "noatime".)
>
> This will still not work, since after some time, the kernel starts
> missing the drive acknowledgements and eventually issues a reset
> condition on that IDE channel. See my other mail for details.

You tell me the kernel starts missing drive ACKs even if there are no read
or write requests pending? Even then, the drive was never in sleep mode
(requires reset), it always was in standby mode (does not require reset). My
primary intent is to reduce the noise of the drive, not the power
consumption.

>
> --
> Matthias Andree

Xuân.:o)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
