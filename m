Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264221AbRFDMXu>; Mon, 4 Jun 2001 08:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264223AbRFDMXa>; Mon, 4 Jun 2001 08:23:30 -0400
Received: from aeon.tvd.be ([195.162.196.20]:50535 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S264221AbRFDMXU>;
	Mon, 4 Jun 2001 08:23:20 -0400
Date: Mon, 4 Jun 2001 14:20:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Melchior FRANZ <a8603365@unet.univie.ac.at>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        linux-fbdev@vuser.vu.union.edu, Hannu MALLAT <hmallat@cc.hut.fi>
Subject: Re: [linux-fbdev] PATCH: tdfxfb: bugfix & enable SUN12x22 font, 
 kernel 2.4.5
In-Reply-To: <200106041121.22749@pflug3.gphy.univie.ac.at>
Message-ID: <Pine.LNX.4.05.10106041418020.28576-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2001, Melchior FRANZ wrote:
> The attached patch fixes that bug and enables 8--12 bit wide fonts, thus
> disabling the "No support ..." messages. I haven't found an indication that

Does it work now for fonts with width 16? I'd expect so.

BTW, instead of using #ifdef __LITTLE_ENDIAN and swapping explicitly, it's
better to use the cpu_to_be* macros.

> there are any Voodoo3/Banshee cards for big endian machines. The bugfix implies
> that they never could have worked. (But if they have indeed, they would be
> broken after applying the patch. Could someone comment on this, please?)

Yes, people are using Voodoo3 boards on PPC. But they require(d) some patches,
IIRC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


