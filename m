Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVBSAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVBSAEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVBSAEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:04:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33043 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261587AbVBSADl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:03:41 -0500
Date: Sat, 19 Feb 2005 01:03:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/sb1000.c: make some variables static
Message-ID: <20050219000339.GI4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/sb1000.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/sb1000.c.old	2005-02-16 18:17:09.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/sb1000.c	2005-02-16 18:18:02.000000000 +0100
@@ -57,9 +57,9 @@
 #include <asm/uaccess.h>
 
 #ifdef SB1000_DEBUG
-int sb1000_debug = SB1000_DEBUG;
+static int sb1000_debug = SB1000_DEBUG;
 #else
-int sb1000_debug = 1;
+static int sb1000_debug = 1;
 #endif
 
 static const int SB1000_IO_EXTENT = 8;
@@ -247,12 +247,12 @@
 	.remove		= sb1000_remove_one,
 };
 
-
+
 /*
  * SB1000 hardware routines to be used during open/configuration phases
  */
 
-const int TimeOutJiffies = (875 * HZ) / 100;
+static const int TimeOutJiffies = (875 * HZ) / 100;
 
 static inline void nicedelay(unsigned long usecs)
 {
@@ -359,11 +359,11 @@
 	return 0;
 }
 
-
+
 /*
  * SB1000 hardware routines to be used during frame rx interrupt
  */
-const int Sb1000TimeOutJiffies = 7 * HZ;
+static const int Sb1000TimeOutJiffies = 7 * HZ;
 
 /* Card Wait For Ready (to be used during frame rx) */
 static inline int

