Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVBMEER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVBMEER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 23:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVBMEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 23:04:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:44249 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261245AbVBMEEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 23:04:12 -0500
Subject: [PATCH] radeonfb: typos fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 15:03:55 +1100
Message-Id: <1108267435.6701.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The dynamic clock code in radeonfb comes almost as-is from X.org (where
it was contributed by ATI). It has a few typos (wrong register access
macros) that this patch fixes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2005-02-13 23:18:52.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2005-02-13 15:01:11.005138528 +1100
@@ -180,7 +180,7 @@
 		tmp = INPLL(pllMCLK_CNTL);
 		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
 			 MCLK_CNTL__FORCE_YCLKA);
-		OUTREG(pllMCLK_CNTL, tmp);
+		OUTPLL(pllMCLK_CNTL, tmp);
 		radeon_msleep(16);
 	}
 	/* Hrm... same shit, X doesn't do that but I have to */
@@ -404,7 +404,7 @@
 	    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) {
 		tmp = INPLL(pllPLL_PWRMGT_CNTL);
 		tmp |= PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE;
-		OUTREG(pllPLL_PWRMGT_CNTL, tmp);
+		OUTPLL(pllPLL_PWRMGT_CNTL, tmp);
 		radeon_msleep(15);
 	}
 



