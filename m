Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUISOxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUISOxd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 10:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUISOxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 10:53:33 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:26058 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269245AbUISOxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 10:53:32 -0400
Date: Sun, 19 Sep 2004 23:53:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed definition order of _sigchld
Message-Id: <20040919235320.24d9e069.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change had fixed definition order of _sigchld about MIPS.

diff -urN -X dontdiff a-orig/include/asm-mips/siginfo.h a/include/asm-mips/siginfo.h
--- a-orig/include/asm-mips/siginfo.h	Mon Sep 13 14:32:48 2004
+++ a/include/asm-mips/siginfo.h	Sun Sep 19 23:14:21 2004
@@ -47,8 +47,8 @@
 		struct {
 			pid_t _pid;		/* which child */
 			uid_t _uid;		/* sender's uid */
-			clock_t _utime;
 			int _status;		/* exit code */
+			clock_t _utime;
 			clock_t _stime;
 		} _sigchld;
 
