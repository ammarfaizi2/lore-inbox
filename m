Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273464AbRIQEMA>; Mon, 17 Sep 2001 00:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273466AbRIQELu>; Mon, 17 Sep 2001 00:11:50 -0400
Received: from sydney2.au.ibm.com ([202.135.142.197]:62215 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S273464AbRIQELo>;
	Mon, 17 Sep 2001 00:11:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: paulus@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bzImage target for PPC
Date: Mon, 17 Sep 2001 14:11:34 +1000
Message-Id: <E15ipks-0006sS-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the instructions (including the message after "make oldconfig")
talk about "make bzImage".  So I suppose it's best to give in to this
rampant Intelism 8)

--- working-pmac-module/arch/ppc/Makefile.~1~	Sat Aug 18 16:38:13 2001
+++ working-pmac-module/arch/ppc/Makefile	Mon Sep 17 14:08:09 2001
@@ -87,6 +87,9 @@
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
 
+# All the instructions talk about "make bzImage".
+bzImage: zImage
+
 $(BOOT_TARGETS): $(CHECKS) vmlinux
 	@$(MAKEBOOT) $@
 
Rusty.
--
Premature optmztion is rt of all evl. --DK
