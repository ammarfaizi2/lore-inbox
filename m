Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVCTT1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVCTT1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVCTT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:27:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35077 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261205AbVCTT0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:26:51 -0500
Date: Sun, 20 Mar 2005 20:26:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/mtrr/generic.c: make generic_get_mtrr static
Message-ID: <20050320192649.GQ4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
 

