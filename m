Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVG1NnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVG1NnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVG1NnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:43:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:38340 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261395AbVG1Nl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:41:56 -0400
Date: Thu, 28 Jul 2005 15:40:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <9e473391050728060741040424@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507281540210.24391@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> 
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728060741040424@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Jon Smirl wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> 
> There are a couple of ways to fix this. 
> 
> 1) Add a check to limit use of the sysfs attributes to 256 entries. If
> you want more you have to use /dev/fb0 and the ioctl. More is an
> uncommon case.
> 2) Switch this to a binary parameter. Now you have to use tools like
> hexdump instead of cat to work with the data. It was nice to be able
> to use cat to see the current map.
> 
> Does anyone have preferences for which way to fix it?

I prefer the first way.

> Thanks for catching the problems. I'm posting these patches to fbdev
> for review first so it is best to catch bugs there.

Sorry, sometimes I miss a few things...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
