Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVAKFac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVAKFac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAKFac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:30:32 -0500
Received: from mail.renesas.com ([202.234.163.13]:60555 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262385AbVAKFaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:30:22 -0500
Date: Tue, 11 Jan 2005 14:30:15 +0900 (JST)
Message-Id: <20050111.143015.102571457.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-bk13] m32r: include nodemask.h for build fix
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to fix compile errors of 2.6.10-bk13 for m32r.
- build fix of arch/m32r/mm/init.c

Compile tested and boot checked.
Please apply.

>  CC      arch/m32r/mm/init.o
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c: In function `reservedpages_count':
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:156: warning: implicit declaration of function `for_each_online_node'
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:157: error: parse error before "for"
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:157: error: parse error before ')' token
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c: In function `mem_init':
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:174: error: parse error before "num_physpages"
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:193: error: parse error before "totalram_pages"
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c: In function `reservedpages_count':
>/work/kernel/linux-2.6.10-bk13/b/arch/m32r/mm/init.c:157: warning: statement with no effect
>make[2]: *** [arch/m32r/mm/init.o] Error 1
>make[1]: *** [arch/m32r/mm] Error 2
>make: *** [_all] Error 2

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/init.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -ruNp a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
--- a/arch/m32r/mm/init.c	2005-01-11 10:31:04.000000000 +0900
+++ b/arch/m32r/mm/init.c	2005-01-11 12:14:10.000000000 +0900
@@ -9,8 +9,6 @@
  *      Copyright (C) 1995  Linus Torvalds
  */
 
-/* $Id$ */
-
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -19,6 +17,7 @@
 #include <linux/swap.h>
 #include <linux/highmem.h>
 #include <linux/bitops.h>
+#include <linux/nodemask.h>
 #include <asm/types.h>
 #include <asm/processor.h>
 #include <asm/page.h>

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

