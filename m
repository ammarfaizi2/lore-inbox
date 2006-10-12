Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWJLSAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWJLSAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWJLSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:00:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31446 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750773AbWJLSAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:00:36 -0400
Date: Thu, 12 Oct 2006 19:00:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixing includes in alpha_ksyms.c
Message-ID: <20061012180035.GH29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	kernel_execve() fallout

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff --git a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
index 692809e..e9762a3 100644
--- a/arch/alpha/kernel/alpha_ksyms.c
+++ b/arch/alpha/kernel/alpha_ksyms.c
@@ -12,7 +12,7 @@ #include <asm/checksum.h>
 #include <asm/fpu.h>
 #include <asm/machvec.h>
 
-#include <asm/unistd.h>
+#include <linux/syscalls.h>
 
 /* these are C runtime functions with special calling conventions: */
 extern void __divl (void);
