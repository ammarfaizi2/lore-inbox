Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTD2NaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTD2NaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:30:21 -0400
Received: from verein.lst.de ([212.34.181.86]:61200 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262004AbTD2NaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:30:20 -0400
Date: Tue, 29 Apr 2003 15:42:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix devfs_register_tape stub
Message-ID: <20030429154236.A23413@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this fixes a harmless but annoying warning when compiling one of the
tape drivers without devfs.


--- 1.43/include/linux/devfs_fs_kernel.h	Sun Apr 20 19:53:06 2003
+++ edited/include/linux/devfs_fs_kernel.h	Fri Apr 25 15:21:07 2003
@@ -62,7 +70,7 @@
 static inline void devfs_remove(const char *fmt, ...)
 {
 }
-static inline int devfs_register_tape (devfs_handle_t de)
+static inline int devfs_register_tape (const char *name)
 {
     return -1;
 }
