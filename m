Return-Path: <linux-kernel-owner+w=401wt.eu-S1750943AbXAICMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAICMb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXAICM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:12:28 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44492 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbXAICL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:58 -0500
Message-Id: <200701090205.l0925nDL024406@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/7] UML - Remove code controlled by non-existent config option
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HOST_TASK_SIZE doesn't exist any more.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/skas/mem.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/skas/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/mem.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/skas/mem.c	2007-01-08 16:48:42.000000000 -0500
@@ -14,13 +14,9 @@ unsigned long set_task_sizes_skas(unsign
 	unsigned long host_task_size = ROUND_4M((unsigned long)
 						&host_task_size);
 
-#ifdef CONFIG_HOST_TASK_SIZE
-	*host_size_out = ROUND_4M(CONFIG_HOST_TASK_SIZE);
-	*task_size_out = CONFIG_HOST_TASK_SIZE;
-#else
 	if (!skas_needs_stub)
 		*task_size_out = host_task_size;
 	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
-#endif
+
 	return host_task_size;
 }

