Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319129AbSHMSoU>; Tue, 13 Aug 2002 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319130AbSHMSoT>; Tue, 13 Aug 2002 14:44:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:27070 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S319129AbSHMSoT>; Tue, 13 Aug 2002 14:44:19 -0400
Date: Tue, 13 Aug 2002 13:48:06 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Peter Samuelson <peter@cadcamlab.org>
cc: Greg Banks <gnb@alphalink.com.au>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <20020813155330.GG761@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208131344140.6035-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Peter Samuelson wrote:

> CONFIG_PROC_FS is needed by ISDN hysdn.  That's actually in my opinion
> more of a "general kernel facility" than a filesystem.  Eh?

Well, the use in hysdn can (and should) die, possibly by adding an
#ifndef CONFIG_PROC_FS
#error This driver won't work without procfs
#endif
until fixed properly.

> Then again it could be said that requiring CONFIG_PROC_FS is actually
> a design bug in hysdn - does the driver *really* need CONFIG_PROC_FS?
> Everything else in the kernel seems to cope without it.  Granted,
> non-/proc kernels are not widely tested....  Kai?

I don't know, I suspect it needs it for something like firmware loading or 
so. But since that's obviously an abuse of /proc, it's okay to have it 
break IMO.

> CONFIG_ISDN_CAPI - interestingly, CONFIG_HYSDN_CAPI, which is under
> the menu "Old ISDN4Linux (obsolete)" seems to require CAPI 2.0.  I
> suppose the CAPI stuff should come first in drivers/isdn/Config.in.
> Kai?

Yes. I'll look into that and fix it properly - I think just exchanging 
probably gives the same kind of problem for CONFIG_ISDN ;(

--Kai


