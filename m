Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVDBFXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVDBFXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 00:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVDBFXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 00:23:55 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:17644 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261698AbVDBFXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 00:23:53 -0500
Date: Sat, 2 Apr 2005 14:23:37 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc1-mm4] mips: warning fix audit_arch()
Message-Id: <20050402142337.24ebb03b.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed the following warning about audit_arch().

  ptrace.o
arch/mips/kernel/ptrace.c:305: warning: function declaration isn't a prototype

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc1-mm4-orig/arch/mips/kernel/ptrace.c rc1-mm4/arch/mips/kernel/ptrace.c
--- rc1-mm4-orig/arch/mips/kernel/ptrace.c	Fri Apr  1 21:22:15 2005
+++ rc1-mm4/arch/mips/kernel/ptrace.c	Sat Apr  2 13:30:09 2005
@@ -301,7 +301,7 @@
 	return ret;
 }
 
-static inline int audit_arch()
+static inline int audit_arch(void)
 {
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #ifdef CONFIG_MIPS64
