Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSCXXhW>; Sun, 24 Mar 2002 18:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312145AbSCXXhN>; Sun, 24 Mar 2002 18:37:13 -0500
Received: from pobox.ati.com ([209.50.91.129]:4050 "EHLO pobox.ati.com")
	by vger.kernel.org with ESMTP id <S312142AbSCXXhF>;
	Sun, 24 Mar 2002 18:37:05 -0500
Message-ID: <328A30E823B7D511A0BF00065B042A3B0C0E@fgl00exh01.atitech.com>
From: Alexander Stohr <AlexanderS@ati.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, arjanv@redhat.com, andersg@0x63.nu
Date: Mon, 25 Mar 2002 00:36:00 +0100
Subject: Re: [PATCH] devexit fixes in i82092.c
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought Linux is an OS of choices.
Calling folks for removing an opition
is not really what i do think is good.

There might be still situations where
it makes sense stripping of the exit
codings of the kernel.

Namely i would classify diskless embedded
systems (like consumer devices), that are 
allowed to shut down instantly by just
powering them off, to be such cases.

It would make life much easier for people
that do program for such targets if the
already existing optional macros would
stay in the source as they are now.

> On Sat, 16 Mar 2002, Anders Gustafsson wrote:
> >
> > this patch fixes "undefined reference to `local symbols in discarded
> > section .text.exit'" linking error.
> 
> Looking more at this, I actually think that the _real_ fix is to call all
> drivers exit functions at kernel shutdown, and not discard the exit
> section when linking into the tree.
> 
> That, together with the device tree, automatically gives us the
> _correct_ shutdown sequence, soemthing we don't have right now.
> 
> Anybody willing to look into this, and get rid of that __devexit_p()
> thing?
> 
>                 Linus

