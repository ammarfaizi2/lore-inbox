Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUKQCqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUKQCqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUKQCqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:46:51 -0500
Received: from mail.renesas.com ([202.234.163.13]:10962 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262163AbUKQCqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:46:48 -0500
Date: Wed, 17 Nov 2004 11:46:31 +0900 (JST)
Message-Id: <20041117.114631.1071436662.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] m32r: Fix build error of
 arch/m32r/mm/fault.c
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please drop "Changes for arch/m32r/mm/fault.c@1.3" or 
apply the attached patch to bk-tree for m32r.

The modification of "Changes for arch/m32r/mm/fault.c@1.3" was
prepared for enforce-a-gap-between-heap-and-stack.patch(*) of -mm tree,
but it has not been merged into mainline.
  (*) "heap-stack-gap for 2.6" (Sep. 25, 2004)
       http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.3/0435.html

So, this patch is for withdrawing the previous arch/m32r/mm/fault.c.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/fault.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-11-15 12:16:47.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-11-17 10:54:24.000000000 +0900
@@ -182,7 +182,7 @@ asmlinkage void do_page_fault(struct pt_
 			goto bad_area;
 	}
 #endif
-	if (expand_stack(vma, address, NULL))
+	if (expand_stack(vma, address))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
