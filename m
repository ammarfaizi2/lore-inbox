Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSGWUqJ>; Tue, 23 Jul 2002 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318296AbSGWUqJ>; Tue, 23 Jul 2002 16:46:09 -0400
Received: from p3E9D3E54.dip.t-dialin.net ([62.157.62.84]:64773 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S318263AbSGWUqH>;
	Tue, 23 Jul 2002 16:46:07 -0400
Date: Tue, 23 Jul 2002 22:51:11 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: 2.4.19-rc3-ac3: init_task.c: missing braces around initializer (trivial)
Message-ID: <20020723205111.GA12072@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the INIT_THREAD initializer.

~/compile/steel/linux-2.4.19-rc3-ac3$ make bzImage modules -s
init_task.c:23: warning: missing braces around initializer
init_task.c:23: warning: (near initialization for `init_task_union.task.thread.io_bitmap')
init_task.c:23: warning: braces around scalar initializer
init_task.c:23: warning: (near initialization for `init_task_union.task.thread.io_bitmap[1]')

It's a resend, previous was for rc2-ac2, rediffed again rc3-ac3.
What about named initializers there, btw?


--- a/include/asm-i386/processor.h	Tue Jul 23 22:41:37 2002
+++ b/include/asm-i386/processor.h	Tue Jul 23 22:45:34 2002
@@ -393,7 +393,7 @@
 	{ [0 ... 7] = 0 },	/* debugging registers */	\
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
-	0,0,0,0,0,0,						\
+	0,0,0,0,0,						\
 	0,{~0,}			/* io permissions */		\
 }
 



