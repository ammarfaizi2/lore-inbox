Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRKNSn3>; Wed, 14 Nov 2001 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRKNSnT>; Wed, 14 Nov 2001 13:43:19 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:12306 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S273065AbRKNSnG>; Wed, 14 Nov 2001 13:43:06 -0500
Message-ID: <02b901c16d3c$a4e4adc0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <tytso@mit.edu>, <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <3BF2947B.DF3BE9DC@mandrakesoft.com> <013d01c16d29$bc5d4380$294b82ce@connecttech.com> <3BF29D69.B16479A1@mandrakesoft.com>
Subject: Re: Fw: [Patch] Some updates to serial-5.05
Date: Wed, 14 Nov 2001 13:46:17 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> Easily.  Your patch:
> > +  case TIOCSER485GET:
> > +  case TIOCSER485SET:
> > +   if (state->lmode_fn)
> > +    return (state->lmode_fn)(state, cmd,
> > +       (unsigned int *) arg);
> > +   else
> > +    return -EINVAL;
> >    case TIOCMGET:
> >     return get_modem_info(info, (unsigned int *) arg);
> >    case TIOCMBIS:
>
> 2.4.x serial.c:
> >                 case TIOCMGET:
> >                         return get_modem_info(info, (unsigned int *)
arg);
> >                 case TIOCMBIS:
>
> The formatting is blatantly, obviously different.

Something is broken along the way then, as I have:
..?
Grrr. Something wicked (windowsian) has damaged all
the tabs when I was inlining the patches.

Hm. Attaching the patches mangles (uuencodes) them and
inlining them damages the tabs. So. Please get the patch tarball
from: ftp://ftp.connecttech.com/pub/linux/blueheat/

> Doubtful.  When applied to 2.4.x-current:
>
> [jgarzik@rum linux_2_4]$ patch drivers/char/serial.c < ~/tmp/patch
> patching file drivers/char/serial.c
> Hunk #1 FAILED at 1405.
> Hunk #2 FAILED at 2514.
> Hunk #3 FAILED at 2572.
> Hunk #4 FAILED at 3968.
> patch: **** malformed patch at line 55: {

You're right, the patches tend not to apply to non-5.05 versions.
However, applying them to 2.4.14 doesn't give me the above. What
exactly is 2.4.x-current, and where can I get it?

I'll do a patch set against 5.05c, should rmk or tytso request it.
Unless you're also a serial maintainer of some description?

..Stu


