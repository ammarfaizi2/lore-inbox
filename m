Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319059AbSH2APr>; Wed, 28 Aug 2002 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSH2APr>; Wed, 28 Aug 2002 20:15:47 -0400
Received: from verein.lst.de ([212.34.181.86]:64269 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319059AbSH2APp>;
	Wed, 28 Aug 2002 20:15:45 -0400
Date: Thu, 29 Aug 2002 02:20:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix syscall prototypes in init/do_mounts.c
Message-ID: <20020829022002.B9792@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the prototypes in init/do_mounts.c to match their actualy
declarations (mostly char vs const char) and add externs.


--- linux-2.4.20-pre4/init/do_mounts.c	Sat Aug 17 14:54:39 2002
+++ linux/init/do_mounts.c	Tue Aug 20 11:39:48 2002
@@ -20,16 +20,16 @@
 
 extern int get_filesystem_list(char * buf);
 
-asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
+extern asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
 	 unsigned long flags, void *data);
-asmlinkage long sys_mkdir(char *name, int mode);
-asmlinkage long sys_chdir(char *name);
-asmlinkage long sys_chroot(char *name);
-asmlinkage long sys_unlink(char *name);
-asmlinkage long sys_symlink(char *old, char *new);
-asmlinkage long sys_mknod(char *name, int mode, dev_t dev);
-asmlinkage long sys_umount(char *name, int flags);
-asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
+extern asmlinkage long sys_mkdir(const char *name, int mode);
+extern asmlinkage long sys_chdir(const char *name);
+extern asmlinkage long sys_chroot(const char *name);
+extern asmlinkage long sys_unlink(const char *name);
+extern asmlinkage long sys_symlink(const char *old, const char *new);
+extern asmlinkage long sys_mknod(const char *name, int mode, dev_t dev);
+extern asmlinkage long sys_umount(char *name, int flags);
+extern asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
