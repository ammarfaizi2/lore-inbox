Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312398AbSCURg4>; Thu, 21 Mar 2002 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312424AbSCURgt>; Thu, 21 Mar 2002 12:36:49 -0500
Received: from mail.s3.kth.se ([130.237.48.5]:46862 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S312398AbSCURfc>;
	Thu, 21 Mar 2002 12:35:32 -0500
Date: Thu, 21 Mar 2002 18:35:15 +0100
Message-Id: <200203211735.g2LHZFb02603@xq806.e.kth.se>
From: =?ISO-8859-1?Q? "M=E5ns?= =?ISO-8859-1?Q?Rullg=E5rd" ?= 
	<mru@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix alpha NR_SYSCALLS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the incorrect macro NR_SYSCALLS in
arch/alpha/kernel/entry.S. With the wrong value the last syscalls are
unavailable. The patch is against 2.4.18.

-- 
Måns Rullgård
e99_mru@e.kth.se


--- arch/alpha/kernel/entry.S.orig	Fri Nov  9 22:45:35 2001
+++ arch/alpha/kernel/entry.S	Thu Mar 21 18:06:21 2002
@@ -10,7 +10,7 @@
 
 #define SIGCHLD 20
 
-#define NR_SYSCALLS 378
+#define NR_SYSCALLS 381
 
 /*
  * These offsets must match with alpha_mv in <asm/machvec.h>.

