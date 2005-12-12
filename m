Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVLLXwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVLLXwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVLLXvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:51:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932272AbVLLXqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:49 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmUF009043@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 9/19] MUTEX: Drivers L-M changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/l* thru drivers/m* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-LtoM-2615rc5.diff
 drivers/macintosh/adb.c                           |    2 +-
 drivers/macintosh/mediabay.c                      |    2 +-
 drivers/macintosh/therm_windtunnel.c              |    2 +-
 drivers/md/dm-raid1.c                             |   10 +++++-----
 drivers/md/dm.c                                   |    2 +-
 drivers/md/kcopyd.c                               |    2 +-
 drivers/media/dvb/b2c2/flexcop-common.h           |    2 +-
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    2 +-
 drivers/media/dvb/bt8xx/bt878.h                   |    2 +-
 drivers/media/dvb/bt8xx/dst.c                     |    2 +-
 drivers/media/dvb/bt8xx/dst_common.h              |    2 +-
 drivers/media/dvb/bt8xx/dvb-bt8xx.h               |    2 +-
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    2 +-
 drivers/media/dvb/dvb-core/dmxdev.c               |    4 ++--
 drivers/media/dvb/dvb-core/dmxdev.h               |    6 +++---
 drivers/media/dvb/dvb-core/dvb_demux.c            |    2 +-
 drivers/media/dvb/dvb-core/dvb_demux.h            |    4 ++--
 drivers/media/dvb/dvb-core/dvb_frontend.c         |    4 ++--
 drivers/media/dvb/dvb-core/dvb_frontend.h         |    2 +-
 drivers/media/dvb/dvb-core/dvb_net.c              |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb-init.c          |    4 ++--
 drivers/media/dvb/dvb-usb/dvb-usb.h               |    4 ++--
 drivers/media/dvb/frontends/bcm3510.c             |    4 ++--
 drivers/media/dvb/ttpci/av7110.c                  |    8 ++++----
 drivers/media/dvb/ttpci/av7110.h                  |    6 +++---
 drivers/media/dvb/ttpci/budget.h                  |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   10 +++++-----
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |   10 +++++-----
 drivers/media/radio/miropcm20-rds-core.c          |    4 ++--
 drivers/media/radio/radio-aimslab.c               |    4 ++--
 drivers/media/radio/radio-aztech.c                |    2 +-
 drivers/media/radio/radio-maestro.c               |    4 ++--
 drivers/media/radio/radio-maxiradio.c             |    4 ++--
 drivers/media/radio/radio-sf16fmi.c               |    4 ++--
 drivers/media/radio/radio-sf16fmr2.c              |    4 ++--
 drivers/media/radio/radio-typhoon.c               |    2 +-
 drivers/media/radio/radio-zoltrix.c               |    2 +-
 drivers/media/video/arv.c                         |    4 ++--
 drivers/media/video/bttvp.h                       |    4 ++--
 drivers/media/video/bw-qcam.c                     |    2 +-
 drivers/media/video/bw-qcam.h                     |    2 +-
 drivers/media/video/c-qcam.c                      |    4 ++--
 drivers/media/video/cpia.c                        |    2 +-
 drivers/media/video/cpia.h                        |    4 ++--
 drivers/media/video/cx88/cx88.h                   |    2 +-
 drivers/media/video/em28xx/em28xx.h               |    2 +-
 drivers/media/video/ir-kbd-i2c.c                  |    2 +-
 drivers/media/video/meye.h                        |    2 +-
 drivers/media/video/msp3400.c                     |    2 +-
 drivers/media/video/planb.c                       |    2 +-
 drivers/media/video/planb.h                       |    2 +-
 drivers/media/video/pms.c                         |    2 +-
 drivers/media/video/saa5246a.c                    |    2 +-
 drivers/media/video/saa5249.c                     |    2 +-
 drivers/media/video/saa7134/saa7134.h             |    4 ++--
 drivers/media/video/tvmixer.c                     |    2 +-
 drivers/media/video/videodev.c                    |    2 +-
 drivers/media/video/vino.c                        |    4 ++--
 drivers/media/video/zoran.h                       |    2 +-
 drivers/message/fusion/mptbase.h                  |    4 ++--
 drivers/message/fusion/mptctl.c                   |    2 +-
 drivers/mfd/ucb1x00-core.c                        |    4 ++--
 drivers/mfd/ucb1x00-ts.c                          |    2 +-
 drivers/mmc/mmc_queue.h                           |    2 +-
 drivers/mtd/devices/blkmtd.c                      |    2 +-
 drivers/mtd/devices/block2mtd.c                   |    2 +-
 drivers/mtd/mtd_blkdevs.c                         |    4 ++--
 drivers/mtd/mtdblock.c                            |    2 +-
 68 files changed, 108 insertions(+), 108 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/adb.c linux-2.6.15-rc5-mutex/drivers/macintosh/adb.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/adb.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/adb.c	2005-12-12 22:12:49.000000000 +0000
@@ -39,7 +39,7 @@
 #include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/mediabay.c linux-2.6.15-rc5-mutex/drivers/macintosh/mediabay.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/mediabay.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/mediabay.c	2005-12-12 21:45:18.000000000 +0000
