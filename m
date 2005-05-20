Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVETT1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVETT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:27:24 -0400
Received: from witte.sonytel.be ([80.88.33.193]:54204 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261550AbVETT1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:27:18 -0400
Date: Fri, 20 May 2005 21:26:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <Pine.LNX.4.61.0505201124230.5107@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0505202125440.18326@numbat.sonytel.be>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de> <Pine.LNX.4.61.0505201124230.5107@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Richard B. Johnson wrote:
> On Fri, 20 May 2005, Jan-Benedict Glaw wrote:
> > On Fri, 2005-05-20 09:48:35 -0400, Richard B. Johnson
> > <linux-os@analogic.com> wrote:
> > >     len = getpagesize();
> > >     if((fd = open("/dev/mem", O_RDWR)) == FAIL)
> > >         ERRORS("open");
> > >     if((sp = mmap((void *)SCREEN, len, PROT, TYPE, fd,
> > > SCREEN))==MAP_FAILED)
> > >         ERRORS("mmap");
> > 
> > Maybe you'd better not fiddle with physical memory, but use the device
> > abstraction that's ment to offer that interface? That is, use a
> > framebuffer driver and open /dev/fb* .

/dev/vcs*?

> No room for any more drivers. This just writes to a small LCD on an
> embedded controller. There should be no reason why I can't
> write directly to the physical memory. Anything written to the
> physical screen buffer will show up on the screen, as long
> as page zero is selected.
> 
> I think that I've discovered a bug. I know that what I have written gets
> to the screen buffer because I can read in back! This doesn't make
> any sense.

Even if it's only in the CPU cache, of course you can read it back (using the
CPU, not DMA ;-).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
