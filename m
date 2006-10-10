Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWJJVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWJJVsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWJJVsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28091 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWJJVri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] ptrace32 trivial __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRp-0007Of-Ci@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86_64/ia32/ptrace32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/ia32/ptrace32.c b/arch/x86_64/ia32/ptrace32.c
index d18198e..3a7561d 100644
--- a/arch/x86_64/ia32/ptrace32.c
+++ b/arch/x86_64/ia32/ptrace32.c
@@ -205,9 +205,9 @@ #undef R32
 static long ptrace32_siginfo(unsigned request, u32 pid, u32 addr, u32 data)
 {
 	int ret;
-	compat_siginfo_t *si32 = (compat_siginfo_t *)compat_ptr(data);
+	compat_siginfo_t __user *si32 = compat_ptr(data);
 	siginfo_t ssi; 
-	siginfo_t *si = compat_alloc_user_space(sizeof(siginfo_t));
+	siginfo_t __user *si = compat_alloc_user_space(sizeof(siginfo_t));
 	if (request == PTRACE_SETSIGINFO) {
 		memset(&ssi, 0, sizeof(siginfo_t));
 		ret = copy_siginfo_from_user32(&ssi, si32);
-- 
1.4.2.GIT


