Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVHRAOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVHRAOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVHRAOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:14:37 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:16229 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751385AbVHRAOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AOmuOgocgDOuIHIO0mHqWcF1WqGTza9Ec5qKAr4H3WFPaO4tn3tasJTHcC81/ffQXuHqo+ExUcQgV7PKPObCL2F33XJEttBpkTOgUsH45GqkexC+RecTDtFXMLq6F2D4X/tCROrsJVzT/T/31JSpW45W2WK7Su0kUbqw+LcJRN0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] rename locking functions - convert sema_init users
Date: Thu, 18 Aug 2005 02:04:33 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180204.33470.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert users of sema_init to use init_sema instead.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/ia64/kernel/perfmon.c                        |    2 +-
 arch/ia64/kernel/salinfo.c                        |    4 ++--
 arch/ia64/sn/kernel/xp_main.c                     |    2 +-
 arch/ia64/sn/kernel/xpc_channel.c                 |    6 +++---
 arch/sh/mm/cache-sh4.c                            |    8 ++++----
 drivers/acpi/osl.c                                |    2 +-
 drivers/block/aoe/aoechr.c                        |    2 +-
 drivers/char/agp/frontend.c                       |    2 +-
 drivers/char/drm/drm_stub.c                       |    4 ++--
 drivers/char/ipmi/ipmi_devintf.c                  |    2 +-
 drivers/char/rocket.c                             |    2 +-
 drivers/char/snsc.c                               |    4 ++--
 drivers/char/tty_io.c                             |    4 ++--
 drivers/char/viotape.c                            |    2 +-
 drivers/char/watchdog/sc1200wdt.c                 |    2 +-
 drivers/char/watchdog/scx200_wdt.c                |    2 +-
 drivers/char/watchdog/wdt_pci.c                   |    2 +-
 drivers/ide/ide.c                                 |    4 ++--
 drivers/ieee1394/ieee1394_types.h                 |    2 +-
 drivers/ieee1394/nodemgr.c                        |    2 +-
 drivers/ieee1394/raw1394.c                        |    2 +-
 drivers/infiniband/hw/mthca/mthca_cmd.c           |    6 +++---
 drivers/md/dm-raid1.c                             |    2 +-
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    2 +-
 drivers/media/dvb/dvb-core/dmxdev.c               |    4 ++--
 drivers/media/dvb/dvb-core/dvb_demux.c            |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb-init.c          |    4 ++--
 drivers/media/dvb/frontends/bcm3510.c             |    2 +-
 drivers/media/dvb/ttpci/av7110.c                  |    6 +++---
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 ++--
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    4 ++--
 drivers/message/fusion/mptctl.c                   |    2 +-
 drivers/net/wireless/airo.c                       |    2 +-
 drivers/net/wireless/prism54/isl_ioctl.c          |    4 ++--
 drivers/net/wireless/prism54/islpci_dev.c         |    4 ++--
 drivers/parport/ChangeLog                         |    2 +-
 drivers/s390/char/sclp_cpi.c                      |    2 +-
 drivers/s390/scsi/zfcp_aux.c                      |    2 +-
 drivers/s390/scsi/zfcp_erp.c                      |    2 +-
 drivers/scsi/megaraid/megaraid_mbox.c             |    2 +-
 drivers/scsi/megaraid/megaraid_mm.c               |    2 +-
 drivers/usb/gadget/serial.c                       |    2 +-
 drivers/usb/serial/io_ti.c                        |    2 +-
 drivers/usb/serial/ti_usb_3410_5052.c             |    2 +-
 fs/block_dev.c                                    |    4 ++--
 fs/dquot.c                                        |    2 +-
 fs/inode.c                                        |    4 ++--
 fs/inotify.c                                      |    2 +-
 fs/reiserfs/journal.c                             |    6 +++---
 fs/seq_file.c                                     |    2 +-
 fs/super.c                                        |    8 ++++----
 fs/xfs/linux-2.6/mutex.h                          |    4 ++--
 fs/xfs/linux-2.6/sema.h                           |    6 +++---
 ipc/util.c                                        |    2 +-
 net/sunrpc/svcsock.c                              |    2 +-
 55 files changed, 85 insertions(+), 85 deletions(-)

