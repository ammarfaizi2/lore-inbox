Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUCWR65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbUCWR65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:58:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:65034 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262752AbUCWR6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:58:50 -0500
Date: Tue, 23 Mar 2004 17:58:47 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jan De Luyck <lkml@kcore.org>
cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
In-Reply-To: <200403231211.09334.lkml@kcore.org>
Message-ID: <Pine.LNX.4.44.0403231722330.2419-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'll hold off forwarding this patch to Linus until after 2.6.5 is out,
> > so that gives everyone a few days in which to argue the name a bunch and
> > then send me a patch that changes it to the decided apon name (if it is
> > to be changed.)
> 
> - From a users point of view: if there are only to be framebuffer devices listed 
> in this class, why not call it just what it is: "Framebuffer" ? Naming it 
> after something it is only in a broad sense makes no sense to me. I'd be 
> looking in /sys/.../framebuffer instead of /sys/.../graphics or /display.
> 
> Display would be the EDID info of my screen (physical), and graphics... 
> well... I'd half expect something like capture cards to be there...
> 
> Just my 0.02EUR.

   Ug!!!! This is insane. Okay there is a few reason for why I called it 
graphics. The number one thing to straighten out is video vs graphics.
There is a big difference between the two. Video cards are meant to 
decode or/and encode program or transport streams. Usually that is 
mpeg streams. This is what I do for a living. Graphics cards are meant 
to display raster or vector graphics objects. It just today alot of
hardware are both so the terms have become mixed up. On the hardware 
boards we have at work the video and graphics chip are physically 
seperate chips. 
   Now for the issue of display, framebuffer, or graphics. A framebuffer
is a chunk of memory that is used to create what is displayed. Now that
the fbdev layer has moved to a accelerated framework it is possible to use
non framebuffer devices for fbcon. So it doesn't make sense to call it 
that. The name graphics covers the idea best. Especially since fbcon is
meant for "graphical" consoles. As for display. That is just apart of 
that. I plan to create a display directory in /sys/graphics so we can 
get monitor data. 
   So lets leave the patch with name graphics alone.


