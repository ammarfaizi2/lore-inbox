Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUBXIb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUBXIb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:31:26 -0500
Received: from witte.sonytel.be ([80.88.33.193]:9914 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261613AbUBXIbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:31:15 -0500
Date: Tue, 24 Feb 2004 09:31:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FrameMasterII fbdev updates.
In-Reply-To: <Pine.LNX.4.44.0402232214520.11599-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.58.0402240930080.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402232214520.11599-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, James Simmons wrote:
> > On Wed, 18 Feb 2004, James Simmons wrote:
> > >   Can you test this patch. It is a port of the driver to use sysfs.
>
> Merged your patch with mine. Here is the latest patch. Please test. The
> patch is against linus tree. Thank you.
>
>
> --- fbdev-2.6/drivers/video/fm2fb.c	2004-02-22 20:18:18.000000000 -0800
> +++ linus-2.6/drivers/video/fm2fb.c	2004-02-18 20:59:07.000000000 -0800

Woops, wrong direction :-)

You missed these two:
  - Fix indentation
  - Kill space at end of line

--- linux/drivers/video/fm2fb.c.orig	2004-02-24 09:28:59.000000000 +0100
+++ linux/drivers/video/fm2fb.c	2004-02-23 20:48:50.000000000 +0100
@@ -211,7 +211,7 @@
      */

 static int __devinit fm2fb_probe(struct zorro_dev *z,
-				const struct zorro_device_id *id);
+				 const struct zorro_device_id *id);

 static struct zorro_device_id fm2fb_devices[] __devinitdata = {
 	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
@@ -226,7 +226,7 @@
 };

 static int __devinit fm2fb_probe(struct zorro_dev *z,
-				const struct zorro_device_id *id)
+				 const struct zorro_device_id *id)
 {
 	struct fb_info *info;
 	unsigned long *ptr;
@@ -238,7 +238,7 @@
 	if (!zorro_request_device(z,"fm2fb"))
 		return -ENXIO;

-	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
+	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
 	if (!info) {
 		zorro_release_device(z);
 		return -ENOMEM;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
