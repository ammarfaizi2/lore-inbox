Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTB0Vbw>; Thu, 27 Feb 2003 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTB0Vbw>; Thu, 27 Feb 2003 16:31:52 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:49158 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267013AbTB0Vbu>; Thu, 27 Feb 2003 16:31:50 -0500
Date: Thu, 27 Feb 2003 14:00:39 -0600
From: Art Haas <ahaas@airmail.net>
To: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for alpha/thread-info.h
Message-ID: <20030227200039.GA31009@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This trivial patch switches the file to use C99 initializers.

Art Haas

===== include/asm-alpha/thread_info.h 1.4 vs edited =====
--- 1.4/include/asm-alpha/thread_info.h	Fri Dec  6 19:54:50 2002
+++ edited/include/asm-alpha/thread_info.h	Thu Feb 27 13:48:14 2003
@@ -34,9 +34,9 @@
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	task:		&tsk,			\
-	exec_domain:	&default_exec_domain,	\
-	addr_limit:	KERNEL_DS,		\
+	.task		= &tsk,			\
+	.exec_domain	= &default_exec_domain,	\
+	.addr_limit	= KERNEL_DS,		\
 	.restart_block = {			\
 		.fn = do_no_restart_syscall,	\
 	},					\
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
