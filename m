Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWCUNdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWCUNdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWCUNdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:33:32 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:24535 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751696AbWCUNda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:33:30 -0500
Subject: [patch] [trivial] remove needless check in nfs_opendir()
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Tue, 21 Mar 2006 14:33:52 +0100
Message-Id: <1142948032.6243.17.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local variable res was initialized to 0 - no check needed here.

signed-off-by: Carsten Otte <cotte@de.ibm.com>
--
diff -ruN linux-2.6.16/fs/nfs/dir.c linux-2.6.16-fix/fs/nfs/dir.c
--- linux-2.6.16/fs/nfs/dir.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fix/fs/nfs/dir.c	2006-03-21 14:01:41.000000000 +0100
@@ -131,8 +131,7 @@
 
 	lock_kernel();
 	/* Call generic open code in order to cache credentials */
-	if (!res)
-		res = nfs_open(inode, filp);
+	res = nfs_open(inode, filp);
 	unlock_kernel();
 	return res;
 }


