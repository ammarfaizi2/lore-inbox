Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbWJ3UFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWJ3UFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWJ3UFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:09 -0500
Received: from [198.99.130.12] ([198.99.130.12]:14222 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030584AbWJ3UFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:05 -0500
Message-Id: <200610302103.k9UL30nZ006239@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/3] UML - add INITCALLS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2006 16:03:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the UML piece of the INITCALLS tidying.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-um/common.lds.S
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/common.lds.S	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/common.lds.S	2006-10-30 13:55:48.000000000 -0500
@@ -42,13 +42,7 @@
 	
   __initcall_start = .;
   .initcall.init : {
-	*(.initcall1.init) 
-	*(.initcall2.init) 
-	*(.initcall3.init) 
-	*(.initcall4.init) 
-	*(.initcall5.init) 
-	*(.initcall6.init) 
-	*(.initcall7.init)
+	INITCALLS
   }
   __initcall_end = .;
 

