Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTHIBMD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTHIBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:09:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7932 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S272248AbTHIBIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:08:39 -0400
Subject: [patch] remove initramfs temp files
From: Robert Love <rml@tech9.net>
To: kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1060391292.31499.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 08 Aug 2003 18:08:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kai.

'make distclean' and 'make mrproper' both fail to remove the file
initramfs_data.S.tmp from the root of the kernel build tree.

Attached patch adds it to the MRPROPER_FILES list.

Patch is against 2.6.0-test2.

	Robert Love


 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.6.0-test2/Makefile linux/Makefile
--- linux-2.6.0-test2/Makefile	2003-07-27 10:04:49.000000000 -0700
+++ linux/Makefile	2003-08-08 18:01:40.721934933 -0700
@@ -676,7 +676,7 @@
 	include/asm \
 	.hdepend include/linux/modversions.h \
 	tags TAGS cscope kernel.spec \
-	.tmp*
+	initramfs_data.S.tmp .tmp*
 
 # Directories removed with 'make mrproper'
 MRPROPER_DIRS += \


