Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVGJNMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVGJNMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 09:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVGJNMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 09:12:05 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:36267 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261929AbVGJNME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 09:12:04 -0400
Date: Sun, 10 Jul 2005 23:12:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       chris@zankel.net
Subject: [PATCH] remove asm-xtensa/ipc.h
Message-Id: <20050710231201.2a6a1a7e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Now that sys_ipc has been removed from xtensa, asm/ipc.h is no longer
needed for that architecture.  Not tested, but obviously correct.  This
file is included only from arch code and this patch also removes the only
inclusion.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/xtensa/kernel/syscalls.c |    1 -
 include/asm-xtensa/ipc.h      |   16 ----------------
 2 files changed, 17 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/xtensa/kernel/syscalls.c linus-xtensa/arch/xtensa/kernel/syscalls.c
--- linus/arch/xtensa/kernel/syscalls.c	2005-07-08 15:18:27.000000000 +1000
+++ linus-xtensa/arch/xtensa/kernel/syscalls.c	2005-07-10 23:00:52.000000000 +1000
@@ -42,7 +42,6 @@
 #include <asm/mman.h>
 #include <asm/shmparam.h>
 #include <asm/page.h>
-#include <asm/ipc.h>
 
 extern void do_syscall_trace(void);
 typedef int (*syscall_t)(void *a0,...);
diff -ruNp linus/include/asm-xtensa/ipc.h linus-xtensa/include/asm-xtensa/ipc.h
--- linus/include/asm-xtensa/ipc.h	2005-07-01 09:58:50.000000000 +1000
+++ linus-xtensa/include/asm-xtensa/ipc.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,16 +0,0 @@
-/*
- * include/asm-xtensa/ipc.h
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of
- * this archive for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_IPC_H
-#define _XTENSA_IPC_H
-
-#include <asm-generic/ipc.h>
-
-#endif	/* _XTENSA_IPC_H */

