Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSKRTYx>; Mon, 18 Nov 2002 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSKRTYw>; Mon, 18 Nov 2002 14:24:52 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:60581 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264620AbSKRTYu> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:50 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (4/16): 64bit sector_t.
Date: Mon, 18 Nov 2002 20:18:08 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182018.08278.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.48/include/asm-s390/types.h linux-2.5.48-s390/include/asm-s390/types.h
--- linux-2.5.48/include/asm-s390/types.h	Mon Nov 18 05:29:46 2002
+++ linux-2.5.48-s390/include/asm-s390/types.h	Mon Nov 18 20:11:20 2002
@@ -63,5 +63,10 @@
 	} subreg;
 } register_pair;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif                                 /* __KERNEL__                       */
 #endif

