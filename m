Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSLLSHI>; Thu, 12 Dec 2002 13:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLLSHI>; Thu, 12 Dec 2002 13:07:08 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:25826 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264940AbSLLSHI> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/8): uaccess bug.
Date: Thu, 12 Dec 2002 19:08:00 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121908.00611.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix return value of __put_user_asm_8.

diffstat:
 uaccess.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.5.51/include/asm-s390/uaccess.h linux-2.5.51-s390/include/asm-s390/uaccess.h
--- linux-2.5.51/include/asm-s390/uaccess.h	Tue Dec 10 03:45:47 2002
+++ linux-2.5.51-s390/include/asm-s390/uaccess.h	Thu Dec 12 18:03:17 2002
@@ -84,7 +84,7 @@
 {
         int err;
 
-        __asm__ __volatile__ (  "   sr    %0,01\n"
+        __asm__ __volatile__ (  "   sr    %0,%0\n"
 				"   lr    2,%1\n"
 				"   lr    4,%2\n"
                                 "   sacf  512\n"

