Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUCQWEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUCQWD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:03:58 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:19987 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262108AbUCQWDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:03:54 -0500
Date: Wed, 17 Mar 2004 22:03:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
In-Reply-To: <MPG.1ac04509fe5b83d7989685@news.gmane.org>
Message-ID: <Pine.LNX.4.44.0403172149140.19415-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I tried vga=ask, and no VESA modes are detected.
> 
> Ok, I'm stupid. I tried vga=ask, told him to scan, still got no VESA 
> modes in the list, but thenand tried 318; it gave me 1024x768 (so did 
> 718 too, any reason why?). Can't get to 1600x1200, though (or at 
> least I don't know how.)

For some reason it never list the VESA modes with vga=ask. I just go by 
the does in Documentation/fb/vesafb.txt to set my mode. Let me look...

I need to add more info to the docs on what modes are supported. 
	1600x1200		
	---------
256	0x119	  0x145	
32K	0x11D	  0x146
64K	0x11E
16M		  0x14E

For lilo translate them to decimal number. I'm curious if the 14X numbers 
work.
 	
> Now that I can work with the VESA driver, I'm feeling much better, 
> but if I load the rivafb driver I *still* get the problem (I cannot 
> touch it, not even with fbset -i). Using 2.6.4;
> 
> Just for reference, these are the logs from vesafb, rivafb and lspci:

> >From rivafb:
> ===
> rivafb: nVidia device/chipset 10DE0112
> rivafb: On a laptop.  Assuming Digital Flat Panel
> rivafb: Detected CRTC controller 1 being used
> rivafb: RIVA MTRR set to ON
> rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 
> 32MB @ 0xE0000000) 
> ===
> 
> In this case, fbset -i returns (well, doesn't because the screen goes 
> black, but the computer is still fully functional):

That a bug I have to work. I have a newer driver but I need to run more 
test.


