Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVBBTkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVBBTkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVBBTjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:39:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14550 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262645AbVBBTfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:35:40 -0500
Date: Wed, 2 Feb 2005 19:35:35 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Haakon Riiser <haakon.riiser@fys.uio.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Accelerated frame buffer functions
In-Reply-To: <20050202174509.GA773@s>
Message-ID: <Pine.LNX.4.56.0502021932180.20184@pentafluge.infradead.org>
References: <20050202133108.GA2410@s> <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
 <20050202142155.GA2764@s> <1107357093.6191.53.camel@gonzales>
 <20050202154139.GA3267@s> <9e4733910502020825434a477@mail.gmail.com>
 <20050202174509.GA773@s>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > You should look at writing a DRM driver. DRM implements the kernel
> > interface to get 3D hardware running. It is a fully accelerated driver
> > interface. They are located in drivers/char/drm
> 
> Have the standard frame buffer drivers been abandoned, even
> for devices that have no 3D acceleration (like the Geode GX2)?

No. It is still around. 

> I took a quick look at the DRM stuff, and it looked like extreme
> overkill for what I need, if it even can be used for what I want
> to do.  At first glance it looked like this is only relevant for
> OpenGL/X11 3D-stuff, which I have absolutely no use for.

This is usually the case for embedded chips. This is the reason the fbdev 
userland interface is still around.

> GX2 is an integrated CPU/graphics chip for embedded systems.
> We have third party applications that use the framebuffer device,
> and I was hoping to make things faster by writing an accelerated
> driver.  The only thing I need answered is how to access fb_ops
> from userspace.  

You can mmap the mmio address space and program the registers yourself.
A bonus is the example code is in the driver :-) 

> If that is impossible because all the framebuffer
> code is leftover junk that no one uses anymore, or even /can/
> use anymore because the userspace interface is gone, please let
> me know now so I don't have to waste any more time.

The userspace interface is still there.

