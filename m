Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSH1Fcq>; Wed, 28 Aug 2002 01:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSH1Fcq>; Wed, 28 Aug 2002 01:32:46 -0400
Received: from dp.samba.org ([66.70.73.150]:6292 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318720AbSH1Fc3>;
	Wed, 28 Aug 2002 01:32:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Designated initializers for shm
Date: Wed, 28 Aug 2002 15:28:11 +1000
Message-Id: <20020828003711.50D6C2C10C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This is the last remenant in kernel/, mm/ and ipc/ ]

Name: Designated initializers for kernel/, mm/ and ipc/
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15522-linux-2.5.30/ipc/shm.c .15522-linux-2.5.30.updated/ipc/shm.c
--- .15522-linux-2.5.30/ipc/shm.c	2002-08-02 11:15:10.000000000 +1000
+++ .15522-linux-2.5.30.updated/ipc/shm.c	2002-08-09 16:14:44.000000000 +1000
@@ -154,13 +154,13 @@ static int shm_mmap(struct file * file, 
 }
 
 static struct file_operations shm_file_operations = {
-	mmap:	shm_mmap
+	.mmap	= shm_mmap
 };
 
 static struct vm_operations_struct shm_vm_ops = {
-	open:	shm_open,	/* callback for a new vm-area open */
-	close:	shm_close,	/* callback for when the vm-area is released */
-	nopage:	shmem_nopage,
+	.open	= shm_open,	/* callback for a new vm-area open */
+	.close	= shm_close,	/* callback for when the vm-area is released */
+	.nopage	= shmem_nopage,
 };
 
 static int newseg (key_t key, int shmflg, size_t size)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
