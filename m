Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUH3IxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUH3IxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUH3IxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:53:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:21188 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267497AbUH3IxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:53:21 -0400
Date: Mon, 30 Aug 2004 10:53:16 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
In-Reply-To: <20040829121153.GA30301@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0408301049330.3353@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0408221129590.25793@anakin>
 <Pine.LNX.4.58.0408221145090.25793@anakin> <20040822101914.GA7480@skeeve>
 <Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0408221333460.13834@anakin> <4128C3F4.6070507@linux-m68k.org>
 <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
 <20040826195643.GI9539@mars.ravnborg.org> <Pine.GSO.4.58.0408291324020.10903@teasel.sonytel.be>
 <20040829121153.GA30301@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004, Sam Ravnborg wrote:
> On Sun, Aug 29, 2004 at 01:38:02PM +0200, Geert Uytterhoeven wrote:
> > Conclusions: gcc 2.95.2 and binutils 2.9.5 are fine for compiling 2.6.x kernels
> > for m68k, but:
> >   - You need a newer binutils for building initramfs (make usr/)
> >   - You need a newer binutils for building modular kernels with
> >     CONFIG_MODVERSIONS=y
>
> Is this something you can make a check for in arch/m68k/Makefile?
> Just so others don't hit the same trap..

Probably. But please note that the first item doesn't need an explicit check,
since as will just error out when not recognizing the .incbin keyword.

About the second item, I don't know whether there are binutils versions that
have the ld bug, but do implement .incbin in as. If these don't exist, no such
test is necessary.

So it's just the people (like me :-) who work around installing a new version
of binutils that got hit...

The reason I'm still using gcc 2.95.2 is that 3.2 gives ICEs on some source
files.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
