Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVIIQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVIIQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVIIQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:18:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33446 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030210AbVIIQSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:18:15 -0400
Date: Fri, 9 Sep 2005 17:18:14 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __user annotations for pointers in i386 sigframe
Message-ID: <20050909161814.GM9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/arch/i386/kernel/sigframe.h current/arch/i386/kernel/sigframe.h
--- RC13-git8-base/arch/i386/kernel/sigframe.h	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/i386/kernel/sigframe.h	2005-09-08 23:53:33.000000000 -0400
@@ -1,6 +1,6 @@
 struct sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
 	struct _fpstate fpstate;
@@ -10,10 +10,10 @@
 
 struct rt_sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
 	struct _fpstate fpstate;
