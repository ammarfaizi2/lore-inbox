Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272310AbTHKGaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272322AbTHKGaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:30:12 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:6904 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272310AbTHKGaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:30:07 -0400
Subject: Re: Linux 2.6.0-test3: logo patch
From: Martin Schlemmer <azarah@gentoo.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Thomas Molina <tmolina@cablespeed.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030809163812.A22875@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
	 <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
	 <20030809163812.A22875@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1060583076.13256.13.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 08:24:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 17:38, Russell King wrote:
> On Sat, Aug 09, 2003 at 11:00:57AM -0500, Thomas Molina wrote:
> > The following patch has been floating around forever.  Can we get it in 
> > mainstream sometime in the near future?
> > 
> > --- linux-2.5-tm/drivers/video/cfbimgblt.c.orig	2003-08-08 17:42:16.000000000 -0500
> > +++ linux-2.5-tm/drivers/video/cfbimgblt.c	2003-08-08 17:42:30.000000000 -0500
> > @@ -325,7 +325,7 @@
> >  		else 
> >  			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
> >  					start_index, pitch_index);
> > -	} else if (image->depth == bpp) 
> > +	} else if (image->depth <= bpp) 
> >  		color_imageblit(image, p, dst1, start_index, pitch_index);
> >  }
> >  
> 
> Is this patch _still_ not in the kernel.
> 
> Linus - please merge this patch - its required for several ARM framebuffer
> drivers, and several other drivers.  James has indicated that this is the
> correct fix back in May:
> 

Right, this fixes the 'no logo' issue - anybody have any idea why
I now have two logo's ? :)

If need be, I can give dmesg/etc/etc, but not at home right now.

> On Tue, May 13, 2003 at 11:41:34PM +0100, James Simmons wrote:
> > At the very bottom of cfbimgblt.c change
> >
> > } else if (image->depth == bpp)
> >
> > to
> >
> > } else if (image->depth <= bpp)
> >
> > and tell me if this works.
-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

