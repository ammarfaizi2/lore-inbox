Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRCaELq>; Fri, 30 Mar 2001 23:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132194AbRCaELg>; Fri, 30 Mar 2001 23:11:36 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:27614 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132186AbRCaELU>; Fri, 30 Mar 2001 23:11:20 -0500
Date: Fri, 30 Mar 2001 20:11:39 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0103301959010.743-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I took to using X, with a single screen size xterm to present the
>illusion of console mode.

Cute trick. I have seen some slow text mode cards. As time goes on it will
get worst since text mode support is not the prime goal anymore. Especially
now that you see graphical BIOS interfaces. Some graphics cards manufactures
have dropped vga text mode support all together. In the next 5 years you
will see the elimination of vga text mode.

>Probably the lack of hardware area copies has something to do with
>this.

Yes this is problem. See my response to Paul about this. The only reason
I'm using MMX for the vesa framebuffer because it has no acceleration. MMX
gives a big boost for genuine intel chips. Other types of MMX are fast but
they don't seemed to be optimized for memory transfers like MMX on intel
chips. I also have regular code that does all kinds of tricks to optimize
data transfers over the bus. It needs more testing but from my comparison
between my voodoo 3 accel engine and this code it ran nearly as fast as
the accelerator at all depths :-)

Another idea for 2.5.X is to implement a font cache in video memory. Even
with AGP it is just to slow to constantly transfer font data over the bus.
Of course this requires a bit of work since we only have so much video
memory but it is worth it for the performance improvement.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

