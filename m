Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVCLRaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVCLRaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVCLRaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:30:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261879AbVCLRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:30:04 -0500
Date: Sat, 12 Mar 2005 18:30:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, adaplas@pol.net
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/video/intelfb/: fix a warning
Message-ID: <20050312173002.GG3814@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems I'm at least partially guilty for the following warning coming 
from Linus' tree:

<--  snip  -->

...
  CC [M]  drivers/video/intelfb/intelfbdrv.o
drivers/video/intelfb/intelfbdrv.h:31: warning: 'intelfb_setup' declared `static' but never defined
...

<--  snip  -->


The fix is simple.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/drivers/video/intelfb/intelfbdrv.h.old	2005-03-12 17:51:06.000000000 +0100
+++ linux-2.6.11-mm3-full/drivers/video/intelfb/intelfbdrv.h	2005-03-12 17:51:20.000000000 +0100
@@ -28,7 +28,6 @@
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-static int __init intelfb_setup(char *options);
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
 			 struct fb_var_screeninfo *var);

