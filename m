Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbULPMpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbULPMpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 07:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbULPMpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 07:45:34 -0500
Received: from mail.renesas.com ([202.234.163.13]:41688 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262656AbULPMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:44:11 -0500
Date: Thu, 16 Dec 2004 21:43:59 +0900 (JST)
Message-Id: <20041216.214359.468732673.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Clean up arch/m32r/mm/fault.c (3/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041216.214100.278750319.takata.hirokazu@renesas.com>
References: <20041216.214100.278750319.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Clean up arch/m32r/mm/fault.c (3/3)
- Fix a typo: ACE_USEMODE --> ACE_USERMODE.
- Update copyright statement, and so on.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/fault.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-12-16 11:25:42.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-12-16 11:30:11.000000000 +0900
@@ -2,13 +2,12 @@
  *  linux/arch/m32r/mm/fault.c
  *
  *  Copyright (c) 2001, 2002  Hitoshi Yamamoto, and H. Kondo
+ *  Copyright (c) 2004  Naoto Sugai, NIIBE Yutaka
  *
  *  Some code taken from i386 version.
  *    Copyright (C) 1995  Linus Torvalds
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -131,7 +130,7 @@ asmlinkage void do_page_fault(struct pt_
 	 * nothing more.
 	 *
 	 * This verifies that the fault happens in kernel space
-	 * (error_code & ACE_USEMODE) == 0, and that the fault was not a
+	 * (error_code & ACE_USERMODE) == 0, and that the fault was not a
 	 * protection error (error_code & ACE_PROTECTION) == 0.
 	 */
 	if (address >= TASK_SIZE && !(error_code & ACE_USERMODE))

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

