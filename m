Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271331AbRHTQRx>; Mon, 20 Aug 2001 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271335AbRHTQRs>; Mon, 20 Aug 2001 12:17:48 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:27142 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S271331AbRHTQQf>; Mon, 20 Aug 2001 12:16:35 -0400
Message-ID: <001601c12993$930fc4a0$0200a8c0@home.lan>
From: "Chris Pockele" <chrisp@newmail.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: sound crashes in 2.4
Date: Mon, 20 Aug 2001 18:17:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >     2.4.8 dies after ~1/2 minute of mpg123 playback,
> >     with tty switching freeze, and typing out
> >     continuously (i`d say infinitely) call trace.
> >
> >         ac7 acts this way too, but before death
> >     sound stalls *some* times, i then each time restart
> >     the proggie which emits it. This pattern survives
> >     4-5 stalls, after which - final trace dump.
> >
> >     gcc-2.95.3, sb16 - genuine, vanilla ac7, vanilla
> >     2.4.8.
> 

I have the same problems with an ALS007 card (in a 486 system).
The card is correctly recognized and set up by the PnP drivers.

The system freezes completely when using sound (no ping replies
anymore), and it's not a CPU/motherboard/RAM issue
(it compiles kernels without any problems), it occurs while
playing MP3's, while playing LxDoom ( now i have an excuse
to play Doom, testing the Linux sound drivers ;) ).
The time after which it crashes is variable, sometimes it crashes
immediately, sometimes it crashes after 5 minutes.
Sometimes, it also stalls a few times before finally crashing.

Having persistant DMA buffers enabled/disabled doesn't change
anything (the machine has 16MB of RAM), and the problem occurs
both when using modules or compiled-in drivers.

Both 2.4.8 and 2.4.9 have this problem (these are the ones I tried).
Btw on 2.2.x i get DMA (output) timeout errors (and broken sound).

There is also another "issue":
the ISAPnP code calls "CMI8330 quirk".  As i have no such
card, i thought this was related to the problem.  After
commenting it out in quirks.c and recompiling, the quirk
was not called anymore, but it didn't solve the problem.

greets


