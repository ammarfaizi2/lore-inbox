Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUIIVwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUIIVwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIIVuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:50:17 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:52893 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267312AbUIIVeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:07 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/7] fbdev: fix logo drawing failure for vga16fb
Date: Fri, 10 Sep 2004 05:34:34 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.34919.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the logo failing to draw in vga16fb due to faulty boolean logic.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

  vga16fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c	2004-09-07 21:18:35.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c	2004-09-07 21:30:39.059300648 +0800
@@ -1306,7 +1306,7 @@ void vga16fb_imageblit(struct fb_info *i
 {
 	if (image->depth == 1)
 		vga_imageblit_expand(info, image);
-	else if (image->depth <= info->var.bits_per_pixel)
+	else
 		vga_imageblit_color(info, image);
 }
 


