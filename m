Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbSLER4z>; Thu, 5 Dec 2002 12:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267400AbSLER4z>; Thu, 5 Dec 2002 12:56:55 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:10446 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267399AbSLER4s>; Thu, 5 Dec 2002 12:56:48 -0500
Date: Thu, 5 Dec 2002 19:03:14 +0100
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Message-ID: <20021205180314.GA860@iliana>
References: <1039050178.1075.82.camel@localhost.localdomain> <Pine.LNX.4.44.0212051732010.31967-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212051732010.31967-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 05:35:56PM +0000, James Simmons wrote:
> 
> > If X is running  in native mode then it has to save the register state. 
> > Otherwise you cannot switch to a console.  If X is running on top of
> > fbdev, then state restore/saves are done using fb_set_var and
> > fb_get_var.  The registers are not touched, that's the purpose of fbdev.
> > 
> > If you are running vgacon, fbdev, and native X, then yes, fbdev and X
> > has to do a save of their initial state.
> 
> Not really. When X closes /dev/fb then fb_release is called which if the 

That supposes X is fbdev aware (either using the fbdev driver or the
UseFBDev option), right ? What if X knows nothing about fbdev, it will
try restoring stuff as if it was in text mode.

> driver supports it will switch back to text mode. The exception is 
> firmware based fbdev drivers like vesafb and offb.  
> 
> > > Does this also apply to vesafb ?
> > Not too sure about this. vesa requires real-mode initialization.  Either
> > you do this at boot time, or fake a real-mode environment like what X
> > does.
> 
> X has to reset the vidoe hardware back to the state that matches what the 
> VESA mode was. Other wise it will mess you your system.
> 
> P.S
> 
>     X on VESA fb always foobars my system when I exit X.

With which driver ? (i am happily running the vesa X driver on top of
vesafb without problems).

Friendly,

Sven Luther

