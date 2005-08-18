Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVHRAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVHRAPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVHRAPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:15:17 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:64374 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751389AbVHRAOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XxnUpkMH/Zj8Qx8UhUIyMAaelMvZ18Rypt6KpVfb6X2FOxswsA7hlKvZF4iuan0FLxUuY7NQPer3RCQjXm3HLC3kb9NWW2H7BUXq5LSgiMao0VLZjl7Zxb3Evw/b3PiGE7yZs2tghqM/H9gCzh0T8qmSoi8uyB73/pYmqDdHZH8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] rename locking functions - convert init_MUTEX* users, part 2
Date: Thu, 18 Aug 2005 02:09:04 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180209.04955.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert users of init_MUTEX and init_MUTEX_LOCKED to
init_mutex and init_mutex_locked - part 2.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/infiniband/ulp/ipoib/ipoib_main.c   |    4 ++--
 drivers/input/gameport/gameport.c           |    2 +-
 drivers/input/input.c                       |    2 +-
 drivers/input/joystick/db9.c                |    2 +-
 drivers/input/joystick/gamecon.c            |    2 +-
 drivers/input/joystick/iforce/iforce-main.c |    2 +-
 drivers/input/joystick/turbografx.c         |    2 +-
 drivers/input/keyboard/hil_kbd.c            |    2 +-
 drivers/input/misc/hp_sdc_rtc.c             |    4 ++--
 drivers/input/mouse/hil_ptr.c               |    2 +-
 drivers/input/serio/hil_mlc.c               |    6 +++---
 drivers/input/serio/hp_sdc.c                |    4 ++--
 drivers/input/serio/libps2.c                |    2 +-
 drivers/input/serio/serio.c                 |    2 +-
 drivers/isdn/capi/capi.c                    |    2 +-
 drivers/isdn/capi/kcapi.c                   |    2 +-
 drivers/isdn/i4l/isdn_common.c              |    2 +-
 drivers/isdn/i4l/isdn_tty.c                 |    2 +-
 drivers/macintosh/mediabay.c                |    2 +-
 drivers/macintosh/therm_windtunnel.c        |    2 +-
 drivers/md/dm.c                             |    2 +-
 drivers/md/kcopyd.c                         |    2 +-
 drivers/md/md.c                             |    2 +-
 drivers/media/common/saa7146_core.c         |    4 ++--
 drivers/media/common/saa7146_vbi.c          |    2 +-
 drivers/media/common/saa7146_video.c        |    2 +-
 drivers/media/dvb/bt8xx/dvb-bt8xx.c         |    4 ++--
 drivers/media/dvb/cinergyT2/cinergyT2.c     |    2 +-
 drivers/media/dvb/dvb-core/dvb_frontend.c   |    6 +++---
 drivers/media/radio/miropcm20-rds-core.c    |    2 +-
 drivers/media/radio/radio-aimslab.c         |    2 +-
 drivers/media/radio/radio-aztech.c          |    2 +-
 drivers/media/radio/radio-maestro.c         |    2 +-
 drivers/media/radio/radio-maxiradio.c       |    2 +-
 drivers/media/radio/radio-sf16fmi.c         |    2 +-
 drivers/media/radio/radio-sf16fmr2.c        |    2 +-
 drivers/media/radio/radio-typhoon.c         |    2 +-
 drivers/media/radio/radio-zoltrix.c         |    2 +-
 drivers/media/video/arv.c                   |    2 +-
 drivers/media/video/bttv-driver.c           |    4 ++--
 drivers/media/video/bw-qcam.c               |    2 +-
 drivers/media/video/c-qcam.c                |    2 +-
 drivers/media/video/cpia.c                  |    4 ++--
 drivers/media/video/cx88/cx88-mpeg.c        |    2 +-
 drivers/media/video/cx88/cx88-video.c       |    2 +-
 drivers/media/video/meye.c                  |    2 +-
 drivers/media/video/planb.c                 |    2 +-
 drivers/media/video/pms.c                   |    2 +-
 drivers/media/video/saa5246a.c              |    2 +-
 drivers/media/video/saa5249.c               |    2 +-
 drivers/media/video/saa7134/saa7134-core.c  |    2 +-
 drivers/media/video/saa7134/saa7134-oss.c   |    2 +-
 drivers/media/video/video-buf-dvb.c         |    2 +-
 drivers/media/video/video-buf.c             |    2 +-
 drivers/media/video/videodev.c              |    2 +-
 drivers/media/video/vino.c                  |    2 +-
 drivers/media/video/zoran_card.c            |    2 +-
 drivers/message/i2o/device.c                |    2 +-
 drivers/message/i2o/iop.c                   |    2 +-
 drivers/mmc/mmc_queue.c                     |    2 +-
 drivers/mtd/devices/blkmtd.c                |    2 +-
 drivers/mtd/devices/block2mtd.c             |    2 +-
 drivers/mtd/devices/doc2000.c               |    2 +-
 drivers/mtd/mtd_blkdevs.c                   |    2 +-
 drivers/mtd/mtdblock.c                      |    2 +-
 drivers/net/3c527.c                         |    2 +-
 drivers/net/hamradio/6pack.c                |    2 +-
 drivers/net/irda/sir_dev.c                  |    2 +-
 drivers/net/irda/vlsi_ir.c                  |    2 +-
 drivers/net/plip.c                          |    2 +-
 drivers/net/ppp_async.c                     |    2 +-
 drivers/net/ppp_synctty.c                   |    2 +-
 drivers/net/sungem.c                        |    2 +-
 drivers/net/wan/cosa.c                      |    4 ++--
 drivers/parport/share.c                     |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c          |    2 +-
 drivers/pci/hotplug/cpci_hotplug_core.c     |    4 ++--
 drivers/pci/hotplug/cpqphp_core.c           |    2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c           |    6 +++---
 drivers/pci/hotplug/ibmphp_hpc.c            |    6 +++---
 drivers/pci/hotplug/pciehp_ctrl.c           |    4 ++--
 drivers/pci/hotplug/pciehp_hpc.c            |    2 +-
 drivers/pci/hotplug/rpaphp_core.c           |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c           |    4 ++--
 drivers/pci/hotplug/shpchp_hpc.c            |    2 +-
 drivers/pcmcia/cs.c                         |    2 +-
 drivers/s390/char/vmcp.c                    |    2 +-
 drivers/s390/cio/qdio.c                     |    2 +-
 88 files changed, 107 insertions(+), 107 deletions(-)

