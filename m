Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUA3UrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUA3UrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:47:25 -0500
Received: from galileo.bork.org ([66.11.174.156]:60881 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S263607AbUA3UrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:47:22 -0500
Date: Fri, 30 Jan 2004 15:47:20 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove the unused kmalloc_percpu_init()
Message-ID: <20040130204720.GC8114@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus and Andrew,

This patch removes kmalloc_percpu_init() from include/linux/percpu.h

It is unused and doesn't seem to be required.

Thanks,
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="remove-kmalloc_percpu_init.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1528  -> 1.1529 
#	include/linux/percpu.h	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/30	mort@green.i.bork.org	1.1529
# Remove the unused kmalloc_percpu_init()
# --------------------------------------------
#
diff -Nru a/include/linux/percpu.h b/include/linux/percpu.h
--- a/include/linux/percpu.h	Fri Jan 30 15:26:53 2004
+++ b/include/linux/percpu.h	Fri Jan 30 15:26:53 2004
@@ -35,7 +35,6 @@
 
 extern void *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(const void *);
-extern void kmalloc_percpu_init(void);
 
 #else /* CONFIG_SMP */
 
@@ -52,7 +51,6 @@
 {	
 	kfree(ptr);
 }
-static inline void kmalloc_percpu_init(void) { }
 
 #endif /* CONFIG_SMP */
 

--tjCHc7DPkfUGtrlw--
