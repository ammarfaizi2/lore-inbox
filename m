Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUJaL65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUJaL65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJaL4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:56:23 -0500
Received: from witte.sonytel.be ([80.88.33.193]:20404 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261608AbUJaLzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:55:38 -0500
Date: Sun, 31 Oct 2004 12:44:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
In-Reply-To: <20041031030931.3d592bf2.akpm@osdl.org>
Message-ID: <Pine.GSO.4.61.0410311243040.21194@waterleaf.sonytel.be>
References: <200410311003.i9VA3UMN009557@anakin.of.borg> <4184BB09.8000107@pobox.com>
 <20041031021933.1eba86a6.akpm@osdl.org> <4184C16E.80705@pobox.com>
 <20041031024840.6eeee92d.akpm@osdl.org> <20041031105724.GA28012@havoc.gtf.org>
 <20041031030931.3d592bf2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > On Sun, Oct 31, 2004 at 02:48:40AM -0800, Andrew Morton wrote:
> >  > > -        void *va = dio_scodetoviraddr(scode);
> >  > > +	unsigned long pa = dio_scodetophysaddr(scode);
> >  > > +        unsigned long va = (pa + DIO_VIRADDRBASE);
> > 
> > 
> >  > That's because the stoopid driver is using spaces instead of tabs all over
> >  > the place.  It comes out visually OK once the patch is applied.  But it's a
> >  > useful reminder of how much dreck we have in the tree.

I did a big whitespace cleanup in arch/m68k a while ago, but I didn't dare to
touch drivers/...

> >  Did you see the above quoted patch chunk?  The patch is inconsistent
> >  with _itself_, adding 'pa' and 'va' with different idents (but when they
> >  should be at the same identation level).
> 
> Trust me ;)
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg

Yep, tabstops should be 1+n*8 (sometimes 2+n*8) instead of n*8 when looking at
patches :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
