Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTEaWjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTEaWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:39:37 -0400
Received: from [209.123.232.253] ([209.123.232.253]:50306 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S264480AbTEaWjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:39:35 -0400
Subject: [PATCH] 2.5.70-mm3: ioctl32-cleanup-ppc64
From: Andres Salomon <dilinger@voxel.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-5pVYtEItHnycrA9TsAMh"
Organization: 
Message-Id: <1054421566.950.8.camel@nrop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2003 18:52:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5pVYtEItHnycrA9TsAMh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Something I noticed missing from 2.5.70-mm3; sparc64 and x86_64 are
cleaned up, but ppc64 isn't.

--=-5pVYtEItHnycrA9TsAMh
Content-Disposition: attachment; filename=ioctl32-cleanup-ppc64.patch
Content-Type: text/plain; name=ioctl32-cleanup-ppc64.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- a/arch/ppc64/kernel/ppc_ksyms.c	2003-05-31 18:48:15.000000000 -0400
+++ b/arch/ppc64/kernel/ppc_ksyms.c	2003-05-31 18:48:28.000000000 -0400
@@ -49,8 +49,6 @@
 
 extern int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 extern int do_signal(sigset_t *, struct pt_regs *);
-extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
-extern int unregister_ioctl32_conversion(unsigned int cmd);
 
 int abs(int);
 
@@ -66,9 +64,6 @@
 EXPORT_SYMBOL(synchronize_irq);
 #endif /* CONFIG_SMP */
 
-EXPORT_SYMBOL(register_ioctl32_conversion);
-EXPORT_SYMBOL(unregister_ioctl32_conversion);
-
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(pci_io_base);
 

--=-5pVYtEItHnycrA9TsAMh--

