Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVJYFUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVJYFUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVJYFUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:20:36 -0400
Received: from xenotime.net ([66.160.160.81]:20899 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751458AbVJYFUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:20:35 -0400
Date: Mon, 24 Oct 2005 22:20:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-docs: fix kernel-doc format problems
Message-Id: <20051024222033.795810e0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Convert to proper kernel-doc format.
Some have extra blank lines (not allowed immed. after the function
name) or need blank lines (after all parameters).
Function summary must be only one line.
Colon (":") in a function description does weird things (causes
kernel-doc to think that it's a new section head sadly).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/block/ll_rw_blk.c |    1 -
 fs/fs-writeback.c         |    5 +++--
 include/linux/kernel.h    |    1 -
 kernel/sys.c              |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff -Naurp linux-2614-rc5/drivers/block/ll_rw_blk.c~kdoc_no_blank_lines linux-2614-rc5/drivers/block/ll_rw_blk.c
--- linux-2614-rc5/drivers/block/ll_rw_blk.c~kdoc_no_blank_lines	2005-10-20 18:55:31.000000000 -0700
+++ linux-2614-rc5/drivers/block/ll_rw_blk.c	2005-10-23 12:17:01.000000000 -0700
@@ -706,7 +706,6 @@ EXPORT_SYMBOL(blk_queue_dma_alignment);
 
 /**
  * blk_queue_find_tag - find a request by its tag and queue
- *
  * @q:	 The request queue for the device
  * @tag: The tag of the request
  *
diff -Naurp linux-2614-rc5/fs/fs-writeback.c~kdoc_no_blank_lines linux-2614-rc5/fs/fs-writeback.c
--- linux-2614-rc5/fs/fs-writeback.c~kdoc_no_blank_lines	2005-10-23 12:20:00.000000000 -0700
+++ linux-2614-rc5/fs/fs-writeback.c	2005-10-24 21:32:55.000000000 -0700
@@ -602,7 +602,7 @@ EXPORT_SYMBOL(sync_inode);
  * O_SYNC flag set, to flush dirty writes to disk.
  *
  * @what is a bitmask, specifying which part of the inode's data should be
- * written and waited upon:
+ * written and waited upon.
  *
  *    OSYNC_DATA:     i_mapping's dirty data
  *    OSYNC_METADATA: the buffers at i_mapping->private_list
@@ -668,8 +668,9 @@ int writeback_acquire(struct backing_dev
 
 /**
  * writeback_in_progress: determine whether there is writeback in progress
- *                        against a backing device.
  * @bdi: the device's backing_dev_info structure.
+ *
+ * Determine whether there is writeback in progress against a backing device.
  */
 int writeback_in_progress(struct backing_dev_info *bdi)
 {
diff -Naurp linux-2614-rc5/include/linux/kernel.h~kdoc_no_blank_lines linux-2614-rc5/include/linux/kernel.h
--- linux-2614-rc5/include/linux/kernel.h~kdoc_no_blank_lines	2005-10-20 18:55:37.000000000 -0700
+++ linux-2614-rc5/include/linux/kernel.h	2005-10-23 12:11:34.000000000 -0700
@@ -266,7 +266,6 @@ extern void dump_stack(void);
 
 /**
  * container_of - cast a member of a structure out to the containing structure
- *
  * @ptr:	the pointer to the member.
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
diff -Naurp linux-2614-rc5/kernel/sys.c~kdoc_no_blank_lines linux-2614-rc5/kernel/sys.c
--- linux-2614-rc5/kernel/sys.c~kdoc_no_blank_lines	2005-10-23 10:28:34.000000000 -0700
+++ linux-2614-rc5/kernel/sys.c	2005-10-23 14:47:14.000000000 -0700
@@ -385,7 +385,7 @@ void kernel_restart_prepare(char *cmd)
 /**
  *	kernel_restart - reboot the system
  *	@cmd: pointer to buffer containing command to execute for restart
- *		or NULL
+ *		or %NULL
  *
  *	Shutdown everything and perform a clean reboot.
  *	This is not safe to call in interrupt context.


---
~Randy
