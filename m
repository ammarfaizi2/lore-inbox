Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVC3Ltl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVC3Ltl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3Ltl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:49:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261875AbVC3Ltb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:49:31 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Cleanup unused variable
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 30 Mar 2005 12:49:25 +0100
Message-ID: <28535.1112183365@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes an unused variable from the FRV arch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-cleanup-unused-2612rc1.diff 
 arch/frv/kernel/signal.c |    1 -
 1 files changed, 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.12-rc1/arch/frv/kernel/signal.c linux-2.6.12-rc1-frv-tlbmiss/arch/frv/kernel/signal.c
--- /warthog/kernels/linux-2.6.12-rc1/arch/frv/kernel/signal.c	2005-03-23 17:08:36.000000000 +0000
+++ linux-2.6.12-rc1-frv-tlbmiss/arch/frv/kernel/signal.c	2005-03-30 12:06:35.000000000 +0100
@@ -225,7 +225,6 @@ asmlinkage int sys_rt_sigreturn(void)
 {
 	struct rt_sigframe __user *frame = (struct rt_sigframe __user *) __frame->sp;
 	sigset_t set;
-	stack_t st;
 	int gr8;
 
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
