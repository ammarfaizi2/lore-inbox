Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbUBXIci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbUBXIci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:32:38 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54458 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262243AbUBXIcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:32:31 -0500
Date: Tue, 24 Feb 2004 09:32:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Apollo framebuffer sysfs 
In-Reply-To: <Pine.LNX.4.44.0402232216120.11599-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.58.0402240931140.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402232216120.11599-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, James Simmons wrote:
> > Wow, the first platform_device on m68k ;-)
>
> :-)
>
> Merged with my patch. This patch is against linus tree. Please test.
>
>
> --- linus-2.6/drivers/video/dnfb.c	2004-02-18 20:59:07.000000000 -0800
> +++ fbdev-2.6/drivers/video/dnfb.c	2004-02-22 21:17:16.000000000 -0800

You missed these:
  - Kill space at end of line
  - Kill unneeded initialization

--- linux/drivers/video/dnfb.c.orig	2004-02-24 09:28:19.000000000 +0100
+++ linux/drivers/video/dnfb.c	2004-02-23 20:59:20.000000000 +0100
@@ -246,7 +246,7 @@
 		framebuffer_release(info);
 		return err;
 	}
-
+
 	err = register_framebuffer(info);
 	if (err < 0) {
 		fb_dealloc_cmap(&info->cmap);
@@ -275,7 +275,6 @@

 static struct platform_device dnfb_device = {
 	.name	= "dnfb",
-	.id	= 0,
 };

 int __init dnfb_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
