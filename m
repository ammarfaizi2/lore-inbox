Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTBQK2s>; Mon, 17 Feb 2003 05:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTBQK2s>; Mon, 17 Feb 2003 05:28:48 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:20646 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266986AbTBQK2r>;
	Mon, 17 Feb 2003 05:28:47 -0500
Date: Mon, 17 Feb 2003 11:36:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nico Schottelius <schottelius@wdt.de>
cc: Torrey Hoffman <thoffman@arnor.net>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
In-Reply-To: <20030215153154.GB469@schottelius.org>
Message-ID: <Pine.GSO.4.21.0302171135100.16817-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Nico Schottelius wrote:
> I think if the patch and the features talked about are included in the
> kernel we'll have (names are not correct)
> 
> CONFIG_LOGO=y/n
> CONFIG_LOGO_XRES=128
> CONFIG_LOGO_YRES=64
> CONFIG_LOGO_BPP=8

The 3 above are stored in struct linux_logo.

> CONFIG_LOGO_PATH="" # (/usr/src/linux/.../logo/tux.pnm)
> CONFIG_LOGO_POS_X="left|center|right"  # or absolute ?
> CONFIG_LOGO_POS_Y="top|center|bottom"  # like X windows +110,+200 ?
> CONFIG_LOGO_BGCOL=#ef0000              # depends on bpp of framebuffer... 

I prefer to store the background color in struct linux_logo as well. And it
must be a palette index, not an RGB triplet, I think.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

