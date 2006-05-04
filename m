Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWEDOBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWEDOBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWEDOBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:01:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5595 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750951AbWEDOBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:01:34 -0400
Date: Thu, 4 May 2006 16:01:37 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi, greg@kroah.com
Subject: [PATCH 1/3] s390: Rename hypfs to s390-hypfs
Message-Id: <20060504160137.06b9b8eb.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since hpyfs is s390 specific we have to do the following:

- rename hypfs filesystem to s390-hypfs
- rename config option to S390_HYPFS_FS

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 arch/s390/Kconfig        |    2 +-
 arch/s390/hypfs/Makefile |    2 +-
 arch/s390/hypfs/inode.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/Kconfig linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/Kconfig
--- linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/Kconfig	2006-05-04 10:22:24.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/Kconfig	2006-05-04 10:25:32.000000000 +0200
@@ -442,7 +442,7 @@ config NO_IDLE_HZ_INIT
 	  The HZ timer is switched off in idle by default. That means the
 	  HZ timer is already disabled at boot time.
 
-config HYPFS_FS
+config S390_HYPFS_FS
 	bool "s390 hypervisor file system support"
 	default y
 	help
diff -urpN linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/hypfs/Makefile linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/Makefile
--- linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/hypfs/Makefile	2006-05-04 10:22:19.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/Makefile	2006-05-04 10:23:23.000000000 +0200
@@ -2,6 +2,6 @@
 # Makefile for the linux hypfs filesystem routines.
 #
 
-obj-$(CONFIG_HYPFS_FS) += hypfs.o
+obj-$(CONFIG_S390_HYPFS_FS) += hypfs.o
 
 hypfs-objs := inode.o hypfs_diag.o
diff -urpN linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/hypfs/inode.c linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/inode.c
--- linux-2.6.16-hypfs-2006-04-28-update1/arch/s390/hypfs/inode.c	2006-05-04 10:22:24.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/inode.c	2006-05-04 10:23:49.000000000 +0200
@@ -422,7 +422,7 @@ static struct file_operations hypfs_file
 
 static struct file_system_type hypfs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "hypfs",
+	.name		= "s390-hypfs",
 	.get_sb		= hypfs_get_super,
 	.kill_sb	= kill_litter_super
 };
