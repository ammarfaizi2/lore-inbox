Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289928AbSAWRm3>; Wed, 23 Jan 2002 12:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289929AbSAWRmT>; Wed, 23 Jan 2002 12:42:19 -0500
Received: from mail.sonytel.be ([193.74.243.200]:40838 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S289928AbSAWRmH>;
	Wed, 23 Jan 2002 12:42:07 -0500
Date: Wed, 23 Jan 2002 18:41:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven <luther@dpt-info.u-strasbg.fr>
cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <20020123184002.A3858@dpt-info.u-strasbg.fr>
Message-ID: <Pine.GSO.4.21.0201231841010.26747-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Sven wrote:
> On Wed, Jan 23, 2002 at 06:34:03PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 23 Jan 2002, Sven wrote:
> > > Also, since when does the B_FREE or NODEV exists ? I did put the changes into
> > > a #ifdef kernel 2.5, and kept the -1 for kernels 2.4, but i guess i could
> > > remove this check altogether if the NODEV was present from the begining. And
> > 
> > IIRC, Marcelo added NODEV to 2.4.x in one of his latest releases, just to solve
> > this problem.
> > 
> > > what about 2.2 kernels ?
> > 
> > No idea. Ask Alan :-)
> 
> Ok, so the best thing would be to keep the #ifdef then.
> 
> or maybe i could try an :
> 
> #ifdef NODEV
> 	..node = NODEV
> #else
> 	..node = -1
> #endif
> 
> ?

Or even shorter (and cleaner, IMHO):

#ifndef NODEV
#define NODEV	-1
#endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

