Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266086AbRGLPmN>; Thu, 12 Jul 2001 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGLPmD>; Thu, 12 Jul 2001 11:42:03 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:31176 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266086AbRGLPlq>; Thu, 12 Jul 2001 11:41:46 -0400
Date: Thu, 12 Jul 2001 16:42:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] show_trace() module_end = 0?
Message-ID: <Pine.LNX.4.21.0107121631490.1934-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace() contains an erroneous line, introduced in 2.4.6-pre4,
which disables trace on module text: appears to be from temporary
testing, since code and comments for tracing module text remain.

Hugh

--- linux-2.4.7-pre6/arch/i386/kernel/traps.c	Wed Jun 20 21:59:44 2001
+++ linux/arch/i386/kernel/traps.c	Thu Jul 12 16:25:42 2001
@@ -105,7 +105,6 @@
 	i = 1;
 	module_start = VMALLOC_START;
 	module_end = VMALLOC_END;
-	module_end = 0;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		/*

