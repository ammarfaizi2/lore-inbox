Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTFUOmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTFUOmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:42:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59631 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264763AbTFUOmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:42:06 -0400
Date: Sat, 21 Jun 2003 16:56:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove useless statement from video/i810/i810_main.c
Message-ID: <20030621145603.GA23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An u8 is _never_ > 255.


--- linux-2.5.72-mm2/drivers/video/i810/i810_main.c.old	2003-06-21 16:52:32.000000000 +0200
+++ linux-2.5.72-mm2/drivers/video/i810/i810_main.c	2003-06-21 16:52:44.000000000 +0200
@@ -1075,8 +1075,6 @@
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u8 *mmio = par->mmio_start_virtual, temp;
 
-	if (regno > 255) return 1;
-
 	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
 		if ((info->var.green.length == 5 && regno > 31) ||
 		    (info->var.green.length == 6 && regno > 63))


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

