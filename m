Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289496AbSBENRn>; Tue, 5 Feb 2002 08:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289507AbSBENRe>; Tue, 5 Feb 2002 08:17:34 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:30479 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S289496AbSBENRY>;
	Tue, 5 Feb 2002 08:17:24 -0500
Date: Tue, 05 Feb 2002 14:17:21 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Asynchronous CDROM Events in Userland
To: hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3C5FDB61.70FDD1FA@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin (hpa@zytor.com) wrote :

>Calin A. Culianu wrote:
>
> >>>
> >>Does it spin up the CD-ROM doing so?
> >>
> >
> > Probably it doesn't, but just having the cpu be non-idle when it could
> > otherwise be idle does add up over time. In linux, polling the cdrom
> > *seems* inexpensive enough, but if you look at 'top' it seems to average
> > out to like 1-2% cpu time! (Ok, these stats aren't super-accurate,
> > they're just from running 'top' with the kde autorun tool running).
> >
> > [Admitedly, the autorun tool is written kind of strangely (it does one
> > redundant ioctl, plus it wait()s on its children constantly rather than
> > installing a signal handler), but still.. it would be nice to get those
> > extra cycles for quake3 or wolfenstein...]
> >
> 
> That just indicates a bullsh*t program. It's also pretty certain that

Oh, you didn't see magicdev yet ? :-)
( it is the GNOME counterpart of autorun, only worse )

> these kinds of things don't belong in the GUI; one of the things I'd
> like to do at some point is to write a daemon to mount things on insert
> (vold).

Pleeeeeaaaase do this soon !
Removable media handling in linux just sux. And the key linux developers
looking the other way doesn't help at all.
Maybe the work could be combined somehow with the hotplug system, as there seem
to be some similarities ?

Oh, BTW , did you in your test find any ATAPI device ( CD-ROM and/or writer )
that supports overlapped commands ( the ATA counterpart of disconnect/reconnect ) ?

>
>         -hpa


-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
