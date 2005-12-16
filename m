Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVLPAbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVLPAbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVLPAa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:56 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:5060 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751205AbVLPAap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:45 -0500
Message-ID: <43A20AB1.6060408@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:41 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] I2O: Lindent run
Content-Type: multipart/mixed;
 boundary="------------040600000804030905020603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600000804030905020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Lindent run

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------040600000804030905020603
Content-Type: text/x-patch;
 name="i2o-lindent-run.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-lindent-run.patch"

Index: linux-2.6/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/device.c
+++ linux-2.6/drivers/message/i2o/device.c
@@ -43,7 +43,7 @@ static inline int i2o_device_issue_claim
 
 	msg->u.head[0] = cpu_to_le32(FIVE_WORD_MSG_SIZE | SGL_OFFSET_0);
 	msg->u.head[1] =
-		cpu_to_le32(cmd << 24 | HOST_TID << 12 | dev->lct_data.tid);
+	    cpu_to_le32(cmd << 24 | HOST_TID << 12 | dev->lct_data.tid);
 	msg->body[0] = cpu_to_le32(type);
 
 	return i2o_msg_post_wait(dev->iop, msg, 60);
@@ -123,7 +123,6 @@ int i2o_device_claim_release(struct i2o_
 	return rc;
 }
 
-
 /**
  *	i2o_device_release - release the memory for a I2O device
  *	@dev: I2O device which should be released
@@ -140,7 +139,6 @@ static void i2o_device_release(struct de
 	kfree(i2o_dev);
 }
 
-
 /**
  *	i2o_device_show_class_id - Displays class id of I2O device
  *	@dev: device of which the class id should be displayed
@@ -250,10 +248,10 @@ static struct i2o_device *i2o_device_add
 
 	/* create user entries refering to this device */
 	list_for_each_entry(tmp, &c->devices, list)
-		if ((tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
-		    && (tmp != i2o_dev))
-		    sysfs_create_link(&tmp->device.kobj,
-				      &i2o_dev->device.kobj, "user");
+	    if ((tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
+		&& (tmp != i2o_dev))
+		sysfs_create_link(&tmp->device.kobj,
+				  &i2o_dev->device.kobj, "user");
 
 	/* create parent entries for this device */
 	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
@@ -263,10 +261,10 @@ static struct i2o_device *i2o_device_add
 
 	/* create parent entries refering to this device */
 	list_for_each_entry(tmp, &c->devices, list)
-		if ((tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
-		    && (tmp != i2o_dev))
-			sysfs_create_link(&tmp->device.kobj,
-					  &i2o_dev->device.kobj, "parent");
+	    if ((tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
+		&& (tmp != i2o_dev))
+		sysfs_create_link(&tmp->device.kobj,
+				  &i2o_dev->device.kobj, "parent");
 
 	i2o_driver_notify_device_add_all(i2o_dev);
 
@@ -410,7 +408,6 @@ int i2o_device_parse_lct(struct i2o_cont
 	return 0;
 }
 
-
 /*
  *	Run time support routines
  */
Index: linux-2.6/drivers/message/i2o/exec-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/exec-osm.c
+++ linux-2.6/drivers/message/i2o/exec-osm.c
@@ -33,7 +33,7 @@
 #include <linux/workqueue.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/sched.h>   /* wait_event_interruptible_timeout() needs this */
+#include <linux/sched.h>	/* wait_event_interruptible_timeout() needs this */
 #include <asm/param.h>		/* HZ */
 #include "core.h"
 
Index: linux-2.6/drivers/message/i2o/i2o_lan.h
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_lan.h
+++ linux-2.6/drivers/message/i2o/i2o_lan.h
@@ -103,14 +103,14 @@
 #define I2O_LAN_DSC_SUSPENDED			0x11
 
 struct i2o_packet_info {
-	u32 offset : 24;
-	u32 flags  : 8;
-	u32 len    : 24;
-	u32 status : 8;
+	u32 offset:24;
+	u32 flags:8;
+	u32 len:24;
+	u32 status:8;
 };
 
 struct i2o_bucket_descriptor {
-	u32 context; 			/* FIXME: 64bit support */
+	u32 context;		/* FIXME: 64bit support */
 	struct i2o_packet_info packet_info[1];
 };
 
@@ -127,14 +127,14 @@ struct i2o_lan_local {
 	u8 unit;
 	struct i2o_device *i2o_dev;
 
-	struct fddi_statistics stats;   /* see also struct net_device_stats */
-	unsigned short (*type_trans)(struct sk_buff *, struct net_device *);
-	atomic_t buckets_out;  		/* nbr of unused buckets on DDM */
-	atomic_t tx_out;		/* outstanding TXes */
-	u8 tx_count;  			/* packets in one TX message frame */
-	u16 tx_max_out;	   		/* DDM's Tx queue len */
-	u8 sgl_max;			/* max SGLs in one message frame */
-	u32 m;				/* IOP address of the batch msg frame */
+	struct fddi_statistics stats;	/* see also struct net_device_stats */
+	unsigned short (*type_trans) (struct sk_buff *, struct net_device *);
+	atomic_t buckets_out;	/* nbr of unused buckets on DDM */
+	atomic_t tx_out;	/* outstanding TXes */
+	u8 tx_count;		/* packets in one TX message frame */
+	u16 tx_max_out;		/* DDM's Tx queue len */
+	u8 sgl_max;		/* max SGLs in one message frame */
+	u32 m;			/* IOP address of the batch msg frame */
 
 	struct work_struct i2o_batch_send_task;
 	int send_active;
@@ -144,16 +144,16 @@ struct i2o_lan_local {
 
 	spinlock_t tx_lock;
 
-	u32 max_size_mc_table;		/* max number of multicast addresses */
+	u32 max_size_mc_table;	/* max number of multicast addresses */
 
 	/* LAN OSM configurable parameters are here: */
 
-	u16 max_buckets_out;		/* max nbr of buckets to send to DDM */
-	u16 bucket_thresh;		/* send more when this many used */
+	u16 max_buckets_out;	/* max nbr of buckets to send to DDM */
+	u16 bucket_thresh;	/* send more when this many used */
 	u16 rx_copybreak;
 
-	u8  tx_batch_mode;		/* Set when using batch mode sends */
-	u32 i2o_event_mask;		/* To turn on interesting event flags */
+	u8 tx_batch_mode;	/* Set when using batch mode sends */
+	u32 i2o_event_mask;	/* To turn on interesting event flags */
 };
 
-#endif /* _I2O_LAN_H */
+#endif				/* _I2O_LAN_H */

--------------040600000804030905020603--
