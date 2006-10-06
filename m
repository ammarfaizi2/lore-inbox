Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWJFCWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWJFCWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 22:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWJFCWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 22:22:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57573 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751663AbWJFCWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 22:22:04 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-rc1] Fix do_mbind warning with CONFIG_MIGRATION=n
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Oct 2006 12:21:18 +1000
Message-ID: <6526.1160101278@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_MIGRATION=n

mm/mempolicy.c: In function 'do_mbind':
mm/mempolicy.c:796: warning: passing argument 2 of 'migrate_pages' from incompatible pointer type

Signed-off-by: Keith Owens <kaos@ocs.com.au>

---
 mm/mempolicy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c
+++ linux/mm/mempolicy.c
@@ -727,7 +727,7 @@ int do_migrate_pages(struct mm_struct *m
 	return -ENOSYS;
 }
 
-static struct page *new_vma_page(struct page *page, unsigned long private)
+static struct page *new_vma_page(struct page *page, unsigned long private, int **x)
 {
 	return NULL;
 }


