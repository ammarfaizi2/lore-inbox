Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUIJIKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUIJIKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUIJIKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:10:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5059 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266884AbUIJIJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:09:56 -0400
Date: Fri, 10 Sep 2004 10:07:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
In-Reply-To: <1094796002.14398.118.camel@gaston>
Message-ID: <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com>
 <1094796002.14398.118.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Benjamin Herrenschmidt wrote:
> I submited a patch moving offb to the bottom of the Makefile to at
> least restore normal drivers. For ofonly, a bit more hackish, but

Just in case they aren't, vesafb and vga16fb should also be at the bottom, cfr.
the old order in fbmem.c.

> what about failing register_framebuffer for anything but offb ?

Humm, indeed hackerish...

But the advantage of this is that we can finally exercise the failure path of
many frame buffer device drivers in the wild ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
