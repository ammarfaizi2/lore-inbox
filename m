Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWACV2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWACV2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWACV2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:28:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40591 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932531AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 30/50] h8300: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008Qx-Ss@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/h8300/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ffc2e31ff9f23d041b8de15f5083ab4e986438dd
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index fe21adf..f053b14 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -195,7 +195,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	struct pt_regs * childregs;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
 	*childregs = *regs;
 	childregs->retpc = (unsigned long) ret_from_fork;
-- 
0.99.9.GIT

