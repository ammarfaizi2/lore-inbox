Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbTC1Ehn>; Thu, 27 Mar 2003 23:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbTC1Ehn>; Thu, 27 Mar 2003 23:37:43 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:50704 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262194AbTC1Ehm>; Thu, 27 Mar 2003 23:37:42 -0500
Date: Fri, 28 Mar 2003 04:48:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
In-Reply-To: <1048798158.1035.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > > 
> > > Yes, fb_logo.depth == info->var.bits_per_pixel.
> > 
> > Euh, now I get confused... Do you mean
> > `Yes, it should be replaced by info->var.bits_per_pixel' or
> > `No, logo.depth is always equal to info->var.bits_per_pixel'?
> 
> :)  Sorry about that. I meant:
> 
> 
> `No, fb_logo.depth is always equal to info->var.bits_per_pixel'

No this is no longer true. For example last night I displayed the 16 color 
logo perfectly fine on a 16 bpp display!!!! The mono display still has 
bugs tho. The new logo tries to pick the best image to display. Say for 
example we have two video cards. One running VESA fbdev at 16 bpp and a 
another at vga 4 planar via vga16fb. This way we can have the both the 16 
color and 224 color logo compiled in.  The correct logo will be displayed 
then on the correct display. Now say we only have a mono display but all 
the cards support 8 bpp or better. That logo still gets displayed.

