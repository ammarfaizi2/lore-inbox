Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVC0Od6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVC0Od6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVC0Od6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:33:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261675AbVC0Odz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:33:55 -0500
Date: Sun, 27 Mar 2005 16:33:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/mtrr/generic.c: make generic_get_mtrr static
Message-ID: <20050327143354.GC4285@stusta.de>
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
 

