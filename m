Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbUDFQB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbUDFP7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:59:37 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:54707 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263876AbUDFP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:59:06 -0400
Date: Tue, 6 Apr 2004 17:59:01 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: linux_udf@hpesjro.ipf.fc.hp.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] UDF - default [ug]id should be 0, not -1 (trivial)
Message-ID: <20040406155901.GA8551@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux_udf@hpesjro.ipf.fc.hp.com,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello there.

This trivial patch sets correct default uid/gid to files that do not have them
on a udf filesystem.

Some DVDs I have seem not to have a uid/gid set on the files and when one does
not specify uid=/gid= mount options, the files have the default values (-1/-1).

Please, apply.

Rudo Thomas.

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="udf-01-default-uid.diff"

diff -urN linux-2.6-vanilla/fs/udf/super.c linux-2.6-vanilla~/fs/udf/super.c
--- linux-2.6-vanilla~/fs/udf/super.c	2004-04-04 18:43:49.230097384 +0200
+++ linux-2.6-vanilla/fs/udf/super.c	2004-03-30 17:15:11.000000000 +0200
@@ -1498,8 +1498,8 @@
 	struct udf_sb_info *sbi;
 
 	uopt.flags = (1 << UDF_FLAG_USE_AD_IN_ICB) | (1 << UDF_FLAG_STRICT);
-	uopt.uid = -1;
-	uopt.gid = -1;
+	uopt.uid = 0;
+	uopt.gid = 0;
 	uopt.umask = 0;
 
 	sbi = kmalloc(sizeof(struct udf_sb_info), GFP_KERNEL);

--uAKRQypu60I7Lcqm--
