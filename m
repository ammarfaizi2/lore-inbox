Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269696AbUICN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbUICN4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269697AbUICNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:55:59 -0400
Received: from mail.renesas.com ([202.234.163.13]:26324 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269696AbUICNzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:55:49 -0400
Date: Fri, 03 Sep 2004 22:55:35 +0900 (JST)
Message-Id: <20040903.225535.291442875.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm3] [m32r] Add m32r ELF machine code
From: Hirokazu Takata <takata.hirokazu@renesas.com>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here is a patch for m32r's ELF machine code.
And also change from "Hitachi H8/300" to "Renesas H8/300"(*).
Please apply this.

  (*) The SuperH, M32R and H8* - now these are all Renesas's products.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>


--- linux-2.6.9-rc1-mm3.orig/include/linux/elf.h	2004-08-14 14:36:17.000000000 +0900
+++ linux-2.6.9-rc1-mm3/include/linux/elf.h	2004-09-03 22:33:18.000000000 +0900
@@ -88,7 +88,9 @@ typedef __s64	Elf64_Sxword;
 
 #define EM_V850		87	/* NEC v850 */
 
-#define EM_H8_300       46      /* Hitachi H8/300,300H,H8S */
+#define EM_M32R		88	/* Renesas M32R */
+
+#define EM_H8_300       46      /* Renesas H8/300,300H,H8S */
 
 /*
  * This is an interim value that we will use until the committee comes
@@ -99,6 +101,9 @@ typedef __s64	Elf64_Sxword;
 /* Bogus old v850 magic number, used by old tools.  */
 #define EM_CYGNUS_V850	0x9080
 
+/* Bogus old m32r magic number, used by old tools.  */
+#define EM_CYGNUS_M32R	0x9041
+
 /*
  * This is the old interim value for S/390 architecture
  */
