Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVFUCkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVFUCkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVFUCjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:39:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:25316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261690AbVFTW7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:44 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Remove struct device::bus_list.
In-Reply-To: <11193083652661@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <1119308365301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Remove struct device::bus_list.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7dc35cdf69149a7f2b5216ada9bafe359746ac1c
tree bdbcaff7bc9d2ac391aae54bc4cb23ecbf93038f
parent 6eded061b1263847aedac7469339e99579aec5e5
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 13:03:35 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:18 -0700

 drivers/base/core.c    |    1 -
 include/linux/device.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -209,7 +209,6 @@ void device_initialize(struct device *de
 	kobject_init(&dev->kobj);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
-	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -263,7 +263,6 @@ extern void class_device_destroy(struct 
 
 struct device {
 	struct list_head node;		/* node in sibling list */
-	struct list_head bus_list;	/* node in bus's list */
 	struct list_head driver_list;
 	struct list_head children;
 	struct klist_node	knode_driver;

