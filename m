Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWDLQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWDLQhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDLQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:37:13 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:8206 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932203AbWDLQhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:37:11 -0400
Date: Wed, 12 Apr 2006 18:37:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Antonino Daplas <adaplas@pol.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fb: Fix section mismatch in savagefb
Message-Id: <20060412183709.e319d204.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following section mismatch:

WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.data: from .text.savagefb_probe after 'savagefb_probe' (at offset 0x5e2)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/savage/savagefb_driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc1.orig/drivers/video/savage/savagefb_driver.c	2006-04-12 18:18:48.000000000 +0200
+++ linux-2.6.17-rc1/drivers/video/savage/savagefb_driver.c	2006-04-12 18:22:03.000000000 +0200
@@ -73,7 +73,7 @@
 /* --------------------------------------------------------------------- */
 
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 
 #ifdef MODULE
 

-- 
Jean Delvare
