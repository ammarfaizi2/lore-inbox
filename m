Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUKKR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUKKR4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKKRxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:53:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262349AbUKKRwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:52:25 -0500
Date: Thu, 11 Nov 2004 17:52:16 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: Fix some DMERR macro usage
Message-ID: <20041111175216.GC8857@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some DMERR macro usage. It already adds : and \n.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-table.c	2004-11-10 15:05:36.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-11-10 15:06:36.000000000 +0000
@@ -664,14 +664,14 @@
 
 	if (!len) {
 		tgt->error = "zero-length target";
-		DMERR(": %s\n", tgt->error);
+		DMERR("%s", tgt->error);
 		return -EINVAL;
 	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
 		tgt->error = "unknown target type";
-		DMERR(": %s\n", tgt->error);
+		DMERR("%s", tgt->error);
 		return -EINVAL;
 	}
 
@@ -708,7 +708,7 @@
 	return 0;
 
  bad:
-	DMERR(": %s\n", tgt->error);
+	DMERR("%s", tgt->error);
 	dm_put_target_type(tgt->type);
 	return r;
 }