@@ -78,7 +78,7 @@ struct media_bay_info {
 	int				index;
 	int				cached_gpio;
 	int				sleeping;
-	struct semaphore		lock;
+	struct mutex			lock;
 #ifdef CONFIG_BLK_DEV_IDE
 	void __iomem			*cd_base;
 	int 				cd_index;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/therm_windtunnel.c linux-2.6.15-rc5-mutex/drivers/macintosh/therm_windtunnel.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/macintosh/therm_windtunnel.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/macintosh/therm_windtunnel.c	2005-12-12 21:45:18.000000000 +0000
@@ -64,7 +64,7 @@ static struct {
 	struct completion	completion;
 	pid_t			poll_task;
 	
-	struct semaphore 	lock;
+	struct mutex		lock;
 	struct of_device	*of_dev;
 	
 	struct i2c_client	*thermostat;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/md/dm.c linux-2.6.15-rc5-mutex/drivers/md/dm.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/md/dm.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/dm.c	2005-12-12 20:57:20.000000000 +0000
@@ -58,7 +58,7 @@ union map_info *dm_get_mapinfo(struct bi
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
-	struct semaphore suspend_lock;
+	struct mutex suspend_lock;
 	rwlock_t map_lock;
 	atomic_t holders;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/md/dm-raid1.c linux-2.6.15-rc5-mutex/drivers/md/dm-raid1.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/md/dm-raid1.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/dm-raid1.c	2005-12-12 20:31:51.000000000 +0000
@@ -358,7 +358,7 @@ static void rh_update_states(struct regi
 		rh->log->type->clear_region(rh->log, reg->key);
 		rh->log->type->complete_resync_work(rh->log, reg->key, 1);
 		dispatch_bios(rh->ms, &reg->delayed_bios);
-		up(&rh->recovery_count);
+		up_sem(&rh->recovery_count);
 		mempool_free(reg, rh->region_pool);
 	}
 
@@ -468,9 +468,9 @@ static int __rh_recovery_prepare(struct 
 
 static void rh_recovery_prepare(struct region_hash *rh)
 {
-	while (!down_trylock(&rh->recovery_count))
+	while (!down_sem_trylock(&rh->recovery_count))
 		if (__rh_recovery_prepare(rh) <= 0) {
-			up(&rh->recovery_count);
+			up_sem(&rh->recovery_count);
 			break;
 		}
 }
@@ -526,7 +526,7 @@ static void rh_stop_recovery(struct regi
 
 	/* wait for any recovering regions */
 	for (i = 0; i < MAX_RECOVERY; i++)
-		down(&rh->recovery_count);
+		down_sem(&rh->recovery_count);
 }
 
 static void rh_start_recovery(struct region_hash *rh)
@@ -534,7 +534,7 @@ static void rh_start_recovery(struct reg
 	int i;
 
 	for (i = 0; i < MAX_RECOVERY; i++)
-		up(&rh->recovery_count);
+		up_sem(&rh->recovery_count);
 
 	wake();
 }
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/md/kcopyd.c linux-2.6.15-rc5-mutex/drivers/md/kcopyd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/md/kcopyd.c	2005-03-02 12:08:10.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/md/kcopyd.c	2005-12-12 20:57:05.000000000 +0000
@@ -191,7 +191,7 @@ struct kcopyd_job {
 	 * These fields are only used if the job has been split
 	 * into more manageable parts.
 	 */
-	struct semaphore lock;
+	struct mutex lock;
 	atomic_t sub_jobs;
 	sector_t progress;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/b2c2/flexcop-common.h linux-2.6.15-rc5-mutex/drivers/media/dvb/b2c2/flexcop-common.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/b2c2/flexcop-common.h	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/b2c2/flexcop-common.h	2005-12-12 20:02:23.000000000 +0000
@@ -73,7 +73,7 @@ struct flexcop_device {
 	int (*fe_sleep) (struct dvb_frontend *);
 
 	struct i2c_adapter i2c_adap;
-	struct semaphore i2c_sem;
+	struct mutex i2c_sem;
 
 	struct module *owner;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/b2c2/flexcop-i2c.c linux-2.6.15-rc5-mutex/drivers/media/dvb/b2c2/flexcop-i2c.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-12-12 20:01:59.000000000 +0000
@@ -180,7 +180,7 @@ int flexcop_i2c_init(struct flexcop_devi
 {
 	int ret;
 
-	sema_init(&fc->i2c_sem,1);
+	init_MUTEX(&fc->i2c_sem);
 
 	memset(&fc->i2c_adap, 0, sizeof(struct i2c_adapter));
 	strncpy(fc->i2c_adap.name, "B2C2 FlexCop device",I2C_NAME_SIZE);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/bt878.h linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/bt878.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/bt878.h	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/bt878.h	2005-12-12 21:01:28.000000000 +0000
@@ -91,7 +91,7 @@
 extern int bt878_num;
 
 struct bt878 {
-	struct semaphore  gpio_lock;
+	struct mutex  gpio_lock;
 	unsigned int nr;
 	unsigned int bttv_nr;
 	struct i2c_adapter *adapter;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dst.c linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dst.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dst.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dst.c	2005-12-12 20:05:44.000000000 +0000
@@ -910,7 +910,7 @@ static int dst_get_device_id(struct dst_
 
 static int dst_probe(struct dst_state *state)
 {
-	sema_init(&state->dst_mutex, 1);
+	init_MUTEX(&state->dst_mutex);
 	if ((rdc_8820_reset(state)) < 0) {
 		dprintk(verbose, DST_ERROR, 1, "RDC 8820 RESET Failed.");
 		return -1;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dst_common.h linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dst_common.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dst_common.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dst_common.h	2005-12-12 20:05:57.000000000 +0000
@@ -121,7 +121,7 @@ struct dst_state {
 	u8 vendor[8];
 	u8 board_info[8];
 
-	struct semaphore dst_mutex;
+	struct mutex dst_mutex;
 };
 
 struct dst_types {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-12-12 21:01:24.000000000 +0000
@@ -38,7 +38,7 @@
 #include "lgdt330x.h"
 
 struct dvb_bt8xx_card {
-	struct semaphore lock;
+	struct mutex lock;
 	int nfeeds;
 	char card_name[32];
 	struct dvb_adapter dvb_adapter;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/cinergyT2/cinergyT2.c linux-2.6.15-rc5-mutex/drivers/media/dvb/cinergyT2/cinergyT2.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-12-12 21:01:13.000000000 +0000
@@ -116,7 +116,7 @@ static struct dvb_frontend_info cinergyt
 struct cinergyt2 {
 	struct dvb_demux demux;
 	struct usb_device *udev;
-	struct semaphore sem;
+	struct mutex sem;
 	struct dvb_adapter adapter;
 	struct dvb_device *fedev;
 	struct dmxdev dmxdev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dmxdev.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dmxdev.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dmxdev.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dmxdev.c	2005-12-12 20:01:25.000000000 +0000
@@ -701,7 +701,7 @@ static int dvb_demux_open(struct inode *
 	}
 
 	dmxdevfilter=&dmxdev->filter[i];
-	sema_init(&dmxdevfilter->mutex, 1);
+	init_MUTEX(&dmxdevfilter->mutex);
 	dmxdevfilter->dvbdev=dmxdev->dvbdev;
 	file->private_data=dmxdevfilter;
 
@@ -1113,7 +1113,7 @@ dvb_dmxdev_init(struct dmxdev *dmxdev, s
 		return -ENOMEM;
 	}
 
-	sema_init(&dmxdev->mutex, 1);
+	init_MUTEX(&dmxdev->mutex);
 	spin_lock_init(&dmxdev->lock);
 	for (i=0; i<dmxdev->filternum; i++) {
 		dmxdev->filter[i].dev=dmxdev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dmxdev.h linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dmxdev.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dmxdev.h	2005-06-22 13:51:50.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dmxdev.h	2005-12-12 22:12:50.000000000 +0000
@@ -30,7 +30,7 @@
 #include <linux/wait.h>
 #include <linux/fs.h>
 #include <linux/string.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/dvb/dmx.h>
 
@@ -83,7 +83,7 @@ struct dmxdev_filter {
         struct dmxdev *dev;
         struct dmxdev_buffer buffer;
 
-	struct semaphore mutex;
+	struct mutex mutex;
 
         /* only for sections */
         struct timer_list timer;
@@ -117,7 +117,7 @@ struct dmxdev {
         struct dmxdev_buffer dvr_buffer;
 #define DVR_BUFFER_SIZE (10*188*1024)
 
-	struct semaphore mutex;
+	struct mutex mutex;
 	spinlock_t lock;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_demux.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_demux.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_demux.c	2005-12-12 20:00:22.000000000 +0000
@@ -1215,7 +1215,7 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 	dmx->disconnect_frontend = dvbdmx_disconnect_frontend;
 	dmx->get_pes_pids = dvbdmx_get_pes_pids;
 
-	sema_init(&dvbdemux->mutex, 1);
+	init_MUTEX(&dvbdemux->mutex);
 	spin_lock_init(&dvbdemux->lock);
 
 	return 0;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_demux.h linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_demux.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_demux.h	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_demux.h	2005-12-12 22:12:50.000000000 +0000
@@ -26,7 +26,7 @@
 #include <linux/time.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "demux.h"
 
@@ -125,7 +125,7 @@ struct dvb_demux {
 	u8 tsbuf[204];
 	int tsbufp;
 
-	struct semaphore mutex;
+	struct mutex mutex;
 	spinlock_t lock;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-12-12 22:12:50.000000000 +0000
@@ -37,7 +37,7 @@
 #include <linux/suspend.h>
 #include <linux/jiffies.h>
 #include <asm/processor.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "dvb_frontend.h"
 #include "dvbdev.h"
@@ -95,7 +95,7 @@ struct dvb_frontend_private {
 	struct dvb_device *dvbdev;
 	struct dvb_frontend_parameters parameters;
 	struct dvb_fe_events events;
-	struct semaphore sem;
+	struct mutex sem;
 	struct list_head list_head;
 	wait_queue_head_t wait_queue;
 	pid_t thread_pid;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-12-12 21:00:24.000000000 +0000
@@ -86,7 +86,7 @@ struct dvb_fe_events {
 	int			  eventr;
 	int			  overflow;
 	wait_queue_head_t	  wait_queue;
-	struct semaphore	  sem;
+	struct mutex		  sem;
 };
 
 struct dvb_frontend {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_net.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-core/dvb_net.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-core/dvb_net.c	2005-12-12 21:00:56.000000000 +0000
@@ -152,7 +152,7 @@ struct dvb_net_priv {
 	int ule_sndu_remain;			/* Nr. of bytes still required for current ULE SNDU. */
 	unsigned long ts_count;			/* Current ts cell counter. */
 
-	struct semaphore mutex;
+	struct mutex mutex;
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-usb/dvb-usb.h linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-usb/dvb-usb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-usb/dvb-usb.h	2005-12-12 20:03:48.000000000 +0000
@@ -276,10 +276,10 @@ struct dvb_usb_device {
 	int pid_filtering;
 
 	/* locking */
-	struct semaphore usb_sem;
+	struct mutex usb_sem;
 
 	/* i2c */
-	struct semaphore i2c_sem;
+	struct mutex i2c_sem;
 	struct i2c_adapter i2c_adap;
 
 	/* tuner programming information */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-usb/dvb-usb-init.c linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-usb/dvb-usb-init.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-12-12 20:03:58.000000000 +0000
@@ -42,8 +42,8 @@ static int dvb_usb_init(struct dvb_usb_d
 {
 	int ret = 0;
 
-	sema_init(&d->usb_sem, 1);
-	sema_init(&d->i2c_sem, 1);
+	init_MUTEX(&d->usb_sem);
+	init_MUTEX(&d->i2c_sem);
 
 	d->state = DVB_USB_STATE_INIT;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/frontends/bcm3510.c linux-2.6.15-rc5-mutex/drivers/media/dvb/frontends/bcm3510.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/frontends/bcm3510.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/frontends/bcm3510.c	2005-12-12 20:00:14.000000000 +0000
@@ -52,7 +52,7 @@ struct bcm3510_state {
 	struct dvb_frontend frontend;
 
 	/* demodulator private data */
-	struct semaphore hab_sem;
+	struct mutex hab_sem;
 	u8 firmware_loaded:1;
 
 	unsigned long next_status_check;
@@ -797,7 +797,7 @@ struct dvb_frontend* bcm3510_attach(cons
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 
-	sema_init(&state->hab_sem, 1);
+	init_MUTEX(&state->hab_sem);
 
 	if ((ret = bcm3510_readB(state,0xe0,&v)) < 0)
 		goto error;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/av7110.c linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/av7110.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/av7110.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/av7110.c	2005-12-12 22:12:50.000000000 +0000
@@ -54,7 +54,7 @@
 #include <linux/i2c.h>
 
 #include <asm/system.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/dvb/frontend.h>
 
@@ -2650,16 +2650,16 @@ static int av7110_attach(struct saa7146_
 	tasklet_init (&av7110->debi_tasklet, debiirq, (unsigned long) av7110);
 	tasklet_init (&av7110->gpio_tasklet, gpioirq, (unsigned long) av7110);
 
-	sema_init(&av7110->pid_mutex, 1);
+	init_SEMA(&av7110->pid_mutex);
 
 	/* locks for data transfers from/to AV7110 */
 	spin_lock_init(&av7110->debilock);
-	sema_init(&av7110->dcomlock, 1);
+	init_MUTEX(&av7110->dcomlock);
 	av7110->debitype = -1;
 
 	/* default OSD window */
 	av7110->osdwin = 1;
-	sema_init(&av7110->osd_sema, 1);
+	init_MUTEX(&av7110->osd_sema);
 
 	/* ARM "watchdog" */
 	init_waitqueue_head(&av7110->arm_wait);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/av7110.h linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/av7110.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/av7110.h	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/av7110.h	2005-12-12 20:03:15.000000000 +0000
@@ -126,7 +126,7 @@ struct av7110 {
 	/* DEBI and polled command interface */
 
 	spinlock_t		debilock;
-	struct semaphore	dcomlock;
+	struct mutex		dcomlock;
 	volatile int		debitype;
 	volatile int		debilen;
 
@@ -145,7 +145,7 @@ struct av7110 {
 
 	int			osdwin;      /* currently active window */
 	u16			osdbpp[8];
-	struct semaphore	osd_sema;
+	struct mutex		osd_sema;
 
 	/* CA */
 
@@ -171,7 +171,7 @@ struct av7110 {
 	struct tasklet_struct   vpe_tasklet;
 
 	int			fe_synced;
-	struct semaphore	pid_mutex;
+	struct mutex		pid_mutex;
 
 	int			video_blank;
 	struct video_status	videostate;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/budget.h linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/budget.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttpci/budget.h	2005-06-22 13:51:52.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/ttpci/budget.h	2005-12-12 21:01:03.000000000 +0000
@@ -51,7 +51,7 @@ struct budget {
 	struct dmx_frontend mem_frontend;
 
 	int fe_synced;
-	struct semaphore pid_mutex;
+	struct mutex pid_mutex;
 
 	int ci_present;
 	int video_port;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.15-rc5-mutex/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-12-12 22:12:50.000000000 +0000
@@ -19,7 +19,7 @@
 #include <linux/time.h>
 #include <linux/errno.h>
 #include <linux/jiffies.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "dvb_frontend.h"
 #include "dmxdev.h"
@@ -83,8 +83,8 @@ struct ttusb {
 	struct dvb_net dvbnet;
 
 	/* and one for USB access. */
-	struct semaphore semi2c;
-	struct semaphore semusb;
+	struct mutex semi2c;
+	struct mutex semusb;
 
 	struct dvb_adapter adapter;
 	struct usb_device *dev;
@@ -1497,8 +1497,8 @@ static int ttusb_probe(struct usb_interf
 	ttusb->dev = udev;
 	ttusb->c = 0;
 	ttusb->mux_state = 0;
-	sema_init(&ttusb->semi2c, 0);
-	sema_init(&ttusb->semusb, 1);
+	init_MUTEX_LOCKED(&ttusb->semi2c);
+	init_MUTEX(&ttusb->semusb);
 
 	ttusb_setup_interfaces(ttusb);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.15-rc5-mutex/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-12-12 22:12:50.000000000 +0000
@@ -20,7 +20,7 @@
  *
  */
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -115,7 +115,7 @@ struct ttusb_dec {
 	unsigned int			out_pipe;
 	unsigned int			irq_pipe;
 	enum ttusb_dec_interface	interface;
-	struct semaphore		usb_sem;
+	struct mutex			usb_sem;
 
 	void			*irq_buffer;
 	struct urb		*irq_urb;
@@ -124,7 +124,7 @@ struct ttusb_dec {
 	dma_addr_t		iso_dma_handle;
 	struct urb		*iso_urb[ISO_BUF_COUNT];
 	int			iso_stream_count;
-	struct semaphore	iso_sem;
+	struct mutex		iso_sem;
 
 	u8				packet[MAX_PVA_LENGTH + 4];
 	enum ttusb_dec_packet_type	packet_type;
@@ -1230,8 +1230,8 @@ static int ttusb_dec_init_usb(struct ttu
 {
 	dprintk("%s\n", __FUNCTION__);
 
-	sema_init(&dec->usb_sem, 1);
-	sema_init(&dec->iso_sem, 1);
+	init_MUTEX(&dec->usb_sem);
+	init_MUTEX(&dec->iso_sem);
 
 	dec->command_pipe = usb_sndbulkpipe(dec->udev, COMMAND_PIPE);
 	dec->result_pipe = usb_rcvbulkpipe(dec->udev, RESULT_PIPE);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/miropcm20-rds-core.c linux-2.6.15-rc5-mutex/drivers/media/radio/miropcm20-rds-core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/miropcm20-rds-core.c	2004-06-18 13:41:41.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/miropcm20-rds-core.c	2005-12-12 22:12:50.000000000 +0000
@@ -18,14 +18,14 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/io.h>
 #include "../../../sound/oss/aci.h"
 #include "miropcm20-rds-core.h"
 
 #define DEBUG 0
 
-static struct semaphore aci_rds_sem;
+static struct mutex aci_rds_sem;
 
 #define RDS_DATASHIFT          2   /* Bit 2 */
 #define RDS_DATAMASK        (1 << RDS_DATASHIFT)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-aimslab.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-aimslab.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-aimslab.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-aimslab.c	2005-12-12 22:12:50.000000000 +0000
@@ -35,7 +35,7 @@
 #include <asm/uaccess.h>	/* copy to/from user		*/
 #include <linux/videodev.h>	/* kernel radio structs		*/
 #include <linux/config.h>	/* CONFIG_RADIO_RTRACK_PORT 	*/
-#include <asm/semaphore.h>	/* Lock for the I/O 		*/
+#include <linux/semaphore.h>	/* Lock for the I/O 		*/
 
 #ifndef CONFIG_RADIO_RTRACK_PORT
 #define CONFIG_RADIO_RTRACK_PORT -1
@@ -43,7 +43,7 @@
 
 static int io = CONFIG_RADIO_RTRACK_PORT; 
 static int radio_nr = -1;
-static struct semaphore lock;
+static struct mutex lock;
 
 struct rt_device
 {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-aztech.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-aztech.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-aztech.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-aztech.c	2005-12-12 21:02:32.000000000 +0000
@@ -42,7 +42,7 @@
 static int io = CONFIG_RADIO_AZTECH_PORT; 
 static int radio_nr = -1;
 static int radio_wait_time = 1000;
-static struct semaphore lock;
+static struct mutex lock;
 
 struct az_device
 {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-maestro.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-maestro.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-maestro.c	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-maestro.c	2005-12-12 22:12:50.000000000 +0000
@@ -23,7 +23,7 @@
 #include <linux/sched.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/pci.h>
 #include <linux/videodev.h>
 
@@ -90,7 +90,7 @@ static struct radio_device
 		muted,	/* VIDEO_AUDIO_MUTE */
 		stereo,	/* VIDEO_TUNER_STEREO_ON */	
 		tuned;	/* signal strength (0 or 0xffff) */
-	struct  semaphore lock;
+	struct  mutex lock;
 } radio_unit = {0, 0, 0, 0, };
 
 static __u32 radio_bits_get(struct radio_device *dev)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-maxiradio.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-maxiradio.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-maxiradio.c	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-maxiradio.c	2005-12-12 22:12:50.000000000 +0000
@@ -37,7 +37,7 @@
 #include <linux/sched.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/pci.h>
 #include <linux/videodev.h>
 
@@ -100,7 +100,7 @@ static struct radio_device
 		
 	unsigned long freq;
 	
-	struct  semaphore lock;
+	struct  mutex lock;
 } radio_unit = {0, 0, 0, 0, };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-sf16fmi.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-sf16fmi.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-sf16fmi.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-sf16fmi.c	2005-12-12 22:12:50.000000000 +0000
@@ -24,7 +24,7 @@
 #include <linux/isapnp.h>
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 struct fmi_device
 {
@@ -37,7 +37,7 @@ struct fmi_device
 static int io = -1; 
 static int radio_nr = -1;
 static struct pnp_dev *dev = NULL;
-static struct semaphore lock;
+static struct mutex lock;
 
 /* freq is in 1/16 kHz to internal number, hw precision is 50 kHz */
 /* It is only useful to give freq in intervall of 800 (=0.05Mhz),
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-sf16fmr2.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-sf16fmr2.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-sf16fmr2.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-sf16fmr2.c	2005-12-12 22:12:50.000000000 +0000
@@ -19,9 +19,9 @@
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
 #include <linux/videodev.h>	/* kernel radio structs		*/
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
-static struct semaphore lock;
+static struct mutex lock;
 
 #undef DEBUG
 //#define DEBUG 1
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-typhoon.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-typhoon.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-typhoon.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-typhoon.c	2005-12-12 21:04:13.000000000 +0000
@@ -59,7 +59,7 @@ struct typhoon_device {
 	int muted;
 	unsigned long curfreq;
 	unsigned long mutefreq;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 static void typhoon_setvol_generic(struct typhoon_device *dev, int vol);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-zoltrix.c linux-2.6.15-rc5-mutex/drivers/media/radio/radio-zoltrix.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/radio/radio-zoltrix.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/radio/radio-zoltrix.c	2005-12-12 21:03:32.000000000 +0000
@@ -48,7 +48,7 @@ struct zol_device {
 	unsigned long curfreq;
 	int muted;
 	unsigned int stereo;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 static int zol_setvol(struct zol_device *dev, int vol)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/arv.c linux-2.6.15-rc5-mutex/drivers/media/video/arv.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/arv.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/arv.c	2005-12-12 22:12:50.000000000 +0000
@@ -32,7 +32,7 @@
 #include <linux/sched.h>
 #include <linux/videodev.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/m32r.h>
 #include <asm/io.h>
@@ -117,7 +117,7 @@ struct ar_device {
 	int width, height;
 	int frame_bytes, line_bytes;
 	wait_queue_head_t wait;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 static int video_nr = -1;	/* video device number (first free) */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bttvp.h linux-2.6.15-rc5-mutex/drivers/media/video/bttvp.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bttvp.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/bttvp.h	2005-12-12 21:07:01.000000000 +0000
@@ -303,9 +303,9 @@ struct bttv {
 
 	/* locking */
 	spinlock_t s_lock;
-	struct semaphore lock;
+	struct mutex lock;
 	int resources;
-	struct semaphore reslock;
+	struct mutex reslock;
 #ifdef VIDIOC_G_PRIORITY
 	struct v4l2_prio_state prio;
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bw-qcam.c linux-2.6.15-rc5-mutex/drivers/media/video/bw-qcam.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bw-qcam.c	2005-03-02 12:08:11.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/bw-qcam.c	2005-12-12 22:12:50.000000000 +0000
@@ -73,7 +73,7 @@ OTHER DEALINGS IN THE SOFTWARE.
 #include <linux/parport.h>
 #include <linux/sched.h>
 #include <linux/videodev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 #include "bw-qcam.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bw-qcam.h linux-2.6.15-rc5-mutex/drivers/media/video/bw-qcam.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/bw-qcam.h	2004-06-18 13:41:41.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/bw-qcam.h	2005-12-12 21:05:53.000000000 +0000
@@ -55,7 +55,7 @@ struct qcam_device {
 	struct video_device vdev;
 	struct pardevice *pdev;
 	struct parport *pport;
-	struct semaphore lock;
+	struct mutex lock;
 	int width, height;
 	int bpp;
 	int mode;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cpia.c linux-2.6.15-rc5-mutex/drivers/media/video/cpia.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cpia.c	2005-11-01 13:19:08.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/cpia.c	2005-12-12 22:12:50.000000000 +0000
@@ -39,7 +39,7 @@
 #include <linux/pagemap.h>
 #include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cpia.h linux-2.6.15-rc5-mutex/drivers/media/video/cpia.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cpia.h	2004-06-18 13:41:41.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/cpia.h	2005-12-12 21:06:15.000000000 +0000
@@ -246,7 +246,7 @@ enum v4l_camstates {
 struct cam_data {
 	struct list_head cam_data_list;
 
-        struct semaphore busy_lock;     /* guard against SMP multithreading */
+        struct mutex busy_lock;		/* guard against SMP multithreading */
 	struct cpia_camera_ops *ops;	/* lowlevel driver operations */
 	void *lowlevel_data;		/* private data for lowlevel driver */
 	u8 *raw_image;			/* buffer for raw image data */
@@ -261,7 +261,7 @@ struct cam_data {
 	u8 mainsFreq;			/* for flicker control */
 
 				/* proc interface */
-	struct semaphore param_lock;	/* params lock for this camera */
+	struct mutex param_lock;	/* params lock for this camera */
 	struct cam_params params;	/* camera settings */
 	struct proc_dir_entry *proc_entry;	/* /proc/cpia/videoX */
 	
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/c-qcam.c linux-2.6.15-rc5-mutex/drivers/media/video/c-qcam.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/c-qcam.c	2005-06-22 13:51:52.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/c-qcam.c	2005-12-12 22:12:50.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/parport.h>
 #include <linux/sched.h>
 #include <linux/videodev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 struct qcam_device {
@@ -47,7 +47,7 @@ struct qcam_device {
 	int contrast, brightness, whitebal;
 	int top, left;
 	unsigned int bidirectional;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 /* cameras maximum */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cx88/cx88.h linux-2.6.15-rc5-mutex/drivers/media/video/cx88/cx88.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/cx88/cx88.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/cx88/cx88.h	2005-12-12 21:05:06.000000000 +0000
@@ -297,7 +297,7 @@ struct cx88_core {
 	/* IR remote control state */
 	struct cx88_IR             *ir;
 
-	struct semaphore           lock;
+	struct mutex               lock;
 
 	/* various v4l controls */
 	u32                        freq;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/em28xx/em28xx.h linux-2.6.15-rc5-mutex/drivers/media/video/em28xx/em28xx.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/em28xx/em28xx.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/em28xx/em28xx.h	2005-12-12 21:45:51.000000000 +0000
@@ -254,7 +254,7 @@ struct em28xx {
 	enum em28xx_stream_state stream;
 	enum em28xx_io_method io;
 	/* locks */
-	struct semaphore lock, fileop_lock;
+	struct mutex mutex, mutex_lock;
 	spinlock_t queue_lock;
 	struct list_head inqueue, outqueue;
 	wait_queue_head_t open, wait_frame, wait_stream;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/ir-kbd-i2c.c linux-2.6.15-rc5-mutex/drivers/media/video/ir-kbd-i2c.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/ir-kbd-i2c.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/ir-kbd-i2c.c	2005-12-12 22:12:50.000000000 +0000
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <media/ir-common.h>
 #include <media/ir-kbd-i2c.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/meye.h linux-2.6.15-rc5-mutex/drivers/media/video/meye.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/meye.h	2005-01-04 11:13:16.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/meye.h	2005-12-12 21:05:41.000000000 +0000
@@ -301,7 +301,7 @@ struct meye {
 					/* list of buffers */
 	struct meye_grab_buffer grab_buffer[MEYE_MAX_BUFNBRS];
 	int vma_use_count[MEYE_MAX_BUFNBRS]; /* mmap count */
-	struct semaphore lock;		/* semaphore for open/mmap... */
+	struct mutex lock;		/* semaphore for open/mmap... */
 	struct kfifo *grabq;		/* queue for buffers to be grabbed */
 	spinlock_t grabq_lock;		/* lock protecting the queue */
 	struct kfifo *doneq;		/* queue for grabbed buffers */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/msp3400.c linux-2.6.15-rc5-mutex/drivers/media/video/msp3400.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/msp3400.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/msp3400.c	2005-12-12 22:12:50.000000000 +0000
@@ -50,7 +50,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/pgtable.h>
 
 #include <media/audiochip.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/planb.c linux-2.6.15-rc5-mutex/drivers/media/video/planb.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/planb.c	2005-06-22 13:51:52.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/planb.c	2005-12-12 22:12:50.000000000 +0000
@@ -48,7 +48,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/irq.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "planb.h"
 #include "saa7196.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/planb.h linux-2.6.15-rc5-mutex/drivers/media/video/planb.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/planb.h	2004-06-18 13:41:41.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/planb.h	2005-12-12 21:05:11.000000000 +0000
@@ -174,7 +174,7 @@ struct planb {
 	int	user;
 	unsigned int tab_size;
 	int     maxlines;
-	struct semaphore lock;
+	struct mutex lock;
 	unsigned int	irq;			/* interrupt number */
 	volatile unsigned int intr_mask;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/pms.c linux-2.6.15-rc5-mutex/drivers/media/video/pms.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/pms.c	2005-03-02 12:08:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/pms.c	2005-12-12 21:05:35.000000000 +0000
@@ -44,7 +44,7 @@ struct pms_device
 	struct video_picture picture;
 	int height;
 	int width;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 struct i2c_info
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa5246a.c linux-2.6.15-rc5-mutex/drivers/media/video/saa5246a.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa5246a.c	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/saa5246a.c	2005-12-12 21:07:15.000000000 +0000
@@ -57,7 +57,7 @@ struct saa5246a_device
 	u8     pgbuf[NUM_DAUS][VTX_VIRTUALSIZE];
 	int    is_searching[NUM_DAUS];
 	struct i2c_client *client;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 static struct video_device saa_template;	/* Declared near bottom */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa5249.c linux-2.6.15-rc5-mutex/drivers/media/video/saa5249.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa5249.c	2005-08-30 13:56:18.000000000 +0100
+++ linux-2.6.15-rc5-mutex/drivers/media/video/saa5249.c	2005-12-12 21:07:26.000000000 +0000
@@ -105,7 +105,7 @@ struct saa5249_device
 	int disp_mode;
 	int virtual_mode;
 	struct i2c_client *client;
-	struct semaphore lock;
+	struct mutex lock;
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134.h linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/saa7134/saa7134.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/saa7134/saa7134.h	2005-12-12 21:06:33.000000000 +0000
@@ -358,7 +358,7 @@ struct saa7134_fh {
 
 /* dmasound dsp status */
 struct saa7134_dmasound {
-	struct semaphore           lock;
+	struct mutex               lock;
 	int                        minor_mixer;
 	int                        minor_dsp;
 	unsigned int               users_dsp;
@@ -422,7 +422,7 @@ struct saa7134_mpeg_ops {
 /* global device status */
 struct saa7134_dev {
 	struct list_head           devlist;
-	struct semaphore           lock;
+	struct mutex               lock;
 	spinlock_t                 slock;
 #ifdef VIDIOC_G_PRIORITY
 	struct v4l2_prio_state     prio;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/tvmixer.c linux-2.6.15-rc5-mutex/drivers/media/video/tvmixer.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/tvmixer.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/tvmixer.c	2005-12-12 22:12:50.000000000 +0000
@@ -16,8 +16,8 @@
 #include <linux/kdev_t.h>
 #include <linux/sound.h>
 #include <linux/soundcard.h>
+#include <linux/semaphore.h>
 
-#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/videodev.c linux-2.6.15-rc5-mutex/drivers/media/video/videodev.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/videodev.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/videodev.c	2005-12-12 22:12:50.000000000 +0000
@@ -29,7 +29,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/videodev.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/vino.c linux-2.6.15-rc5-mutex/drivers/media/video/vino.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/vino.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/vino.c	2005-12-12 21:06:48.000000000 +0000
@@ -245,7 +245,7 @@ struct vino_framebuffer_queue {
 	struct vino_framebuffer *buffer[VINO_FRAMEBUFFER_COUNT_MAX];
 
 	spinlock_t queue_lock;
-	struct semaphore queue_sem;
+	struct mutex queue_sem;
 	wait_queue_head_t frame_wait_queue;
 };
 
@@ -283,7 +283,7 @@ struct vino_channel_settings {
 	/* the driver is currently processing the queue */
 	int capturing;
 
-	struct semaphore sem;
+	struct mutex sem;
 	spinlock_t capture_lock;
 
 	unsigned int users;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/zoran.h linux-2.6.15-rc5-mutex/drivers/media/video/zoran.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/media/video/zoran.h	2005-01-04 11:13:17.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/media/video/zoran.h	2005-12-12 21:07:22.000000000 +0000
@@ -395,7 +395,7 @@ struct zoran {
 	struct videocodec *codec;	/* video codec */
 	struct videocodec *vfe;	/* video front end */
 
-	struct semaphore resource_lock;	/* prevent evil stuff */
+	struct mutex resource_lock;	/* prevent evil stuff */
 
 	u8 initialized;		/* flag if zoran has been correctly initalized */
 	int user;		/* number of current users */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/message/fusion/mptbase.h linux-2.6.15-rc5-mutex/drivers/message/fusion/mptbase.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/message/fusion/mptbase.h	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/message/fusion/mptbase.h	2005-12-12 20:08:51.000000000 +0000
@@ -417,7 +417,7 @@ typedef struct _MPT_IOCTL {
 	u8			 status;	/* current command status */
 	u8			 reset;		/* 1 if bus reset allowed */
 	u8			 target;	/* target for reset */
-	struct semaphore	 sem_ioc;
+	struct mutex		sem_ioc;
 } MPT_IOCTL;
 
 #define MPT_SAS_MGMT_STATUS_RF_VALID	0x02	/* The Reply Frame is VALID */
@@ -425,7 +425,7 @@ typedef struct _MPT_IOCTL {
 #define MPT_SAS_MGMT_STATUS_TM_FAILED	0x40	/* User TM request failed */
 
 typedef struct _MPT_SAS_MGMT {
-	struct semaphore	 mutex;
+	struct mutex		 mutex;
 	struct completion	 done;
 	u8			 reply[MPT_DEFAULT_FRAME_SIZE]; /* reply frame data */
 	u8			 status;	/* current command status */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/message/fusion/mptctl.c linux-2.6.15-rc5-mutex/drivers/message/fusion/mptctl.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/message/fusion/mptctl.c	2005-12-08 16:23:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/message/fusion/mptctl.c	2005-12-12 20:24:32.000000000 +0000
@@ -2745,7 +2745,7 @@ mptctl_probe(struct pci_dev *pdev, const
 	memset(mem, 0, sz);
 	ioc->ioctl = (MPT_IOCTL *) mem;
 	ioc->ioctl->ioc = ioc;
-	sema_init(&ioc->ioctl->sem_ioc, 1);
+	init_MUTEX(&ioc->ioctl->sem_ioc);
 	return 0;
 
 out_fail:
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mfd/ucb1x00-core.c linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-core.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mfd/ucb1x00-core.c	2005-11-01 13:19:09.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-core.c	2005-12-12 20:32:38.000000000 +0000
@@ -135,7 +135,7 @@ unsigned int ucb1x00_io_read(struct ucb1
  */
 void ucb1x00_adc_enable(struct ucb1x00 *ucb)
 {
-	down(&ucb->adc_sem);
+	down_sem(&ucb->adc_sem);
 
 	ucb->adc_cr |= UCB_ADC_ENA;
 
@@ -193,7 +193,7 @@ void ucb1x00_adc_disable(struct ucb1x00 
 	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr);
 	ucb1x00_disable(ucb);
 
-	up(&ucb->adc_sem);
+	up_sem(&ucb->adc_sem);
 }
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mfd/ucb1x00-ts.c linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-ts.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mfd/ucb1x00-ts.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mfd/ucb1x00-ts.c	2005-12-12 22:12:50.000000000 +0000
@@ -35,7 +35,7 @@
 #include <linux/delay.h>
 
 #include <asm/dma.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/arch/collie.h>
 #include <asm/mach-types.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mmc/mmc_queue.h linux-2.6.15-rc5-mutex/drivers/mmc/mmc_queue.h
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mmc/mmc_queue.h	2005-01-04 11:13:17.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mmc/mmc_queue.h	2005-12-12 20:58:14.000000000 +0000
@@ -8,7 +8,7 @@ struct mmc_queue {
 	struct mmc_card		*card;
 	struct completion	thread_complete;
 	wait_queue_head_t	thread_wq;
-	struct semaphore	thread_sem;
+	struct mutex		thread_sem;
 	unsigned int		flags;
 	struct request		*req;
 	int			(*prep_fn)(struct mmc_queue *, struct request *);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/devices/blkmtd.c linux-2.6.15-rc5-mutex/drivers/mtd/devices/blkmtd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/devices/blkmtd.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/devices/blkmtd.c	2005-12-12 21:19:07.000000000 +0000
@@ -46,7 +46,7 @@ struct blkmtd_dev {
 	struct list_head list;
 	struct block_device *blkdev;
 	struct mtd_info mtd_info;
-	struct semaphore wrbuf_mutex;
+	struct mutex wrbuf_mutex;
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/devices/block2mtd.c linux-2.6.15-rc5-mutex/drivers/mtd/devices/block2mtd.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/devices/block2mtd.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/devices/block2mtd.c	2005-12-12 21:19:09.000000000 +0000
@@ -31,7 +31,7 @@ struct block2mtd_dev {
 	struct list_head list;
 	struct block_device *blkdev;
 	struct mtd_info mtd;
-	struct semaphore write_mutex;
+	struct mutex write_mutex;
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/mtd_blkdevs.c linux-2.6.15-rc5-mutex/drivers/mtd/mtd_blkdevs.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/mtd_blkdevs.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/mtd_blkdevs.c	2005-12-12 22:08:48.000000000 +0000
@@ -19,12 +19,12 @@
 #include <linux/spinlock.h>
 #include <linux/hdreg.h>
 #include <linux/init.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 
 static LIST_HEAD(blktrans_majors);
 
-extern struct semaphore mtd_table_mutex;
+extern struct mutex mtd_table_mutex;
 extern struct mtd_info *mtd_table[];
 
 struct mtd_blkcore_priv {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/mtdblock.c linux-2.6.15-rc5-mutex/drivers/mtd/mtdblock.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/mtd/mtdblock.c	2005-12-08 16:23:42.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/mtd/mtdblock.c	2005-12-12 21:19:16.000000000 +0000
@@ -23,7 +23,7 @@
 static struct mtdblk_dev {
 	struct mtd_info *mtd;
 	int count;
-	struct semaphore cache_sem;
+	struct mutex cache_sem;
 	unsigned char *cache_data;
 	unsigned long cache_offset;
 	unsigned int cache_size;
