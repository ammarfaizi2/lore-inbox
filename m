Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTBFJLj>; Thu, 6 Feb 2003 04:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTBFJLj>; Thu, 6 Feb 2003 04:11:39 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:60058 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265791AbTBFJLi>;
	Thu, 6 Feb 2003 04:11:38 -0500
Date: Thu, 6 Feb 2003 10:19:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
In-Reply-To: <1044428068.1170.10.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0302061017330.3301-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2003, Antonino Daplas wrote:
> On Wed, 2003-02-05 at 20:37, Geert Uytterhoeven wrote:
> > Come on, is there really no one to comment on this??
> 
> Actually, I tried the patch before, but it was erased so fast that I
> never got to see the logo :-)
> 
> Anyway, I think it's because logo_lines require logo_height in
> fbcon_set_display().  logo_height is returned by fb_show_logo(), however
> fb_show_logo() is called after computing logo_lines.

I always see the logo twice. The first time it's erased by the text (because
initially fbcon thinks logo_height = 0), the second time it's displayed
correctly.

So I also wondered why it's drawn twice?

> So, how about breaking up fb_show_logo() into fb_prepare_logo() and
> fb_show_logo()?  We can call fb_prepare_logo() to get the logo height
> for the logo_lines, then do an fb_show_logo() for the actual drawing.

OK for me.

> Overall, I like it, though it does add some kilobytes to the kernel
> image size.

Why would it increase kernel size that much? The logos were there before as
well (unless you enable all of them, of course :-).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

