Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVGVVdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVGVVdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVGVVdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:33:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262191AbVGVVdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:33:47 -0400
Date: Fri, 22 Jul 2005 23:33:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ftape: fix warnings with -Wundef
Message-ID: <20050722213341.GS3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/include/linux/ftape.h.old	2005-07-22 18:17:18.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/linux/ftape.h	2005-07-22 18:17:41.000000000 +0200
@@ -165,7 +165,7 @@
 #  undef  CONFIG_FT_FDC_DMA
 #  define CONFIG_FT_FDC_DMA 2
 # endif
-#elif CONFIG_FT_ALT_FDC == 1  /* CONFIG_FT_MACH2 */
+#elif defined(CONFIG_FT_ALT_FDC)  /* CONFIG_FT_MACH2 */
 # if CONFIG_FT_FDC_BASE == 0
 #  undef  CONFIG_FT_FDC_BASE
 #  define CONFIG_FT_FDC_BASE 0x370

