Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUKFBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUKFBIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUKFBIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:08:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:43157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbUKFBIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:08:49 -0500
Date: Fri, 5 Nov 2004 17:08:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo in last procfs patch
Message-ID: <20041105170846.K14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in patch to avoid oops in proc_delete_inode.

base.c: In function `proc_pid_make_inode':
base.c:783: error: `node' undeclared (first use in this function)
base.c:783: error: (Each undeclared identifier is reported only once
base.c:783: error: for each function it appears in.)

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/proc/base.c 1.20 vs edited =====
--- 1.20/fs/proc/base.c	2004-11-03 18:25:16 -08:00
+++ edited/fs/proc/base.c	2004-11-05 17:02:30 -08:00
@@ -780,7 +780,7 @@
 	return inode;
 
 out_unlock:
-	node->u.generic_ip = NULL;
+	inode->u.generic_ip = NULL;
 	iput(inode);
 	return NULL;
 }
