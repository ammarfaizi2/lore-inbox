Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWBHMmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWBHMmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWBHMmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:42:02 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:9238 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030407AbWBHMmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:42:00 -0500
Date: Wed, 8 Feb 2006 13:41:56 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <maks@sternwelten.at>
Subject: [patch 09/10] s390: add #ifdef __KERNEL__ to asm-s390/setup.h
Message-ID: <20060208124156.GJ1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Based on a patch from Maximilian Attems <maks@sternwelten.at> .
Nothing in asm-s390/setup.h is of interest for user space.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

diff --git a/include/asm-s390/setup.h b/include/asm-s390/setup.h
index 348a881..da3fd4a 100644
--- a/include/asm-s390/setup.h
+++ b/include/asm-s390/setup.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#ifdef __KERNEL__
+
 #include <asm/types.h>
 
 #define PARMAREA		0x10400
@@ -114,7 +116,7 @@ extern u16 ipl_devno;
 				 IPL_PARMBLOCK_ORIGIN)
 #define IPL_PARMBLOCK_SIZE	(IPL_PARMBLOCK_START->hdr.length)
 
-#else 
+#else /* __ASSEMBLY__ */
 
 #ifndef __s390x__
 #define IPL_DEVICE        0x10404
@@ -127,6 +129,6 @@ extern u16 ipl_devno;
 #endif /* __s390x__ */
 #define COMMAND_LINE      0x10480
 
-#endif
-
-#endif
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_S390_SETUP_H */
