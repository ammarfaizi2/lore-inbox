Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265693AbSKALC0>; Fri, 1 Nov 2002 06:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265703AbSKALC0>; Fri, 1 Nov 2002 06:02:26 -0500
Received: from mail.hometree.net ([212.34.181.120]:47062 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265693AbSKALCZ>; Fri, 1 Nov 2002 06:02:25 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.5.45] Doc Patch
Date: Fri, 1 Nov 2002 11:08:52 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aptnc4$bld$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036148932 5887 212.34.181.4 (1 Nov 2002 11:08:52 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 1 Nov 2002 11:08:52 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That file really need serious updating. Here is at least a small patch

--- linux-2.5.45/Documentation/filesystems/ext2.txt.xxxx	Thu Oct 31 01:42:20 2002
+++ linux-2.5.45/Documentation/filesystems/ext2.txt	Fri Nov  1 12:07:01 2002
@@ -319,26 +319,8 @@
 ----------
 
 A journaling extension to the ext2 code has been developed by Stephen
-Tweedie.  It avoids the risks of metadata corruption and the need to
-wait for e2fsck to complete after a crash, without requiring a change
-to the on-disk ext2 layout.  In a nutshell, the journal is a regular
-file which stores whole metadata (and optionally data) blocks that have
-been modified, prior to writing them into the filesystem.  This means
-it is possible to add a journal to an existing ext2 filesystem without
-the need for data conversion.
-
-When changes to the filesystem (e.g. a file is renamed) they are stored in
-a transaction in the journal and can either be complete or incomplete at
-the time of a crash.  If a transaction is complete at the time of a crash
-(or in the normal case where the system does not crash), then any blocks
-in that transaction are guaranteed to represent a valid filesystem state,
-and are copied into the filesystem.  If a transaction is incomplete at
-the time of the crash, then there is no guarantee of consistency for
-the blocks in that transaction so they are discarded (which means any
-filesystem changes they represent are also lost).
-
-The ext3 code is currently (Apr 2001) available for 2.2 kernels only,
-and not yet available for 2.4 kernels.
+Tweedie.  As of Linux 2.4 it has been fully integrated in the kernel.
+Please see the Documentation/filesystems/ext3.txt file for full details.
 
 References
 ==========


	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
