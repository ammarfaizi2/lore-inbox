Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136898AbREJTKZ>; Thu, 10 May 2001 15:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136899AbREJTKP>; Thu, 10 May 2001 15:10:15 -0400
Received: from hood.tvd.be ([195.162.196.21]:4546 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S136898AbREJTKG>;
	Thu, 10 May 2001 15:10:06 -0400
Date: Thu, 10 May 2001 21:06:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fbdev logo (fwd)
Message-ID: <Pine.LNX.4.05.10105102106100.21744-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI...

---------- Forwarded message ----------
Date: Thu, 10 May 2001 21:01:41 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbdev logo

	Hi Linus,

This patch fixes a few bugs in the penguin logo code of the fbdev (frame buffer
device) subsystem:

  - Technical fixes:
      o The colors of the 16-color penguin logo are wrong. The logo looks like
        a psychedelic penguin holding a glass of beer (or LSD?). This is caused
	by a bug fix in the console subsystem that no longer allows us to use
	an old color palette hack. This problem is ca. 9 months old!
	Solution: replace the logo by a new one that uses colors from the
	standard console palette only.
      o Remove an obsolete #include.
      o Remove an obsolete logo file in drivers/char/sgi/ (it was removed from
        the Linux/MIPS CVS tree some months ago).
      o Use __HAVE_ARCH_LINUX_LOGO* defines to determine logo inclusion in the
        include files.
  
  - Political fixes:
      o There were still some penguins left carrying a glass of beer or wine.
        This problem is about 2 years old!

  - Aesthetical fixes:
      o Upgrade the logos to an anti-aliased variant with pleasant halo-effect.

Some of these fixes are already in Alan's tree. I'll make sure he gets a copy
of the patch relative to his tree, and will post this message to linux-kernel
(with a link to the patch).

You can find a table showing the old and new logos at my web page:

    http://home.tvd.be/cr26864/Linux/fbdev/logo.html

Thanks for applying this patch!

    [ patch removed, look at the web page ]

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

