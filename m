Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRHSLAg>; Sun, 19 Aug 2001 07:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270336AbRHSLA0>; Sun, 19 Aug 2001 07:00:26 -0400
Received: from aeon.tvd.be ([195.162.196.20]:16179 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S270333AbRHSLAO>;
	Sun, 19 Aug 2001 07:00:14 -0400
Date: Sun, 19 Aug 2001 12:55:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Adam J. Richter" <adam@ns1.yggdrasil.com>
cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mj@ucw.cz
Subject: Re: [Linux-fbdev-devel] Patch, please TEST: linux-2.4.9 console font
 modularization
In-Reply-To: <200108191028.DAA01752@ns1.yggdrasil.com>
Message-ID: <Pine.LNX.4.05.10108191252190.16179-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Adam J. Richter wrote:
> >What's wrong with the ancient console ioctl()s to change the font at runtine?
> >(damned, I can't remember the name of the command)
> 
> 	I don't know enough about fbdev vs. the old PC VGA console 
> to know whether those ioctl's are available for fbdev.

Yes, they should work, through the console->con_font_op() call.

> 	As far as I'm concerned, loading fonts by user level programs
> would be even better than by loading modules, although, I think that,
> when trying to move a facility from kernel to userland, people are a
> lot more willing to try that change if the kernel-based way is still
> available, but normally just compiled as modules that people gradually
> stop using.

Yes, and the user-land support is even older than the kernel support, except
for the one builtin font that fbdev requires (on VGA text the font is in the
VGA BIOS ROM).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

