Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265795AbSKAW3Y>; Fri, 1 Nov 2002 17:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265796AbSKAW3X>; Fri, 1 Nov 2002 17:29:23 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:14243 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265795AbSKAW3W>; Fri, 1 Nov 2002 17:29:22 -0500
Date: Fri, 1 Nov 2002 15:29:04 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
In-Reply-To: <1036178902.572.33.camel@daplas>
Message-ID: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James,
>
> I tried the patch, and it does produce a cleaner and smaller driver.
> Overall, I like it. Some observations:
>
> 1. Without the fb_set_var() hook, switching from X messes up the
> console.  I would guess this will be addressed by the console?

fbcon_switch has to be rewritten. I'm going threw the process of cleaning
up the upper fbcon layer. Its such a mess. Yuck!!!

> 2. Console panning/wrapping does not work.  updatevar includes a check
> "if (con == info->currcon)", and my guess is info->currcon is obsoleted
> so the check always fails.

It worked before. Strange. Do you mean for you console panning doesn't
work on the visiable VC or a non visible VC?

> 3. fbdev can be loaded without taking over the console.  After running
> an fb-based application, exiting fbdev messes up the vga console
> (actually hangs the system).  Should the fbdev driver provide the
> capability to restore the VGA state then, ie at info->fb_release?

Yes!!! Of course there is the issue is the framebuffer that actual one
used for vgacon or is it independent, thinking multihead here.

> 4. The initial font loaded is 8x8. It seems that 8x16 fonts are limited
> for the SGI console console only.  Any reason why?

I have no idea why that is. You can select a differnt font.

> 5.  The cfb_* drawing functions still behave erratically, especially in
> emacs.  Geert has made some versions that work correctly for me.  This
> was discussed in a thread sometimes ago.

Where are the patchs. I like to incorporate them into BK.

> Attached is a diff that will allow the logo to be drawn at 8-bpp
> pseudocolor:

Applied.

