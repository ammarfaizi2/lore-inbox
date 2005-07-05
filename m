Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVGEVOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVGEVOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVGEVNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:13:34 -0400
Received: from ozlabs.org ([203.10.76.45]:14531 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261966AbVGEVGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:06:54 -0400
Date: Wed, 6 Jul 2005 07:04:21 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: remove duplicate syscall reservation
Message-ID: <20050705210421.GI12786@krispykreme>
References: <20050705205632.GF12786@krispykreme> <20050705205804.GG12786@krispykreme> <20050705210204.GH12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705210204.GH12786@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We already have a prototype for sys_remap_file_pages (239) so there is no
need to reserve it twice.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: linux-2.6.git-work/include/asm-ppc/unistd.h
===================================================================
--- linux-2.6.git-work.orig/include/asm-ppc/unistd.h	2005-07-02 08:20:44.000000000 +1000
+++ linux-2.6.git-work/include/asm-ppc/unistd.h	2005-07-23 23:48:50.000000000 +1000
@@ -262,7 +262,7 @@
 #define __NR_rtas		255
 #define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
-/* Number 258 is reserved for new sys_remap_file_pages */
+/* 258 currently unused */
 /* Number 259 is reserved for new sys_mbind */
 /* Number 260 is reserved for new sys_get_mempolicy */
 /* Number 261 is reserved for new sys_set_mempolicy */
Index: linux-2.6.git-work/include/asm-ppc64/unistd.h
===================================================================
--- linux-2.6.git-work.orig/include/asm-ppc64/unistd.h	2005-07-02 08:20:47.000000000 +1000
+++ linux-2.6.git-work/include/asm-ppc64/unistd.h	2005-07-23 23:51:56.000000000 +1000
@@ -268,7 +268,7 @@
 #define __NR_rtas		255
 /* Number 256 is reserved for sys_debug_setcontext */
 /* Number 257 is reserved for vserver */
-/* Number 258 is reserved for new sys_remap_file_pages */
+/* 258 currently unused */
 #define __NR_mbind		259
 #define __NR_get_mempolicy	260
 #define __NR_set_mempolicy	261
