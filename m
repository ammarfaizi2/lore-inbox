Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUIJDen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUIJDen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUIJD2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:28:11 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:33962 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267793AbUIJD11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:27:27 -0400
Date: Fri, 10 Sep 2004 12:29:23 +0900 (JST)
Message-Id: <200409100329.i8A3TNYV007108@mailsv.bs1.fc.nec.co.jp>
To: akpm@osdl.org, hugh@veritas.com
Cc: wli@holomorphy.com, takata.hirokazu@renesas.com, kaigai@ak.jp.nec.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] atomic_inc_return() for arm[3/5] (Re: atomic_inc_return)
In-Reply-To: Your message of "Thu, 9 Sep 2004 20:48:27 +0100 (BST)".
	<Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[3/5] atomic_inc_return-linux-2.6.9-rc1.arm.patch
  This patch declares atomic_inc_return() as the alias of atomic_add_return()
  and atomic_dec_return() as an alias of atomic_dec_return().
  This patch has not been tested, since we don't have ARM machine.
  I want to let this reviewed by ARM specialists.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


diff -rNU4 linux-2.6.9-rc1/include/asm-arm/atomic.h linux-2.6.9-rc1.atomic_inc_return/include/asm-arm/atomic.h
--- linux-2.6.9-rc1/include/asm-arm/atomic.h	2004-08-24 16:01:55.000000000 +0900
+++ linux-2.6.9-rc1.atomic_inc_return/include/asm-arm/atomic.h	2004-09-10 10:15:18.000000000 +0900
@@ -194,8 +194,10 @@
 #define atomic_dec(v)		atomic_sub(1, v)
 
 #define atomic_inc_and_test(v)	(atomic_add_return(1, v) == 0)
 #define atomic_dec_and_test(v)	(atomic_sub_return(1, v) == 0)
+#define atomic_inc_return(v)    (atomic_add_return(1, v))
+#define atomic_dec_return(v)    (atomic_sub_return(1, v))
 
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
 
 /* Atomic operations are already serializing on ARM */
