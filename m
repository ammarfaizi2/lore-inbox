Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSFCGIM>; Mon, 3 Jun 2002 02:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317288AbSFCGIL>; Mon, 3 Jun 2002 02:08:11 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:52449 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317287AbSFCGIK>; Mon, 3 Jun 2002 02:08:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL: rwhron@earthlink.net: remove space in cache names
Date: Mon, 03 Jun 2002 16:12:02 +1000
Message-Id: <E17El4U-0007ha-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net: remove space in _proc_slabinfo cache_name:
  Most /proc/slabinfo cache_names are in the format:
  cache_name.  There are a couple with spaces in the
  name, which is inconsistent and requires a special case
  when scripting.
  
  Changes "fasync cache" and "file lock cache" to have
  the usual underscore.
  
  Tested on 2.5.18.  Applies to 2.4.19-pre8 with offset.
  

--- trivial-2.5.20/fs/fcntl.c.orig	Mon Jun  3 15:25:18 2002
+++ trivial-2.5.20/fs/fcntl.c	Mon Jun  3 15:25:18 2002
@@ -551,7 +551,7 @@
 
 static int __init fasync_init(void)
 {
-	fasync_cache = kmem_cache_create("fasync cache",
+	fasync_cache = kmem_cache_create("fasync_cache",
 		sizeof(struct fasync_struct), 0, 0, NULL, NULL);
 	if (!fasync_cache)
 		panic("cannot create fasync slab cache");
--- trivial-2.5.20/fs/locks.c.orig	Mon Jun  3 15:25:18 2002
+++ trivial-2.5.20/fs/locks.c	Mon Jun  3 15:25:18 2002
@@ -1940,7 +1940,7 @@
 
 static int __init filelock_init(void)
 {
-	filelock_cache = kmem_cache_create("file lock cache",
+	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, 0, init_once, NULL);
 	if (!filelock_cache)
 		panic("cannot create file lock slab cache");

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
