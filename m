Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155388AbQEQCa1>; Tue, 16 May 2000 22:30:27 -0400
Received: by vger.rutgers.edu id <S155477AbQEQCaH>; Tue, 16 May 2000 22:30:07 -0400
Received: from xena.acsu.buffalo.edu ([128.205.7.121]:32858 "HELO xena.acsu.buffalo.edu") by vger.rutgers.edu with SMTP id <S155491AbQEQC3t>; Tue, 16 May 2000 22:29:49 -0400
Date: Tue, 16 May 2000 22:48:27 -0400 (EDT)
From: James Simmons <jsimmons@acsu.buffalo.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>, Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] updated Mips Magnum frame buffer device
In-Reply-To: <Pine.LNX.4.05.10005162223490.17982-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10005162241050.3106-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Tue, 16 May 2000, Geert Uytterhoeven wrote:

> On Tue, 16 May 2000, James Simmons wrote:
> > Yet another frame buffer driver updated to the new API. I don't know 
> > the author's email address. Please test since I lack this hardware. It
> > does compile. 
> 
> Forwarded to tsbogend@alpha.franken.de (see CREDITS :-), who's probably busy
> with the PA-RISC port.
> 
> BTW, drivers that conform to the new API can have fb_ops->fb_get_{var,fix,cmap}
> == NULL as well, if fbmem.c takes care of that.

Once all the drivers conform we can remove those functions from fb_ops.
The ultimate goal being fbgen is really intergrated into fbdev. It will
make life much easier for driver writers. I will wipe up a patch for
pan_display tomorrow for detecting xxfb_pan_display and allowing drivers
that lack support for it to have it set to NULL. 

Q: Why did they deprecate a.out support in linux?
A: Because a nasty coff is bad for your elf.

James Simmons  [jsimmons@linux-fbdev.org]               ____/| 
fbdev/gfx developer                                     \ o.O| 
http://www.linux-fbdev.org                               =(_)= 
http://linuxgfx.sourceforge.net                            U


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
