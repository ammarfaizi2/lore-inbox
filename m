Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbTAQMXV>; Fri, 17 Jan 2003 07:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTAQMXV>; Fri, 17 Jan 2003 07:23:21 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:19340 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266020AbTAQMXT>;
	Fri, 17 Jan 2003 07:23:19 -0500
Date: Fri, 17 Jan 2003 13:28:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Anders Gustafsson <andersg@0x63.nu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
In-Reply-To: <Pine.LNX.4.44.0301162220160.19302-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.GSO.4.21.0301171326040.8910-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Kai Germaschewski wrote:
> On Fri, 17 Jan 2003, Anders Gustafsson wrote:
> > On Thu, Jan 16, 2003 at 10:12:23PM -0600, Kai Germaschewski wrote:
> > > > ./scripts/kconfig/mconf arch/i386/Kconfig
> > > > arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
> > > > make: *** [menuconfig] Error 1
> > > 
> > > 	bk -r get -q
> > > 
> > > or just
> > > 
> > > 	bk get drivers/eisa
> > > 
> > > in this case. I guess this is becoming a FAQ.
> > 
> > It would be cool if the the Makefile let make knew about these dependencies
> > so they would be checked out automagically.
> 
> Unfortunately, the Makefile doesn't really know about the Kconfig files, 
> the "source drivers/whatever/Kconfig" commands are in Kconfig, and 
> duplicating them into the Makefile would be rather error-prone.

What about learning `make depend' a bit Kconfig syntax?

> Even if that was done, the Makefiles also cannot know about e.g. headers 
> included into C files, so it'd die at that point. At some point I hacked a 
> LD_PRELOAD library which would try to exec a "get" when open(2) fails, 
> which fixes gcc, kconfig and whatnotsoever. I suppose a better solution is 
> "checkout: get", though.

Isn't all of this in .depend?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

