Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVG1Vmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVG1Vmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVG1VkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:40:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53929 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261531AbVG1Vjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:39:35 -0400
Date: Thu, 28 Jul 2005 23:39:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <9e47339105072813507c00687e@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> 
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> 
 <9e473391050728060741040424@mail.gmail.com>  <42E8F0CD.6070500@gmail.com> 
 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be> 
 <9e473391050728092936794718@mail.gmail.com>  <9e47339105072811183ac0f008@mail.gmail.com>
  <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be> 
 <9e4733910507281315419c3c12@mail.gmail.com>  <9e47339105072813213db7cee4@mail.gmail.com>
 <9e47339105072813507c00687e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Jon Smirl wrote:
> I've verified now that all ATI R300+ chips have 10bit cmaps. These are
> pretty common so I'd be in favor of making this into a binary
> attribute where I can get/set the whole table at once. Given that
> OpenGL is already supporting 12 and 16 bits these tables are only
> going to get much larger.
> 
> 1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text attribute.
> 
> 65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text attribute.
> 
> The bits_per_pixel sysfs attribute is an easy way to tell how many
> entries you need. You can just set it at 4, 8, 10, etc until you get
> an error. Now you know the max. 2^n and you know how many entries.

No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
