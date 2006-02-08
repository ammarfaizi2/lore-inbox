Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWBHMnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWBHMnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWBHMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:43:05 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:3607 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030406AbWBHMnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:43:04 -0500
Date: Wed, 8 Feb 2006 13:42:48 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: [patch 10/10] s390: remove one set of brackets in __constant_test_bit()
Message-ID: <20060208124248.GK1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Paris <eparis@redhat.com>

Right now in __constant_test_bit for the s390 there is an extra set of
() surrounding the calculation.
This patch simply removes one set of () that is surrounding the whole
clause.

Signed-off-by: Eric Paris <eparis@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/bitops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-s390/bitops.h b/include/asm-s390/bitops.h
index 6123276..3628899 100644
--- a/include/asm-s390/bitops.h
+++ b/include/asm-s390/bitops.h
@@ -518,8 +518,8 @@ static inline int __test_bit(unsigned lo
 
 static inline int 
 __constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
-    return ((((volatile char *) addr)
-	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)))) != 0;
+    return (((volatile char *) addr)
+	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7))) != 0;
 }
 
 #define test_bit(nr,addr) \
