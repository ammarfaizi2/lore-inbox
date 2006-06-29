Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWF2TVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWF2TVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWF2TVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:21:40 -0400
Received: from [141.84.69.5] ([141.84.69.5]:30736 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932286AbWF2TVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:21:33 -0400
Date: Thu, 29 Jun 2006 21:20:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: spyro@f2s.com, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] show Acorn-specific block devices menu only when required
Message-ID: <20060629192041.GU19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't show a menu that can't be entered due to lack of contents on arm
(the options are only available on arm26).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2006

--- linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig.old	2006-04-17 16:40:13.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig	2006-04-17 16:40:50.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Acorn-specific block devices"
-	depends on ARCH_ACORN
+	depends on ARCH_ARC || ARCH_A5K
 
 config BLK_DEV_FD1772
 	tristate "Old Archimedes floppy (1772) support"

