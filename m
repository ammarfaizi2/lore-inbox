Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319730AbSILRQE>; Thu, 12 Sep 2002 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319737AbSILRQE>; Thu, 12 Sep 2002 13:16:04 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:3088 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S319730AbSILRQC> convert rfc822-to-8bit;
	Thu, 12 Sep 2002 13:16:02 -0400
Date: Thu, 12 Sep 2002 20:20:52 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: pk@edu.joroinen.fi
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: sched.h changes in 2.4.19rc5aa1 / Digi's cpci driver doesn't
 compile
In-Reply-To: <1031849453.2902.98.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209122017230.17322-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Sep 2002, Alan Cox wrote:

> On Thu, 2002-09-12 at 17:30, Pasi Kärkkäinen wrote
> > The code goes like this (cpci.c line 3847):
> >
> > 	current->state = TASK_INTERRUPTIBLE;
> > 	current->counter = 0;   /* make us low-priority */
> >
> > current is task_struct.
>
> Its assuming old old scheduler bits. I suspect just removing the
> current->counter junk will make it happy
>


I removed that line, and then it compiled OK and it seems to work too.


Digi International ClassicBoard PCI and Neo Driver v1.1.16 Loaded
Copyright (C) 1999-2001 Digi International, Inc.
PCI Digi Neo 8 Port (Card #0;IRQ17) Found
ttyCP0 at 0xd084a000 (irq = 17) is a XR17C158
ttyCP1 at 0xd084a200 (irq = 17) is a XR17C158
ttyCP2 at 0xd084a400 (irq = 17) is a XR17C158
ttyCP3 at 0xd084a600 (irq = 17) is a XR17C158
ttyCP4 at 0xd084a800 (irq = 17) is a XR17C158
ttyCP5 at 0xd084aa00 (irq = 17) is a XR17C158
ttyCP6 at 0xd084ac00 (irq = 17) is a XR17C158
ttyCP7 at 0xd084ae00 (irq = 17) is a XR17C158


Thank you!


- Pasi Kärkkäinen

ps. If somebody from Digi is reading this, why don't you send these
drivers for inclusion to the kernel?


                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

