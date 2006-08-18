Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHRGxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHRGxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHRGxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:53:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19600 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750738AbWHRGxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:53:30 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Use decimal for PTRACE_ATTACH and PTRACE_DETACH.
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060818065320.47B97180030@magilla.sf.frob.com>
Date: Thu, 17 Aug 2006 23:53:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is sure confusing that linux/ptrace.h has:
	#define PTRACE_SINGLESTEP	   9
	#define PTRACE_ATTACH		0x10
	#define PTRACE_DETACH		0x11
	#define PTRACE_SYSCALL		  24
All the low-numbered constants are in decimal, but the last two in hex.
It sure makes it likely that someone will look at this and think that
9, 10, 11 are used, and that 16 and 17 are not used.

How about we use the same notation for all the numbers [0,24] in the
same short list?

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/linux/ptrace.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 8b2749a..eeb1976 100644  
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -16,8 +16,8 @@
 #define PTRACE_KILL		   8
 #define PTRACE_SINGLESTEP	   9
 
-#define PTRACE_ATTACH		0x10
-#define PTRACE_DETACH		0x11
+#define PTRACE_ATTACH		  16
+#define PTRACE_DETACH		  17
 
 #define PTRACE_SYSCALL		  24
 
