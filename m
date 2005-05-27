Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVE0BKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVE0BKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVE0BIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:08:25 -0400
Received: from [151.97.230.9] ([151.97.230.9]:51217 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261433AbVE0BFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:22 -0400
Subject: [patch 3/8] uml: fix PREEMPT_ACTIVE
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       paulus@samba.org, mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:40 +0200
Message-Id: <20050527003840.7A4A41AEE86@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>

This is a continuation for UML of:

http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-um/thread_info.h~uml-fix-interrupts include/asm-um/thread_info.h
--- linux-2.6.git/include/asm-um/thread_info.h~uml-fix-interrupts	2005-05-27 02:30:48.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/thread_info.h	2005-05-27 02:36:42.000000000 +0200
@@ -62,7 +62,7 @@ static inline struct thread_info *curren
 
 #endif
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x10000000
 
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
_
