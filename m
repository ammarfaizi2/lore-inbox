Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWEYB0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWEYB0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEYB0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:26:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29070 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964814AbWEYB0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:26:42 -0400
Message-Id: <20060525003420.759175000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:46 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] Remove some unused definitions in zorro.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These definitions have long been superseded by asm-offsets.h

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/zorro.h |   42 ------------------------------------------
 1 file changed, 42 deletions(-)

Index: linux-2.6-mm/include/linux/zorro.h
===================================================================
--- linux-2.6-mm.orig/include/linux/zorro.h
+++ linux-2.6-mm/include/linux/zorro.h
@@ -11,8 +11,6 @@
 #ifndef _LINUX_ZORRO_H
 #define _LINUX_ZORRO_H
 
-#ifndef __ASSEMBLY__
-
 #include <linux/device.h>
 
 
@@ -112,45 +110,6 @@ struct ConfigDev {
     __u32		cd_Unused[4];	/* for whatever the driver wants */
 } __attribute__ ((packed));
 
-#else /* __ASSEMBLY__ */
-
-LN_Succ		= 0
-LN_Pred		= LN_Succ+4
-LN_Type		= LN_Pred+4
-LN_Pri		= LN_Type+1
-LN_Name		= LN_Pri+1
-LN_sizeof	= LN_Name+4
-
-ER_Type		= 0
-ER_Product	= ER_Type+1
-ER_Flags	= ER_Product+1
-ER_Reserved03	= ER_Flags+1
-ER_Manufacturer	= ER_Reserved03+1
-ER_SerialNumber	= ER_Manufacturer+2
-ER_InitDiagVec	= ER_SerialNumber+4
-ER_Reserved0c	= ER_InitDiagVec+2
-ER_Reserved0d	= ER_Reserved0c+1
-ER_Reserved0e	= ER_Reserved0d+1
-ER_Reserved0f	= ER_Reserved0e+1
-ER_sizeof	= ER_Reserved0f+1
-
-CD_Node		= 0
-CD_Flags	= CD_Node+LN_sizeof
-CD_Pad		= CD_Flags+1
-CD_Rom		= CD_Pad+1
-CD_BoardAddr	= CD_Rom+ER_sizeof
-CD_BoardSize	= CD_BoardAddr+4
-CD_SlotAddr	= CD_BoardSize+4
-CD_SlotSize	= CD_SlotAddr+2
-CD_Driver	= CD_SlotSize+2
-CD_NextCD	= CD_Driver+4
-CD_Unused	= CD_NextCD+4
-CD_sizeof	= CD_Unused+(4*4)
-
-#endif /* __ASSEMBLY__ */
-
-#ifndef __ASSEMBLY__
-
 #define ZORRO_NUM_AUTO		16
 
 #ifdef __KERNEL__
@@ -290,7 +249,6 @@ extern DECLARE_BITMAP(zorro_unused_z2ram
 #define Z2RAM_CHUNKSHIFT	(16)
 
 
-#endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_ZORRO_H */

--

