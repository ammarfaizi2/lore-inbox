Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbUKARrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUKARrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUKARq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:46:59 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:56329 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S273473AbUKARc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:32:58 -0500
Date: Mon, 1 Nov 2004 17:32:04 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: adaplas@pol.net
cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
In-Reply-To: <200410300825.47096.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.10.10411011719270.2438-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thanks for the info Antonino. I see you spotted my typing error. Yes it is
the 2.6.10-rc1-bk6 kernel. The oter error is the 2.2.8.1. It should be
2.6.8.1.
 
The cgthree driver does not currently set up the all->info.var.red,
all->info.var.green or all->info.var.blue structures. Putting a value of 8
in the length field of these structures (correct for the cgthree) does get
me my logo back but I am still getting black on black text. It makes it
very difficult to read. It is begining to look like there is something
werid going on with the colour pallet stuf for PSEUDO_COLOUR.

Regards
	Mark Fortescue.

On Sat, 30 Oct 2004, Antonino A. Daplas wrote:

> On Saturday 30 October 2004 02:22, Mark Fortescue wrote:
> > Hi all,
> >
> > I have been trying to get a CG3 sparc clone up and running with linux.
> > Under 2.2.26, the console is fine. During the development of the
> > 2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
> > to track done one of the problems (the blanking code had some typing
> > errors in it) and this gave me a logo + black screen and cursor using a
> > linux-2.2.8.1 kernel. Still no console text.
> >
> > Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
> > appropriate patches and made some additional mods to keep the
> > compiler/linker happy. Now I have a black console, no text, logo or cursor
> > and if I redirect the console output to a serial port I get the following:
> 
> I'm assuming 2.6.10-rc1-bk6...
> 
> Make sure you correctly fill up the red, green, blue, and transp fields
> in all->info.var.  You can do it in sbufsfb_fill_var, or somewhere
> within cg3.c before the register_framebuffer() part.
> 
> As a reminder, info->var and info->fix must be valid prior to framebuffer
> registration.
> 
> Tony
> 
> 
> 
> 

