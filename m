Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSLBVIA>; Mon, 2 Dec 2002 16:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLBVH7>; Mon, 2 Dec 2002 16:07:59 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:36110 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265168AbSLBVH5>; Mon, 2 Dec 2002 16:07:57 -0500
Date: Mon, 2 Dec 2002 21:15:09 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: fix for fbcon Oops
In-Reply-To: <1038468191.1092.48.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212022112230.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This fixes fbcon oopsing at load time which is due to the fb_cursor's
> palette index entries being improperly updated.

Fixed.

> A new kind of 'emacs glitch'  appeared, though. This can be described as
> a block of text that is incompletely  copied, ie when "tabbing" a line
> of text.  This is present with all hardware I tested, soft accel and
> hardware accel, which indicates a problem in the higher layers (probably
> fbcon). vgacon works okay.  

Its is fbcon. If you play with the low level driver to draw things you 
noticed everything is okay. I have to track it down.
 
> Other changes:
> 
> 1. optimization of fbcon_accel_putcs()

Applied. If you look at my patch I attempted to make fbcon_pixmap dynamic 
instead of a static memeory area. It oops so I have that code commented 
out for now. Actually I applied it when the fix came out rigth away.

> 2. enabling logo displays at all packed pixel formats (as long as
> fb_imageblit is supported)

This didn't apply well. Only thing missing.

> 3. Various fbcon_accel_cursor() fixes which would have resulted in
> wrong cursor colors or an invisible cursor.

Applied. Worked now :-)


