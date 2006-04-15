Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWDODLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWDODLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 23:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWDODLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 23:11:13 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:17133 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030222AbWDODLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 23:11:00 -0400
Subject: [PATCH 06/08] percpu -v2 arch/i386 vmlinux.lds.S
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 23:10:58 -0400
Message-Id: <1145070658.27407.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add .data.percpu_offset section into arch/i386

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.17-rc1.orig/arch/i386/kernel/vmlinux.lds.S	2006-04-14 17:28:53.000000000 -0400
+++ linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S	2006-04-14 18:50:21.000000000 -0400
@@ -62,6 +62,7 @@ SECTIONS
   /* rarely changed data like cpu maps */
   . = ALIGN(32);
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
+  PERCPU_OFFSET
   _edata = .;			/* End of data section */
 
   . = ALIGN(THREAD_SIZE);	/* init_task */


