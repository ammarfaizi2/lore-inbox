Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbSJOIde>; Tue, 15 Oct 2002 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbSJOIdd>; Tue, 15 Oct 2002 04:33:33 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:44475 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263293AbSJOIdd>;
	Tue, 15 Oct 2002 04:33:33 -0400
Date: Tue, 15 Oct 2002 10:38:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <Pine.LNX.4.33.0210140937040.4264-100000@maxwell.earthlink.net>
Message-ID: <Pine.GSO.4.21.0210151036400.25245-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, James Simmons wrote:
> > On Sun, 13 Oct 2002, James Simmons wrote:
> > > This is nearly the last of the fbdev api changes (90% of them). Alot of
> > > driver fixes as well. The console related stuff in each fbdev driver
> > > is nearly gone!!! Please do a pull. Thank you.
> > >
> > > bk://fbdev.bkbits.net/fbdev-2.5
> >
> > Please add the output of diffstat, so we know which files you changed.
> 
> Better yet here is the BK patch via email.
> @@ -220,12 +218,7 @@
>     bool '  Advanced low level driver options' CONFIG_FBCON_ADVANCED
>     if [ "$CONFIG_FBCON_ADVANCED" = "y" ]; then
>        tristate '    Monochrome support' CONFIG_FBCON_MFB

CONFIG_FBCON_MFB can be deleted, because of this change to the Makefile:

> -obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o

>  #      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16

FBCON_IPLAN2P16 can be deleted, since it doesn't exist.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

