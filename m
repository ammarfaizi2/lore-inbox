Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVEMAus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVEMAus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVEMAri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:47:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37131 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262203AbVEMArN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:13 -0400
Date: Fri, 13 May 2005 02:47:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/module.c: make a function static
Message-ID: <20050513004711.GQ3603@stusta.de>
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

--- linux-2.6.12-rc3-mm2-full/kernel/module.c.old	2005-05-03 07:45:42.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/module.c	2005-05-03 07:47:08.000000000 +0200
@@ -692,7 +692,7 @@
 	return 0;
 }
 
-int set_obsolete(const char *val, struct kernel_param *kp)
+static int set_obsolete(const char *val, struct kernel_param *kp)
 {
 	unsigned int min, max;
 	unsigned int size, maxsize;

