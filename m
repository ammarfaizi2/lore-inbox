Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAGCvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAGCvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVAGCvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:51:04 -0500
Received: from mail.renesas.com ([202.234.163.13]:48841 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261161AbVAGCvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:51:01 -0500
Date: Fri, 07 Jan 2005 11:50:52 +0900 (JST)
Message-Id: <20050107.115052.957827809.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>,
       Greg Banks <gnb@melbourne.sgi.com>, takata@linux-m32r.org
Subject: [PATCH 2.6.10-mm2] oprofile: update m32r for api changes
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oprofile m32r arch updates, including some API changes.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -x CVS -ruNp b/arch/m32r/oprofile/init.c /work/kernel/linux-2.6_edge/source/arch/m32r/oprofile/init.c
--- b/arch/m32r/oprofile/init.c	2004-12-25 06:33:50.000000000 +0900
+++ /work/kernel/linux-2.6_edge/source/arch/m32r/oprofile/init.c	2004-11-15 11:56:19.000000000 +0900
@@ -12,11 +12,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 
-extern void timer_init(struct oprofile_operations ** ops);
-
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
+void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
-	return -ENODEV;
 }
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
