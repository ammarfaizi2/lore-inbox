Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267266AbUBMXDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267276AbUBMXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:03:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:26522 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267266AbUBMXCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:02:43 -0500
Subject: [PATCH] ppc64: export clear_user_page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076713293.900.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 10:01:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need clear_user_page, is should be exported

diff -urN linux-2.5/arch/ppc64/kernel/ppc_ksyms.c linuxppc-2.5-benh/arch/ppc64/kernel/ppc_ksyms.c
--- linux-2.5/arch/ppc64/kernel/ppc_ksyms.c	2004-02-02 13:09:08.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc64/kernel/ppc_ksyms.c	2004-02-14 09:58:16.226078944 +1100
@@ -93,6 +93,8 @@
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
+EXPORT_SYMBOL(clear_user_page);
+
 #ifdef CONFIG_MSCHUNKS
 EXPORT_SYMBOL(msChunks);
 #endif


