Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264775AbSJVRJT>; Tue, 22 Oct 2002 13:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264776AbSJVRJT>; Tue, 22 Oct 2002 13:09:19 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:18123 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264775AbSJVRJT>;
	Tue, 22 Oct 2002 13:09:19 -0400
Date: Tue, 22 Oct 2002 19:13:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [BK PATCHS] fbdev updates.
In-Reply-To: <20021018223708.C15827@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0210221912430.8374-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Russell King wrote:
> On Fri, Oct 18, 2002 at 02:24:48PM -0700, James Simmons wrote:
> > Your right. That is a bug from the old fbgen code. Since few driver used
> > the old fbgen code it never appeared. I suggest we remove can_soft_blank
> > and just test to see if the function pointer exist for fb_blank. If it
> > doesn't then we can resort to other tricks in suggested in the ther email.
> 
> Ok.  What about the case where you're running in true colour / static
> pseudo colour, and can't blank the palette, but do have a fb_blank
> method to handle the direct colour / pseudo colour case?

That's what the return value of the fb_blank() function is for: to indicate
whether it handled the blanking or not. If not, the upper layer has to take
care of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

