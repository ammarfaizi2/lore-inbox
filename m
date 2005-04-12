Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVDMBaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVDMBaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVDLTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:53:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:48072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVDLKbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:51 -0400
Message-Id: <200504121031.j3CAVj98005399@shell0.pdx.osdl.net>
Subject: [patch 068/198] x86-64: Fix BUG()
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andi Kleen <ak@suse.de>

Use the correct file name in BUG()

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-x86_64/bug.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-x86_64/bug.h~x86-64-fix-bug include/asm-x86_64/bug.h
--- 25/include/asm-x86_64/bug.h~x86-64-fix-bug	2005-04-12 03:21:19.792128040 -0700
+++ 25-akpm/include/asm-x86_64/bug.h	2005-04-12 03:21:19.794127736 -0700
@@ -18,7 +18,7 @@ struct bug_frame {
 #define HAVE_ARCH_BUG
 #define BUG() \
 	asm volatile("ud2 ; .quad %c1 ; .short %c0" :: \
-		     "i"(__LINE__), "i" (__stringify(KBUILD_BASENAME)))
+		     "i"(__LINE__), "i" (__stringify(__FILE__)))
 void out_of_line_bug(void);
 #include <asm-generic/bug.h>
 
_
