Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbRCGRQE>; Wed, 7 Mar 2001 12:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbRCGRP4>; Wed, 7 Mar 2001 12:15:56 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:37049 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130449AbRCGRPr>; Wed, 7 Mar 2001 12:15:47 -0500
Date: Wed, 7 Mar 2001 01:16:50 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Cort Dougan <cort@fsmlabs.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <Pine.LNX.4.31.0103070112460.1335-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>} The fbdev console problem is too horrible to pretend to solve by resyncing
>} on timer interrupts. At least for the x86 the fix is to sort out the fb
>} locking properly
>
>How close is that?

Working on it. I have done alot of cleanup to the fbdev layer. I have
moved to a xxxfb_fillrect, xxxfb_copyarea, xxxfb_imageblit to handle all
the console functions. I have written really fast software versions of
these functions for cards that lack this functionality. A exmaple. My
software fillrect function is nearly as fast as the Voodoo 3 at 1024x768
at 32 bpp. You can think of my functions as really fast or the accelerator
really slow.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