--- linux-2.6.13-rc6-git9-orig/arch/ia64/kernel/perfmon.c	2005-08-17 21:51:27.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ia64/kernel/perfmon.c	2005-08-18 00:46:40.000000000 +0200
@@ -2698,7 +2698,7 @@ pfm_context_create(pfm_context_t *ctx, v
 	/*
 	 * init restart semaphore to locked
 	 */
-	sema_init(&ctx->ctx_restart_sem, 0);
+	init_sema(&ctx->ctx_restart_sem, 0);
 
 	/*
 	 * activation is used in SMP only
--- linux-2.6.13-rc6-git9-orig/arch/ia64/kernel/salinfo.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ia64/kernel/salinfo.c	2005-08-18 00:46:40.000000000 +0200
@@ -563,7 +563,7 @@ salinfo_init(void)
 	for (i = 0; i < ARRAY_SIZE(salinfo_log_name); i++) {
 		data = salinfo_data + i;
 		data->type = i;
-		sema_init(&data->sem, 0);
+		init_sema(&data->sem, 0);
 		dir = proc_mkdir(salinfo_log_name[i], salinfo_dir);
 		if (!dir)
 			continue;
@@ -589,7 +589,7 @@ salinfo_init(void)
 				set_bit(j, &data->cpu_event);
 				++online;
 			}
-		sema_init(&data->sem, online);
+		init_sema(&data->sem, online);
 
 		*sdir++ = dir;
 	}
--- linux-2.6.13-rc6-git9-orig/arch/ia64/sn/kernel/xp_main.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ia64/sn/kernel/xp_main.c	2005-08-18 00:46:40.000000000 +0200
@@ -252,7 +252,7 @@ xp_init(void)
 
 	/* initialize the connection registration semaphores */
 	for (ch_number = 0; ch_number < XPC_NCHANNELS; ch_number++) {
-		sema_init(&xpc_registrations[ch_number].sema, 1);  /* mutex */
+		init_sema(&xpc_registrations[ch_number].sema, 1);  /* mutex */
 	}
 
 	return 0;
--- linux-2.6.13-rc6-git9-orig/arch/ia64/sn/kernel/xpc_channel.c	2005-08-17 21:51:27.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/ia64/sn/kernel/xpc_channel.c	2005-08-18 00:46:40.000000000 +0200
@@ -56,7 +56,7 @@ xpc_initialize_channels(struct xpc_parti
 		atomic_set(&ch->n_to_notify, 0);
 
 		spin_lock_init(&ch->lock);
-		sema_init(&ch->msg_to_pull_sema, 1);	/* mutex */
+		init_sema(&ch->msg_to_pull_sema, 1);	/* mutex */
 
 		atomic_set(&ch->n_on_msg_allocate_wq, 0);
 		init_waitqueue_head(&ch->msg_allocate_wq);
@@ -552,10 +552,10 @@ xpc_allocate_msgqueues(struct xpc_channe
 
 	for (i = 0; i < ch->local_nentries; i++) {
 		/* use a semaphore as an event wait queue */
-		sema_init(&ch->notify_queue[i].sema, 0);
+		init_sema(&ch->notify_queue[i].sema, 0);
 	}
 
-	sema_init(&ch->teardown_sema, 0);	/* event wait */
+	init_sema(&ch->teardown_sema, 0);	/* event wait */
 
 	spin_lock_irqsave(&ch->lock, irq_flags);
 	ch->flags |= XPC_C_SETUP;
--- linux-2.6.13-rc6-git9-orig/arch/sh/mm/cache-sh4.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/arch/sh/mm/cache-sh4.c	2005-08-18 00:46:40.000000000 +0200
@@ -42,10 +42,10 @@ void __init p3_cache_init(void)
 	if (remap_area_pages(P3SEG, 0, PAGE_SIZE*4, _PAGE_CACHABLE))
 		panic("%s failed.", __FUNCTION__);
 
-	sema_init (&p3map_sem[0], 1);
-	sema_init (&p3map_sem[1], 1);
-	sema_init (&p3map_sem[2], 1);
-	sema_init (&p3map_sem[3], 1);
+	init_sema (&p3map_sem[0], 1);
+	init_sema (&p3map_sem[1], 1);
+	init_sema (&p3map_sem[2], 1);
+	init_sema (&p3map_sem[3], 1);
 }
 
 /*
--- linux-2.6.13-rc6-git9-orig/drivers/acpi/osl.c	2005-08-17 21:53:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/acpi/osl.c	2005-08-18 00:46:40.000000000 +0200
@@ -845,7 +845,7 @@ acpi_os_create_semaphore(
 		return_ACPI_STATUS (AE_NO_MEMORY);
 	memset(sem, 0, sizeof(struct semaphore));
 
-	sema_init(sem, initial_units);
+	init_sema(sem, initial_units);
 
 	*handle = (acpi_handle*)sem;
 
--- linux-2.6.13-rc6-git9-orig/drivers/block/aoe/aoechr.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/block/aoe/aoechr.c	2005-08-18 00:46:40.000000000 +0200
@@ -216,7 +216,7 @@ aoechr_init(void)
 		printk(KERN_ERR "aoe: aoechr_init: can't register char device\n");
 		return n;
 	}
-	sema_init(&emsgs_sema, 0);
+	init_sema(&emsgs_sema, 0);
 	spin_lock_init(&emsgs_lock);
 	aoe_class = class_create(THIS_MODULE, "aoe");
 	if (IS_ERR(aoe_class)) {
--- linux-2.6.13-rc6-git9-orig/drivers/char/agp/frontend.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/agp/frontend.c	2005-08-18 00:46:40.000000000 +0200
@@ -1088,7 +1088,7 @@ static struct miscdevice agp_miscdev =
 int agp_frontend_initialize(void)
 {
 	memset(&agp_fe, 0, sizeof(struct agp_front_data));
-	sema_init(&(agp_fe.agp_mutex), 1);
+	init_sema(&(agp_fe.agp_mutex), 1);
 
 	if (misc_register(&agp_miscdev)) {
 		printk(KERN_ERR PFX "unable to get minor: %d\n", AGPGART_MINOR);
--- linux-2.6.13-rc6-git9-orig/drivers/char/drm/drm_stub.c	2005-08-17 21:51:39.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/drm/drm_stub.c	2005-08-18 00:46:40.000000000 +0200
@@ -59,8 +59,8 @@ static int drm_fill_in_dev(drm_device_t 
 
 	spin_lock_init(&dev->count_lock);
 	init_timer( &dev->timer );
-	sema_init( &dev->struct_sem, 1 );
-	sema_init( &dev->ctxlist_sem, 1 );
+	init_sema( &dev->struct_sem, 1 );
+	init_sema( &dev->ctxlist_sem, 1 );
 
 	dev->pdev   = pdev;
 
--- linux-2.6.13-rc6-git9-orig/drivers/char/ipmi/ipmi_devintf.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/ipmi/ipmi_devintf.c	2005-08-18 00:46:40.000000000 +0200
@@ -143,7 +143,7 @@ static int ipmi_open(struct inode *inode
 	INIT_LIST_HEAD(&(priv->recv_msgs));
 	init_waitqueue_head(&priv->wait);
 	priv->fasync_queue = NULL;
-	sema_init(&(priv->recv_sem), 1);
+	init_sema(&(priv->recv_sem), 1);
 
 	/* Use the low-level defaults. */
 	priv->default_retries = -1;
--- linux-2.6.13-rc6-git9-orig/drivers/char/rocket.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/rocket.c	2005-08-18 00:46:40.000000000 +0200
@@ -720,7 +720,7 @@ static void init_r_port(int board, int a
 		}
 	}
 	spin_lock_init(&info->slock);
-	sema_init(&info->write_sem, 1);
+	init_sema(&info->write_sem, 1);
 	rp_table[line] = info;
 	if (pci_dev)
 		tty_register_device(rocket_driver, line, &pci_dev->dev);
--- linux-2.6.13-rc6-git9-orig/drivers/char/snsc.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/snsc.c	2005-08-18 00:46:40.000000000 +0200
@@ -99,8 +99,8 @@ scdrv_open(struct inode *inode, struct f
 	spin_lock_init(&sd->sd_wlock);
 	init_waitqueue_head(&sd->sd_rq);
 	init_waitqueue_head(&sd->sd_wq);
-	sema_init(&sd->sd_rbs, 1);
-	sema_init(&sd->sd_wbs, 1);
+	init_sema(&sd->sd_rbs, 1);
+	init_sema(&sd->sd_wbs, 1);
 
 	file->private_data = sd;
 
--- linux-2.6.13-rc6-git9-orig/drivers/char/tty_io.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/tty_io.c	2005-08-18 00:46:40.000000000 +0200
@@ -2650,8 +2650,8 @@ static void initialize_tty_struct(struct
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
-	sema_init(&tty->atomic_read, 1);
-	sema_init(&tty->atomic_write, 1);
+	init_sema(&tty->atomic_read, 1);
+	init_sema(&tty->atomic_write, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 	INIT_WORK(&tty->SAK_work, NULL, NULL);
--- linux-2.6.13-rc6-git9-orig/drivers/char/viotape.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/viotape.c	2005-08-18 00:46:40.000000000 +0200
@@ -1015,7 +1015,7 @@ int __init viotap_init(void)
 	}
 	spin_lock_init(&op_struct_list_lock);
 
-	sema_init(&reqSem, VIOTAPE_MAXREQ);
+	init_sema(&reqSem, VIOTAPE_MAXREQ);
 
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		vio_set_hostlp();
--- linux-2.6.13-rc6-git9-orig/drivers/char/watchdog/sc1200wdt.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/watchdog/sc1200wdt.c	2005-08-18 00:46:40.000000000 +0200
@@ -380,7 +380,7 @@ static int __init sc1200wdt_init(void)
 	printk(banner);
 
 	spin_lock_init(&sc1200wdt_lock);
-	sema_init(&open_sem, 1);
+	init_sema(&open_sem, 1);
 
 #if defined CONFIG_PNP
 	if (isapnp) {
--- linux-2.6.13-rc6-git9-orig/drivers/char/watchdog/scx200_wdt.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/watchdog/scx200_wdt.c	2005-08-18 00:46:40.000000000 +0200
@@ -230,7 +230,7 @@ static int __init scx200_wdt_init(void)
 	scx200_wdt_update_margin();
 	scx200_wdt_disable();
 
-	sema_init(&open_semaphore, 1);
+	init_sema(&open_semaphore, 1);
 
 	r = misc_register(&scx200_wdt_miscdev);
 	if (r) {
--- linux-2.6.13-rc6-git9-orig/drivers/char/watchdog/wdt_pci.c	2005-08-17 21:51:40.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/char/watchdog/wdt_pci.c	2005-08-18 00:46:40.000000000 +0200
@@ -607,7 +607,7 @@ static int __devinit wdtpci_init_one (st
 		goto out_pci;
 	}
 
-	sema_init(&open_sem, 1);
+	init_sema(&open_sem, 1);
 	spin_lock_init(&wdtpci_lock);
 
 	irq = dev->irq;
--- linux-2.6.13-rc6-git9-orig/drivers/ide/ide.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/ide/ide.c	2005-08-18 00:46:40.000000000 +0200
@@ -222,7 +222,7 @@ static void init_hwif_data(ide_hwif_t *h
 	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
 	hwif->swdma_mask = 0x80;	/* disable all swdma */
 
-	sema_init(&hwif->gendev_rel_sem, 0);
+	init_sema(&hwif->gendev_rel_sem, 0);
 
 	default_hwif_iops(hwif);
 	default_hwif_transport(hwif);
@@ -245,7 +245,7 @@ static void init_hwif_data(ide_hwif_t *h
 		drive->is_flash			= 0;
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
-		sema_init(&drive->gendev_rel_sem, 0);
+		init_sema(&drive->gendev_rel_sem, 0);
 	}
 }
 
--- linux-2.6.13-rc6-git9-orig/drivers/ieee1394/ieee1394_types.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/ieee1394/ieee1394_types.h	2005-08-18 00:46:40.000000000 +0200
@@ -28,7 +28,7 @@ do {						\
 	spin_lock_init(&(_tp)->lock);		\
 	(_tp)->next = 0;			\
 	(_tp)->allocations = 0;			\
-	sema_init(&(_tp)->count, 63);		\
+	init_sema(&(_tp)->count, 63);		\
 } while (0)
 
 
--- linux-2.6.13-rc6-git9-orig/drivers/ieee1394/nodemgr.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/ieee1394/nodemgr.c	2005-08-18 00:46:40.000000000 +0200
@@ -1649,7 +1649,7 @@ static void nodemgr_add_host(struct hpsb
 
 	hi->host = host;
 	init_completion(&hi->exited);
-        sema_init(&hi->reset_sem, 0);
+        init_sema(&hi->reset_sem, 0);
 
 	sprintf(hi->daemon_name, "knodemgrd_%d", host->id);
 
--- linux-2.6.13-rc6-git9-orig/drivers/ieee1394/raw1394.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/ieee1394/raw1394.c	2005-08-18 00:46:40.000000000 +0200
@@ -2686,7 +2686,7 @@ static int raw1394_open(struct inode *in
 	fi->state = opened;
 	INIT_LIST_HEAD(&fi->req_pending);
 	INIT_LIST_HEAD(&fi->req_complete);
-	sema_init(&fi->complete_sem, 0);
+	init_sema(&fi->complete_sem, 0);
 	spin_lock_init(&fi->reqlists_lock);
 	init_waitqueue_head(&fi->poll_wait_complete);
 	INIT_LIST_HEAD(&fi->addr_list);
--- linux-2.6.13-rc6-git9-orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-08-17 21:51:41.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-08-18 00:46:40.000000000 +0200
@@ -433,8 +433,8 @@ static int mthca_cmd_imm(struct mthca_de
 
 int mthca_cmd_init(struct mthca_dev *dev)
 {
-	sema_init(&dev->cmd.hcr_sem, 1);
-	sema_init(&dev->cmd.poll_sem, 1);
+	init_sema(&dev->cmd.hcr_sem, 1);
+	init_sema(&dev->cmd.poll_sem, 1);
 	dev->cmd.use_events = 0;
 
 	dev->hcr = ioremap(pci_resource_start(dev->pdev, 0) + MTHCA_HCR_BASE,
@@ -487,7 +487,7 @@ int mthca_cmd_use_events(struct mthca_de
 	dev->cmd.context[dev->cmd.max_cmds - 1].next = -1;
 	dev->cmd.free_head = 0;
 
-	sema_init(&dev->cmd.event_sem, dev->cmd.max_cmds);
+	init_sema(&dev->cmd.event_sem, dev->cmd.max_cmds);
 	spin_lock_init(&dev->cmd.context_lock);
 
 	for (dev->cmd.token_mask = 1;
--- linux-2.6.13-rc6-git9-orig/drivers/md/dm-raid1.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/md/dm-raid1.c	2005-08-18 00:46:40.000000000 +0200
@@ -168,7 +168,7 @@ static int rh_init(struct region_hash *r
 		INIT_LIST_HEAD(rh->buckets + i);
 
 	spin_lock_init(&rh->region_lock);
-	sema_init(&rh->recovery_count, 0);
+	init_sema(&rh->recovery_count, 0);
 	INIT_LIST_HEAD(&rh->clean_regions);
 	INIT_LIST_HEAD(&rh->quiesced_regions);
 	INIT_LIST_HEAD(&rh->recovered_regions);
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-08-18 00:46:40.000000000 +0200
@@ -182,7 +182,7 @@ int flexcop_i2c_init(struct flexcop_devi
 {
 	int ret;
 
-	sema_init(&fc->i2c_sem,1);
+	init_sema(&fc->i2c_sem,1);
 
 	memset(&fc->i2c_adap, 0, sizeof(struct i2c_adapter));
 	strncpy(fc->i2c_adap.name, "B2C2 FlexCop device",I2C_NAME_SIZE);
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/dvb-core/dmxdev.c	2005-08-18 00:46:40.000000000 +0200
@@ -701,7 +701,7 @@ static int dvb_demux_open(struct inode *
 	}
 
 	dmxdevfilter=&dmxdev->filter[i];
-	sema_init(&dmxdevfilter->mutex, 1);
+	init_sema(&dmxdevfilter->mutex, 1);
 	dmxdevfilter->dvbdev=dmxdev->dvbdev;
 	file->private_data=dmxdevfilter;
 
@@ -1097,7 +1097,7 @@ dvb_dmxdev_init(struct dmxdev *dmxdev, s
 		return -ENOMEM;
 	}
 
-	sema_init(&dmxdev->mutex, 1);
+	init_sema(&dmxdev->mutex, 1);
 	spin_lock_init(&dmxdev->lock);
 	for (i=0; i<dmxdev->filternum; i++) {
 		dmxdev->filter[i].dev=dmxdev;
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/dvb-core/dvb_demux.c	2005-08-18 00:46:40.000000000 +0200
@@ -1271,7 +1271,7 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 	dmx->disconnect_frontend = dvbdmx_disconnect_frontend;
 	dmx->get_pes_pids = dvbdmx_get_pes_pids;
 
-	sema_init(&dvbdemux->mutex, 1);
+	init_sema(&dvbdemux->mutex, 1);
 	spin_lock_init(&dvbdemux->lock);
 
 	if ((err = dmx_register_demux(dmx)) < 0)
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-08-18 00:46:40.000000000 +0200
@@ -42,8 +42,8 @@ static int dvb_usb_init(struct dvb_usb_d
 {
 	int ret = 0;
 
-	sema_init(&d->usb_sem, 1);
-	sema_init(&d->i2c_sem, 1);
+	init_sema(&d->usb_sem, 1);
+	init_sema(&d->i2c_sem, 1);
 
 	d->state = DVB_USB_STATE_INIT;
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/frontends/bcm3510.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/frontends/bcm3510.c	2005-08-18 00:46:40.000000000 +0200
@@ -794,7 +794,7 @@ struct dvb_frontend* bcm3510_attach(cons
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 
-	sema_init(&state->hab_sem, 1);
+	init_sema(&state->hab_sem, 1);
 
 	if ((ret = bcm3510_readB(state,0xe0,&v)) < 0)
 		goto error;
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/ttpci/av7110.c	2005-08-17 21:51:42.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/ttpci/av7110.c	2005-08-18 00:46:40.000000000 +0200
@@ -2615,16 +2615,16 @@ static int av7110_attach(struct saa7146_
 	tasklet_init (&av7110->debi_tasklet, debiirq, (unsigned long) av7110);
 	tasklet_init (&av7110->gpio_tasklet, gpioirq, (unsigned long) av7110);
 
-	sema_init(&av7110->pid_mutex, 1);
+	init_sema(&av7110->pid_mutex, 1);
 
 	/* locks for data transfers from/to AV7110 */
 	spin_lock_init(&av7110->debilock);
-	sema_init(&av7110->dcomlock, 1);
+	init_sema(&av7110->dcomlock, 1);
 	av7110->debitype = -1;
 
 	/* default OSD window */
 	av7110->osdwin = 1;
-	sema_init(&av7110->osd_sema, 1);
+	init_sema(&av7110->osd_sema, 1);
 
 	/* ARM "watchdog" */
 	init_waitqueue_head(&av7110->arm_wait);
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-08-18 00:46:40.000000000 +0200
@@ -1498,8 +1498,8 @@ static int ttusb_probe(struct usb_interf
 	ttusb->dev = udev;
 	ttusb->c = 0;
 	ttusb->mux_state = 0;
-	sema_init(&ttusb->semi2c, 0);
-	sema_init(&ttusb->semusb, 1);
+	init_sema(&ttusb->semi2c, 0);
+	init_sema(&ttusb->semusb, 1);
 
 	ttusb_setup_interfaces(ttusb);
 
--- linux-2.6.13-rc6-git9-orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-08-18 00:46:40.000000000 +0200
@@ -1221,8 +1221,8 @@ static int ttusb_dec_init_usb(struct ttu
 {
 	dprintk("%s\n", __FUNCTION__);
 
-	sema_init(&dec->usb_sem, 1);
-	sema_init(&dec->iso_sem, 1);
+	init_sema(&dec->usb_sem, 1);
+	init_sema(&dec->iso_sem, 1);
 
 	dec->command_pipe = usb_sndbulkpipe(dec->udev, COMMAND_PIPE);
 	dec->result_pipe = usb_rcvbulkpipe(dec->udev, RESULT_PIPE);
--- linux-2.6.13-rc6-git9-orig/drivers/message/fusion/mptctl.c	2005-08-17 21:51:46.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/message/fusion/mptctl.c	2005-08-18 00:46:40.000000000 +0200
@@ -2746,7 +2746,7 @@ mptctl_probe(struct pci_dev *pdev, const
 	memset(mem, 0, sz);
 	ioc->ioctl = (MPT_IOCTL *) mem;
 	ioc->ioctl->ioc = ioc;
-	sema_init(&ioc->ioctl->sem_ioc, 1);
+	init_sema(&ioc->ioctl->sem_ioc, 1);
 	return 0;
 
 out_fail:
--- linux-2.6.13-rc6-git9-orig/drivers/net/wireless/airo.c	2005-08-17 21:51:48.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/wireless/airo.c	2005-08-18 00:46:40.000000000 +0200
@@ -2724,7 +2724,7 @@ struct net_device *_init_airo_card( unsi
 	}
         ai->dev = dev;
 	spin_lock_init(&ai->aux_lock);
-	sema_init(&ai->sem, 1);
+	init_sema(&ai->sem, 1);
 	ai->config.len = 0;
 	ai->pci = pci;
 	init_waitqueue_head (&ai->thr_wait);
--- linux-2.6.13-rc6-git9-orig/drivers/net/wireless/prism54/isl_ioctl.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/wireless/prism54/isl_ioctl.c	2005-08-18 00:46:40.000000000 +0200
@@ -1259,7 +1259,7 @@ prism54_set_raw(struct net_device *ndev,
 void
 prism54_acl_init(struct islpci_acl *acl)
 {
-	sema_init(&acl->sem, 1);
+	init_sema(&acl->sem, 1);
 	INIT_LIST_HEAD(&acl->mac_list);
 	acl->size = 0;
 	acl->policy = MAC_POLICY_OPEN;
@@ -1690,7 +1690,7 @@ void
 prism54_wpa_ie_init(islpci_private *priv)
 {
 	INIT_LIST_HEAD(&priv->bss_wpa_list);
-	sema_init(&priv->wpa_sem, 1);
+	init_sema(&priv->wpa_sem, 1);
 }
 
 void
--- linux-2.6.13-rc6-git9-orig/drivers/net/wireless/prism54/islpci_dev.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/net/wireless/prism54/islpci_dev.c	2005-08-18 00:46:40.000000000 +0200
@@ -857,10 +857,10 @@ islpci_setup(struct pci_dev *pdev)
 	init_waitqueue_head(&priv->reset_done);
 
 	/* init the queue read locks, process wait counter */
-	sema_init(&priv->mgmt_sem, 1);
+	init_sema(&priv->mgmt_sem, 1);
 	priv->mgmt_received = NULL;
 	init_waitqueue_head(&priv->mgmt_wqueue);
-	sema_init(&priv->stats_sem, 1);
+	init_sema(&priv->stats_sem, 1);
 	spin_lock_init(&priv->slock);
 
 	/* init state machine with off#1 state */
--- linux-2.6.13-rc6-git9-orig/drivers/parport/ChangeLog	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/parport/ChangeLog	2005-08-18 00:46:40.000000000 +0200
@@ -321,7 +321,7 @@
 2001-03-02  Tim Waugh  <twaugh@redhat.com>
 
 	* ieee1284_ops.c (parport_ieee1284_write_compat): Don't use
-	down_trylock to reset the IRQ count.  Don't even use sema_init,
+	down_trylock to reset the IRQ count.  Don't even use init_sema,
 	because it's not even necessary to reset the count.  I can't
 	remember why we ever did.
 
--- linux-2.6.13-rc6-git9-orig/drivers/s390/char/sclp_cpi.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/char/sclp_cpi.c	2005-08-18 00:46:40.000000000 +0200
@@ -215,7 +215,7 @@ cpi_module_init(void)
 	}
 
 	/* Prepare semaphore */
-	sema_init(&sem, 0);
+	init_sema(&sem, 0);
 	req->callback_data = &sem;
 	/* Add request to sclp queue */
 	rc = sclp_add_request(req);
--- linux-2.6.13-rc6-git9-orig/drivers/s390/scsi/zfcp_aux.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/scsi/zfcp_aux.c	2005-08-18 00:46:40.000000000 +0200
@@ -322,7 +322,7 @@ zfcp_module_init(void)
 		       ZFCP_CFDC_DEV_MAJOR, zfcp_cfdc_misc.minor);
 
 	/* Initialise proc semaphores */
-	sema_init(&zfcp_data.config_sema, 1);
+	init_sema(&zfcp_data.config_sema, 1);
 
 	/* initialise configuration rw lock */
 	rwlock_init(&zfcp_data.config_lock);
--- linux-2.6.13-rc6-git9-orig/drivers/s390/scsi/zfcp_erp.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/scsi/zfcp_erp.c	2005-08-18 00:46:40.000000000 +0200
@@ -1073,7 +1073,7 @@ zfcp_erp_thread_setup(struct zfcp_adapte
 	rwlock_init(&adapter->erp_lock);
 	INIT_LIST_HEAD(&adapter->erp_ready_head);
 	INIT_LIST_HEAD(&adapter->erp_running_head);
-	sema_init(&adapter->erp_ready_sem, 0);
+	init_sema(&adapter->erp_ready_sem, 0);
 
 	retval = kernel_thread(zfcp_erp_thread, adapter, SIGCHLD);
 	if (retval < 0) {
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/megaraid/megaraid_mbox.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/megaraid/megaraid_mbox.c	2005-08-18 00:46:40.000000000 +0200
@@ -3919,7 +3919,7 @@ megaraid_sysfs_alloc_resources(adapter_t
 		megaraid_sysfs_free_resources(adapter);
 	}
 
-	sema_init(&raid_dev->sysfs_sem, 1);
+	init_sema(&raid_dev->sysfs_sem, 1);
 
 	init_waitqueue_head(&raid_dev->sysfs_wait_q);
 
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/megaraid/megaraid_mm.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/megaraid/megaraid_mm.c	2005-08-18 00:46:40.000000000 +0200
@@ -944,7 +944,7 @@ mraid_mm_register_adp(mraid_mmadp_t *lld
 	 */
 	INIT_LIST_HEAD(&adapter->kioc_pool);
 	spin_lock_init(&adapter->kioc_pool_lock);
-	sema_init(&adapter->kioc_semaphore, lld_adp->max_kioc);
+	init_sema(&adapter->kioc_semaphore, lld_adp->max_kioc);
 
 	mbox_list	= (mbox64_t *)adapter->mbox_list;
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/gadget/serial.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/gadget/serial.c	2005-08-18 00:46:40.000000000 +0200
@@ -674,7 +674,7 @@ static int __init gs_module_init(void)
 	tty_set_operations(gs_tty_driver, &gs_tty_ops);
 
 	for (i=0; i < GS_NUM_PORTS; i++)
-		sema_init(&gs_open_close_sem[i], 1);
+		init_sema(&gs_open_close_sem[i], 1);
 
 	retval = tty_register_driver(gs_tty_driver);
 	if (retval) {
--- linux-2.6.13-rc6-git9-orig/drivers/usb/serial/io_ti.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/serial/io_ti.c	2005-08-18 00:46:41.000000000 +0200
@@ -2739,7 +2739,7 @@ static int edge_startup (struct usb_seri
 		return -ENOMEM;
 	}
 	memset (edge_serial, 0, sizeof(struct edgeport_serial));
-	sema_init(&edge_serial->es_sem, 1);
+	init_sema(&edge_serial->es_sem, 1);
 	edge_serial->serial = serial;
 	usb_set_serial_data(serial, edge_serial);
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/serial/ti_usb_3410_5052.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/serial/ti_usb_3410_5052.c	2005-08-18 00:46:41.000000000 +0200
@@ -419,7 +419,7 @@ static int ti_startup(struct usb_serial 
 		return -ENOMEM;
 	}
 	memset(tdev, 0, sizeof(struct ti_device));
-	sema_init(&tdev->td_open_close_sem, 1);
+	init_sema(&tdev->td_open_close_sem, 1);
 	tdev->td_serial = serial;
 	usb_set_serial_data(serial, tdev);
 
--- linux-2.6.13-rc6-git9-orig/fs/block_dev.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/block_dev.c	2005-08-18 00:46:41.000000000 +0200
@@ -265,8 +265,8 @@ static void init_once(void * foo, kmem_c
 	    SLAB_CTOR_CONSTRUCTOR)
 	{
 		memset(bdev, 0, sizeof(*bdev));
-		sema_init(&bdev->bd_sem, 1);
-		sema_init(&bdev->bd_mount_sem, 1);
+		init_sema(&bdev->bd_sem, 1);
+		init_sema(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
--- linux-2.6.13-rc6-git9-orig/fs/dquot.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/dquot.c	2005-08-18 00:46:41.000000000 +0200
@@ -574,7 +574,7 @@ static struct dquot *get_empty_dquot(str
 		return NODQUOT;
 
 	memset((caddr_t)dquot, 0, sizeof(struct dquot));
-	sema_init(&dquot->dq_lock, 1);
+	init_sema(&dquot->dq_lock, 1);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_HLIST_NODE(&dquot->dq_hash);
--- linux-2.6.13-rc6-git9-orig/fs/inode.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/inode.c	2005-08-18 00:46:41.000000000 +0200
@@ -192,7 +192,7 @@ void inode_init_once(struct inode *inode
 	INIT_HLIST_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_devices);
-	sema_init(&inode->i_sem, 1);
+	init_sema(&inode->i_sem, 1);
 	init_rwsem(&inode->i_alloc_sem);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.tree_lock);
@@ -205,7 +205,7 @@ void inode_init_once(struct inode *inode
 	i_size_ordered_init(inode);
 #ifdef CONFIG_INOTIFY
 	INIT_LIST_HEAD(&inode->inotify_watches);
-	sema_init(&inode->inotify_sem, 1);
+	init_sema(&inode->inotify_sem, 1);
 #endif
 }
 
--- linux-2.6.13-rc6-git9-orig/fs/inotify.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/inotify.c	2005-08-18 00:46:41.000000000 +0200
@@ -896,7 +896,7 @@ asmlinkage long sys_inotify_init(void)
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watches);
 	init_waitqueue_head(&dev->wq);
-	sema_init(&dev->sem, 1);
+	init_sema(&dev->sem, 1);
 	dev->event_count = 0;
 	dev->queue_size = 0;
 	dev->max_events = inotify_max_queued_events;
--- linux-2.6.13-rc6-git9-orig/fs/reiserfs/journal.c	2005-08-17 21:52:02.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/reiserfs/journal.c	2005-08-18 00:46:41.000000000 +0200
@@ -2473,7 +2473,7 @@ static struct reiserfs_journal_list *all
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
 	INIT_LIST_HEAD(&jl->j_bh_list);
-	sema_init(&jl->j_commit_lock, 1);
+	init_sema(&jl->j_commit_lock, 1);
 	SB_JOURNAL(s)->j_num_lists++;
 	get_journal_list(jl);
 	return jl;
@@ -2744,8 +2744,8 @@ int journal_init(struct super_block *p_s
 	journal->j_last = NULL;
 	journal->j_first = NULL;
 	init_waitqueue_head(&(journal->j_join_wait));
-	sema_init(&journal->j_lock, 1);
-	sema_init(&journal->j_flush_sem, 1);
+	init_sema(&journal->j_lock, 1);
+	init_sema(&journal->j_flush_sem, 1);
 
 	journal->j_trans_id = 10;
 	journal->j_mount_id = 10;
--- linux-2.6.13-rc6-git9-orig/fs/seq_file.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/seq_file.c	2005-08-18 00:46:41.000000000 +0200
@@ -32,7 +32,7 @@ int seq_open(struct file *file, struct s
 	if (!p)
 		return -ENOMEM;
 	memset(p, 0, sizeof(*p));
-	sema_init(&p->sem, 1);
+	init_sema(&p->sem, 1);
 	p->op = op;
 	file->private_data = p;
 
--- linux-2.6.13-rc6-git9-orig/fs/super.c	2005-08-17 21:52:02.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/super.c	2005-08-18 00:46:41.000000000 +0200
@@ -72,13 +72,13 @@ static struct super_block *alloc_super(v
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
-		sema_init(&s->s_lock, 1);
+		init_sema(&s->s_lock, 1);
 		down_write(&s->s_umount);
 		s->s_count = S_BIAS;
 		atomic_set(&s->s_active, 1);
-		sema_init(&s->s_vfs_rename_sem,1);
-		sema_init(&s->s_dquot.dqio_sem, 1);
-		sema_init(&s->s_dquot.dqonoff_sem, 1);
+		init_sema(&s->s_vfs_rename_sem,1);
+		init_sema(&s->s_dquot.dqio_sem, 1);
+		init_sema(&s->s_dquot.dqonoff_sem, 1);
 		init_rwsem(&s->s_dquot.dqptr_sem);
 		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
--- linux-2.6.13-rc6-git9-orig/fs/xfs/linux-2.6/mutex.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/mutex.h	2005-08-18 00:46:41.000000000 +0200
@@ -44,8 +44,8 @@
 #define MUTEX_DEFAULT		0x0
 typedef struct semaphore	mutex_t;
 
-#define mutex_init(lock, type, name)		sema_init(lock, 1)
-#define mutex_destroy(lock)			sema_init(lock, -99)
+#define mutex_init(lock, type, name)		init_sema(lock, 1)
+#define mutex_destroy(lock)			init_sema(lock, -99)
 #define mutex_lock(lock, num)			down(lock)
 #define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
 #define mutex_unlock(lock)			up(lock)
--- linux-2.6.13-rc6-git9-orig/fs/xfs/linux-2.6/sema.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/sema.h	2005-08-18 00:46:41.000000000 +0200
@@ -43,9 +43,9 @@
 
 typedef struct semaphore sema_t;
 
-#define init_sema(sp, val, c, d)	sema_init(sp, val)
-#define initsema(sp, val)		sema_init(sp, val)
-#define initnsema(sp, val, name)	sema_init(sp, val)
+#define init_sema(sp, val, c, d)	init_sema(sp, val)
+#define initsema(sp, val)		init_sema(sp, val)
+#define initnsema(sp, val, name)	init_sema(sp, val)
 #define psema(sp, b)			down(sp)
 #define vsema(sp)			up(sp)
 #define valusema(sp)			(atomic_read(&(sp)->count))
--- linux-2.6.13-rc6-git9-orig/ipc/util.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/ipc/util.c	2005-08-18 00:46:41.000000000 +0200
@@ -58,7 +58,7 @@ __initcall(ipc_init);
 void __init ipc_init_ids(struct ipc_ids* ids, int size)
 {
 	int i;
-	sema_init(&ids->sem,1);
+	init_sema(&ids->sem,1);
 
 	if(size > IPCMNI)
 		size = IPCMNI;
--- linux-2.6.13-rc6-git9-orig/net/sunrpc/svcsock.c	2005-08-17 21:53:55.000000000 +0200
+++ linux-2.6.13-rc6-git9/net/sunrpc/svcsock.c	2005-08-18 00:46:41.000000000 +0200
@@ -1359,7 +1359,7 @@ svc_setup_socket(struct svc_serv *serv, 
 	svsk->sk_lastrecv = get_seconds();
 	INIT_LIST_HEAD(&svsk->sk_deferred);
 	INIT_LIST_HEAD(&svsk->sk_ready);
-	sema_init(&svsk->sk_sem, 1);
+	init_sema(&svsk->sk_sem, 1);
 
 	/* Initialize the socket */
 	if (sock->type == SOCK_DGRAM)


