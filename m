Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUDZJKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUDZJKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDZJKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:10:21 -0400
Received: from witte.sonytel.be ([80.88.33.193]:6367 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262279AbUDZJKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:10:17 -0400
Date: Mon, 26 Apr 2004 11:10:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] vesafb and *fb
In-Reply-To: <1082906968.28039.7.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0404261109370.25122@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
 <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
 <1082906968.28039.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2004, Alan Cox wrote:
> On Sul, 2004-04-25 at 14:13, Geert Uytterhoeven wrote:
> > > >     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> > > > 	    printk(KERN_WARNING
> > > > 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> > > > 		    vesafb_fix.smem_start);
> > > > 	    /* We cannot make this fatal. Sometimes this comes from magic
> > > > 	       spaces our resource handlers simply don't know about */
>
> Various built-in video systems broke on that test because we didnt
> have resources for them so the resources couldnt be allocated. Probably
> if vesafb is enabled we should skip any primary video device (ie the one
> with VGA_EN at boot)

But vesafb is meant to be used as a fallback, if no chipset-specific driver is
found.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
