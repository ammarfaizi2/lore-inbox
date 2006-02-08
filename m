Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWBHDT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWBHDT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWBHDT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:64640 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030479AbWBHDTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:17 -0500
To: torvalds@osdl.org
Subject: [PATCH 17/29] fix __user annotations in drivers/base/memory.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frR-0006DE-3U@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791976 -0500

sysfs store doesn't deal with userland pointers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/base/memory.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

be7ee9b2f5ef11448f79c2ff7f47eb21b7c008b4
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d1a0522..105a0d6 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -303,7 +303,7 @@ static int block_size_init(void)
  */
 #ifdef CONFIG_ARCH_MEMORY_PROBE
 static ssize_t
-memory_probe_store(struct class *class, const char __user *buf, size_t count)
+memory_probe_store(struct class *class, const char *buf, size_t count)
 {
 	u64 phys_addr;
 	int ret;
-- 
0.99.9.GIT

