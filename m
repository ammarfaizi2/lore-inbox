Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSLWVKv>; Mon, 23 Dec 2002 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbSLWVKv>; Mon, 23 Dec 2002 16:10:51 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:50111 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266981AbSLWVKu>;
	Mon, 23 Dec 2002 16:10:50 -0500
Date: Mon, 23 Dec 2002 22:17:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: Russell King <rmk@arm.linux.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
In-Reply-To: <1040677903.21606.0.camel@rth.ninka.net>
Message-ID: <Pine.GSO.4.21.0212232217260.1694-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Dec 2002, David S. Miller wrote:
> On Mon, 2002-12-23 at 01:18, Geert Uytterhoeven wrote:
> > That's because originally there was no fix.line_length field, and the line
> > length was derived from var.xres_virtual and var.bits_per_pixel.
> > 
> > With some hardware, the line length must be a multiple of 32 or 64 bits, and we
> > needed a way to specify that, so fix.line_length was introduced. If it was
> > zero, user code should fallback to the old behavior.
> 
> And with some cards, the line length is constant.  Ie. to get to
> "X, Y + 1" for a given "X, Y" you add a constant to your current
> frame buffer pointer.
> 
> That is what fix.line_length is for right?

Yep.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

