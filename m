Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQKPLaw>; Thu, 16 Nov 2000 06:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbQKPLao>; Thu, 16 Nov 2000 06:30:44 -0500
Received: from [209.249.10.20] ([209.249.10.20]:52690 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129894AbQKPLag>; Thu, 16 Nov 2000 06:30:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Nov 2000 02:24:51 -0800
Message-Id: <200011161024.CAA01591@adam.yggdrasil.com>
To: perex@suse.cz
Subject: Patch(?): linux-2.4.0-test11-pre5 ISAPNP_DEVICE simplification
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I think the definition of ISAPNP_DEVICE in
linux-2.4.0-test11-pre5/include/linux/isapnp.h is unnecessarily complex.
Here is a proposed patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux/include/linux/isapnp.h.orig	Thu Nov 16 02:20:14 2000
+++ linux/include/linux/isapnp.h	Thu Nov 16 02:20:33 2000
@@ -42,10 +42,8 @@
 #define ISAPNP_VENDOR(a,b,c)	(((((a)-'A'+1)&0x3f)<<2)|\
 				((((b)-'A'+1)&0x18)>>3)|((((b)-'A'+1)&7)<<13)|\
 				((((c)-'A'+1)&0x1f)<<8))
-#define ISAPNP_DEVICE(x)	((((x)&0xf000)>>8)|\
-				 (((x)&0x0f00)>>8)|\
-				 (((x)&0x00f0)<<8)|\
-				 (((x)&0x000f)<<8))
+#define ISAPNP_DEVICE(x)	((((x)&0xff00)>>8)|\
+				 (((x)&0x00ff)<<8))
 #define ISAPNP_FUNCTION(x)	ISAPNP_DEVICE(x)
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
