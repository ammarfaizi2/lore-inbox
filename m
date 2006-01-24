Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWAXBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWAXBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWAXBR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:17:56 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:39126 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030267AbWAXBRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:51 -0500
Date: Mon, 23 Jan 2006 20:16:16 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 4/9] ia32 syscalls: switch i386 to new table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
Message-ID: <200601232017_MC3-1-B683-9F3C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 4/9:

Switch i386 to the new shared call table.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm2.orig/arch/i386/kernel/entry.S
+++ 2.6.16-rc1-mm2/arch/i386/kernel/entry.S
@@ -678,6 +678,7 @@ ENTRY(spurious_interrupt_bug)
 	jmp error_code
 
 .section .rodata,"a"
-#include "syscall_table.S"
+ENTRY(sys_call_table)
+#include "syscall_tbl.S"
 
 syscall_table_size=(.-sys_call_table)
-- 
Chuck
