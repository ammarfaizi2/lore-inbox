Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVIBOPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVIBOPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbVIBOPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:15:47 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:24303 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1161016AbVIBOPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:15:47 -0400
Date: Fri, 2 Sep 2005 23:15:41 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: remove the unused variable about futex
Message-Id: <20050902231541.3e057cf5.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has removed the unused variable about futex.
Please apply.

Yoichi

  CC      kernel/futex.o
In file included from kernel/futex.c:43:
include/asm/futex.h: In function `futex_atomic_op_inuser':
include/asm/futex.h:17: warning: unused variable `tem'


Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/include/asm-mips/futex.h mm1/include/asm-mips/futex.h
--- mm1-orig/include/asm-mips/futex.h	2005-09-01 21:58:47.000000000 +0900
+++ mm1/include/asm-mips/futex.h	2005-09-02 23:04:03.000000000 +0900
@@ -14,7 +14,7 @@
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
