Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUDWXbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUDWXbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUDWXbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:31:50 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:15876 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261718AbUDWXbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:31:47 -0400
Date: Sat, 24 Apr 2004 00:31:45 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] vesafb and *fb
In-Reply-To: <Pine.GSO.4.58.0404210949590.7657@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know why it is that way. I would think it should fail at this 
point. Anyone know why this is?


> Yesterday I noticed on a box at work that if you compile in both vesafb and
> atyfb (the box has an ATI 3D RAGE PRO), you get both fb0 (atyfb) and fb1
> (vesafb). That's not supposed to happen.
> 
> Vesafb did print that the frame buffer was already in use, but it just
> continued, cfr. this code:
> 
>     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> 	    printk(KERN_WARNING
> 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> 		    vesafb_fix.smem_start);
> 	    /* We cannot make this fatal. Sometimes this comes from magic
> 	       spaces our resource handlers simply don't know about */
>     }
> 
> That was on plain 2.6.5. But to my surprise the latest 2.4 behaves the same.
> This seems to have been changed in 2.4.15.
> Does anyone know why this was changed?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

