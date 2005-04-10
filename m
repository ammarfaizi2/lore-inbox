Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVDJUfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDJUfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVDJUfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:35:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26643 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261598AbVDJUfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:35:36 -0400
Date: Sun, 10 Apr 2005 22:35:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/mtrr/generic.c: make generic_get_mtrr static
Message-ID: <20050410203533.GI4204@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005
- 20 Mar 2005

--- linux-2.6.11-mm4-full/arch/i386/kernel/cpu/mtrr/generic.c.old	2005-03-20 19:43:46.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/kernel/cpu/mtrr/generic.c	2005-03-20 19:44:11.000000000 +0100
@@ -114,8 +114,8 @@
 	return -ENOSPC;
 }
 
-void generic_get_mtrr(unsigned int reg, unsigned long *base,
-		      unsigned int *size, mtrr_type * type)
+static void generic_get_mtrr(unsigned int reg, unsigned long *base,
+			     unsigned int *size, mtrr_type * type)
 {
 	unsigned int mask_lo, mask_hi, base_lo, base_hi;
 

