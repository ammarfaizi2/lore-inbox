Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWAXBSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWAXBSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWAXBST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:18:19 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:430 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030273AbWAXBRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:54 -0500
Date: Mon, 23 Jan 2006 20:16:07 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 1/9] ia32 syscalls: prepare UML for new table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601232017_MC3-1-B683-9F38@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 1/9:

Make uml compatible with future i386 syscall renames.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm2.orig/arch/um/sys-i386/sys_call_table.S
+++ 2.6.16-rc1-mm2/arch/um/sys-i386/sys_call_table.S
@@ -11,6 +11,15 @@
 
 #define sys_stime um_stime
 #define sys_time um_time
+
+/*
+ * old_mmap and old_select will be renamed
+ * to sys_old_mmap and sys_old_select.
+ * Be compatible with both old and new names.
+ */
 #define old_mmap old_mmap_i386
+#define sys_old_mmap old_mmap_i386
+
+#define sys_old_select old_select
 
 #include "../../i386/kernel/syscall_table.S"
-- 
Chuck
