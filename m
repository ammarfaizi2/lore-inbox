Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUEMVqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUEMVqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUEMVqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:46:10 -0400
Received: from [64.62.253.241] ([64.62.253.241]:52240 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S263868AbUEMVqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:46:07 -0400
Date: Wed, 12 May 2004 21:14:03 -0700
From: Bryan Rittmeyer <bryan@staidm.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       benh@kernel.crashing.org
Subject: [PATCH] IBM PowerPC 750GX Support
Message-ID: <20040513041403.GA11357@staidm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds preliminary support for the IBM PowerPC 750GX. In
summary this part is a PPC750FX ramped to 1 GHz with a 1MB 4-way L2
and more advanced I/O pipelining. It is beginning to appear in embedded
systems and was rumored to be under evaluation inside Apple. Tested on
PVR 70020101; please merge.

http://www-3.ibm.com/chips/techlib/techlib.nsf/products/PowerPC_750GX_Microprocessor

--- linux-2.5-benh/arch/ppc/kernel/cputable.c~	2004-04-01 09:39:25.000000000 -0800
+++ linux-2.5-benh/arch/ppc/kernel/cputable.c	2004-05-13 12:44:24.000000000 -0700
@@ -185,7 +185,15 @@
 	32, 32,
 	__setup_cpu_750fx
     },
-
+    {	/* 750GX */
+    	0xffff0000, 0x70020000, "750GX",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
+	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
+	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750fx
+    },
     {	/* 740/750 (L2CR bit need fixup for 740) */
     	0xffff0000, 0x00080000, "740/750",
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |

-Bryan

