Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266164AbUFIPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUFIPaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUFIPaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:30:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42644 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266164AbUFIPaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:30:08 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 1/5: kcopyd: remove superfluous INIT_LIST_HEADs
Date: Wed, 9 Jun 2004 10:30:53 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091030.53614.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove superfluous kcopyd INIT_LIST_HEAD.

From: Alasdair Kergon <agk@redhat.com>
Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/kcopyd.c	2004-06-09 08:47:09.248461240 +0000
+++ source/drivers/md/kcopyd.c	2004-06-09 08:47:38.850960976 +0000
@@ -224,10 +224,6 @@
 
 static int __init jobs_init(void)
 {
-	INIT_LIST_HEAD(&_complete_jobs);
-	INIT_LIST_HEAD(&_io_jobs);
-	INIT_LIST_HEAD(&_pages_jobs);
-
 	_job_cache = kmem_cache_create("kcopyd-jobs",
 				       sizeof(struct kcopyd_job),
 				       __alignof__(struct kcopyd_job),
