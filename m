Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbSLFAqI>; Thu, 5 Dec 2002 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbSLFAqI>; Thu, 5 Dec 2002 19:46:08 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:56837 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267468AbSLFAqH>; Thu, 5 Dec 2002 19:46:07 -0500
Date: Fri, 6 Dec 2002 00:53:41 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
 module
In-Reply-To: <1039135574.1032.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212060051080.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > One thing I like to suggest. I like to move the vga code in fb.h to vga.h. 
> > Alot of fbdev devices don't have a VGA core. 
> > 
> > 
> 
> Only the structure definition of fb_vgastate is in fb.h.  For drivers
> without a vga core, they'll just won't link to it and it won't be
> compiled.  Plus, vga.h is not a common header (not located in
> include/asm or include/linux) and it contains a lot of declarations and
> definitions which are irrelevant to most drivers or are already
> duplicated.  This will be messier, I think.  

I like to move vga.h to include/video. And yes I like to clean it up. The 
reason is I like to implement the function in vga.h and some in vgastate 
into vgacon.c. It would be nice if vgacon could support different hardware 
states per VC instead of changing every virtual console for everything. 
The other dream is I like to see vgacon become firmware independent. 

> Maybe we can just enclose it in a macro, something like:
> 
> #ifdef FBDEV_HAS_VGACORE
> ...
> #endif
 
Yuck :-(

