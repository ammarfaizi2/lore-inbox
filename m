Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUEFPFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUEFPFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUEFPFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:05:38 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:34292 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S262450AbUEFPFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:05:35 -0400
Message-ID: <409A542A.9030808@superonline.com>
Date: Thu, 06 May 2004 18:05:14 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-pre2-pac1
Content-Type: multipart/mixed;
 boundary="------------020609000806040004060603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609000806040004060603
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Another one: This removes duplicate fls defines.

Regards;
Özkan Sezer

--------------020609000806040004060603
Content-Type: text/plain;
 name="fls-remove-duplicate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fls-remove-duplicate.patch"

diff -urN 27p2.pac1/include/net/sctp/compat.h 27p2.acx1/include/net/sctp/compat.h
--- 27p2.pac1/include/net/sctp/compat.h
+++ 27p2.acx1/include/net/sctp/compat.h
@@ -95,36 +95,5 @@
 #define sk_wmem_queued wmem_queued
 #define sk_bound_dev_if bound_dev_if
 
-/*
- * find last bit set.
- */
-static __inline__ int fls(int x)
-{
-	int r = 32;
-	
-	if (!x)
-		return 0;
-	if (!(x & 0xffff0000u)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xff000000u)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf0000000u)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc0000000u)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
-}
 
 #endif /* __net_sctp_compat_h__ */
diff -urN 27p2.pac1/include/asm-x86_64/bitops.h 27p2.acx1/include/asm-x86_64/bitops.h
--- 27p2.pac1/include/asm-x86_64/bitops.h
+++ 27p2.acx1/include/asm-x86_64/bitops.h
@@ -436,6 +436,13 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
+
 #ifdef __KERNEL__
 
 static inline int _sched_find_first_bit(const unsigned long *b)

--------------020609000806040004060603--

