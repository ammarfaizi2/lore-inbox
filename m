Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbULCTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbULCTul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbULCTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:50:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:7328 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262496AbULCTts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:49:48 -0500
Subject: [PATCH] Document kfree and vfree NULL usage (resend)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Date: Fri, 03 Dec 2004 21:48:02 +0200
Message-Id: <1102103282.17778.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds comments for kfree() and vfree() stating that both accept
NULL pointers.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c    |    2 ++
 vmalloc.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: 2.6.10-rc2/mm/slab.c
===================================================================
--- 2.6.10-rc2.orig/mm/slab.c	2004-11-27 14:33:14.000000000 +0200
+++ 2.6.10-rc2/mm/slab.c	2004-11-27 16:12:54.573387384 +0200
@@ -2535,6 +2535,8 @@
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
+ * If @objp is NULL, no operation is performed.
+ *
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
Index: 2.6.10-rc2/mm/vmalloc.c
===================================================================
--- 2.6.10-rc2.orig/mm/vmalloc.c	2004-11-27 16:13:48.026261312 +0200
+++ 2.6.10-rc2/mm/vmalloc.c	2004-11-27 16:14:04.875699808 +0200
@@ -389,7 +389,8 @@
  *	@addr:		memory base address
  *
  *	Free the virtually contiguous memory area starting at @addr, as
- *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
+ *	obtained from vmalloc(), vmalloc_32() or __vmalloc(). If @addr is
+ *	NULL, no operation is performed.
  *
  *	May not be called in interrupt context.
  */


