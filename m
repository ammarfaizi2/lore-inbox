Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUDGBPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbUDGBPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:15:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12334 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263407AbUDGBP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:15:28 -0400
Date: Tue, 6 Apr 2004 18:14:28 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] bitop - fix test_and_change_bit comment
Message-Id: <20040406181428.2d061035.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty, Andrew,

Is there a place in the world for this patch?  I normally don't mess
with comment fixes except as part of bigger stuff.  But someone could
stub their little toe on this one.

If you prefer, I'd be happy to bury this fix in with the cpumask
and bitmap stuff I'm cooking up.

I've read over the code in each case, built and ran a test case for
i386 in particular, and studied the other uses and definitions of
test_and_change_bit().  Everything I see recommends this change.

 * Fix test_and_change_bit() comment: returns old value, not new one.

===================================================================
--- 2.6.5.orig/include/asm-cris/bitops.h	2004-04-06 17:30:54.000000000 -0700
+++ 2.6.5/include/asm-cris/bitops.h	2004-04-06 17:31:37.000000000 -0700
@@ -169,7 +169,7 @@
 	return retval;
 }
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
===================================================================
--- 2.6.5.orig/include/asm-i386/bitops.h	2004-04-06 17:30:54.000000000 -0700
+++ 2.6.5/include/asm-i386/bitops.h	2004-04-06 17:31:41.000000000 -0700
@@ -212,7 +212,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
===================================================================
--- 2.6.5.orig/include/asm-ia64/bitops.h	2004-04-06 17:30:55.000000000 -0700
+++ 2.6.5/include/asm-ia64/bitops.h	2004-04-06 17:31:45.000000000 -0700
@@ -236,7 +236,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
===================================================================
--- 2.6.5.orig/include/asm-mips/bitops.h	2004-04-06 17:30:55.000000000 -0700
+++ 2.6.5/include/asm-mips/bitops.h	2004-04-06 17:38:45.000000000 -0700
@@ -296,7 +296,7 @@
 }
 
 /*
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
@@ -567,7 +567,7 @@
 }
 
 /*
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
===================================================================
--- 2.6.5.orig/include/asm-x86_64/bitops.h	2004-04-06 17:30:55.000000000 -0700
+++ 2.6.5/include/asm-x86_64/bitops.h	2004-04-06 17:39:14.000000000 -0700
@@ -204,7 +204,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
