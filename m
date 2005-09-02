Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030628AbVIBBYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbVIBBYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbVIBBYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:24:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32016 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030305AbVIBBX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:23:56 -0400
Date: Fri, 2 Sep 2005 03:23:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/cramfs/uncompress.c should #include <linux/cramfs_fs.h> (fwd)
Message-ID: <20050902012355.GO3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header with the prototypes of the global 
functions it is offering.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Aug 2005

--- linux-2.6.13-rc6-mm1-full/fs/cramfs/uncompress.c.old	2005-08-23 01:56:47.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/fs/cramfs/uncompress.c	2005-08-23 01:57:09.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
+#include <linux/cramfs_fs.h>
 
 static z_stream stream;
 static int initialized;

