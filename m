Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTC0TWw>; Thu, 27 Mar 2003 14:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbTC0TWv>; Thu, 27 Mar 2003 14:22:51 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:54797 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S261352AbTC0TWv>; Thu, 27 Mar 2003 14:22:51 -0500
Subject: Re: [Linux-fbdev-devel] Much better framebuffer fixes.
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0303271016300.26358-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303271016300.26358-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048792147.1086.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Mar 2003 03:15:23 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:18, Geert Uytterhoeven wrote:
> On Thu, 27 Mar 2003, James Simmons wrote:
> >  drivers/video/logo/logo.c       |   69 +++++------
> 
> Are you sure the change from logo type to logo depth in (fb_)find_logo() won't
> have any side effects? After this change, you may receive a different type of
> logo than you requested.
> 


I agree.  Take the case of Directcolor. At 16-bpp, it needs
linux_logo_vga16, not linux_logo_clut224. Also, monochrome at 8bpp needs
linux_logo_mono, certainly not linux_logo_clut224.  There are obviously
other similar cases.

I think the original logo code in both logo.c and fbmem.c, though a bit
more confusing, provides better ways of choosing the correct logo.

Tony


