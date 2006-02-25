Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWBYIOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWBYIOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWBYIOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:14:30 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:61842 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932513AbWBYIOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:14:30 -0500
Date: Sat, 25 Feb 2006 03:02:42 -0500
From: Chuck Ebbert <76306.1226@CompuServe.com>
Subject: [patch] i386: more vsyscall documentation
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200602250306_MC3-1-B93A-6757@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document a limitation of vsyscall-sysenter, since patches to fix it
have been rejected.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-64.orig/arch/i386/kernel/vsyscall-sysenter.S
+++ 2.6.16-rc4-64/arch/i386/kernel/vsyscall-sysenter.S
@@ -21,6 +21,9 @@
  * instruction clobbers %esp, the user's %esp won't even survive entry
  * into the kernel. We store %esp in %ebp. Code in entry.S must fetch
  * arg6 from the stack.
+ *
+ * You can not use this vsyscall for the clone() syscall because the
+ * three dwords on the parent stack do not get copied to the child.
  */
 	.text
 	.globl __kernel_vsyscall
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
