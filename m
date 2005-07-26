Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVGZHOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVGZHOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVGZHOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:14:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22179 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261821AbVGZHOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:14:15 -0400
Date: Tue, 26 Jul 2005 09:13:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] add NULL short circuit to fb_dealloc_cmap()
In-Reply-To: <9e47339105071715322c558403@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507260912210.3470@numbat.sonytel.be>
References: <200507172043.41473.jesper.juhl@gmail.com> 
 <9e473391050717132233347d25@mail.gmail.com>  <Pine.LNX.4.62.0507172314000.4553@numbat.sonytel.be>
 <9e47339105071715322c558403@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Jon Smirl wrote:
> On 7/17/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > struct fb_super_cmap {
> > >    struct fb_cmap cmap;
> > >    __u16 red[255];
> > >    __u16 blue[255];
> > >    __u16 green[255];
> > >    __u16 transp[255];
> >                   ^^^
> > I assume you meant 256?
> > 
> > > }
> > >
> > > Then adjust the code as need. Have the embedded cmap struct point to
> > > the fields in the super_cmap and the drivers don't have to be changed.
> > 
> > What if your colormap has more than 256 entries?
> 
> I meant 256. Does any hardware exist that takes more that 256 entries? 

1024 was quite common on high-end graphics hardware.

> They are __u16 values but I have never seen hardware that take more
> that __u8 either.

10 bit was quite common on high-end graphics hardware.

IIRC, DEC TGA can do at least one of them.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
