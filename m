Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVHWVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVHWVxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVHWVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:52:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2998 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932424AbVHWVnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:23 -0400
To: torvalds@osdl.org
Subject: [PATCH] (20/43) Kconfig fix (ppc32 SMP dependencies)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1E7gbC-0007Bf-NF@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc SMP is supported only for 6xx/POWER3/POWER4 - i.e. ones that have
PPC_STD_MMU.  Dependency fixed.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-vga/arch/ppc/Kconfig RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig
--- RC13-rc6-git13-vga/arch/ppc/Kconfig	2005-08-21 13:16:48.000000000 -0400
+++ RC13-rc6-git13-ppc-SMP/arch/ppc/Kconfig	2005-08-21 13:17:03.000000000 -0400
@@ -915,6 +915,7 @@
 	default y if PPC_PREP
 
 config SMP
+	depends on PPC_STD_MMU
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
