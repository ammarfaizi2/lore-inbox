Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSGWUse>; Tue, 23 Jul 2002 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSGWUsd>; Tue, 23 Jul 2002 16:48:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1532 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318302AbSGWUrp>; Tue, 23 Jul 2002 16:47:45 -0400
Subject: [PATCH] page-writeback.c compile warning fix
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 13:50:53 -0700
Message-Id: <1027457453.931.111.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Linus,

Compile of mm/page-writeback.c gives a warning of undefined use of
"writeback_backing_dev()".

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/include/linux/backing-dev.h linux/include/linux/backing-dev.h
--- linux-2.5.27/include/linux/backing-dev.h	Sat Jul 20 12:11:12 2002
+++ linux/include/linux/backing-dev.h	Tue Jul 23 13:47:34 2002
@@ -26,5 +26,7 @@
 int writeback_acquire(struct backing_dev_info *bdi);
 int writeback_in_progress(struct backing_dev_info *bdi);
 void writeback_release(struct backing_dev_info *bdi);
+void writeback_backing_dev(struct backing_dev_info *bdi, int *nr_to_write,
+	enum writeback_sync_modes sync_mode, unsigned long *older_than_this);
 
 #endif		/* _LINUX_BACKING_DEV_H */



