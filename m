Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbTAJSaY>; Fri, 10 Jan 2003 13:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAJS0Q>; Fri, 10 Jan 2003 13:26:16 -0500
Received: from [193.158.237.250] ([193.158.237.250]:17800 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265754AbTAJS0B>; Fri, 10 Jan 2003 13:26:01 -0500
Date: Fri, 10 Jan 2003 19:34:43 +0100
Message-Id: <200301101834.h0AIYgU04073@mail.intergenia.de>
To: Miles Bader <miles@gnu.org>
From: miles@lsi.nec.co.jp (Miles Bader)
Subject: [PATCH]  Add __gpl_ksymtab section to v850 linker script [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.55-moo.orig/arch/v850/vmlinux.lds.S	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.5.55-moo/arch/v850/vmlinux.lds.S	2003-01-09 15:27:41.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/vmlinux.lds.S -- kernel linker script for v850 platforms
  *
- *  Copyright (C) 2002  NEC Electronics Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -51,6 +51,9 @@
 		___start___ksymtab = . ;/* Kernel symbol table.  */	      \
 			*(__ksymtab)					      \
 		___stop___ksymtab = . ;					      \
+		___start___gpl_ksymtab = . ; /* Same for GPL symbols.  */     \
+			*(__gpl_ksymtab)				      \
+		___stop___gpl_ksymtab = . ;				      \
 		. = ALIGN (4) ;						      \
 		__etext = . ;
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

