Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUIGNMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUIGNMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUIGNJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:09:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268029AbUIGNDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:03:49 -0400
Date: Tue, 7 Sep 2004 14:02:27 +0100
Message-Id: <200409071302.i87D2ROd030909@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/6]: ext3 reservations: Renumber the ext3 reservations ioctls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All ext2/3 ioctls apart from these ones use 'f' as the root char for
their macro-generated ioctl numbers; make reservations consistent with
this.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h.=K0001=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h
@@ -235,8 +235,8 @@ struct ext3_new_group_data {
 #ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC_WAIT_FOR_READONLY	_IOR('f', 99, long)
 #endif
-#define EXT3_IOC_GETRSVSZ		_IOR('r', 1, long)
-#define EXT3_IOC_SETRSVSZ		_IOW('r', 2, long)
+#define EXT3_IOC_GETRSVSZ		_IOR('f', 5, long)
+#define EXT3_IOC_SETRSVSZ		_IOW('f', 6, long)
 
 /*
  * Structure of an inode on the disk
