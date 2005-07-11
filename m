Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVGKB16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVGKB16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVGKBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:25:39 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:27625 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262182AbVGKBYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:24:25 -0400
Date: Sun, 10 Jul 2005 18:23:35 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, hari@in.ibm.com
Subject: [PATCH] kernel/crash_dump.c: add kerneldoc
Message-Id: <20050710182335.54eb1add.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kerneldoc to kernel/crash_dump.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 kernel/crash_dump.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -Naurp linux-2613-rc2/kernel/crash_dump.c~kdoc_kernel_crashdump linux-2613-rc2/kernel/crash_dump.c
--- linux-2613-rc2/kernel/crash_dump.c~kdoc_kernel_crashdump	2005-07-09 13:55:03.000000000 -0700
+++ linux-2613-rc2/kernel/crash_dump.c	2005-07-10 16:34:12.000000000 -0700
@@ -18,7 +18,16 @@
 /* Stores the physical address of elf header of crash image. */
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 
-/*
+/**
+ * copy_oldmem_page - copy one page from "oldmem"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
  */


---
