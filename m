Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132615AbRDCGZk>; Tue, 3 Apr 2001 02:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRDCGZb>; Tue, 3 Apr 2001 02:25:31 -0400
Received: from aeon.tvd.be ([195.162.196.20]:13162 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S132613AbRDCGZY>;
	Tue, 3 Apr 2001 02:25:24 -0400
Date: Tue, 3 Apr 2001 08:23:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@linux-fbdev.org>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <E14kD3w-0006qD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10104030822570.14623-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Alan Cox wrote:
> > Yes this is problem. See my response to Paul about this. The only reason
> > I'm using MMX for the vesa framebuffer because it has no acceleration. MMX
> > gives a big boost for genuine intel chips. Other types of MMX are fast but
> > they don't seemed to be optimized for memory transfers like MMX on intel
> > chips. I also have regular code that does all kinds of tricks to optimize
> 
> Then you are doing something badly wrong.
> 
> The MMX memcpy for CyrixIII and Athlon boxes is something like twice the
> speed of rep movs. On most pentium II/III boxes the fast paths for rep movs
> and for MMX are the same speed

As long as you are copying in real memory. So the PCI bus or the host bridge
implementation may be the actual limit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

