Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUIQENI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUIQENI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUIQENI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:08 -0400
Received: from [12.177.129.25] ([12.177.129.25]:4036 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268265AbUIQENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:01 -0400
Message-Id: <200409170517.i8H5HP2J005367@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Export memmove
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/os-Linux/user_syms.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/os-Linux/user_syms.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/os-Linux/user_syms.c	2004-09-16 23:04:22.000000000 -0400
@@ -14,11 +14,13 @@
 
 extern size_t strlen(const char *);
 extern void *memcpy(void *, const void *, size_t);
+extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
 
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(printf);
 

