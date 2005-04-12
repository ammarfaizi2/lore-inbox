Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVDLKnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVDLKnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVDLKmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:42:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:38602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262272AbVDLKdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:22 -0400
Message-Id: <200504121033.j3CAX2kL005754@shell0.pdx.osdl.net>
Subject: [patch 151/198] arm: fix floppy disk dependencies
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Russell King <rmk+lkml@arm.linux.org.uk>

Both the RiscPC and (optionally) EBSA285 have floppy disk support.  Allow this
option to be selected on these ARM platforms again.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/block/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/Kconfig~arm-fix-floppy-disk-dependencies drivers/block/Kconfig
--- 25/drivers/block/Kconfig~arm-fix-floppy-disk-dependencies	2005-04-12 03:21:39.810084848 -0700
+++ 25-akpm/drivers/block/Kconfig	2005-04-12 03:21:39.813084392 -0700
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64 && !UML) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !UML) || Q40 || (SUN3X && BROKEN) || ARCH_RPC || ARCH_EBSA285
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
_
