Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTIPDJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTIPDHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:07:41 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:33152 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261772AbTIPDE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:04:58 -0400
Message-ID: <1063681483.3f667dcbbf875@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:04:43 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 7 of 15 -- /fs/inode.c
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


diff -Nur linux-2.6.0-test4-bk5-mandocs/fs/inode.c
linux-2.6.0-test4-bk5-mandocs_tweaks/fs/inode.c
--- linux-2.6.0-test4-bk5-mandocs/fs/inode.c	2003-09-04 10:57:06.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/fs/inode.c	2003-09-06
19:40:06.000000000 +1000
@@ -252,6 +252,9 @@
 }
 
 /*
+ * dispose_list - dispose of the contents of a local list
+ * @head: the head of the list to free
+ *
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
@@ -728,11 +731,11 @@
 /**
  * ifind - internal function, you want ilookup5() or iget5().
  * @sb:		super block of file system to search
- * @hashval:	hash value (usually inode number) to search for
+ * @head:       the head of the list to search
  * @test:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @test
  *
- * ifind() searches for the inode specified by @hashval and @data in the inode
+ * ifind() searches for the inode specified by @data in the inode
  * cache. This is a generalized version of ifind_fast() for file systems where
  * the inode number is not sufficient for unique identification of an inode.
  *
@@ -764,6 +767,7 @@
 /**
  * ifind_fast - internal function, you want ilookup() or iget().
  * @sb:		super block of file system to search
+ * @head:       head of the list to search
  * @ino:	inode number to search for
  *
  * ifind_fast() searches for the inode @ino in the inode cache. This is for

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
