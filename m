Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTEBGLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 02:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTEBGKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 02:10:47 -0400
Received: from dp.samba.org ([66.70.73.150]:22947 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261849AbTEBGKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 02:10:19 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16050.3732.615164.697680@argo.ozlabs.ibm.com>
Date: Fri, 2 May 2003 16:22:12 +1000
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] fix mach64_gx.c
X-Mailer: VM 7.14 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is needed for drivers/video/aty/mach64_gx.c to compile
correctly.  Somehow a couple of the var_to_pll routines got the wrong
argument list.

Paul.

diff -urN linux-2.5/drivers/video/aty/mach64_gx.c pmac-2.5/drivers/video/aty/mach64_gx.c
--- linux-2.5/drivers/video/aty/mach64_gx.c	2003-04-21 10:27:15.000000000 +1000
+++ pmac-2.5/drivers/video/aty/mach64_gx.c	2003-04-23 22:10:54.000000000 +1000
@@ -494,7 +494,7 @@
      */
 
 static int aty_var_to_pll_1703(const struct fb_info *info, u32 vclk_per,
-			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+			       u8 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -610,7 +610,7 @@
      */
 
 static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
-			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+			       u8 bpp, union aty_pll *pll)
 {
 	u32 tempA, tempB, fOut, longMHz100, diff, preDiff;
 
