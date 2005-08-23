Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVHWVmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVHWVmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVHWVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59061 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932415AbVHWVmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:43 -0400
To: torvalds@osdl.org
Subject: [PATCH] (12/43) Kconfig fix (arv)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gaY-00079w-CD@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arv uses constants provided only by include/asm-m32r/m32700ut/m32700ut_lan.h
It won't build for any subarchitecture other than M32700UT; marked as such.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-infiniband/drivers/media/video/Kconfig RC13-rc6-git13-arv/drivers/media/video/Kconfig
--- RC13-rc6-git13-infiniband/drivers/media/video/Kconfig	2005-08-10 10:37:49.000000000 -0400
+++ RC13-rc6-git13-arv/drivers/media/video/Kconfig	2005-08-21 13:16:55.000000000 -0400
@@ -356,7 +356,7 @@
 
 config VIDEO_M32R_AR_M64278
 	tristate "Use Colour AR module M64278(VGA)"
-	depends on VIDEO_M32R_AR
+	depends on VIDEO_M32R_AR && PLAT_M32700UT
 	---help---
 	  Say Y here to use the Renesas M64278E-800 camera module,
 	  which supports VGA(640x480 pixcels) size of images.
