Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132160AbQLLQ54>; Tue, 12 Dec 2000 11:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132206AbQLLQ5p>; Tue, 12 Dec 2000 11:57:45 -0500
Received: from ip44.packplace.ethernet.citizens.swva.net ([206.153.170.44]:16905
	"EHLO crib.corepower.com") by vger.kernel.org with ESMTP
	id <S132160AbQLLQ50>; Tue, 12 Dec 2000 11:57:26 -0500
Date: Tue, 12 Dec 2000 11:27:00 -0500 (EST)
From: raubitsj@dynabytesystems.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] unresolved symbols in ext2.o (2.4.0-test12)
Message-ID: <Pine.LNX.4.21.0012121122370.25443-100000@crib.corepower.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a patch i need to fix two unresolved symbols when ext2 was
compiled as a module.

-jeff

--- linux-2.4.0-test12/kernel/ksyms.c	Tue Dec 12 11:19:17 2000
+++ linux/kernel/ksyms.c	Tue Dec 12 11:18:57 2000
@@ -252,6 +252,8 @@
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);
 EXPORT_SYMBOL(dcache_readdir);
+EXPORT_SYMBOL(buffer_insert_inode_queue);
+EXPORT_SYMBOL(fsync_inode_buffers);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);

  ------------------------------------------------------------------------
       Jeff Raubitschek 
       DynaByte Systems
       raubitsj@DynaByteSystems.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
