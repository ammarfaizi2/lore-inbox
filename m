Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136254AbRECIyc>; Thu, 3 May 2001 04:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136256AbRECIyW>; Thu, 3 May 2001 04:54:22 -0400
Received: from styx.suse.cz ([213.210.157.162]:25330 "EHLO monk.suse.cz")
	by vger.kernel.org with ESMTP id <S136254AbRECIyK>;
	Thu, 3 May 2001 04:54:10 -0400
Date: Thu, 3 May 2001 10:53:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Trivial cleanup in arch/i386/ptrace.c
Message-ID: <20010503105338.A30263@monk.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Function get_stack_long should better return long, not int as it does now.

							      Pavel

Index: ptrace.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/i386/kernel/ptrace.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 ptrace.c
--- clean/linux/arch/i386/kernel/ptrace.c	2001/04/19 20:02:44	1.1.1.2
+++ linux/linux/arch/i386/kernel/ptrace.c	2001/05/03 07:51:51
@@ -50,7 +50,7 @@
 
 	stack = (unsigned char *)task->thread.esp0;
 	stack += offset;
-	return (*((int *)stack));
+	return (*((unsigned long *)stack));
 }
 
 /*
