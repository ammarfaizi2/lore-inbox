Return-Path: <linux-kernel-owner+w=401wt.eu-S1750743AbXAICzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXAICzR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbXAICzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:55:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4154 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750743AbXAICzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:55:16 -0500
Date: Tue, 9 Jan 2007 03:55:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Steven M. Christey" <coley@mitre.org>
Subject: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Message-ID: <20070109025516.GC25007@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RESTORE_CONTEXT lost a newline in 
commit 658fdbef66e5e9be79b457edc2cbbb3add840aa9:
http://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg00559.html

Reported by Steven M. Christey.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- a/include/asm-x86_64/system.h
+++ b/include/asm-x86_64/system.h
@@ -21,7 +21,7 @@
 
 /* frame pointer must be last for get_wchan */
 #define SAVE_CONTEXT    "pushf ; pushq %%rbp ; movq %%rsi,%%rbp\n\t"
-#define RESTORE_CONTEXT "movq %%rbp,%%rsi ; popq %%rbp ; popf\t"
+#define RESTORE_CONTEXT "movq %%rbp,%%rsi ; popq %%rbp ; popf\n\t"
 
 #define __EXTRA_CLOBBER  \
 	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
