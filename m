Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbUJ2ISJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbUJ2ISJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUJ2IQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:16:47 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:3555 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263140AbUJ2IP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:15:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Fix misnamed variable in ptrace.c
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081548.B39934D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:48 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/ptrace.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -ruN -X../cludes linux-2.6.9-uc0/arch/v850/kernel/ptrace.c linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/ptrace.c
--- linux-2.6.9-uc0/arch/v850/kernel/ptrace.c	2004-10-25 15:14:32 +0900
+++ linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/ptrace.c	2004-10-28 13:32:47 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/ptrace.c -- `ptrace' system call
  *
- *  Copyright (C) 2002,03  NEC Electronics Corporation
- *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03,04  NEC Electronics Corporation
+ *  Copyright (C) 2002,03,04  Miles Bader <miles@gnu.org>
  *
  * Derived from arch/mips/kernel/ptrace.c:
  *
@@ -147,8 +147,8 @@
 		rval = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
+	rval = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (rval < 0)
 		goto out_tsk;
 
 	switch (request) {
