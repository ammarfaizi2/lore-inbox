Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVHWVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVHWVyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVHWVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55989 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932413AbVHWVm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] (9/43) Kconfig fix (PCI on m32r)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gaJ-00079P-8Q@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI support is broken on m32r (pci_map_... missing, etc.); marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-broken-on-big-endian/arch/m32r/Kconfig RC13-rc6-git13-m32r-pci/arch/m32r/Kconfig
--- RC13-rc6-git13-broken-on-big-endian/arch/m32r/Kconfig	2005-08-21 13:16:49.000000000 -0400
+++ RC13-rc6-git13-m32r-pci/arch/m32r/Kconfig	2005-08-21 13:16:52.000000000 -0400
@@ -286,6 +286,7 @@
 
 config PCI
 	bool "PCI support"
+	depends on BROKEN
 	default n
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
