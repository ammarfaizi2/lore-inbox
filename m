Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUACFE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 00:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUACFE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 00:04:59 -0500
Received: from gizmo07ps.bigpond.com ([144.140.71.17]:54231 "HELO
	gizmo07ps.bigpond.com") by vger.kernel.org with SMTP
	id S262603AbUACFE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 00:04:57 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Export idle_warning (x86-64)
Date: Sat, 3 Jan 2004 16:05:43 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031605.43495.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch the ACPI processor module does not load (and hence thermal 
module too):
--- 2.6.1-rc1-bk3/arch/x86_64/kernel/process.c.orig     2004-01-03 
04:52:32.000000000 +1100
+++ 2.6.1-rc1-bk3/arch/x86_64/kernel/process.c  2004-01-03 04:56:49.000000000 
+1100
@@ -166,6 +166,8 @@
        printk(KERN_ERR "******* Disabling USB legacy in the BIOS may also 
help.\n");
 }

+EXPORT_SYMBOL(idle_warning);
+
 /* Prints also some state that isn't saved in the pt_regs */
 void __show_regs(struct pt_regs * regs)
 {

With that patch (against 2.6.1-rc1-bk3) those modules load and work fine.

Thanks
Hari
harisri@bigpond.com

