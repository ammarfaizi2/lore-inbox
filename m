Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268053AbRG2P5L>; Sun, 29 Jul 2001 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268056AbRG2P5C>; Sun, 29 Jul 2001 11:57:02 -0400
Received: from mail3.iadfw.net ([209.196.123.3]:31241 "HELO mail3.iadfw.net")
	by vger.kernel.org with SMTP id <S268053AbRG2P4v>;
	Sun, 29 Jul 2001 11:56:51 -0400
From: "Art Haas" <ahaas@neosoft.com>
Date: Sun, 29 Jul 2001 11:00:45 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] two small patches for fs/exec.c and fs/ramfs/inode.c
Message-ID: <20010729110045.C347@localhost.neosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.

Here are two trivial patches that remove warnings. The fs/exec.c patch
removes an unused variable, and the fs/ramfs/inode.c patch replaces
a call of `linux/malloc.h' with `linux/slab.h'. Both patches I've
applied to my 2.4.7-ac2 kernel. Sorry if this is the 50th time you've
seen these posted to the mailing list ...

My thanks to everyone working on the kernel. The 2.4 kernels keep
getting better every day!

Art Haas 

====================================================

--- fs/exec.c.orig	Sat Jul 28 11:52:47 2001
+++ fs/exec.c	Sat Jul 28 12:25:28 2001
@@ -929,7 +929,6 @@
 
 int do_coredump(long signr, struct pt_regs * regs)
 {
-	struct mm_struct *mm;
 	struct linux_binfmt * binfmt;
 	char corename[6+sizeof(current->comm)+10];
 	struct file * file;

====================================================

--- fs/ramfs/inode.c.orig	Sat Jul 28 11:52:50 2001
+++ fs/ramfs/inode.c	Sat Jul 28 13:00:26 2001
@@ -30,7 +30,7 @@
 #include <linux/string.h>
 #include <linux/locks.h>
 #include <linux/highmem.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #include <asm/uaccess.h>
 #include <linux/spinlock.h>

