Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWIZP4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWIZP4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIZP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:56:39 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:54519 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932137AbWIZP4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:56:37 -0400
Subject: [Patch] SCSI I/O statistics
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 26 Sep 2006 17:56:33 +0200
Message-Id: <1159286194.2925.5.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch is against 2.6.18-mm1. Please apply.

This patch makes the SCSI mid layer report statistics data, i.e. request
sizes, request latencies, request results and queue utilisation.
For sample output please see below. This data is only gathered if these
statistics have been enabled by users at run time (default is off).

It is crucial (for us) to be able to look at such kernel level data in
case of customer situations. It allows us to determine what kind of
requests might be involved in performance situations. This information
helps to understand whether one faces a device issue or a Linux issue.
Not being able to tap into performance data is regarded as a big minus
by some enterprise customers, who are reluctant to use Linux SCSI
support or Linux.

Thanks,
Martin


size_write missed 0x0
size_write 0x1000 128631
size_write 0xc000 4344
size_write 0x80000 1898
size_write 0x10000 1675
size_write 0x1e000 1483
size_write 0x1d000 1385
size_write 0x2c000 1349
size_write 0x14000 1305
size_write 0xf000 1245
size_write 0x2b000 1224
size_write 0xd000 1223
size_write 0x12000 1222
size_write 0x11000 1198
size_write 0x3a000 1186
size_write 0x1c000 1182
size_write 0x13000 1173
size_write 0x15000 1170
size_write 0x16000 1167
size_write 0x1b000 1165
size_write 0x2000 1165
size_write 0x18000 1163
size_write 0x1a000 1159
size_write 0x23000 1158
size_write 0x34000 1153
size_write 0x22000 1141
size_write 0x21000 1136
size_write 0x1f000 1136
size_write 0x19000 1135
size_write 0x24000 1134
size_write 0x17000 1132
size_write 0x25000 1127
size_write 0x27000 1124
size_write 0x28000 1113
size_write 0x26000 1113
size_write 0x2e000 1106
size_write 0xe000 1095
size_write 0x2d000 1093
size_write 0x2a000 1090
size_write 0x29000 1088
size_write 0x2f000 1083
size_write 0x37000 1070
size_write 0x30000 1069
size_write 0x74000 1067
size_write 0x39000 1066
size_write 0x48000 1061
size_write 0x33000 1053
size_write 0x73000 1052
size_write 0x31000 1044
size_write 0x32000 1039
size_write 0x20000 1035
size_write 0x35000 1030
size_write 0x36000 1005
size_write 0x77000 1005
size_write 0x3b000 1002
size_write 0x3c000 1002
size_write 0x47000 1002
size_write 0x75000 992
size_write 0x4b000 989
size_write 0x38000 986
size_write 0x46000 975
size_write 0x70000 973
size_write 0x3e000 970
size_write 0x3d000 968
size_write 0x76000 968
size_write 0x3f000 968
size_write 0x4d000 968
size_write 0x78000 965
size_write 0x7c000 963
size_write 0x71000 961
size_write 0x4c000 960
size_write 0x79000 959
size_write 0x6f000 958
size_write 0x45000 956
size_write 0x4a000 955
size_write 0x44000 953
size_write 0x72000 953
size_write 0x52000 952
size_write 0x49000 952
size_write 0x6e000 952
size_write 0x54000 952
size_write 0x56000 952
size_write 0x42000 951
size_write 0x7d000 949
size_write 0x7a000 949
size_write 0x43000 949
size_write 0x6d000 947
size_write 0x4e000 943
size_write 0x55000 940
size_write 0x7e000 938
size_write 0x53000 936
size_write 0x50000 935
size_write 0x51000 929
size_write 0x4f000 928
size_write 0x6c000 920
size_write 0x41000 918
size_write 0x5b000 917
size_write 0x59000 916
size_write 0x7b000 916
size_write 0x5a000 908
size_write 0x58000 907
size_write 0x62000 906
size_write 0x5c000 906
size_write 0x64000 906
size_write 0x5e000 901
size_write 0x57000 899
size_write 0x63000 898
size_write 0x61000 897
size_write 0x5d000 896
size_write 0x5f000 892
size_write 0x67000 891
size_write 0x65000 884
size_write 0x68000 883
size_write 0x66000 881
size_write 0x7f000 880
size_write 0x6b000 879
size_write 0x69000 868
size_write 0x6a000 862
size_write 0x40000 843
size_write 0x60000 829
size_write 0x6000 380
size_write 0xb000 377
size_write 0x4000 377
size_write 0x3000 358
size_write 0x9000 286
size_write 0x5000 274
size_write 0x8000 274
size_write 0x7000 271
size_write 0xa000 270
size_read missed 0x0
size_read 0x1000 304083
size_read 0xc000 297397
size_read 0x14000 148250
size_read 0x13000 38451
size_read 0x10000 25604
size_read 0x9000 14150
size_read 0x7000 11427
size_read 0xa000 8605
size_read 0xb000 8052
size_read 0x8000 8019
size_read 0x2000 6075
size_read 0x4000 5678
size_read 0x18000 5660
size_read 0x6000 5573
size_read 0x5000 5471
size_read 0x16000 5432
size_read 0x15000 5427
size_read 0x12000 5416
size_read 0x3000 5405
size_read 0xe000 5374
size_read 0x11000 5364
size_read 0xd000 5343
size_read 0xf000 5333
size_read 0x19000 5250
size_read 0x17000 5183
size_read 0x1a000 4740
size_read 0x1b000 4735
size_read 0x37000 4216
size_read 0x3b000 3988
size_read 0x41000 3720
size_read 0x49000 3697
size_read 0x26000 3241
size_read 0x2b000 2965
size_read 0x1c000 2825
size_read 0x27000 2818
size_read 0x1d000 2794
size_read 0x23000 2793
size_read 0x20000 2780
size_read 0x1f000 2778
size_read 0x1e000 2771
size_read 0x25000 2771
size_read 0x24000 2766
size_read 0x21000 2764
size_read 0x22000 2763
size_read 0x2a000 2746
size_read 0x28000 2699
size_read 0x29000 2693
size_read 0x2c000 2679
size_read 0x2d000 2659
size_read 0x34000 2651
size_read 0x2e000 2641
size_read 0x2f000 2587
size_read 0x30000 2553
size_read 0x31000 2530
size_read 0x33000 2502
size_read 0x32000 2495
size_read 0x35000 2494
size_read 0x36000 2460
size_read 0x42000 2404
size_read 0x38000 2397
size_read 0x39000 2357
size_read 0x3a000 2345
size_read 0x3c000 2337
size_read 0x3e000 2335
size_read 0x3d000 2324
size_read 0x3f000 2315
size_read 0x40000 2293
size_read 0x43000 2282
size_read 0x44000 2218
size_read 0x46000 2213
size_read 0x45000 2206
size_read 0x47000 2185
size_read 0x48000 2159
size_read 0x4a000 2060
size_read 0x4b000 1972
size_read 0x4c000 1840
size_read 0x4d000 1771
size_read 0x4f000 1739
size_read 0x4e000 1737
size_read 0x50000 1731
size_read 0x54000 1664
size_read 0x5a000 1664
size_read 0x58000 1664
size_read 0x55000 1664
size_read 0x56000 1664
size_read 0x57000 1663
size_read 0x59000 1663
size_read 0x53000 1659
size_read 0x52000 1657
size_read 0x51000 1655
size_read 0x5c000 1512
size_read 0x5f000 1512
size_read 0x5b000 1511
size_read 0x5e000 1511
size_read 0x5d000 1510
size_read 0x60000 1357
size_read 0x61000 252
latency_write <=0 0
latency_write <=1000 46530
latency_write <=2000 41820
latency_write <=4000 21842
latency_write <=8000 21369
latency_write <=16000 24324
latency_write <=32000 35888
latency_write <=64000 32587
latency_write <=128000 32487
latency_write <=256000 88
latency_write <=512000 0
latency_write <=1024000 0
latency_write >1024000 0
latency_read <=0 0
latency_read <=1000 496195
latency_read <=2000 364485
latency_read <=4000 191480
latency_read <=8000 58985
latency_read <=16000 6100
latency_read <=32000 73
latency_read <=64000 8
latency_read <=128000 3
latency_read <=256000 6
latency_read <=512000 3
latency_read <=1024000 0
latency_read >1024000 0
latency_nodata <=0 0
latency_nodata <=1000 1041
latency_nodata <=2000 30
latency_nodata <=4000 13
latency_nodata <=8000 1
latency_nodata <=16000 0
latency_nodata <=32000 0
latency_nodata <=64000 0
latency_nodata <=128000 0
latency_nodata <=256000 0
latency_nodata <=512000 0
latency_nodata <=1024000 0
latency_nodata >1024000 0
result missed 0x0
result 0x0 1375358
queue_used_depth 1375459 1 4.749 32 102.764


