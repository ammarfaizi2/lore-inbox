Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTITN16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTITN16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:27:58 -0400
Received: from verein.lst.de ([212.34.189.10]:58497 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261879AbTITN14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:27:56 -0400
Date: Sat, 20 Sep 2003 15:27:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill superflous kdev_t.h inclusions
Message-ID: <20030920132752.GB23153@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

now that kdev_t is gone very few places needs this still, the only
header of those beeing fs.h


--- 1.33/include/linux/bio.h	Fri Jul 25 20:09:32 2003
+++ edited/include/linux/bio.h	Fri Sep 19 12:09:17 2003
@@ -20,7 +20,6 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
-#include <linux/kdev_t.h>
 #include <linux/highmem.h>
 #include <linux/mempool.h>
 
--- 1.8/include/linux/console.h	Mon May 26 08:17:30 2003
+++ edited/include/linux/console.h	Fri Sep 19 12:09:11 2003
@@ -15,7 +15,6 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/types.h>
-#include <linux/kdev_t.h>
 #include <linux/spinlock.h>
 
 struct vc_data;
--- 1.46/include/linux/devfs_fs_kernel.h	Tue May 13 06:23:09 2003
+++ edited/include/linux/devfs_fs_kernel.h	Fri Sep 19 12:09:05 2003
@@ -4,7 +4,6 @@
 #include <linux/fs.h>
 #include <linux/config.h>
 #include <linux/spinlock.h>
-#include <linux/kdev_t.h>
 #include <linux/types.h>
 
 #include <asm/semaphore.h>
--- 1.77/include/linux/swap.h	Thu May  8 06:19:58 2003
+++ edited/include/linux/swap.h	Fri Sep 19 12:08:58 2003
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/spinlock.h>
-#include <linux/kdev_t.h>
 #include <linux/linkage.h>
 #include <linux/mmzone.h>
 #include <linux/list.h>
