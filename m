Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVIGWVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVIGWVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIGWVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:21:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19676 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932091AbVIGWVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:21:13 -0400
Date: Wed, 7 Sep 2005 23:21:11 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bogus #if (arch/um/kernel/mem.c)
Message-ID: <20050907222111.GD13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-ppc64-sparse/arch/um/kernel/mem.c RC13-git7-uml-mem/arch/um/kernel/mem.c
--- RC13-git7-ppc64-sparse/arch/um/kernel/mem.c	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git7-uml-mem/arch/um/kernel/mem.c	2005-09-07 13:55:42.000000000 -0400
@@ -196,7 +196,7 @@
 
 static void __init fixaddr_user_init( void)
 {
-#if CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
+#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pgd_t *pgd;
 	pud_t *pud;