Signed-off-by: Martin Peschke <mp3@de.ibm.com> 
---

 drivers/scsi/scsi.c        |    7 +++++
 drivers/scsi/scsi_lib.c    |   26 +++++++++++++++++++
 drivers/scsi/scsi_scan.c   |   61 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/scsi_sysfs.c  |    2 +
 include/linux/time.h       |   14 +++++++++-
 include/scsi/scsi_cmnd.h   |    3 ++
 include/scsi/scsi_device.h |   15 +++++++++++
 7 files changed, 126 insertions(+), 2 deletions(-)

diff -urp a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h	2006-09-18 09:23:10.000000000 +0200
+++ b/include/scsi/scsi_device.h	2006-09-18 11:22:00.000000000 +0200
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/statistic.h>
 #include <asm/atomic.h>
 
 struct request_queue;
@@ -45,6 +46,17 @@ enum scsi_device_state {
 				 * to the scsi lld. */
 };
 
+enum scsi_unit_stats {
+	SCSI_STAT_U_SW,		/* size, write */
+	SCSI_STAT_U_SR,		/* size, read */
+	SCSI_STAT_U_LW,		/* latency, write */
+	SCSI_STAT_U_LR,		/* latency, read */
+	SCSI_STAT_U_LN,		/* latency, no data */
+	SCSI_STAT_U_R,		/* result */
+	SCSI_STAT_U_QUD,	/* queue used depth */
+	_SCSI_STAT_U_NUMBER,
+};
+
 struct scsi_device {
 	struct Scsi_Host *host;
 	struct request_queue *request_queue;
@@ -133,6 +145,9 @@ struct scsi_device {
 	atomic_t iodone_cnt;
 	atomic_t ioerr_cnt;
 
+	struct statistic_interface stat_if;
+	struct statistic	   stat[_SCSI_STAT_U_NUMBER];
+
 	int timeout;
 
 	struct device		sdev_gendev;
diff -urp a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
--- a/include/scsi/scsi_cmnd.h	2006-09-18 09:23:10.000000000 +0200
+++ b/include/scsi/scsi_cmnd.h	2006-09-18 09:54:06.000000000 +0200
@@ -54,6 +54,9 @@ struct scsi_cmnd {
 	 */
 	unsigned long jiffies_at_alloc;
 
+	struct timeval issued;
+	struct timeval received;
+
 	int retries;
 	int allowed;
 	int timeout_per_command;
diff -urp a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	2006-09-18 09:23:08.000000000 +0200
+++ b/drivers/scsi/scsi_scan.c	2006-09-18 11:21:38.000000000 +0200
@@ -133,6 +133,54 @@ static void scsi_unlock_floptical(struct
 			 SCSI_TIMEOUT, 3);
 }
 
+static struct statistic_info scsi_statinfo_u[] = {
+	[SCSI_STAT_U_SW] = {
+		.name	  = "size_write",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[SCSI_STAT_U_SR] = {
+		.name	  = "size_read",
+		.x_unit	  = "bytes",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[SCSI_STAT_U_LW] = {
+		.name	  = "latency_write",
+		.x_unit	  = "microsec",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_log2 entries=13 "
+			    "base_interval=1000 range_min=0"
+	},
+	[SCSI_STAT_U_LR] = {
+		.name	  = "latency_read",
+		.x_unit	  = "microsec",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_log2 entries=13 "
+			    "base_interval=1000 range_min=0"
+	},
+	[SCSI_STAT_U_LN] = {
+		.name	  = "latency_nodata",
+		.x_unit	  = "microsec",
+		.y_unit	  = "request",
+		.defaults = "type=histogram_log2 entries=13 "
+			    "base_interval=1000 range_min=0"
+	},
+	[SCSI_STAT_U_R] = {
+		.name	  = "result",
+		.x_unit	  = "flags",
+		.y_unit	  = "request",
+		.defaults = "type=sparse entries=256"
+	},
+	[SCSI_STAT_U_QUD] = {
+		.name	  = "queue_used_depth",
+		.x_unit	  = "requests",
+		.y_unit   = "",
+		.defaults = "type=utilisation"
+	}
+};
+
 /**
  * scsi_alloc_sdev - allocate and setup a scsi_Device
  *
@@ -150,6 +198,7 @@ static struct scsi_device *scsi_alloc_sd
 	struct scsi_device *sdev;
 	int display_failure_msg = 1, ret;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	char name[64];
 
 	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
 		       GFP_ATOMIC);
@@ -206,6 +255,14 @@ static struct scsi_device *scsi_alloc_sd
 
 	scsi_sysfs_device_initialize(sdev);
 
+ 	sprintf(name, "scsi-%d:%d:%d:%d", sdev->host->host_no, sdev->channel,
+ 		sdev->id, sdev->lun);
+ 	sdev->stat_if.stat = sdev->stat;
+ 	sdev->stat_if.info = scsi_statinfo_u;
+ 	sdev->stat_if.number = _SCSI_STAT_U_NUMBER;
+ 	if (statistic_create(&sdev->stat_if, name))
+		goto out_device_destroy;
+
 	if (shost->hostt->slave_alloc) {
 		ret = shost->hostt->slave_alloc(sdev);
 		if (ret) {
@@ -215,12 +272,14 @@ static struct scsi_device *scsi_alloc_sd
 			 */
 			if (ret == -ENXIO)
 				display_failure_msg = 0;
-			goto out_device_destroy;
+			goto out_stat_destroy;
 		}
 	}
 
 	return sdev;
 
+out_stat_destroy:
+	statistic_remove(&sdev->stat_if);
 out_device_destroy:
 	transport_destroy_device(&sdev->sdev_gendev);
 	put_device(&sdev->sdev_gendev);
diff -urp a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	2006-09-18 09:23:08.000000000 +0200
+++ b/drivers/scsi/scsi_sysfs.c	2006-09-18 09:47:13.000000000 +0200
@@ -247,6 +247,8 @@ static void scsi_device_dev_release_user
 
 	scsi_target_reap(scsi_target(sdev));
 
+	statistic_remove(&sdev->stat_if);
+
 	kfree(sdev->inquiry);
 	kfree(sdev);
 
diff -urp a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	2006-09-18 09:23:08.000000000 +0200
+++ b/drivers/scsi/scsi.c	2006-09-18 11:04:44.000000000 +0200
@@ -582,6 +582,9 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		cmd->result = (DID_NO_CONNECT << 16);
 		scsi_done(cmd);
 	} else {
+#ifdef CONFIG_STATISTICS
+		do_gettimeofday(&cmd->issued);
+#endif
 		rtn = host->hostt->queuecommand(cmd, scsi_done);
 	}
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -653,6 +656,10 @@ void __scsi_done(struct scsi_cmnd *cmd)
 {
 	struct request *rq = cmd->request;
 
+#ifdef CONFIG_STATISTICS
+	do_gettimeofday(&cmd->received);
+#endif
+
 	/*
 	 * Set the serial numbers back to zero
 	 */
diff -urp a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2006-09-18 09:23:08.000000000 +0200
+++ b/drivers/scsi/scsi_lib.c	2006-09-18 11:22:29.000000000 +0200
@@ -1358,6 +1358,30 @@ static void scsi_kill_request(struct req
 	__scsi_done(cmd);
 }
 
+static void scsi_stat_completion(struct scsi_cmnd *cmd)
+{
+#ifdef CONFIG_STATISTICS
+	struct statistic *stat = cmd->device->stat;
+	unsigned size = cmd->request_bufflen;
+	s64 issued = timeval_to_us(&cmd->issued);
+	s64 received = timeval_to_us(&cmd->received);
+	s64 latency = received - issued;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	_statistic_inc(stat, SCSI_STAT_U_R, cmd->result);
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		_statistic_inc(stat, SCSI_STAT_U_SW, size);
+		_statistic_inc(stat, SCSI_STAT_U_LW, latency);
+	} else if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
+		_statistic_inc(stat, SCSI_STAT_U_SR, size);
+		_statistic_inc(stat, SCSI_STAT_U_LR, latency);
+	} else if (cmd->sc_data_direction == DMA_NONE)
+		_statistic_inc(stat, SCSI_STAT_U_LN, latency);
+	local_irq_restore(flags);
+#endif
+}
+
 static void scsi_softirq_done(struct request *rq)
 {
 	struct scsi_cmnd *cmd = rq->completion_data;
@@ -1376,6 +1400,7 @@ static void scsi_softirq_done(struct req
 	}
 			
 	scsi_log_completion(cmd, disposition);
+	scsi_stat_completion(cmd);
 
 	switch (disposition) {
 		case SUCCESS:
@@ -1452,6 +1477,7 @@ static void scsi_request_fn(struct reque
 		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
 			blkdev_dequeue_request(req);
 		sdev->device_busy++;
+		statistic_inc(sdev->stat, SCSI_STAT_U_QUD, sdev->device_busy);
 
 		spin_unlock(q->queue_lock);
 		cmd = req->special;
diff -urp a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	2006-09-18 09:23:10.000000000 +0200
+++ b/include/linux/time.h	2006-09-18 09:49:30.000000000 +0200
@@ -132,8 +132,20 @@ static inline s64 timespec_to_ns(const s
 }
 
 /**
+ * timeval_to_us - Convert timeval to microseconds
+ * @tv:		pointer to the timeval variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timeval
+ * parameter.
+ */
+static inline s64 timeval_to_us(const struct timeval *tv)
+{
+	return ((s64) tv->tv_sec * USEC_PER_SEC) + tv->tv_usec;
+}
+
+/**
  * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
+ * @tv:		pointer to the timeval variable to be converted
  *
  * Returns the scalar nanosecond representation of the timeval
  * parameter.



