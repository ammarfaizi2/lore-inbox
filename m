Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbSLER32>; Thu, 5 Dec 2002 12:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbSLER31>; Thu, 5 Dec 2002 12:29:27 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:57618 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267362AbSLER2Z>; Thu, 5 Dec 2002 12:28:25 -0500
Date: Thu, 5 Dec 2002 17:35:56 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
In-Reply-To: <1039050178.1075.82.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212051732010.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If X is running  in native mode then it has to save the register state. 
> Otherwise you cannot switch to a console.  If X is running on top of
> fbdev, then state restore/saves are done using fb_set_var and
> fb_get_var.  The registers are not touched, that's the purpose of fbdev.
> 
> If you are running vgacon, fbdev, and native X, then yes, fbdev and X
> has to do a save of their initial state.

Not really. When X closes /dev/fb then fb_release is called which if the 
driver supports it will switch back to text mode. The exception is 
firmware based fbdev drivers like vesafb and offb.  

> > Does this also apply to vesafb ?
> Not too sure about this. vesa requires real-mode initialization.  Either
> you do this at boot time, or fake a real-mode environment like what X
> does.

X has to reset the vidoe hardware back to the state that matches what the 
VESA mode was. Other wise it will mess you your system.

P.S

    X on VESA fb always foobars my system when I exit X.


