Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWADDlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWADDlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 22:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWADDlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 22:41:09 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:10409 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932506AbWADDlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 22:41:08 -0500
Date: Tue, 3 Jan 2006 22:36:14 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.15] i386: "invalid operand" -> "invalid opcode"
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200601032240_MC3-1-B544-E0A1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the manual, INT 6 is "invalid opcode", not "invalid operand".

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.15a.orig/arch/i386/kernel/traps.c
+++ 2.6.15a/arch/i386/kernel/traps.c
@@ -452,7 +452,7 @@ DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 #endif
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
-DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
+DO_ERROR_INFO( 6, SIGILL,  "invalid opcode", invalid_op, ILL_ILLOPN, regs->eip)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
-- 
Chuck
