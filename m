Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTIPDJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbTIPDHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:07:31 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:35968 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261774AbTIPDFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:05:18 -0400
Message-ID: <1063681511.3f667de791244@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:05:11 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 8 of 15 -- /fs/locks.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/fs/locks.c
linux-2.6.0-test4-bk5-mandocs_tweaks/fs/locks.c
--- linux-2.6.0-test4-bk5-mandocs/fs/locks.c	2003-09-04 10:57:06.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/fs/locks.c	2003-09-06
20:31:11.000000000 +1000
@@ -928,10 +928,10 @@
  * locks_mandatory_area - Check for a conflicting lock
  * @read_write: %FLOCK_VERIFY_WRITE for exclusive access, %FLOCK_VERIFY_READ
  *		for shared
- * @inode: the file to check
- * @file: how the file was opened (if it was)
- * @offset: start of area to check
- * @count: length of area to check
+ * @inode:      the file to check
+ * @filp:       how the file was opened (if it was)
+ * @offset:     start of area to check
+ * @count:      length of area to check
  *
  * Searches the inode's list of locks to find any POSIX locks which conflict.
  * This function is called from locks_verify_area() and
@@ -1119,6 +1119,7 @@
 /**
  *	lease_get_mtime
  *	@inode: the inode
+ *      @time:  pointer to a timespec which will contain the last modified time
  *
  * This is to force NFS clients to flush their caches for files with
  * exclusive leases.  The justification is that if someone has an
@@ -1720,6 +1721,7 @@
 
 /**
  *	posix_unblock_lock - stop waiting for a file lock
+ *      @filp:   how the file was opened
  *	@waiter: the lock which was waiting
  *
  *	lockd needs to block waiting for locks.

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