--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-08-18 00:55:11.000000000 +0200
@@ -838,8 +838,8 @@ static void ipoib_setup(struct net_devic
 	spin_lock_init(&priv->lock);
 	spin_lock_init(&priv->tx_lock);
 
-	init_MUTEX(&priv->mcast_mutex);
-	init_MUTEX(&priv->vlan_mutex);
+	init_mutex(&priv->mcast_mutex);
+	init_mutex(&priv->vlan_mutex);
 
 	INIT_LIST_HEAD(&priv->path_list);
 	INIT_LIST_HEAD(&priv->child_intfs);
--- linux-2.6.13-rc6-git9-orig/drivers/input/gameport/gameport.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/gameport/gameport.c	2005-08-18 00:55:11.000000000 +0200
@@ -516,7 +516,7 @@ static void gameport_init_port(struct ga
 
 	__module_get(THIS_MODULE);
 
-	init_MUTEX(&gameport->drv_sem);
+	init_mutex(&gameport->drv_sem);
 	device_initialize(&gameport->dev);
 	snprintf(gameport->dev.bus_id, sizeof(gameport->dev.bus_id),
 		 "gameport%lu", (unsigned long)atomic_inc_return(&gameport_no) - 1);
--- linux-2.6.13-rc6-git9-orig/drivers/input/input.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/input.c	2005-08-18 00:55:11.000000000 +0200
@@ -602,7 +602,7 @@ void input_register_device(struct input_
 
 	set_bit(EV_SYN, dev->evbit);
 
-	init_MUTEX(&dev->sem);
+	init_mutex(&dev->sem);
 
 	/*
 	 * If delay and period are pre-set by the driver, then autorepeating
--- linux-2.6.13-rc6-git9-orig/drivers/input/joystick/db9.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/joystick/db9.c	2005-08-18 00:55:11.000000000 +0200
@@ -577,7 +577,7 @@ static struct db9 __init *db9_probe(int 
 		return NULL;
 	}
 
-	init_MUTEX(&db9->sem);
+	init_mutex(&db9->sem);
 	db9->mode = config[1];
 	init_timer(&db9->timer);
 	db9->timer.data = (long) db9;
--- linux-2.6.13-rc6-git9-orig/drivers/input/joystick/gamecon.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/joystick/gamecon.c	2005-08-18 00:55:11.000000000 +0200
@@ -559,7 +559,7 @@ static struct gc __init *gc_probe(int *c
 		return NULL;
 	}
 
-	init_MUTEX(&gc->sem);
+	init_mutex(&gc->sem);
 
 	gc->pd = parport_register_device(pp, "gamecon", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
 
--- linux-2.6.13-rc6-git9-orig/drivers/input/joystick/iforce/iforce-main.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/joystick/iforce/iforce-main.c	2005-08-18 00:55:11.000000000 +0200
@@ -344,7 +344,7 @@ int iforce_init_device(struct iforce *if
 
 	init_waitqueue_head(&iforce->wait);
 	spin_lock_init(&iforce->xmit_lock);
-	init_MUTEX(&iforce->mem_mutex);
+	init_mutex(&iforce->mem_mutex);
 	iforce->xmit.buf = iforce->xmit_data;
 
 	iforce->dev.ff_effects_max = 10;
--- linux-2.6.13-rc6-git9-orig/drivers/input/joystick/turbografx.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/joystick/turbografx.c	2005-08-18 00:55:11.000000000 +0200
@@ -183,7 +183,7 @@ static struct tgfx __init *tgfx_probe(in
 		return NULL;
 	}
 
-	init_MUTEX(&tgfx->sem);
+	init_mutex(&tgfx->sem);
 
 	tgfx->pd = parport_register_device(pp, "turbografx", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
 
--- linux-2.6.13-rc6-git9-orig/drivers/input/keyboard/hil_kbd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/keyboard/hil_kbd.c	2005-08-18 00:55:11.000000000 +0200
@@ -262,7 +262,7 @@ static void hil_kbd_connect(struct serio
 	kbd->serio = serio;
 	kbd->dev.private = kbd;
 
-	init_MUTEX_LOCKED(&(kbd->sem));
+	init_mutex_locked(&(kbd->sem));
 
 	/* Get device info.  MLC driver supplies devid/status/etc. */
 	serio->write(serio, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/input/misc/hp_sdc_rtc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/misc/hp_sdc_rtc.c	2005-08-18 00:55:11.000000000 +0200
@@ -105,7 +105,7 @@ static int hp_sdc_rtc_do_read_bbrtc (str
 	t.endidx =		91;
 	t.seq =			tseq;
 	t.act.semaphore =	&tsem;
-	init_MUTEX_LOCKED(&tsem);
+	init_mutex_locked(&tsem);
 	
 	if (hp_sdc_enqueue_transaction(&t)) return -1;
 	
@@ -698,7 +698,7 @@ static int __init hp_sdc_rtc_init(void)
 {
 	int ret;
 
-	init_MUTEX(&i8042tregs);
+	init_mutex(&i8042tregs);
 
 	if ((ret = hp_sdc_request_timer_irq(&hp_sdc_rtc_isr)))
 		return ret;
--- linux-2.6.13-rc6-git9-orig/drivers/input/mouse/hil_ptr.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/mouse/hil_ptr.c	2005-08-18 00:55:11.000000000 +0200
@@ -256,7 +256,7 @@ static void hil_ptr_connect(struct serio
 	ptr->serio = serio;
 	ptr->dev.private = ptr;
 
-	init_MUTEX_LOCKED(&(ptr->sem));
+	init_mutex_locked(&(ptr->sem));
 
 	/* Get device info.  MLC driver supplies devid/status/etc. */
 	serio->write(serio, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/input/serio/hil_mlc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/serio/hil_mlc.c	2005-08-18 00:55:11.000000000 +0200
@@ -849,15 +849,15 @@ int hil_mlc_register(hil_mlc *mlc) {
         mlc->ostarted = 0;
 
         rwlock_init(&mlc->lock);
-        init_MUTEX(&(mlc->osem));
+        init_mutex(&(mlc->osem));
 
-        init_MUTEX(&(mlc->isem));
+        init_mutex(&(mlc->isem));
         mlc->icount = -1;
         mlc->imatch = 0;
 
 	mlc->opercnt = 0;
 
-        init_MUTEX_LOCKED(&(mlc->csem));
+        init_mutex_locked(&(mlc->csem));
 
 	hil_mlc_clear_di_scratch(mlc);
 	hil_mlc_clear_di_map(mlc, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/input/serio/hp_sdc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/serio/hp_sdc.c	2005-08-18 00:55:11.000000000 +0200
@@ -842,7 +842,7 @@ static int __init hp_sdc_init(void)
 	ts_sync[1]	= 0x0f;
 	ts_sync[2] = ts_sync[3]	= ts_sync[4] = ts_sync[5] = 0;
 	t_sync.act.semaphore = &s_sync;
-	init_MUTEX_LOCKED(&s_sync);
+	init_mutex_locked(&s_sync);
 	hp_sdc_enqueue_transaction(&t_sync);
 	down(&s_sync); /* Wait for t_sync to complete */
 
@@ -953,7 +953,7 @@ static int __init hp_sdc_register(void)
 		return hp_sdc.dev_err;
 	}
 
-	init_MUTEX_LOCKED(&tq_init_sem);
+	init_mutex_locked(&tq_init_sem);
 
 	tq_init.actidx		= 0;
 	tq_init.idx		= 1;
--- linux-2.6.13-rc6-git9-orig/drivers/input/serio/libps2.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/serio/libps2.c	2005-08-18 00:55:11.000000000 +0200
@@ -281,7 +281,7 @@ int ps2_schedule_command(struct ps2dev *
 
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 {
-	init_MUTEX(&ps2dev->cmd_sem);
+	init_mutex(&ps2dev->cmd_sem);
 	init_waitqueue_head(&ps2dev->wait);
 	ps2dev->serio = serio;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/input/serio/serio.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/input/serio/serio.c	2005-08-18 00:55:11.000000000 +0200
@@ -520,7 +520,7 @@ static void serio_init_port(struct serio
 	__module_get(THIS_MODULE);
 
 	spin_lock_init(&serio->lock);
-	init_MUTEX(&serio->drv_sem);
+	init_mutex(&serio->drv_sem);
 	device_initialize(&serio->dev);
 	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id),
 		 "serio%ld", (long)atomic_inc_return(&serio_no) - 1);
--- linux-2.6.13-rc6-git9-orig/drivers/isdn/capi/capi.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/isdn/capi/capi.c	2005-08-18 00:55:11.000000000 +0200
@@ -381,7 +381,7 @@ static struct capidev *capidev_alloc(voi
 		return NULL;
 	memset(cdev, 0, sizeof(struct capidev));
 
-	init_MUTEX(&cdev->ncci_list_sem);
+	init_mutex(&cdev->ncci_list_sem);
 	skb_queue_head_init(&cdev->recvqueue);
 	init_waitqueue_head(&cdev->recvwait);
 	write_lock_irqsave(&capidev_list_lock, flags);
--- linux-2.6.13-rc6-git9-orig/drivers/isdn/capi/kcapi.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/isdn/capi/kcapi.c	2005-08-18 00:55:11.000000000 +0200
@@ -524,7 +524,7 @@ u16 capi20_register(struct capi20_appl *
 	ap->nsentctlpkt = 0;
 	ap->nsentdatapkt = 0;
 	ap->callback = NULL;
-	init_MUTEX(&ap->recv_sem);
+	init_mutex(&ap->recv_sem);
 	skb_queue_head_init(&ap->recv_queue);
 	INIT_WORK(&ap->recv_work, recv_handler, (void *)ap);
 	ap->release_in_progress = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/isdn/i4l/isdn_common.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/isdn/i4l/isdn_common.c	2005-08-18 00:55:11.000000000 +0200
@@ -2176,7 +2176,7 @@ static int __init isdn_init(void)
 #ifdef MODULE
 	dev->owner = THIS_MODULE;
 #endif
-	init_MUTEX(&dev->sem);
+	init_mutex(&dev->sem);
 	init_waitqueue_head(&dev->info_waitq);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
 		dev->drvmap[i] = -1;
--- linux-2.6.13-rc6-git9-orig/drivers/isdn/i4l/isdn_tty.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/isdn/i4l/isdn_tty.c	2005-08-18 00:55:11.000000000 +0200
@@ -1929,7 +1929,7 @@ isdn_tty_modem_init(void)
 		info->owner = THIS_MODULE;
 #endif
 		spin_lock_init(&info->readlock);
-		init_MUTEX(&info->write_sem);
+		init_mutex(&info->write_sem);
 		sprintf(info->last_cause, "0000");
 		sprintf(info->last_num, "none");
 		info->last_dir = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/macintosh/mediabay.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/macintosh/mediabay.c	2005-08-18 00:55:11.000000000 +0200
@@ -672,7 +672,7 @@ static int __devinit media_bay_attach(st
 	bay->index = i;
 	bay->ops = match->data;
 	bay->sleeping = 0;
-	init_MUTEX(&bay->lock);
+	init_mutex(&bay->lock);
 
 	/* Init HW probing */
 	if (bay->ops->init)
--- linux-2.6.13-rc6-git9-orig/drivers/macintosh/therm_windtunnel.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/macintosh/therm_windtunnel.c	2005-08-18 00:55:11.000000000 +0200
@@ -488,7 +488,7 @@ g4fan_init( void )
 	struct apple_thermal_info *info;
 	struct device_node *np;
 
-	init_MUTEX( &x.lock );
+	init_mutex( &x.lock );
 
 	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
 		return -ENODEV;
--- linux-2.6.13-rc6-git9-orig/drivers/md/dm.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/md/dm.c	2005-08-18 00:55:11.000000000 +0200
@@ -748,7 +748,7 @@ static struct mapped_device *alloc_dev(u
 
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->io_lock);
-	init_MUTEX(&md->suspend_lock);
+	init_mutex(&md->suspend_lock);
 	rwlock_init(&md->map_lock);
 	atomic_set(&md->holders, 1);
 	atomic_set(&md->event_nr, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/md/kcopyd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/md/kcopyd.c	2005-08-18 00:55:11.000000000 +0200
@@ -549,7 +549,7 @@ int kcopyd_copy(struct kcopyd_client *kc
 		dispatch_job(job);
 
 	else {
-		init_MUTEX(&job->lock);
+		init_mutex(&job->lock);
 		job->progress = 0;
 		split_job(job);
 	}
--- linux-2.6.13-rc6-git9-orig/drivers/md/md.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/md/md.c	2005-08-18 00:55:11.000000000 +0200
@@ -218,7 +218,7 @@ static mddev_t * mddev_find(dev_t unit)
 	else
 		new->md_minor = MINOR(unit) >> MdpMinorShift;
 
-	init_MUTEX(&new->reconfig_sem);
+	init_mutex(&new->reconfig_sem);
 	INIT_LIST_HEAD(&new->disks);
 	INIT_LIST_HEAD(&new->all_mddevs);
 	init_timer(&new->safemode_timer);
--- linux-2.6.13-rc6-git9-orig/drivers/media/common/saa7146_core.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/common/saa7146_core.c	2005-08-18 00:55:11.000000000 +0200
@@ -407,11 +407,11 @@ static int saa7146_init_one(struct pci_d
 
 	pci_set_drvdata(pci, dev);
 
-        init_MUTEX(&dev->lock);
+        init_mutex(&dev->lock);
 	spin_lock_init(&dev->int_slock);
 	spin_lock_init(&dev->slock);
 
-	init_MUTEX(&dev->i2c_lock);
+	init_mutex(&dev->i2c_lock);
 
 	dev->module = THIS_MODULE;
 	init_waitqueue_head(&dev->i2c_wq);
--- linux-2.6.13-rc6-git9-orig/drivers/media/common/saa7146_vbi.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/common/saa7146_vbi.c	2005-08-18 00:55:11.000000000 +0200
@@ -410,7 +410,7 @@ static int vbi_open(struct saa7146_dev *
 			    V4L2_FIELD_SEQ_TB, // FIXME: does this really work?
 			    sizeof(struct saa7146_buf),
 			    file);
-	init_MUTEX(&fh->vbi_q.lock);
+	init_mutex(&fh->vbi_q.lock);
 
 	init_timer(&fh->vbi_read_timeout);
 	fh->vbi_read_timeout.function = vbi_read_timeout;
--- linux-2.6.13-rc6-git9-orig/drivers/media/common/saa7146_video.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/common/saa7146_video.c	2005-08-18 00:55:11.000000000 +0200
@@ -1419,7 +1419,7 @@ static int video_open(struct saa7146_dev
 			    sizeof(struct saa7146_buf),
 			    file);
 
-	init_MUTEX(&fh->video_q.lock);
+	init_mutex(&fh->video_q.lock);
 
 	return 0;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-08-18 00:55:11.000000000 +0200
@@ -659,7 +659,7 @@ static int dvb_bt8xx_probe(struct device
 		return -ENOMEM;
 
 	memset(card, 0, sizeof(*card));
-	init_MUTEX(&card->lock);
+	init_mutex(&card->lock);
 	card->bttv_nr = sub->core->nr;
 	strncpy(card->card_name, sub->core->name, sizeof(sub->core->name));
 	card->i2c_adapter = &sub->core->i2c_adap;
@@ -754,7 +754,7 @@ static int dvb_bt8xx_probe(struct device
 
 	}
 
-	init_MUTEX(&card->bt->gpio_lock);
+	init_mutex(&card->bt->gpio_lock);
 	card->bt->bttv_nr = sub->core->nr;
 
 	if ( (ret = dvb_bt8xx_load_card(card, sub->core->type)) ) {
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-08-18 00:55:11.000000000 +0200
@@ -782,7 +782,7 @@ static int cinergyt2_probe (struct usb_i
 	memset (cinergyt2, 0, sizeof (struct cinergyt2));
 	usb_set_intfdata (intf, (void *) cinergyt2);
 
-	init_MUTEX(&cinergyt2->sem);
+	init_mutex(&cinergyt2->sem);
 	init_waitqueue_head (&cinergyt2->poll_wq);
 	INIT_WORK(&cinergyt2->query_work, cinergyt2_query, cinergyt2);
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-08-18 00:55:11.000000000 +0200
@@ -556,7 +556,7 @@ static void dvb_frontend_stop(struct dvb
 		printk("dvb_frontend_stop: thread PID %d already died\n",
 				fepriv->thread_pid);
 		/* make sure the mutex was not held by the thread */
-		init_MUTEX (&fepriv->sem);
+		init_mutex (&fepriv->sem);
 		return;
 	}
 
@@ -908,10 +908,10 @@ int dvb_register_frontend(struct dvb_ada
 	fepriv = fe->frontend_priv;
 	memset(fe->frontend_priv, 0, sizeof(struct dvb_frontend_private));
 
-	init_MUTEX (&fepriv->sem);
+	init_mutex (&fepriv->sem);
 	init_waitqueue_head (&fepriv->wait_queue);
 	init_waitqueue_head (&fepriv->events.wait_queue);
-	init_MUTEX (&fepriv->events.sem);
+	init_mutex (&fepriv->events.sem);
 	fe->dvb = dvb;
 	fepriv->inversion = INVERSION_OFF;
 	fepriv->tone = SEC_TONE_OFF;
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/miropcm20-rds-core.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/miropcm20-rds-core.c	2005-08-18 00:55:11.000000000 +0200
@@ -200,7 +200,7 @@ EXPORT_SYMBOL(aci_rds_cmd);
 
 int __init attach_aci_rds(void)
 {
-	init_MUTEX(&aci_rds_sem);
+	init_mutex(&aci_rds_sem);
 	return 0;
 }
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-aimslab.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-aimslab.c	2005-08-18 00:55:11.000000000 +0200
@@ -336,7 +336,7 @@ static int __init rtrack_init(void)
 
 	/* Set up the I/O locking */
 	
-	init_MUTEX(&lock);
+	init_mutex(&lock);
 	
  	/* mute card - prevents noisy bootups */
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-aztech.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-aztech.c	2005-08-18 00:55:11.000000000 +0200
@@ -282,7 +282,7 @@ static int __init aztech_init(void)
 		return -EBUSY;
 	}
 
-	init_MUTEX(&lock);
+	init_mutex(&lock);
 	aztech_radio.priv=&aztech_unit;
 	
 	if(video_register_device(&aztech_radio, VFL_TYPE_RADIO, radio_nr)==-1)
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-maestro.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-maestro.c	2005-08-18 00:55:11.000000000 +0200
@@ -311,7 +311,7 @@ static __u16 radio_install(struct pci_de
 	
 	radio_unit.io = pcidev->resource[0].start + GPIO_DATA;
 	maestro_radio.priv = &radio_unit;
-	init_MUTEX(&radio_unit.lock);
+	init_mutex(&radio_unit.lock);
 	
 	if(radio_power_on(&radio_unit)) {
 		if(video_register_device(&maestro_radio, VFL_TYPE_RADIO, radio_nr)==-1) {
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-maxiradio.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-maxiradio.c	2005-08-18 00:55:11.000000000 +0200
@@ -289,7 +289,7 @@ static int __devinit maxiradio_init_one(
 	        goto err_out_free_region;
 
 	radio_unit.io = pci_resource_start(pdev, 0);
-	init_MUTEX(&radio_unit.lock);
+	init_mutex(&radio_unit.lock);
 	maxiradio_radio.priv = &radio_unit;
 
 	if(video_register_device(&maxiradio_radio, VFL_TYPE_RADIO, radio_nr)==-1) {
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-sf16fmi.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-sf16fmi.c	2005-08-18 00:55:11.000000000 +0200
@@ -295,7 +295,7 @@ static int __init fmi_init(void)
 	fmi_unit.flags = VIDEO_TUNER_LOW;
 	fmi_radio.priv = &fmi_unit;
 	
-	init_MUTEX(&lock);
+	init_mutex(&lock);
 	
 	if (video_register_device(&fmi_radio, VFL_TYPE_RADIO, radio_nr) == -1) {
 		release_region(io, 2);
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-sf16fmr2.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-sf16fmr2.c	2005-08-18 00:55:11.000000000 +0200
@@ -379,7 +379,7 @@ static int __init fmr2_init(void)
 	fmr2_unit.card_type = 0;
 	fmr2_radio.priv = &fmr2_unit;
 
-	init_MUTEX(&lock);
+	init_mutex(&lock);
 
 	if (request_region(io, 2, "sf16fmr2"))
 	{
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-typhoon.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-typhoon.c	2005-08-18 00:55:11.000000000 +0200
@@ -336,7 +336,7 @@ static int __init typhoon_init(void)
 #endif /* MODULE */
 
 	printk(KERN_INFO BANNER);
-	init_MUTEX(&typhoon_unit.lock);
+	init_mutex(&typhoon_unit.lock);
 	io = typhoon_unit.iobase;
 	if (!request_region(io, 8, "typhoon")) {
 		printk(KERN_ERR "radio-typhoon: port 0x%x already in use\n",
--- linux-2.6.13-rc6-git9-orig/drivers/media/radio/radio-zoltrix.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/radio/radio-zoltrix.c	2005-08-18 00:55:11.000000000 +0200
@@ -349,7 +349,7 @@ static int __init zoltrix_init(void)
 	}
 	printk(KERN_INFO "Zoltrix Radio Plus card driver.\n");
 
-	init_MUTEX(&zoltrix_unit.lock);
+	init_mutex(&zoltrix_unit.lock);
 	
 	/* mute card - prevents noisy bootups */
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/arv.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/arv.c	2005-08-18 00:55:12.000000000 +0200
@@ -824,7 +824,7 @@ static int __init ar_init(void)
 		ar->line_bytes	= AR_LINE_BYTES_QVGA;
 		ar->mode	= AR_MODE_INTERLACE;
 	}
-	init_MUTEX(&ar->lock);
+	init_mutex(&ar->lock);
 	init_waitqueue_head(&ar->wait);
 
 #if USE_INT
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/bttv-driver.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/bttv-driver.c	2005-08-18 00:55:12.000000000 +0200
@@ -3844,8 +3844,8 @@ static int __devinit bttv_probe(struct p
 	sprintf(btv->c.name,"bttv%d",btv->c.nr);
 
 	/* initialize structs / fill in defaults */
-        init_MUTEX(&btv->lock);
-        init_MUTEX(&btv->reslock);
+        init_mutex(&btv->lock);
+        init_mutex(&btv->reslock);
         spin_lock_init(&btv->s_lock);
         spin_lock_init(&btv->gpio_lock);
         init_waitqueue_head(&btv->gpioq);
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/bw-qcam.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/bw-qcam.c	2005-08-18 00:55:12.000000000 +0200
@@ -168,7 +168,7 @@ static struct qcam_device *qcam_init(str
 	
 	memcpy(&q->vdev, &qcam_template, sizeof(qcam_template));
 	
-	init_MUTEX(&q->lock);
+	init_mutex(&q->lock);
 
 	q->port_mode = (QC_ANY | QC_NOTSET);
 	q->width = 320;
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/c-qcam.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/c-qcam.c	2005-08-18 00:55:12.000000000 +0200
@@ -726,7 +726,7 @@ static struct qcam_device *qcam_init(str
 	
 	memcpy(&q->vdev, &qcam_template, sizeof(qcam_template));
 
-	init_MUTEX(&q->lock);
+	init_mutex(&q->lock);
 	q->width = q->ccd_width = 320;
 	q->height = q->ccd_height = 240;
 	q->mode = QC_MILLIONS | QC_DECIMATION_1;
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/cpia.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/cpia.c	2005-08-18 00:55:12.000000000 +0200
@@ -3935,8 +3935,8 @@ static void init_camera_struct(struct ca
 	memset(cam, 0, sizeof(struct cam_data));
 
 	cam->ops = ops;
-	init_MUTEX(&cam->param_lock);
-	init_MUTEX(&cam->busy_lock);
+	init_mutex(&cam->param_lock);
+	init_mutex(&cam->busy_lock);
 
 	reset_camera_struct(cam);
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/cx88/cx88-mpeg.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/cx88/cx88-mpeg.c	2005-08-18 00:55:12.000000000 +0200
@@ -387,7 +387,7 @@ int cx8802_init_common(struct cx8802_dev
 	       dev->pci_lat,pci_resource_start(dev->pci,0));
 
 	/* initialize driver struct */
-        init_MUTEX(&dev->lock);
+        init_mutex(&dev->lock);
 	spin_lock_init(&dev->slock);
 
 	/* init dma queue */
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/cx88/cx88-video.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/cx88/cx88-video.c	2005-08-18 00:55:12.000000000 +0200
@@ -1798,7 +1798,7 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* initialize driver struct */
-        init_MUTEX(&dev->lock);
+        init_mutex(&dev->lock);
 	spin_lock_init(&dev->slock);
 	core->tvnorm = tvnorms;
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/meye.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/meye.c	2005-08-18 00:55:12.000000000 +0200
@@ -1911,7 +1911,7 @@ static int __devinit meye_probe(struct p
 		goto outvideoreg;
 	}
 
-	init_MUTEX(&meye.lock);
+	init_mutex(&meye.lock);
 	init_waitqueue_head(&meye.proc_list);
 	meye.picture.depth = 16;
 	meye.picture.palette = VIDEO_PALETTE_YUV422;
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/planb.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/planb.c	2005-08-18 00:55:12.000000000 +0200
@@ -2067,7 +2067,7 @@ static int init_planb(struct planb *pb)
 #endif
 	pb->tab_size = PLANB_MAXLINES + 40;
 	pb->suspend = 0;
-	init_MUTEX(&pb->lock);
+	init_mutex(&pb->lock);
 	pb->ch1_cmd = 0;
 	pb->ch2_cmd = 0;
 	pb->mask = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/pms.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/pms.c	2005-08-18 00:55:12.000000000 +0200
@@ -1028,7 +1028,7 @@ static int __init init_pms_cards(void)
 		return -ENODEV;
 	}
 	memcpy(&pms_device, &pms_template, sizeof(pms_template));
-	init_MUTEX(&pms_device.lock);
+	init_mutex(&pms_device.lock);
 	pms_device.height=240;
 	pms_device.width=320;
 	pms_swsense(75);
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/saa5246a.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/saa5246a.c	2005-08-18 00:55:12.000000000 +0200
@@ -91,7 +91,7 @@ static int saa5246a_attach(struct i2c_ad
 	}
 	memset(t, 0, sizeof(*t));
 	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
-	init_MUTEX(&t->lock);
+	init_mutex(&t->lock);
 
 	/*
 	 *	Now create a video4linux device
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/saa5249.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/saa5249.c	2005-08-18 00:55:12.000000000 +0200
@@ -159,7 +159,7 @@ static int saa5249_attach(struct i2c_ada
 	}
 	memset(t, 0, sizeof(*t));
 	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
-	init_MUTEX(&t->lock);
+	init_mutex(&t->lock);
 	
 	/*
 	 *	Now create a video4linux device
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/saa7134/saa7134-core.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/saa7134/saa7134-core.c	2005-08-18 00:55:12.000000000 +0200
@@ -637,7 +637,7 @@ static int saa7134_hwinit1(struct saa713
 
 	saa_writel(SAA7134_IRQ1, 0);
 	saa_writel(SAA7134_IRQ2, 0);
-        init_MUTEX(&dev->lock);
+        init_mutex(&dev->lock);
 	spin_lock_init(&dev->slock);
 
 	saa7134_track_gpio(dev,"pre-init");
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/saa7134/saa7134-oss.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/saa7134/saa7134-oss.c	2005-08-18 00:55:12.000000000 +0200
@@ -771,7 +771,7 @@ struct file_operations saa7134_mixer_fop
 int saa7134_oss_init1(struct saa7134_dev *dev)
 {
 	/* general */
-        init_MUTEX(&dev->oss.lock);
+        init_mutex(&dev->oss.lock);
 	init_waitqueue_head(&dev->oss.wq);
 
 	switch (dev->pci->device) {
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/video-buf-dvb.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/video-buf-dvb.c	2005-08-18 00:55:12.000000000 +0200
@@ -139,7 +139,7 @@ int videobuf_dvb_register(struct videobu
 {
 	int result;
 
-	init_MUTEX(&dvb->lock);
+	init_mutex(&dvb->lock);
 
 	/* register adapter */
 	result = dvb_register_adapter(&dvb->adapter, dvb->name, module);
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/video-buf.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/video-buf.c	2005-08-18 00:55:12.000000000 +0200
@@ -389,7 +389,7 @@ void videobuf_queue_init(struct videobuf
 	q->ops     = ops;
 	q->priv_data = priv;
 
-	init_MUTEX(&q->lock);
+	init_mutex(&q->lock);
 	INIT_LIST_HEAD(&q->stream);
 }
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/videodev.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/videodev.c	2005-08-18 00:55:12.000000000 +0200
@@ -332,7 +332,7 @@ int video_register_device(struct video_d
 	sprintf(vfd->devfs_name, "v4l/%s%d", name_base, i - base);
 	devfs_mk_cdev(MKDEV(VIDEO_MAJOR, vfd->minor),
 			S_IFCHR | S_IRUSR | S_IWUSR, vfd->devfs_name);
-	init_MUTEX(&vfd->lock);
+	init_mutex(&vfd->lock);
 
 	/* sysfs class */
         memset(&vfd->class_dev, 0x00, sizeof(vfd->class_dev));
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/vino.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/vino.c	2005-08-18 00:55:12.000000000 +0200
@@ -283,7 +283,7 @@ static int __init vino_init(void)
         vino->a.fifo_thres = threshold_a;
 	vino->b.fifo_thres = threshold_b;
 
-	init_MUTEX(&Vino->input_lock);
+	init_mutex(&Vino->input_lock);
 
 	if (request_irq(SGI_VINO_IRQ, vino_interrupt, 0, vinostr, NULL)) {
 		printk(KERN_ERR "VINO: irq%02d registration failed\n",
--- linux-2.6.13-rc6-git9-orig/drivers/media/video/zoran_card.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/video/zoran_card.c	2005-08-18 00:55:12.000000000 +0200
@@ -1209,7 +1209,7 @@ find_zr36057 (void)
 		zr->id = zoran_num;
 		snprintf(ZR_DEVNAME(zr), sizeof(ZR_DEVNAME(zr)), "MJPEG[%u]", zr->id);
 		spin_lock_init(&zr->spinlock);
-		init_MUTEX(&zr->resource_lock);
+		init_mutex(&zr->resource_lock);
 		if (pci_enable_device(dev))
 			continue;
 		zr->zr36057_adr = pci_resource_start(zr->pci_dev, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/message/i2o/device.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/message/i2o/device.c	2005-08-18 00:55:12.000000000 +0200
@@ -189,7 +189,7 @@ static struct i2o_device *i2o_device_all
 	memset(dev, 0, sizeof(*dev));
 
 	INIT_LIST_HEAD(&dev->list);
-	init_MUTEX(&dev->lock);
+	init_mutex(&dev->lock);
 
 	dev->device.bus = &i2o_bus_type;
 	dev->device.release = &i2o_device_release;
--- linux-2.6.13-rc6-git9-orig/drivers/message/i2o/iop.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/message/i2o/iop.c	2005-08-18 00:55:12.000000000 +0200
@@ -1105,7 +1105,7 @@ struct i2o_controller *i2o_iop_alloc(voi
 
 	INIT_LIST_HEAD(&c->devices);
 	spin_lock_init(&c->lock);
-	init_MUTEX(&c->lct_lock);
+	init_mutex(&c->lct_lock);
 	c->unit = unit++;
 	sprintf(c->name, "iop%d", c->unit);
 
--- linux-2.6.13-rc6-git9-orig/drivers/mmc/mmc_queue.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mmc/mmc_queue.c	2005-08-18 00:55:12.000000000 +0200
@@ -156,7 +156,7 @@ int mmc_init_queue(struct mmc_queue *mq,
 
 	init_completion(&mq->thread_complete);
 	init_waitqueue_head(&mq->thread_wq);
-	init_MUTEX(&mq->thread_sem);
+	init_mutex(&mq->thread_sem);
 
 	ret = kernel_thread(mmc_queue_thread, mq, CLONE_KERNEL);
 	if (ret >= 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/mtd/devices/blkmtd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mtd/devices/blkmtd.c	2005-08-18 00:55:12.000000000 +0200
@@ -662,7 +662,7 @@ static struct blkmtd_dev *add_device(cha
 	memset(dev, 0, sizeof(struct blkmtd_dev));
 	dev->blkdev = bdev;
 	if(!readonly) {
-		init_MUTEX(&dev->wrbuf_mutex);
+		init_mutex(&dev->wrbuf_mutex);
 	}
 
 	dev->mtd_info.size = dev->blkdev->bd_inode->i_size & PAGE_MASK;
--- linux-2.6.13-rc6-git9-orig/drivers/mtd/devices/block2mtd.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mtd/devices/block2mtd.c	2005-08-18 00:55:12.000000000 +0200
@@ -310,7 +310,7 @@ static struct block2mtd_dev *add_device(
 		goto devinit_err;
 	}
 
-	init_MUTEX(&dev->write_mutex);
+	init_mutex(&dev->write_mutex);
 
 	/* Setup the MTD structure */
 	/* make the name contain the block device in */
--- linux-2.6.13-rc6-git9-orig/drivers/mtd/devices/doc2000.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mtd/devices/doc2000.c	2005-08-18 00:55:12.000000000 +0200
@@ -605,7 +605,7 @@ static void DoC2k_init(struct mtd_info *
 
 	this->curfloor = -1;
 	this->curchip = -1;
-	init_MUTEX(&this->lock);
+	init_mutex(&this->lock);
 
 	/* Ident all the chips present. */
 	DoC_ScanChips(this, maxchips);
--- linux-2.6.13-rc6-git9-orig/drivers/mtd/mtd_blkdevs.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mtd/mtd_blkdevs.c	2005-08-18 00:55:12.000000000 +0200
@@ -275,7 +275,7 @@ int add_mtd_blktrans_dev(struct mtd_blkt
 		return -EBUSY;
 	}
 
-	init_MUTEX(&new->sem);
+	init_mutex(&new->sem);
 	list_add_tail(&new->list, &tr->devs);
  added:
 	if (!tr->writesect)
--- linux-2.6.13-rc6-git9-orig/drivers/mtd/mtdblock.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/mtd/mtdblock.c	2005-08-18 00:55:12.000000000 +0200
@@ -282,7 +282,7 @@ static int mtdblock_open(struct mtd_blkt
 	mtdblk->count = 1;
 	mtdblk->mtd = mtd;
 
-	init_MUTEX (&mtdblk->cache_sem);
+	init_mutex (&mtdblk->cache_sem);
 	mtdblk->cache_state = STATE_EMPTY;
 	if ((mtdblk->mtd->flags & MTD_CAP_RAM) != MTD_CAP_RAM &&
 	    mtdblk->mtd->erasesize) {
--- linux-2.6.13-rc6-git9-orig/drivers/net/3c527.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/3c527.c	2005-08-18 00:55:12.000000000 +0200
@@ -514,7 +514,7 @@ static int __init mc32_probe1(struct net
 	lp->tx_len 		= lp->exec_box->data[9];   /* Transmit list count */ 
 	lp->rx_len 		= lp->exec_box->data[11];  /* Receive list count */
 
-	init_MUTEX_LOCKED(&lp->cmd_mutex);
+	init_mutex_locked(&lp->cmd_mutex);
 	init_completion(&lp->execution_cmd);
 	init_completion(&lp->xceiver_cmd);
 	
--- linux-2.6.13-rc6-git9-orig/drivers/net/hamradio/6pack.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/hamradio/6pack.c	2005-08-18 00:55:12.000000000 +0200
@@ -625,7 +625,7 @@ static int sixpack_open(struct tty_struc
 
 	spin_lock_init(&sp->lock);
 	atomic_set(&sp->refcnt, 1);
-	init_MUTEX_LOCKED(&sp->dead_sem);
+	init_mutex_locked(&sp->dead_sem);
 
 	/* !!! length of the buffers. MTU is IP MTU, not PACLEN!  */
 
--- linux-2.6.13-rc6-git9-orig/drivers/net/irda/sir_dev.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/irda/sir_dev.c	2005-08-18 00:55:12.000000000 +0200
@@ -612,7 +612,7 @@ struct sir_dev * sirdev_get_instance(con
 	dev->tx_skb = NULL;
 
 	spin_lock_init(&dev->tx_lock);
-	init_MUTEX(&dev->fsm.sem);
+	init_mutex(&dev->fsm.sem);
 
 	INIT_LIST_HEAD(&dev->fsm.rq.lh_request);
 	dev->fsm.rq.pending = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/net/irda/vlsi_ir.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/irda/vlsi_ir.c	2005-08-18 00:55:12.000000000 +0200
@@ -1664,7 +1664,7 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	idev = ndev->priv;
 
 	spin_lock_init(&idev->lock);
-	init_MUTEX(&idev->sem);
+	init_mutex(&idev->sem);
 	down(&idev->sem);
 	idev->pdev = pdev;
 
--- linux-2.6.13-rc6-git9-orig/drivers/net/plip.c	2005-08-17 21:51:47.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/plip.c	2005-08-18 00:55:12.000000000 +0200
@@ -1125,7 +1125,7 @@ plip_close(struct net_device *dev)
 
 	if (dev->irq == -1)
 	{
-		init_MUTEX_LOCKED (&nl->killed_timer_sem);
+		init_mutex_locked (&nl->killed_timer_sem);
 		atomic_set (&nl->kill_timer, 1);
 		down (&nl->killed_timer_sem);
 	}
--- linux-2.6.13-rc6-git9-orig/drivers/net/ppp_async.c	2005-08-17 21:51:47.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/ppp_async.c	2005-08-18 00:55:12.000000000 +0200
@@ -178,7 +178,7 @@ ppp_asynctty_open(struct tty_struct *tty
 	tasklet_init(&ap->tsk, ppp_async_process, (unsigned long) ap);
 
 	atomic_set(&ap->refcnt, 1);
-	init_MUTEX_LOCKED(&ap->dead_sem);
+	init_mutex_locked(&ap->dead_sem);
 
 	ap->chan.private = ap;
 	ap->chan.ops = &async_ops;
--- linux-2.6.13-rc6-git9-orig/drivers/net/ppp_synctty.c	2005-08-17 21:51:47.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/ppp_synctty.c	2005-08-18 00:55:12.000000000 +0200
@@ -226,7 +226,7 @@ ppp_sync_open(struct tty_struct *tty)
 	tasklet_init(&ap->tsk, ppp_sync_process, (unsigned long) ap);
 
 	atomic_set(&ap->refcnt, 1);
-	init_MUTEX_LOCKED(&ap->dead_sem);
+	init_mutex_locked(&ap->dead_sem);
 
 	ap->chan.private = ap;
 	ap->chan.ops = &sync_ops;
--- linux-2.6.13-rc6-git9-orig/drivers/net/sungem.c	2005-08-17 21:51:48.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/sungem.c	2005-08-18 00:55:12.000000000 +0200
@@ -3038,7 +3038,7 @@ static int __devinit gem_init_one(struct
 
 	spin_lock_init(&gp->lock);
 	spin_lock_init(&gp->tx_lock);
-	init_MUTEX(&gp->pm_sem);
+	init_mutex(&gp->pm_sem);
 
 	init_timer(&gp->link_timer);
 	gp->link_timer.function = gem_link_timer;
--- linux-2.6.13-rc6-git9-orig/drivers/net/wan/cosa.c	2005-08-17 21:51:48.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/wan/cosa.c	2005-08-18 00:55:12.000000000 +0200
@@ -825,8 +825,8 @@ static struct net_device_stats *cosa_net
 
 static void chardev_channel_init(struct channel_data *chan)
 {
-	init_MUTEX(&chan->rsem);
-	init_MUTEX(&chan->wsem);
+	init_mutex(&chan->rsem);
+	init_mutex(&chan->wsem);
 }
 
 static ssize_t cosa_read(struct file *file,
--- linux-2.6.13-rc6-git9-orig/drivers/parport/share.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/parport/share.c	2005-08-18 00:55:12.000000000 +0200
@@ -311,7 +311,7 @@ struct parport *parport_register_port(un
 	spin_lock_init(&tmp->pardevice_lock);
 	tmp->ieee1284.mode = IEEE1284_MODE_COMPAT;
 	tmp->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
-	init_MUTEX_LOCKED (&tmp->ieee1284.irq); /* actually a semaphore at 0 */
+	init_mutex_locked (&tmp->ieee1284.irq); /* actually a semaphore at 0 */
 	tmp->spintime = parport_default_spintime;
 	atomic_set (&tmp->ref_count, 1);
 	INIT_LIST_HEAD(&tmp->full_list);
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/acpiphp_glue.c	2005-08-17 21:51:49.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/acpiphp_glue.c	2005-08-18 00:55:12.000000000 +0200
@@ -185,7 +185,7 @@ register_slot(acpi_handle handle, u32 lv
 		slot->device = device;
 		slot->sun = sun;
 		INIT_LIST_HEAD(&slot->funcs);
-		init_MUTEX(&slot->crit_sect);
+		init_mutex(&slot->crit_sect);
 
 		slot->next = bridge->slots;
 		bridge->slots = slot;
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/cpci_hotplug_core.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/cpci_hotplug_core.c	2005-08-18 00:55:12.000000000 +0200
@@ -599,8 +599,8 @@ cpci_start_thread(void)
 	int pid;
 
 	/* initialize our semaphores */
-	init_MUTEX_LOCKED(&event_semaphore);
-	init_MUTEX_LOCKED(&thread_exit);
+	init_mutex_locked(&event_semaphore);
+	init_mutex_locked(&thread_exit);
 	thread_finished = 0;
 
 	if (controller->irq)
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/cpqphp_core.c	2005-08-17 21:51:49.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/cpqphp_core.c	2005-08-18 00:55:12.000000000 +0200
@@ -1057,7 +1057,7 @@ static int cpqhpc_probe(struct pci_dev *
 	dbg("bus device function rev: %d %d %d %d\n", ctrl->bus,
 		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), ctrl->rev);
 
-	init_MUTEX(&ctrl->crit_sect);
+	init_mutex(&ctrl->crit_sect);
 	init_waitqueue_head(&ctrl->queue);
 
 	/* initialize our threads if they haven't already been started up */
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/cpqphp_ctrl.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/cpqphp_ctrl.c	2005-08-18 00:55:12.000000000 +0200
@@ -1822,9 +1822,9 @@ int cpqhp_event_start_thread(void)
 	int pid;
 
 	/* initialize our semaphores */
-	init_MUTEX(&delay_sem);
-	init_MUTEX_LOCKED(&event_semaphore);
-	init_MUTEX_LOCKED(&event_exit);
+	init_mutex(&delay_sem);
+	init_mutex_locked(&event_semaphore);
+	init_mutex_locked(&event_exit);
 	event_finished=0;
 
 	pid = kernel_thread(event_thread, NULL, 0);
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/ibmphp_hpc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/ibmphp_hpc.c	2005-08-18 00:55:12.000000000 +0200
@@ -131,9 +131,9 @@ void __init ibmphp_hpc_initvars (void)
 {
 	debug ("%s - Entry\n", __FUNCTION__);
 
-	init_MUTEX (&sem_hpcaccess);
-	init_MUTEX (&semOperations);
-	init_MUTEX_LOCKED (&sem_exit);
+	init_mutex (&sem_hpcaccess);
+	init_mutex (&semOperations);
+	init_mutex_locked (&sem_exit);
 	to_debug = FALSE;
 	ibmphp_shutdown = FALSE;
 	tid_poll = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-18 00:55:12.000000000 +0200
@@ -1521,10 +1521,10 @@ int pciehp_event_start_thread(void)
 	int pid;
 
 	/* initialize our semaphores */
-	init_MUTEX_LOCKED(&event_exit);
+	init_mutex_locked(&event_exit);
 	event_finished=0;
 
-	init_MUTEX_LOCKED(&event_semaphore);
+	init_mutex_locked(&event_semaphore);
 	pid = kernel_thread(event_thread, NULL, 0);
 
 	if (pid < 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/pciehp_hpc.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/pciehp_hpc.c	2005-08-18 00:55:12.000000000 +0200
@@ -1353,7 +1353,7 @@ int pcie_init(struct controller * ctrl,
 	if (pci_enable_device(pdev))
 		goto abort_free_ctlr;
 	
-	init_MUTEX(&ctrl->crit_sect);
+	init_mutex(&ctrl->crit_sect);
 	/* setup wait queue */
 	init_waitqueue_head(&ctrl->queue);
 
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/rpaphp_core.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/rpaphp_core.c	2005-08-18 00:55:12.000000000 +0200
@@ -427,7 +427,7 @@ static void init_slots(void)
 static int __init init_rpa(void)
 {
 
-	init_MUTEX(&rpaphp_sem);
+	init_mutex(&rpaphp_sem);
 
 	/* initialize internal data structure etc. */
 	init_slots();
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-18 00:55:12.000000000 +0200
@@ -1691,10 +1691,10 @@ int shpchp_event_start_thread (void)
 	int pid;
 
 	/* initialize our semaphores */
-	init_MUTEX_LOCKED(&event_exit);
+	init_mutex_locked(&event_exit);
 	event_finished=0;
 
-	init_MUTEX_LOCKED(&event_semaphore);
+	init_mutex_locked(&event_semaphore);
 	pid = kernel_thread(event_thread, NULL, 0);
 
 	if (pid < 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/pci/hotplug/shpchp_hpc.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pci/hotplug/shpchp_hpc.c	2005-08-18 00:55:12.000000000 +0200
@@ -1506,7 +1506,7 @@ int shpc_init(struct controller * ctrl,
 	dbg("%s: php_ctlr->creg %p\n", __FUNCTION__, php_ctlr->creg);
 	dbg("%s: physical addr %p\n", __FUNCTION__, (void*)pci_resource_start(pdev, 0));
 
-	init_MUTEX(&ctrl->crit_sect);
+	init_mutex(&ctrl->crit_sect);
 	/* Setup wait queue */
 	init_waitqueue_head(&ctrl->queue);
 
--- linux-2.6.13-rc6-git9-orig/drivers/pcmcia/cs.c	2005-08-17 21:51:49.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/pcmcia/cs.c	2005-08-18 00:55:12.000000000 +0200
@@ -237,7 +237,7 @@ int pcmcia_register_socket(struct pcmcia
 	init_completion(&socket->socket_released);
 	init_completion(&socket->thread_done);
 	init_waitqueue_head(&socket->thread_wait);
-	init_MUTEX(&socket->skt_sem);
+	init_mutex(&socket->skt_sem);
 	spin_lock_init(&socket->thread_lock);
 
 	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
--- linux-2.6.13-rc6-git9-orig/drivers/s390/char/vmcp.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/char/vmcp.c	2005-08-18 00:55:12.000000000 +0200
@@ -40,7 +40,7 @@ static int vmcp_open(struct inode *inode
 	session->bufsize = PAGE_SIZE;
 	session->response = NULL;
 	session->resp_size = 0;
-	init_MUTEX(&session->mutex);
+	init_mutex(&session->mutex);
 	file->private_data = session;
 	return nonseekable_open(inode, file);
 }
--- linux-2.6.13-rc6-git9-orig/drivers/s390/cio/qdio.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/cio/qdio.c	2005-08-18 00:55:12.000000000 +0200
@@ -2641,7 +2641,7 @@ qdio_allocate(struct qdio_initialize *in
 
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
 
-	init_MUTEX(&irq_ptr->setting_up_sema);
+	init_mutex(&irq_ptr->setting_up_sema);
 
 	/* QDR must be in DMA area since CCW data address is only 32 bit */
 	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);


