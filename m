Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265302AbUEOA1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbUEOA1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUEOAZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:25:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:46821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265302AbUEOAUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:20:19 -0400
Date: Fri, 14 May 2004 17:20:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Joseph Fannin <jhf@rivenstone.net>
Subject: [PATCH] mqueue rlimit compile fix for ppc/cris/m68k
Message-ID: <20040514172014.E21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin notes that I missed a couple INIT_TASK spots in the
rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch.  Patch below
adds proper #includes.

--- linux-2.6.6-mm2/arch/ppc/kernel/process.c~init_task	2004-05-13 11:19:39.000000000 -0700
+++ linux-2.6.6-mm2/arch/ppc/kernel/process.c	2004-05-14 17:09:20.778637392 -0700
@@ -35,6 +35,7 @@
 #include <linux/init_task.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/mqueue.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
--- linux-2.6.6-mm2/arch/cris/kernel/process.c~init_task	2004-05-09 19:32:52.000000000 -0700
+++ linux-2.6.6-mm2/arch/cris/kernel/process.c	2004-05-14 17:10:02.974222688 -0700
@@ -102,6 +102,7 @@
 #include <linux/fs.h>
 #include <linux/user.h>
 #include <linux/elfcore.h>
+#include <linux/mqueue.h>
 
 //#define DEBUG
 
--- linux-2.6.6-mm2/arch/m68k/kernel/process.c~init_task	2004-05-13 11:19:38.000000000 -0700
+++ linux-2.6.6-mm2/arch/m68k/kernel/process.c	2004-05-14 17:10:36.796080984 -0700
@@ -26,6 +26,7 @@
 #include <linux/a.out.h>
 #include <linux/reboot.h>
 #include <linux/init_task.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
