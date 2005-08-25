Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbVHYFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbVHYFVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbVHYFVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2252 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751542AbVHYFVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:41 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (13/22) isa_{type,sex} should be exported (m68k)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEI-0005dB-Fj@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missing export on m68k

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-m68k-mul/arch/m68k/kernel/setup.c RC13-rc7-isa_type/arch/m68k/kernel/setup.c
--- RC13-rc7-m68k-mul/arch/m68k/kernel/setup.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-isa_type/arch/m68k/kernel/setup.c	2005-08-25 00:54:13.000000000 -0400
@@ -100,6 +100,8 @@
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 int isa_type;
 int isa_sex;
+EXPORT_SYMBOL(isa_type);
+EXPORT_SYMBOL(isa_sex);
 #endif
 
 extern int amiga_parse_bootinfo(const struct bi_record *);
