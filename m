Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSKRTY5>; Mon, 18 Nov 2002 14:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSKRTY4>; Mon, 18 Nov 2002 14:24:56 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:60837 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264624AbSKRTYu> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:50 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (3/16): mman.
Date: Mon, 18 Nov 2002 20:17:43 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182017.43590.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.48/include/asm-s390/mman.h linux-2.5.48-s390/include/asm-s390/mman.h
--- linux-2.5.48/include/asm-s390/mman.h	Mon Nov 18 05:29:22 2002
+++ linux-2.5.48-s390/include/asm-s390/mman.h	Mon Nov 18 20:11:15 2002
@@ -26,6 +26,8 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -urN linux-2.5.48/include/asm-s390x/mman.h linux-2.5.48-s390/include/asm-s390x/mman.h
--- linux-2.5.48/include/asm-s390x/mman.h	Mon Nov 18 05:29:29 2002
+++ linux-2.5.48-s390/include/asm-s390x/mman.h	Mon Nov 18 20:11:15 2002
@@ -26,6 +26,8 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */

