Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbTAGVff>; Tue, 7 Jan 2003 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTAGVff>; Tue, 7 Jan 2003 16:35:35 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:16132 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266478AbTAGVfe>; Tue, 7 Jan 2003 16:35:34 -0500
Date: Tue, 7 Jan 2003 21:43:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <1041717978.1052.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301072139130.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Personally, that's fine by me since I have no need for those 2
> extensions.  But please apply the accel_putcs() buffer overrun patch.

Applied. 

> BTW, attached is another patch that will change the resolution of the
> console via tty ioctl TIOCSWINSZ.  I'm not sure if this is the correct
> solution, but it's the only one I can think of without really adding a
> lot of extra code.  This is implemented by adding a con_resize() hook to
> fbcon, so the window size can be changed such as by using:
>
> stty cols 128 rows 48 (1024x768 with font 8x16)

Yes this is the correct approach.
 
> The new window size should also be preserved per console.  Still, there
> are other fb parameters that can screw up the console (such as changing
> yres_virtual and bits_per_pixel) but the window size is the most
> important.

Updatevar in fbcon.c should handle yres_virtual properly. The scrolling 
code needs alot of work. It is a mess. Bits_per_pixel will be trickier to 
handle. 

