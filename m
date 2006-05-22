Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWEVVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWEVVFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEVVFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:05:21 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:469 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750947AbWEVVFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:05:19 -0400
Date: Mon, 22 May 2006 16:59:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [stable][patch] x86_64: fix number of ia32 syscalls
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       linux-stable <stable@kernel.org>
Message-ID: <200605221701_MC3-1-C081-B4B3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent discussions about whether to print a message about unimplemented
ia32 syscalls on x86_64 have missed the real bug: the number of ia32
syscalls is wrong in 2.6.16.  Fixing that kills the message.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16.17-64.orig/include/asm-x86_64/ia32_unistd.h
+++ 2.6.16.17-64/include/asm-x86_64/ia32_unistd.h
@@ -317,6 +317,6 @@
 #define __NR_ia32_ppoll			309
 #define __NR_ia32_unshare		310
 
-#define IA32_NR_syscalls 315	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 311	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
-- 
Chuck

"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
