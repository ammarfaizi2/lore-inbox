Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWEaTYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWEaTYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWEaTYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:24:17 -0400
Received: from witte.sonytel.be ([80.88.33.193]:29911 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965113AbWEaTYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:24:17 -0400
Date: Wed, 31 May 2006 21:24:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Ondrej Zajicek <santiago@mail.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <447CD367.5050606@gmail.com>
Message-ID: <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
 <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
 <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
 <20060530223513.GA32267@localhost.localdomain> <447CD367.5050606@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Antonino A. Daplas wrote:
> Ondrej Zajicek wrote:
> > On Tue, May 30, 2006 at 10:40:20AM -0700, David Lang wrote:
> >> as a long time linux user I tend to not to use the framebuffer, but 
> >> instead use the standard vga text drivers (with X and sometimes dri/drm).
> >>
> >> in part this dates back to my early experiances with the framebuffer code 
> >> when it was first introduced, but I still find that the framebuffer is not 
> >> as nice to use as the simpler direct access for text modes. and when I 
> >> start X up it doesn't need a framebuffer, so why suffer with the 
> >> performance hit of the framebuffer?
> > 
> > Many users want to use text mode for console. But this request is not
> > in contradiction with fbdev and fbcon. It just requires to do some work:
> > 
> > 1) To extend fbcon to be able to handle framebuffer in text mode.
> 
> And it can be done.  The matrox driver in 2.4 can do just that.  For 2.6,
> we have tileblitting which is a drawing method that can handle pure text.
> None of the drivers use this, but vgacon can be trivially written as a
> framebuffer driver that uses tileblitting (instead of the default bitblit).
> 
> I believe that there was a vgafb driver before that does exactly what you
> want.

Indeed. Early 2.1.x had a vgafb and an fbcon-vga, before vgacon existed in its
current form.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
