Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314300AbSEBJbh>; Thu, 2 May 2002 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314303AbSEBJbg>; Thu, 2 May 2002 05:31:36 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:51462 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314300AbSEBJbf>; Thu, 2 May 2002 05:31:35 -0400
Date: Thu, 2 May 2002 11:31:17 +0200
From: tomas szepe <kala@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
Subject: [PATCH] add missing MODULE_LICENSE tags in fs/
Message-ID: <20020502093116.GH7072@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 10 days, 3:29)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


just noticed that loading exportfs.o (needed by nfsd.o) tainted my 2.5.12
kernel on account of a missing MODULE_LICENSE tag. When I was at it, I did
a bit of grepping through fs/ and fixed up a couple other affected modules
too.

The patch is against -dj1, but applies to vanilla 2.5.12 as well
(w/ minor offset on fs/exportfs/expfs.c).

Files modified:

fs/binfmt_elf.c
fs/binfmt_em86.c
fs/binfmt_script.c
fs/driverfs/inode.c
fs/exportfs/expfs.c
fs/hpfs/super.c

-Tomas



diff -urN linux-2.5.12-dj1/fs/binfmt_elf.c linux-2.5.12-dj1.n/fs/binfmt_elf.c
--- linux-2.5.12-dj1/fs/binfmt_elf.c	Mon Apr 15 16:14:48 2002
+++ linux-2.5.12-dj1.n/fs/binfmt_elf.c	Thu May  2 10:43:55 2002
@@ -1279,3 +1279,4 @@
 
 module_init(init_elf_binfmt)
 module_exit(exit_elf_binfmt)
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.12-dj1/fs/binfmt_em86.c linux-2.5.12-dj1.n/fs/binfmt_em86.c
--- linux-2.5.12-dj1/fs/binfmt_em86.c	Mon Apr 15 16:14:48 2002
+++ linux-2.5.12-dj1.n/fs/binfmt_em86.c	Thu May  2 10:44:04 2002
@@ -111,3 +111,4 @@
 
 module_init(init_em86_binfmt)
 module_exit(exit_em86_binfmt)
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.12-dj1/fs/binfmt_script.c linux-2.5.12-dj1.n/fs/binfmt_script.c
--- linux-2.5.12-dj1/fs/binfmt_script.c	Mon Apr 15 16:14:48 2002
+++ linux-2.5.12-dj1.n/fs/binfmt_script.c	Thu May  2 10:45:34 2002
@@ -111,3 +111,4 @@
 
 module_init(init_script_binfmt)
 module_exit(exit_script_binfmt)
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.12-dj1/fs/driverfs/inode.c linux-2.5.12-dj1.n/fs/driverfs/inode.c
--- linux-2.5.12-dj1/fs/driverfs/inode.c	Thu May  2 10:56:55 2002
+++ linux-2.5.12-dj1.n/fs/driverfs/inode.c	Thu May  2 10:52:46 2002
@@ -646,3 +646,4 @@
 EXPORT_SYMBOL(driverfs_create_dir);
 EXPORT_SYMBOL(driverfs_remove_file);
 EXPORT_SYMBOL(driverfs_remove_dir);
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.12-dj1/fs/exportfs/expfs.c linux-2.5.12-dj1.n/fs/exportfs/expfs.c
--- linux-2.5.12-dj1/fs/exportfs/expfs.c	Thu May  2 10:56:55 2002
+++ linux-2.5.12-dj1.n/fs/exportfs/expfs.c	Thu May  2 10:41:16 2002
@@ -3,6 +3,8 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 
+MODULE_LICENSE("GPL");
+
 /**
  * find_exported_dentry - helper routine to implement export_operations->decode_fh
  * @sb:		The &super_block identifying the filesystem
diff -urN linux-2.5.12-dj1/fs/hpfs/super.c linux-2.5.12-dj1.n/fs/hpfs/super.c
--- linux-2.5.12-dj1/fs/hpfs/super.c	Mon Apr 15 16:14:50 2002
+++ linux-2.5.12-dj1.n/fs/hpfs/super.c	Thu May  2 10:54:19 2002
@@ -650,3 +650,4 @@
 
 module_init(init_hpfs_fs)
 module_exit(exit_hpfs_fs)
+MODULE_LICENSE("GPL");
