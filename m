Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBHBMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUBHBMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:12:20 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18375 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261731AbUBHBMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:12:19 -0500
Date: Sun, 8 Feb 2004 02:12:15 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux390@de.ibm.com
Cc: linux-390@vm.marist.edu, linux-kernel@vger.kernel.org
Subject: [patch] s390: remove a kernel 2.2 #ifdef
Message-ID: <20040208011214.GH7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patych below removes an #ifdef for kernel 2.2 from 
include/asm-s390/debug.h .

Please apply
Adrian


--- linux-2.6.2-mm1/include/asm-s390/debug.h.old	2004-02-08 02:07:18.000000000 +0100
+++ linux-2.6.2-mm1/include/asm-s390/debug.h	2004-02-08 02:07:48.000000000 +0100
@@ -35,11 +35,7 @@
 
 #ifdef __KERNEL__
 #include <linux/version.h>
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0))
- #include <asm/spinlock.h>
-#else
- #include <linux/spinlock.h>
-#endif /* LINUX_VERSION_CODE */
+#include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>

