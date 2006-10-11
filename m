Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030679AbWJKQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030679AbWJKQYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:24:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54972 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030679AbWJKQYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:24:46 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: signal __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXgsv-0005YR-71@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:24:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m32r/kernel/signal.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
index a9174ef..b60cea4 100644
--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -33,7 +33,7 @@ #define _BLOCKABLE (~(sigmask(SIGKILL) |
 int do_signal(struct pt_regs *, sigset_t *);
 
 asmlinkage int
-sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize,
+sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize,
 		  unsigned long r2, unsigned long r3, unsigned long r4,
 		  unsigned long r5, unsigned long r6, struct pt_regs *regs)
 {
@@ -78,8 +78,8 @@ sys_sigaltstack(const stack_t __user *us
 struct rt_sigframe
 {
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
 //	struct _fpstate fpstate;
-- 
1.4.2.GIT


