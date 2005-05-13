Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVEMAr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVEMAr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVEMAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:47:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262202AbVEMArL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:11 -0400
Date: Fri, 13 May 2005 02:47:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] init/calibrate.c: make a function static
Message-ID: <20050513004708.GP3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 May 2005

--- linux-2.6.12-rc3-mm2-full/init/calibrate.c.old	2005-05-03 07:30:39.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/init/calibrate.c	2005-05-03 07:31:15.000000000 +0200
@@ -29,7 +29,7 @@
 #define DELAY_CALIBRATION_TICKS			((HZ < 100) ? 1 : (HZ/100))
 #define MAX_DIRECT_CALIBRATION_RETRIES		5
 
-unsigned long __devinit calibrate_delay_direct(void)
+static unsigned long __devinit calibrate_delay_direct(void)
 {
 	unsigned long pre_start, start, post_start;
 	unsigned long pre_end, end, post_end;
@@ -102,7 +102,7 @@
 	return 0;
 }
 #else
-unsigned long __devinit calibrate_delay_direct(void) {return 0;}
+static unsigned long __devinit calibrate_delay_direct(void) {return 0;}
 #endif
 
 /*

