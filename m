Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753849AbWKHCCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWKHCCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbWKHCCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:02:00 -0500
Received: from witte.sonytel.be ([80.88.33.193]:52148 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1753849AbWKHCB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:01:59 -0500
Date: Wed, 8 Nov 2006 03:01:34 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: ajwade@alumni.uwaterloo.ca, Andrew Morton <akpm@osdl.org>,
       Kimball Murray <kimball.murray@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] 2.6.19-rc4-mm2
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
Message-ID: <Pine.LNX.4.62.0611080259340.28657@pademelon.sonytel.be>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Richardson, Charlotte wrote:
> If I can't repro it with this chip, if you want to mess around with it
> on yours, here's what I think we had to do... I believe the trick was
> to use 16bpp mode as far as what mode you write to the chip, and then
> double all the x coordinate values for things like offset, width, and
> pitch. You would have to do that to the accelerated routines also.

> > From: Andrew Wade [mailto:andrew.j.wade@gmail.com]
> > On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com>
> > wrote:
> > ...
> > > How much is each line offset when you have the garbled stuff? I
> mean,
> > > is it a couple pixels, half the total width, something else? And is
> > > it always the same for each line (or can you tell)?
> > 
> > Each ghost is 1/3 of a screen horizontally from the other ghosts. I've
> > been looking carefully at test patterns to figure out what is going
> on.

Since the ghosts are 1/3 of a screen apart and not 1/2...

If this is similar to the old Mach64, for 24-bit you have to use 8-bit mode and
multiply all horizontal values by _3_.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
