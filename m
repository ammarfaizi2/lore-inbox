Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUKVJwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUKVJwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUKVJwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:52:22 -0500
Received: from witte.sonytel.be ([80.88.33.193]:61918 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262010AbUKVJvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:51:15 -0500
Date: Mon, 22 Nov 2004 10:43:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [2.6 patch] drivers/video/: misc cleanups
In-Reply-To: <200411221055.07693.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.61.0411221043040.7323@waterleaf.sonytel.be>
References: <20041121153702.GB2829@stusta.de> <20041121155811.GA2961@stusta.de>
 <200411221055.07693.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Antonino A. Daplas wrote:
> On Sunday 21 November 2004 23:58, Adrian Bunk wrote:
> > On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:
> > > The patch below does the following cleanups under drivers/video/ :
> > > - make some needlessly global code static
> > > - the following was needlessly EXPORT_SYMBOL'ed:
> > >   - fbcon.c: fb_con
> > >   - mdacon.c: fb_blank
> > >   - fbmon.c: get_EDID_from_firmware (completely unused)
> > >...
> >
> > I forgot one thing:
> >
> > Please review my global_mode_option removal in modedb.c .
> >
> > It was always NULL and I'd say the only usage was wrong (although it
> > had no practical effect).
> 
> Should be ok to remove it.  I only see fb_find_mode using it, and as
> you've concluded, usage is not very clear.
> 
> BTW: The global_mode_option, previously, is filled up when no driver is
> specified in the boot options, such as "video=1024x768@60".  But this was
> removed during the fb initialization cleanup.

What a pity... It allowed people to not have to care about the name of their
graphics driver(s)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
