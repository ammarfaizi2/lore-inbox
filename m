Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGIMop>; Tue, 9 Jul 2002 08:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSGIMoo>; Tue, 9 Jul 2002 08:44:44 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25813 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315162AbSGIMol>; Tue, 9 Jul 2002 08:44:41 -0400
Date: Tue, 9 Jul 2002 14:46:58 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Paul Bristow <paul@paulbristow.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <3D2AD6EE.6020303@evision-ventures.com>
Message-ID: <Pine.SOL.4.30.0207091445540.15575-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Martin Dalecki wrote:

> U¿ytkownik Paul Bristow napisa³:
> > OK.  I kept quiet while the IDE re-write went on so that when it was
> > over I could fix up ide-floppy and start adding some of the requested
> > features that were only really possible with the taskfile capabilities.
> > But I have to jump in with the latest statements from Martin...
> > Martin Dalecki wrote:
> >
> >> U¿ytkownik Eduard Bloch napisa³:
> >>
> >>
> >>> Why not another way round? Just make the ide-scsi driver be prefered,
> >>> and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
> >>> that are expected as /dev/hd* by some user's configuration?
> >>>
> >>
> >>
> >> This is the intention.
> >>
> > Since when?  I thought Jens was in the process of getting rid of the
> > ide-scsi kludge with his moves to support cd/dvd writing directly in
> > ide-cd?
>
> Well code decides. And in reality I have tried the much simpler goal
> to unify the ide-floppy ide-tape and ide-cd parts which
> should be common. Like for example a simple SCSI multi media command set
> preparation library. Admittedly I have failed. Therefore and in
> fact of the 2.6 release schedule it's simple not practical to
> persue this road further. It makes much more sense to just
>
> 1. Scrap the specific atapi drivers.
>
> 2. Try to make ide-scsi independant from SCSI subsystem from users view.
>
> 3. Replicate some of the workarounds in the previous ide-xxxx drivers.

And how will you support i.e. DSC in ide-tape?

> >
> > The current system may be ugly, but if we have to break it in the name
> > of progress we have at least to make the new, improved version work as
> > well (and hopefully better) than the old one.
> >
> >>> Other operating systems did switch to constitent (scsi-based) way of
> >>> accessing all kinds of removable media drivers. Why does Linux have to
> >>> keep a kludge, written years ago without having a good concept?
> >>>
> >>>
> >>
> > If we can address all these issues I will be extremely happy to helping
> > create a sensible removeable media subsystem.
>
> That's a deal.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

