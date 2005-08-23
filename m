Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVHWVmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVHWVmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVHWVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53173 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932407AbVHWVmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:12 -0400
To: torvalds@osdl.org
Subject: [PATCH] (6/43) Kconfig fix (m32r genrtc)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7ga4-00078t-4e@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genrtc is not for m32r; marked as such.  Probably ought to put that into
arch/* - list of "don't build it on <platform>" is getting too long.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-NUMA/drivers/char/Kconfig RC13-rc6-git13-m32r-genrtc/drivers/char/Kconfig
--- RC13-rc6-git13-m32r-NUMA/drivers/char/Kconfig	2005-08-21 13:16:46.000000000 -0400
+++ RC13-rc6-git13-m32r-genrtc/drivers/char/Kconfig	2005-08-21 13:16:49.000000000 -0400
@@ -736,7 +736,7 @@
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !PPC64
+	depends on RTC!=y && !IA64 && !ARM && !PPC64 && !M32R
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
