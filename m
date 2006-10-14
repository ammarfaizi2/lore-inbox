Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWJNPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWJNPxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWJNPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:53:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17615 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422699AbWJNPxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:53:39 -0400
Date: Sat, 14 Oct 2006 16:53:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sun3_ioremap() prototype
Message-ID: <20061014155338.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-m68k/sun3mmu.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-m68k/sun3mmu.h b/include/asm-m68k/sun3mmu.h
index 6c8c17d..d8f17a0 100644
--- a/include/asm-m68k/sun3mmu.h
+++ b/include/asm-m68k/sun3mmu.h
@@ -4,6 +4,7 @@
 #ifndef __SUN3_MMU_H__
 #define __SUN3_MMU_H__
 
+#include <linux/types.h>
 #include <asm/movs.h>
 #include <asm/sun3-head.h>
 
@@ -160,7 +161,7 @@ static inline void sun3_put_context(unsi
 	return;
 }
 
-extern void *sun3_ioremap(unsigned long phys, unsigned long size,
+extern void __iomem *sun3_ioremap(unsigned long phys, unsigned long size,
 			  unsigned long type);
 
 extern int sun3_map_test(unsigned long addr, char *val);
-- 
1.4.2.GIT

