Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263861AbVBDRfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbVBDRfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbVBDRe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:34:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52167 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265832AbVBDRbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:45 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Add TIF_MEMDIE
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:31:39 +0000
Message-ID: <28747.1107538299@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds TIF_MEMDIE for FRV.

Could whoever added it to include/asm-i386/thread_info.h comment this flag
there please? I've given it a comment here, but I'm not sure it's correct.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-tif-memdie-2611rc3.diff 
 include/asm-frv/thread_info.h |    1 +
 1 files changed, 1 insertion(+)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/thread_info.h linux-2.6.11-rc3-frv/include/asm-frv/thread_info.h
--- /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/thread_info.h	2005-02-04 11:50:21.000000000 +0000
+++ linux-2.6.11-rc3-frv/include/asm-frv/thread_info.h	2005-02-04 12:29:39.000000000 +0000
@@ -132,6 +132,7 @@ register struct thread_info *__current_t
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		17	/* OOM killer killed process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
