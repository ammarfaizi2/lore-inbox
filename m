Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbVHRAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbVHRAPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVHRAPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:15:12 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:27249 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751390AbVHRAOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QtnXKZgI4dbf+s7yvOnlvKA+aYwsrC3MrPFPtQ46W4iZIyO1IJBVThpsCP/FIG0CIxhIjWhkVthV50c6pjk9mQwUV6nWIyzG4b4naVQJ+AN5yu0Hd95MonSWe/a1ZTL1hxV/8l0269nH7vqtw6447gPBexTf/T8oBhVlnWD1eKk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] rename locking functions - convert init_MUTEX* users, part 3
Date: Thu, 18 Aug 2005 02:10:28 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180210.29126.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert users of init_MUTEX and init_MUTEX_LOCKED to
init_mutex and init_mutex_locked - part 3.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/s390/net/ctctty.c           |    2 +-
 drivers/s390/s390mach.c             |    2 +-
 drivers/sbus/char/vfc_dev.c         |    2 +-
 drivers/scsi/3w-9xxx.c              |    2 +-
 drivers/scsi/3w-xxxx.c              |    2 +-
 drivers/scsi/aacraid/commctrl.c     |    2 +-
 drivers/scsi/aacraid/commsup.c      |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c  |    6 +++---
 drivers/scsi/aic7xxx/aic7xxx_osm.c  |    2 +-
 drivers/scsi/ch.c                   |    2 +-
 drivers/scsi/hosts.c                |    2 +-
 drivers/scsi/megaraid.c             |    2 +-
 drivers/scsi/osst.c                 |    2 +-
 drivers/scsi/qla2xxx/qla_os.c       |    4 ++--
 drivers/scsi/scsi_transport_spi.c   |    2 +-
 drivers/scsi/st.c                   |    2 +-
 drivers/serial/serial_core.c        |    2 +-
 drivers/usb/atm/cxacru.c            |    2 +-
 drivers/usb/atm/usbatm.c            |    2 +-
 drivers/usb/class/bluetty.c         |    2 +-
 drivers/usb/class/usblp.c           |    2 +-
 drivers/usb/core/usb.c              |    2 +-
 drivers/usb/gadget/inode.c          |    2 +-
 drivers/usb/image/mdc800.c          |    2 +-
 drivers/usb/image/microtek.c        |    2 +-
 drivers/usb/media/dabusb.c          |    2 +-
 drivers/usb/media/ov511.c           |   10 +++++-----
 drivers/usb/media/pwc/pwc-if.c      |    2 +-
 drivers/usb/media/se401.c           |    2 +-
 drivers/usb/media/sn9c102_core.c    |    4 ++--
 drivers/usb/media/stv680.c          |    2 +-
 drivers/usb/media/usbvideo.c        |    4 ++--
 drivers/usb/media/vicam.c           |    2 +-
 drivers/usb/media/w9968cf.c         |    4 ++--
 drivers/usb/misc/auerswald.c        |    6 +++---
 drivers/usb/misc/idmouse.c          |    2 +-
 drivers/usb/misc/ldusb.c            |    2 +-
 drivers/usb/misc/legousbtower.c     |    2 +-
 drivers/usb/misc/rio500.c           |    2 +-
 drivers/usb/misc/sisusbvga/sisusb.c |    2 +-
 drivers/usb/misc/usbtest.c          |    2 +-
 drivers/usb/mon/mon_text.c          |    2 +-
 drivers/usb/storage/usb.c           |    4 ++--
 drivers/video/backlight/backlight.c |    2 +-
 drivers/video/backlight/lcd.c       |    2 +-
 drivers/video/pxafb.c               |    2 +-
 drivers/video/sa1100fb.c            |    2 +-
 drivers/w1/w1_int.c                 |    2 +-
 fs/affs/super.c                     |    6 +++---
 fs/autofs4/inode.c                  |    2 +-
 fs/cifs/connect.c                   |    2 +-
 fs/cifs/dir.c                       |    2 +-
 fs/cifs/file.c                      |    2 +-
 fs/cifs/misc.c                      |    4 ++--
 fs/eventpoll.c                      |    2 +-
 fs/ext3/super.c                     |    2 +-
 fs/fat/fatent.c                     |    2 +-
 fs/hfs/btree.c                      |    4 ++--
 fs/hfs/inode.c                      |    4 ++--
 fs/hfs/super.c                      |    2 +-
 fs/hfsplus/btree.c                  |    2 +-
 fs/hfsplus/inode.c                  |    4 ++--
 fs/hfsplus/super.c                  |    2 +-
 fs/hpfs/super.c                     |    6 +++---
 fs/isofs/compress.c                 |    2 +-
 fs/jbd/journal.c                    |    4 ++--
 fs/jffs/jffs_fm.c                   |    2 +-
 fs/jffs2/readinode.c                |    2 +-
 fs/jffs2/super.c                    |    6 +++---
 fs/jfs/jfs_dmap.c                   |    2 +-
 fs/jfs/jfs_imap.c                   |    4 ++--
 fs/jfs/jfs_logmgr.c                 |    2 +-
 fs/jfs/super.c                      |    2 +-
 fs/libfs.c                          |    2 +-
 fs/lockd/host.c                     |    2 +-
 fs/lockd/svcsubs.c                  |    2 +-
 fs/ncpfs/inode.c                    |    6 +++---
 fs/nfs/idmap.c                      |    4 ++--
 fs/nfs/nfs4state.c                  |    4 ++--
 fs/ntfs/inode.c                     |    4 ++--
 fs/smbfs/inode.c                    |    2 +-
 fs/sysfs/file.c                     |    2 +-
 fs/udf/super.c                      |    2 +-
 83 files changed, 113 insertions(+), 113 deletions(-)

--- linux-2.6.13-rc6-git9-orig/drivers/s390/net/ctctty.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/net/ctctty.c	2005-08-18 00:55:12.000000000 +0200
@@ -1171,7 +1171,7 @@ ctc_tty_init(void)
 	driver->ctc_tty_device = device;
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++) {
 		info = &driver->info[i];
-		init_MUTEX(&info->write_sem);
+		init_mutex(&info->write_sem);
 		tasklet_init(&info->tasklet, ctc_tty_task,
 				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
--- linux-2.6.13-rc6-git9-orig/drivers/s390/s390mach.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/s390/s390mach.c	2005-08-18 00:55:12.000000000 +0200
@@ -442,7 +442,7 @@ s390_do_machine_check(struct pt_regs *re
 static int
 machine_check_init(void)
 {
-	init_MUTEX_LOCKED(&m_sem);
+	init_mutex_locked(&m_sem);
 	ctl_clear_bit(14, 25);	/* disable external damage MCH */
 	ctl_set_bit(14, 27);    /* enable system recovery MCH */
 #ifdef CONFIG_MACHCHK_WARNING
--- linux-2.6.13-rc6-git9-orig/drivers/sbus/char/vfc_dev.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/sbus/char/vfc_dev.c	2005-08-18 00:55:12.000000000 +0200
@@ -135,7 +135,7 @@ int init_vfc_hw(struct vfc_dev *dev) 
 int init_vfc_devstruct(struct vfc_dev *dev, int instance) 
 {
 	dev->instance=instance;
-	init_MUTEX(&dev->device_lock_sem);
+	init_mutex(&dev->device_lock_sem);
 	dev->control_reg=0;
 	dev->busy=0;
 	return 0;
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/3w-9xxx.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/3w-9xxx.c	2005-08-18 00:55:12.000000000 +0200
@@ -1156,7 +1156,7 @@ static int twa_initialize_device_extensi
 	tw_dev->error_sequence_id = 1;
 	tw_dev->chrdev_request_id = TW_IOCTL_CHRDEV_FREE;
 
-	init_MUTEX(&tw_dev->ioctl_sem);
+	init_mutex(&tw_dev->ioctl_sem);
 	init_waitqueue_head(&tw_dev->ioctl_wqueue);
 
 	retval = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/3w-xxxx.c	2005-08-17 21:51:53.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/3w-xxxx.c	2005-08-18 00:55:12.000000000 +0200
@@ -1270,7 +1270,7 @@ static int tw_initialize_device_extensio
 	tw_dev->pending_tail = TW_Q_START;
 	tw_dev->chrdev_request_id = TW_IOCTL_CHRDEV_FREE;
 
-	init_MUTEX(&tw_dev->ioctl_sem);
+	init_mutex(&tw_dev->ioctl_sem);
 	init_waitqueue_head(&tw_dev->ioctl_wqueue);
 
 	return 0;
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/aacraid/commctrl.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/aacraid/commctrl.c	2005-08-18 00:55:12.000000000 +0200
@@ -170,7 +170,7 @@ static int open_getadapter_fib(struct aa
 		/*
 		 *	Initialize the mutex used to wait for the next AIF.
 		 */
-		init_MUTEX_LOCKED(&fibctx->wait_sem);
+		init_mutex_locked(&fibctx->wait_sem);
 		fibctx->wait = 0;
 		/*
 		 *	Initialize the fibs and set the count of fibs on
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/aacraid/commsup.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/aacraid/commsup.c	2005-08-18 00:55:12.000000000 +0200
@@ -112,7 +112,7 @@ int fib_setup(struct aac_dev * dev)
 		fibptr->hw_fib = hw_fib_va;
 		fibptr->data = (void *) fibptr->hw_fib->data;
 		fibptr->next = fibptr+1;	/* Forward chain the fibs */
-		init_MUTEX_LOCKED(&fibptr->event_wait);
+		init_mutex_locked(&fibptr->event_wait);
 		spin_lock_init(&fibptr->event_lock);
 		hw_fib_va->header.XferState = cpu_to_le32(0xffffffff);
 		hw_fib_va->header.SenderSize = cpu_to_le16(dev->max_fib_size);
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-18 00:55:12.000000000 +0200
@@ -2172,9 +2172,9 @@ ahd_platform_alloc(struct ahd_softc *ahd
 	ahd->platform_data->completeq_timer.data = (u_long)ahd;
 	ahd->platform_data->completeq_timer.function =
 	    (ahd_linux_callback_t *)ahd_linux_thread_run_complete_queue;
-	init_MUTEX_LOCKED(&ahd->platform_data->eh_sem);
-	init_MUTEX_LOCKED(&ahd->platform_data->dv_sem);
-	init_MUTEX_LOCKED(&ahd->platform_data->dv_cmd_sem);
+	init_mutex_locked(&ahd->platform_data->eh_sem);
+	init_mutex_locked(&ahd->platform_data->dv_sem);
+	init_mutex_locked(&ahd->platform_data->dv_cmd_sem);
 	ahd_setup_runq_tasklet(ahd);
 	ahd->seltime = (aic79xx_seltime & 0x3) << 4;
 	return (0);
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-08-18 00:55:12.000000000 +0200
@@ -1127,7 +1127,7 @@ ahc_platform_alloc(struct ahc_softc *ahc
 	memset(ahc->platform_data, 0, sizeof(struct ahc_platform_data));
 	ahc->platform_data->irq = AHC_LINUX_NOIRQ;
 	ahc_lockinit(ahc);
-	init_MUTEX_LOCKED(&ahc->platform_data->eh_sem);
+	init_mutex_locked(&ahc->platform_data->eh_sem);
 	ahc->seltime = (aic7xxx_seltime & 0x3) << 4;
 	ahc->seltime_b = (aic7xxx_seltime & 0x3) << 4;
 	if (aic7xxx_pci_parity == 0)
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/ch.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/ch.c	2005-08-18 00:55:12.000000000 +0200
@@ -934,7 +934,7 @@ static int ch_probe(struct device *dev)
 	memset(ch,0,sizeof(*ch));
 	ch->minor = ch_devcount;
 	sprintf(ch->name,"ch%d",ch->minor);
-	init_MUTEX(&ch->lock);
+	init_mutex(&ch->lock);
 	ch->device = sd;
 	ch_readconfig(ch);
 	if (init)
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/hosts.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/hosts.c	2005-08-18 00:55:12.000000000 +0200
@@ -232,7 +232,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 	INIT_LIST_HEAD(&shost->starved_list);
 	init_waitqueue_head(&shost->host_wait);
 
-	init_MUTEX(&shost->scan_mutex);
+	init_mutex(&shost->scan_mutex);
 
 	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
 	shost->dma_channel = 0xff;
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/megaraid.c	2005-08-17 21:51:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/megaraid.c	2005-08-18 00:55:12.000000000 +0200
@@ -4842,7 +4842,7 @@ megaraid_probe_one(struct pci_dev *pdev,
 		adapter->has_64bit_addr = 0;
 	}
 		
-	init_MUTEX(&adapter->int_mtx);
+	init_mutex(&adapter->int_mtx);
 	init_completion(&adapter->int_waitq);
 
 	adapter->this_id = DEFAULT_INITIATOR_ID;
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/osst.c	2005-08-17 21:51:55.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/osst.c	2005-08-18 00:55:12.000000000 +0200
@@ -5793,7 +5793,7 @@ static int osst_probe(struct device *dev
 	tpnt->modes[2].defined = 1;
 	tpnt->density_changed = tpnt->compression_changed = tpnt->blksize_changed = 0;
 
-	init_MUTEX(&tpnt->lock);
+	init_mutex(&tpnt->lock);
 	osst_nr_dev++;
 	write_unlock(&os_scsi_tapes_lock);
 	{
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/qla2xxx/qla_os.c	2005-08-17 21:51:55.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/qla2xxx/qla_os.c	2005-08-18 00:55:12.000000000 +0200
@@ -1406,8 +1406,8 @@ int qla2x00_probe_one(struct pci_dev *pd
 	/* load the F/W, read paramaters, and init the H/W */
 	ha->instance = num_hosts;
 
-	init_MUTEX(&ha->mbx_cmd_sem);
-	init_MUTEX_LOCKED(&ha->mbx_intr_sem);
+	init_mutex(&ha->mbx_cmd_sem);
+	init_mutex_locked(&ha->mbx_intr_sem);
 
 	INIT_LIST_HEAD(&ha->list);
 	INIT_LIST_HEAD(&ha->fcports);
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/scsi_transport_spi.c	2005-08-17 21:51:55.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/scsi_transport_spi.c	2005-08-18 00:55:12.000000000 +0200
@@ -233,7 +233,7 @@ static int spi_setup_transport_attrs(str
 	spi_pcomp_en(starget) = 0;
 	spi_dv_pending(starget) = 0;
 	spi_initial_dv(starget) = 0;
-	init_MUTEX(&spi_dv_sem(starget));
+	init_mutex(&spi_dv_sem(starget));
 
 	return 0;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/scsi/st.c	2005-08-17 21:51:55.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/scsi/st.c	2005-08-18 00:55:12.000000000 +0200
@@ -3958,7 +3958,7 @@ static int st_probe(struct device *dev)
 
 	tpnt->density_changed = tpnt->compression_changed =
 	    tpnt->blksize_changed = 0;
-	init_MUTEX(&tpnt->lock);
+	init_mutex(&tpnt->lock);
 
 	st_nr_dev++;
 	write_unlock(&st_dev_arr_lock);
--- linux-2.6.13-rc6-git9-orig/drivers/serial/serial_core.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/serial/serial_core.c	2005-08-18 00:55:12.000000000 +0200
@@ -2135,7 +2135,7 @@ int uart_register_driver(struct uart_dri
 		state->close_delay     = 500;	/* .5 seconds */
 		state->closing_wait    = 30000;	/* 30 seconds */
 
-		init_MUTEX(&state->sem);
+		init_mutex(&state->sem);
 	}
 
 	retval = tty_register_driver(normal);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/atm/cxacru.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/atm/cxacru.c	2005-08-18 00:55:12.000000000 +0200
@@ -723,7 +723,7 @@ static int cxacru_bind(struct usbatm_dat
 			cxacru_blocking_completion, &instance->snd_done, 4);
 	instance->snd_urb->transfer_flags |= URB_ASYNC_UNLINK;
 
-	init_MUTEX(&instance->cm_serialize);
+	init_mutex(&instance->cm_serialize);
 
 	INIT_WORK(&instance->poll_work, (void *)cxacru_poll_status, instance);
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/atm/usbatm.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/atm/usbatm.c	2005-08-18 00:55:12.000000000 +0200
@@ -1005,7 +1005,7 @@ int usbatm_usb_probe(struct usb_interfac
 	/* private fields */
 
 	kref_init(&instance->refcount);		/* dropped in usbatm_usb_disconnect */
-	init_MUTEX(&instance->serialize);
+	init_mutex(&instance->serialize);
 
 	instance->thread_pid = -1;
 	init_completion(&instance->thread_started);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/class/bluetty.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/class/bluetty.c	2005-08-18 00:55:12.000000000 +0200
@@ -1063,7 +1063,7 @@ static int usb_bluetooth_probe (struct u
 	bluetooth->dev = dev;
 	bluetooth->minor = minor;
 	INIT_WORK(&bluetooth->work, bluetooth_softint, bluetooth);
-	init_MUTEX(&bluetooth->lock);
+	init_mutex(&bluetooth->lock);
 
 	/* record the interface number for the control out */
 	bluetooth->control_out_bInterfaceNum = control_out_endpoint;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/class/usblp.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/class/usblp.c	2005-08-18 00:55:12.000000000 +0200
@@ -863,7 +863,7 @@ static int usblp_probe(struct usb_interf
 	}
 	memset(usblp, 0, sizeof(struct usblp));
 	usblp->dev = dev;
-	init_MUTEX (&usblp->sem);
+	init_mutex (&usblp->sem);
 	init_waitqueue_head(&usblp->wait);
 	usblp->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	usblp->intf = intf;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/core/usb.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/core/usb.c	2005-08-18 00:55:12.000000000 +0200
@@ -758,7 +758,7 @@ usb_alloc_dev(struct usb_device *parent,
 	dev->parent = parent;
 	INIT_LIST_HEAD(&dev->filelist);
 
-	init_MUTEX(&dev->serialize);
+	init_mutex(&dev->serialize);
 
 	return dev;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/usb/gadget/inode.c	2005-08-17 21:51:56.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/gadget/inode.c	2005-08-18 00:55:12.000000000 +0200
@@ -1590,7 +1590,7 @@ static int activate_ep_files (struct dev
 			goto enomem;
 		memset (data, 0, sizeof data);
 		data->state = STATE_EP_DISABLED;
-		init_MUTEX (&data->lock);
+		init_mutex (&data->lock);
 		init_waitqueue_head (&data->wait);
 
 		strncpy (data->name, ep->name, sizeof (data->name) - 1);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/image/mdc800.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/image/mdc800.c	2005-08-18 00:55:12.000000000 +0200
@@ -988,7 +988,7 @@ static int __init usb_mdc800_init (void)
 	mdc800->dev = NULL;
 	mdc800->open=0;
 	mdc800->state=NOT_CONNECTED;
-	init_MUTEX (&mdc800->io_lock);
+	init_mutex (&mdc800->io_lock);
 
 	init_waitqueue_head (&mdc800->irq_wait);
 	init_waitqueue_head (&mdc800->write_wait);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/image/microtek.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/image/microtek.c	2005-08-18 00:55:13.000000000 +0200
@@ -784,7 +784,7 @@ static int mts_usb_probe(struct usb_inte
 
 	new_desc->usb_dev = dev;
 	new_desc->usb_intf = intf;
-	init_MUTEX(&new_desc->lock);
+	init_mutex(&new_desc->lock);
 
 	/* endpoints */
 	new_desc->ep_out = ep_out;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/dabusb.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/dabusb.c	2005-08-18 00:55:13.000000000 +0200
@@ -831,7 +831,7 @@ static int __init dabusb_init (void)
 	for (u = 0; u < NRDABUSB; u++) {
 		pdabusb_t s = &dabusb[u];
 		memset (s, 0, sizeof (dabusb_t));
-		init_MUTEX (&s->mutex);
+		init_mutex (&s->mutex);
 		s->usbdev = NULL;
 		s->total_buffer_size = buffers;
 		init_waitqueue_head (&s->wait);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/ov511.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/ov511.c	2005-08-18 00:55:13.000000000 +0200
@@ -5851,11 +5851,11 @@ ov51x_probe(struct usb_interface *intf, 
 
 	init_waitqueue_head(&ov->wq);
 
-	init_MUTEX(&ov->lock);	/* to 1 == available */
-	init_MUTEX(&ov->buf_lock);
-	init_MUTEX(&ov->param_lock);
-	init_MUTEX(&ov->i2c_lock);
-	init_MUTEX(&ov->cbuf_lock);
+	init_mutex(&ov->lock);	/* to 1 == available */
+	init_mutex(&ov->buf_lock);
+	init_mutex(&ov->param_lock);
+	init_mutex(&ov->i2c_lock);
+	init_mutex(&ov->cbuf_lock);
 
 	ov->buf_state = BUF_NOT_ALLOCATED;
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/pwc/pwc-if.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/pwc/pwc-if.c	2005-08-18 00:55:13.000000000 +0200
@@ -1893,7 +1893,7 @@ static int usb_pwc_probe(struct usb_inte
 		pdev->angle_range.tilt_max =  2500;
 	}
 
-	init_MUTEX(&pdev->modlock);
+	init_mutex(&pdev->modlock);
 	spin_lock_init(&pdev->ptrlock);
 
 	pdev->udev = udev;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/se401.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/se401.c	2005-08-18 00:55:13.000000000 +0200
@@ -1365,7 +1365,7 @@ static int se401_probe(struct usb_interf
 	memcpy(&se401->vdev, &se401_template, sizeof(se401_template));
 	memcpy(se401->vdev.name, se401->camera_name, strlen(se401->camera_name));
 	init_waitqueue_head(&se401->wq);
-	init_MUTEX(&se401->lock);
+	init_mutex(&se401->lock);
 	wmb();
 
 	if (video_register_device(&se401->vdev, VFL_TYPE_GRABBER, video_nr) == -1) {
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/sn9c102_core.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/sn9c102_core.c	2005-08-18 00:55:13.000000000 +0200
@@ -1382,7 +1382,7 @@ static int sn9c102_init(struct sn9c102_d
 	}
 
 	if (!(cam->state & DEV_INITIALIZED)) {
-		init_MUTEX(&cam->fileop_sem);
+		init_mutex(&cam->fileop_sem);
 		spin_lock_init(&cam->queue_lock);
 		init_waitqueue_head(&cam->wait_frame);
 		init_waitqueue_head(&cam->wait_stream);
@@ -2575,7 +2575,7 @@ sn9c102_usb_probe(struct usb_interface* 
 		goto fail;
 	}
 
-	init_MUTEX(&cam->dev_sem);
+	init_mutex(&cam->dev_sem);
 
 	r = sn9c102_read_reg(cam, 0x00);
 	if (r < 0 || r != 0x10) {
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/stv680.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/stv680.c	2005-08-18 00:55:13.000000000 +0200
@@ -1408,7 +1408,7 @@ static int stv680_probe (struct usb_inte
 
 	memcpy (stv680->vdev->name, stv680->camera_name, strlen (stv680->camera_name));
 	init_waitqueue_head (&stv680->wq);
-	init_MUTEX (&stv680->lock);
+	init_mutex (&stv680->lock);
 	wmb ();
 
 	if (video_register_device (stv680->vdev, VFL_TYPE_GRABBER, video_nr) == -1) {
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/usbvideo.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/usbvideo.c	2005-08-18 00:55:13.000000000 +0200
@@ -715,7 +715,7 @@ int usbvideo_register(
 	cams->md_module = md;
 	if (cams->md_module == NULL)
 		warn("%s: module == NULL!", __FUNCTION__);
-	init_MUTEX(&cams->lock);	/* to 1 == available */
+	init_mutex(&cams->lock);	/* to 1 == available */
 
 	for (i = 0; i < num_cams; i++) {
 		struct uvd *up = &cams->cam[i];
@@ -936,7 +936,7 @@ static int usbvideo_find_struct(struct u
 		if (!uvd->uvd_used) /* This one is free */
 		{
 			uvd->uvd_used = 1;	/* In use now */
-			init_MUTEX(&uvd->lock);	/* to 1 == available */
+			init_mutex(&uvd->lock);	/* to 1 == available */
 			uvd->dev = NULL;
 			rv = u;
 			break;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/vicam.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/vicam.c	2005-08-18 00:55:13.000000000 +0200
@@ -1309,7 +1309,7 @@ vicam_probe( struct usb_interface *intf,
 
 	cam->shutter_speed = 15;
 
-	init_MUTEX(&cam->cam_lock);
+	init_mutex(&cam->cam_lock);
 
 	memcpy(&cam->vdev, &vicam_template,
 	       sizeof (vicam_template));
--- linux-2.6.13-rc6-git9-orig/drivers/usb/media/w9968cf.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/media/w9968cf.c	2005-08-18 00:55:13.000000000 +0200
@@ -2442,7 +2442,7 @@ w9968cf_configure_camera(struct w9968cf_
                          enum w9968cf_model_id mod_id,
                          const unsigned short dev_nr)
 {
-	init_MUTEX(&cam->fileop_sem);
+	init_mutex(&cam->fileop_sem);
 	init_waitqueue_head(&cam->open);
 	spin_lock_init(&cam->urb_lock);
 	spin_lock_init(&cam->flist_lock);
@@ -3532,7 +3532,7 @@ w9968cf_usb_probe(struct usb_interface* 
 
 	memset(cam, 0, sizeof(*cam));
 
-	init_MUTEX(&cam->dev_sem);
+	init_mutex(&cam->dev_sem);
 	down(&cam->dev_sem);
 
 	cam->usbdev = udev;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/auerswald.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/auerswald.c	2005-08-18 00:55:13.000000000 +0200
@@ -1392,8 +1392,8 @@ static int auerchar_open (struct inode *
 
 	/* Initialize device descriptor */
 	memset( ccp, 0, sizeof(auerchar_t));
-	init_MUTEX( &ccp->mutex);
-	init_MUTEX( &ccp->readmutex);
+	init_mutex( &ccp->mutex);
+	init_mutex( &ccp->readmutex);
         auerbuf_init (&ccp->bufctl);
         ccp->scontext.id = AUH_UNASSIGNED;
         ccp->scontext.dispatch = auerchar_ctrlread_dispatch;
@@ -1928,7 +1928,7 @@ static int auerswald_probe (struct usb_i
 
 	/* Initialize device descriptor */
 	memset (cp, 0, sizeof(auerswald_t));
-	init_MUTEX (&cp->mutex);
+	init_mutex (&cp->mutex);
 	cp->usbdev = usbdev;
 	auerchain_init (&cp->controlchain);
         auerbuf_init (&cp->bufctl);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/idmouse.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/idmouse.c	2005-08-18 00:55:13.000000000 +0200
@@ -359,7 +359,7 @@ static int idmouse_probe(struct usb_inte
 		return -ENOMEM;
 	memset(dev, 0x00, sizeof(*dev));
 
-	init_MUTEX(&dev->sem);
+	init_mutex(&dev->sem);
 	dev->udev = udev;
 	dev->interface = interface;
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/ldusb.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/ldusb.c	2005-08-18 00:55:13.000000000 +0200
@@ -625,7 +625,7 @@ static int ld_usb_probe(struct usb_inter
 		goto exit;
 	}
 	memset(dev, 0x00, sizeof(*dev));
-	init_MUTEX(&dev->sem);
+	init_mutex(&dev->sem);
 	dev->intf = intf;
 	init_waitqueue_head(&dev->read_wait);
 	init_waitqueue_head(&dev->write_wait);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/legousbtower.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/legousbtower.c	2005-08-18 00:55:13.000000000 +0200
@@ -868,7 +868,7 @@ static int tower_probe (struct usb_inter
 		goto exit;
 	}
 
-	init_MUTEX (&dev->sem);
+	init_mutex (&dev->sem);
 
 	dev->udev = udev;
 	dev->open_count = 0;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/rio500.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/rio500.c	2005-08-18 00:55:13.000000000 +0200
@@ -481,7 +481,7 @@ static int probe_rio(struct usb_interfac
 	}
 	dbg("probe_rio: ibuf address:%p", rio->ibuf);
 
-	init_MUTEX(&(rio->lock));
+	init_mutex(&(rio->lock));
 
 	usb_set_intfdata (intf, rio);
 	rio->present = 1;
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/sisusbvga/sisusb.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/sisusbvga/sisusb.c	2005-08-18 00:55:13.000000000 +0200
@@ -2923,7 +2923,7 @@ static int sisusb_probe(struct usb_inter
 	memset(sisusb, 0, sizeof(*sisusb));
 	kref_init(&sisusb->kref);
 
-	init_MUTEX(&(sisusb->lock));
+	init_mutex(&(sisusb->lock));
 
 	/* Register device */
 	if ((retval = usb_register_dev(intf, &usb_sisusb_class))) {
--- linux-2.6.13-rc6-git9-orig/drivers/usb/misc/usbtest.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/misc/usbtest.c	2005-08-18 00:55:13.000000000 +0200
@@ -1878,7 +1878,7 @@ usbtest_probe (struct usb_interface *int
 	memset (dev, 0, sizeof *dev);
 	info = (struct usbtest_info *) id->driver_info;
 	dev->info = info;
-	init_MUTEX (&dev->sem);
+	init_mutex (&dev->sem);
 
 	dev->intf = intf;
 
--- linux-2.6.13-rc6-git9-orig/drivers/usb/mon/mon_text.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/mon/mon_text.c	2005-08-18 00:55:13.000000000 +0200
@@ -228,7 +228,7 @@ static int mon_text_open(struct inode *i
 	memset(rp, 0, sizeof(struct mon_reader_text));
 	INIT_LIST_HEAD(&rp->e_list);
 	init_waitqueue_head(&rp->wait);
-	init_MUTEX(&rp->printf_lock);
+	init_mutex(&rp->printf_lock);
 
 	rp->printf_size = PRINTF_DFL;
 	rp->printf_buf = kmalloc(rp->printf_size, GFP_KERNEL);
--- linux-2.6.13-rc6-git9-orig/drivers/usb/storage/usb.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/usb/storage/usb.c	2005-08-18 00:55:13.000000000 +0200
@@ -888,8 +888,8 @@ static int storage_probe(struct usb_inte
 
 	us = host_to_us(host);
 	memset(us, 0, sizeof(struct us_data));
-	init_MUTEX(&(us->dev_semaphore));
-	init_MUTEX_LOCKED(&(us->sema));
+	init_mutex(&(us->dev_semaphore));
+	init_mutex_locked(&(us->sema));
 	init_completion(&(us->notify));
 	init_waitqueue_head(&us->delay_wait);
 
--- linux-2.6.13-rc6-git9-orig/drivers/video/backlight/backlight.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/video/backlight/backlight.c	2005-08-18 00:55:13.000000000 +0200
@@ -176,7 +176,7 @@ struct backlight_device *backlight_devic
 	if (unlikely(!new_bd))
 		return ERR_PTR(ENOMEM);
 
-	init_MUTEX(&new_bd->sem);
+	init_mutex(&new_bd->sem);
 	new_bd->props = bp;
 	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
 	new_bd->class_dev.class = &backlight_class;
--- linux-2.6.13-rc6-git9-orig/drivers/video/backlight/lcd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/video/backlight/lcd.c	2005-08-18 00:55:13.000000000 +0200
@@ -175,7 +175,7 @@ struct lcd_device *lcd_device_register(c
 	if (unlikely(!new_ld))
 		return ERR_PTR(ENOMEM);
 
-	init_MUTEX(&new_ld->sem);
+	init_mutex(&new_ld->sem);
 	new_ld->props = lp;
 	memset(&new_ld->class_dev, 0, sizeof(new_ld->class_dev));
 	new_ld->class_dev.class = &lcd_class;
--- linux-2.6.13-rc6-git9-orig/drivers/video/pxafb.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/video/pxafb.c	2005-08-18 00:55:13.000000000 +0200
@@ -1082,7 +1082,7 @@ static struct pxafb_info * __init pxafb_
 
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task, fbi);
-	init_MUTEX(&fbi->ctrlr_sem);
+	init_mutex(&fbi->ctrlr_sem);
 
 	return fbi;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/video/sa1100fb.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/video/sa1100fb.c	2005-08-18 00:55:13.000000000 +0200
@@ -1448,7 +1448,7 @@ static struct sa1100fb_info * __init sa1
 
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, sa1100fb_task, fbi);
-	init_MUTEX(&fbi->ctrlr_sem);
+	init_mutex(&fbi->ctrlr_sem);
 
 	return fbi;
 }
--- linux-2.6.13-rc6-git9-orig/drivers/w1/w1_int.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/drivers/w1/w1_int.c	2005-08-18 00:55:13.000000000 +0200
@@ -74,7 +74,7 @@ static struct w1_master * w1_alloc_dev(u
 	atomic_set(&dev->refcnt, 2);
 
 	INIT_LIST_HEAD(&dev->slist);
-	init_MUTEX(&dev->mutex);
+	init_mutex(&dev->mutex);
 
 	init_completion(&dev->dev_released);
 	init_completion(&dev->dev_exited);
--- linux-2.6.13-rc6-git9-orig/fs/affs/super.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/affs/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -89,8 +89,8 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->i_link_lock);
-		init_MUTEX(&ei->i_ext_lock);
+		init_mutex(&ei->i_link_lock);
+		init_mutex(&ei->i_ext_lock);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -284,7 +284,7 @@ static int affs_fill_super(struct super_
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
 	memset(sbi, 0, sizeof(*sbi));
-	init_MUTEX(&sbi->s_bmlock);
+	init_mutex(&sbi->s_bmlock);
 
 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
 				&blocksize,&sbi->s_prefix,
--- linux-2.6.13-rc6-git9-orig/fs/autofs4/inode.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/autofs4/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -271,7 +271,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
-	init_MUTEX(&sbi->wq_sem);
+	init_mutex(&sbi->wq_sem);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
 	s->s_blocksize = 1024;
--- linux-2.6.13-rc6-git9-orig/fs/cifs/connect.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/cifs/connect.c	2005-08-18 00:55:13.000000000 +0200
@@ -1592,7 +1592,7 @@ cifs_mount(struct super_block *sb, struc
 			to the struct since the kernel thread not created yet
 			so no need to spinlock this init of tcpStatus */
 			srvTcp->tcpStatus = CifsNew;
-			init_MUTEX(&srvTcp->tcpSem);
+			init_mutex(&srvTcp->tcpSem);
 			rc = (int)kernel_thread((void *)(void *)cifs_demultiplex_thread, srvTcp,
 				      CLONE_FS | CLONE_FILES | CLONE_VM);
 			if(rc < 0) {
--- linux-2.6.13-rc6-git9-orig/fs/cifs/dir.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/cifs/dir.c	2005-08-18 00:55:13.000000000 +0200
@@ -248,7 +248,7 @@ cifs_create(struct inode *inode, struct 
 			pCifsFile->pInode = newinode;
 			pCifsFile->invalidHandle = FALSE;
 			pCifsFile->closePend     = FALSE;
-			init_MUTEX(&pCifsFile->fh_sem);
+			init_mutex(&pCifsFile->fh_sem);
 			/* set the following in open now 
 				pCifsFile->pfile = file; */
 			write_lock(&GlobalSMBSeslock);
--- linux-2.6.13-rc6-git9-orig/fs/cifs/file.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/cifs/file.c	2005-08-18 00:55:13.000000000 +0200
@@ -42,7 +42,7 @@ static inline struct cifsFileInfo *cifs_
 	memset(private_data, 0, sizeof(struct cifsFileInfo));
 	private_data->netfid = netfid;
 	private_data->pid = current->tgid;	
-	init_MUTEX(&private_data->fh_sem);
+	init_mutex(&private_data->fh_sem);
 	private_data->pfile = file; /* needed for writepage */
 	private_data->pInode = inode;
 	private_data->invalidHandle = FALSE;
--- linux-2.6.13-rc6-git9-orig/fs/cifs/misc.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/cifs/misc.c	2005-08-18 00:55:13.000000000 +0200
@@ -80,7 +80,7 @@ sesInfoAlloc(void)
 		atomic_inc(&sesInfoAllocCount);
 		ret_buf->status = CifsNew;
 		list_add(&ret_buf->cifsSessionList, &GlobalSMBSessionList);
-		init_MUTEX(&ret_buf->sesSem);
+		init_mutex(&ret_buf->sesSem);
 		write_unlock(&GlobalSMBSeslock);
 	}
 	return ret_buf;
@@ -124,7 +124,7 @@ tconInfoAlloc(void)
 			 &GlobalTreeConnectionList);
 		ret_buf->tidStatus = CifsNew;
 		INIT_LIST_HEAD(&ret_buf->openFileList);
-		init_MUTEX(&ret_buf->tconSem);
+		init_mutex(&ret_buf->tconSem);
 #ifdef CONFIG_CIFS_STATS
 		spin_lock_init(&ret_buf->stat_lock);
 #endif
--- linux-2.6.13-rc6-git9-orig/fs/eventpoll.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/eventpoll.c	2005-08-18 00:55:13.000000000 +0200
@@ -1611,7 +1611,7 @@ static int __init eventpoll_init(void)
 {
 	int error;
 
-	init_MUTEX(&epsem);
+	init_mutex(&epsem);
 
 	/* Initialize the structure used to perform safe poll wait head wake ups */
 	ep_poll_safewake_init(&psw);
--- linux-2.6.13-rc6-git9-orig/fs/ext3/super.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/ext3/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -467,7 +467,7 @@ static void init_once(void * foo, kmem_c
 #ifdef CONFIG_EXT3_FS_XATTR
 		init_rwsem(&ei->xattr_sem);
 #endif
-		init_MUTEX(&ei->truncate_sem);
+		init_mutex(&ei->truncate_sem);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
--- linux-2.6.13-rc6-git9-orig/fs/fat/fatent.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/fat/fatent.c	2005-08-18 00:55:13.000000000 +0200
@@ -279,7 +279,7 @@ void fat_ent_access_init(struct super_bl
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	init_MUTEX(&sbi->fat_lock);
+	init_mutex(&sbi->fat_lock);
 
 	switch (sbi->fat_bits) {
 	case 32:
--- linux-2.6.13-rc6-git9-orig/fs/hfs/btree.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfs/btree.c	2005-08-18 00:55:13.000000000 +0200
@@ -26,7 +26,7 @@ struct hfs_btree *hfs_btree_open(struct 
 		return NULL;
 	memset(tree, 0, sizeof(*tree));
 
-	init_MUTEX(&tree->tree_lock);
+	init_mutex(&tree->tree_lock);
 	spin_lock_init(&tree->hash_lock);
 	/* Set the correct compare function */
 	tree->sb = sb;
@@ -41,7 +41,7 @@ struct hfs_btree *hfs_btree_open(struct 
 	{
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
 	HFS_I(tree->inode)->flags = 0;
-	init_MUTEX(&HFS_I(tree->inode)->extents_lock);
+	init_mutex(&HFS_I(tree->inode)->extents_lock);
 	switch (id) {
 	case HFS_EXT_CNID:
 		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec, mdb->drXTFlSize,
--- linux-2.6.13-rc6-git9-orig/fs/hfs/inode.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfs/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -158,7 +158,7 @@ struct inode *hfs_new_inode(struct inode
 	if (!inode)
 		return NULL;
 
-	init_MUTEX(&HFS_I(inode)->extents_lock);
+	init_mutex(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	hfs_cat_build_key((btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	inode->i_ino = HFS_SB(sb)->next_id++;
@@ -290,7 +290,7 @@ static int hfs_read_inode(struct inode *
 
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
-	init_MUTEX(&HFS_I(inode)->extents_lock);
+	init_mutex(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 
 	/* Initialize the inode */
--- linux-2.6.13-rc6-git9-orig/fs/hfs/super.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfs/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -302,7 +302,7 @@ static int hfs_fill_super(struct super_b
 
 	sb->s_op = &hfs_super_operations;
 	sb->s_flags |= MS_NODIRATIME;
-	init_MUTEX(&sbi->bitmap_lock);
+	init_mutex(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
 	if (res) {
--- linux-2.6.13-rc6-git9-orig/fs/hfsplus/btree.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfsplus/btree.c	2005-08-18 00:55:13.000000000 +0200
@@ -29,7 +29,7 @@ struct hfs_btree *hfs_btree_open(struct 
 		return NULL;
 	memset(tree, 0, sizeof(*tree));
 
-	init_MUTEX(&tree->tree_lock);
+	init_mutex(&tree->tree_lock);
 	spin_lock_init(&tree->hash_lock);
 	/* Set the correct compare function */
 	tree->sb = sb;
--- linux-2.6.13-rc6-git9-orig/fs/hfsplus/inode.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfsplus/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -166,7 +166,7 @@ static struct dentry *hfsplus_file_looku
 
 	inode->i_ino = dir->i_ino;
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
-	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
+	init_mutex(&HFSPLUS_I(inode).extents_lock);
 	HFSPLUS_I(inode).flags = HFSPLUS_FLG_RSRC;
 
 	hfs_find_init(HFSPLUS_SB(sb).cat_tree, &fd);
@@ -331,7 +331,7 @@ struct inode *hfsplus_new_inode(struct s
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
 	inode->i_blksize = HFSPLUS_SB(sb).alloc_blksz;
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
-	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
+	init_mutex(&HFSPLUS_I(inode).extents_lock);
 	atomic_set(&HFSPLUS_I(inode).opencnt, 0);
 	HFSPLUS_I(inode).flags = 0;
 	memset(HFSPLUS_I(inode).first_extents, 0, sizeof(hfsplus_extent_rec));
--- linux-2.6.13-rc6-git9-orig/fs/hfsplus/super.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hfsplus/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -47,7 +47,7 @@ static void hfsplus_read_inode(struct in
 	atomic_inc(&HFSPLUS_SB(inode->i_sb).inode_cnt);
 	hfsplus_inode_check(inode->i_sb);
 	INIT_LIST_HEAD(&HFSPLUS_I(inode).open_dir_list);
-	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
+	init_mutex(&HFSPLUS_I(inode).extents_lock);
 	HFSPLUS_I(inode).flags = 0;
 	HFSPLUS_I(inode).rsrc_inode = NULL;
 
--- linux-2.6.13-rc6-git9-orig/fs/hpfs/super.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/hpfs/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -181,8 +181,8 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->i_sem);
-		init_MUTEX(&ei->i_parent);
+		init_mutex(&ei->i_sem);
+		init_mutex(&ei->i_parent);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -468,7 +468,7 @@ static int hpfs_fill_super(struct super_
 	sbi->sb_bmp_dir = NULL;
 	sbi->sb_cp_table = NULL;
 
-	init_MUTEX(&sbi->hpfs_creation_de);
+	init_mutex(&sbi->hpfs_creation_de);
 
 	uid = current->uid;
 	gid = current->gid;
--- linux-2.6.13-rc6-git9-orig/fs/isofs/compress.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/isofs/compress.c	2005-08-18 00:55:13.000000000 +0200
@@ -330,7 +330,7 @@ int __init zisofs_init(void)
 	zisofs_zlib_workspace = vmalloc(zlib_inflate_workspacesize());
 	if ( !zisofs_zlib_workspace )
 		return -ENOMEM;
-	init_MUTEX(&zisofs_zlib_semaphore);
+	init_mutex(&zisofs_zlib_semaphore);
 
 	initialized = 1;
 	return 0;
--- linux-2.6.13-rc6-git9-orig/fs/jbd/journal.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jbd/journal.c	2005-08-18 00:55:13.000000000 +0200
@@ -671,8 +671,8 @@ static journal_t * journal_init_common (
 	init_waitqueue_head(&journal->j_wait_checkpoint);
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
-	init_MUTEX(&journal->j_barrier);
-	init_MUTEX(&journal->j_checkpoint_sem);
+	init_mutex(&journal->j_barrier);
+	init_mutex(&journal->j_checkpoint_sem);
 	spin_lock_init(&journal->j_revoke_lock);
 	spin_lock_init(&journal->j_list_lock);
 	spin_lock_init(&journal->j_state_lock);
--- linux-2.6.13-rc6-git9-orig/fs/jffs/jffs_fm.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jffs/jffs_fm.c	2005-08-18 00:55:13.000000000 +0200
@@ -138,7 +138,7 @@ jffs_build_begin(struct jffs_control *c,
 	fmc->tail = NULL;
 	fmc->head_extra = NULL;
 	fmc->tail_extra = NULL;
-	init_MUTEX(&fmc->biglock);
+	init_mutex(&fmc->biglock);
 	return fmc;
 }
 
--- linux-2.6.13-rc6-git9-orig/fs/jffs2/readinode.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jffs2/readinode.c	2005-08-18 00:55:13.000000000 +0200
@@ -482,7 +482,7 @@ int jffs2_do_crccheck_inode(struct jffs2
 		return -ENOMEM;
 
 	memset(f, 0, sizeof(*f));
-	init_MUTEX_LOCKED(&f->sem);
+	init_mutex_locked(&f->sem);
 	f->inocache = ic;
 
 	ret = jffs2_do_read_inode_internal(c, f, &n);
--- linux-2.6.13-rc6-git9-orig/fs/jffs2/super.c	2005-08-17 21:52:00.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jffs2/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -51,7 +51,7 @@ static void jffs2_i_init_once(void * foo
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX_LOCKED(&ei->sem);
+		init_mutex_locked(&ei->sem);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -142,8 +142,8 @@ static struct super_block *jffs2_get_sb_
 
 	/* Initialize JFFS2 superblock locks, the further initialization will be
 	 * done later */
-	init_MUTEX(&c->alloc_sem);
-	init_MUTEX(&c->erase_free_sem);
+	init_mutex(&c->alloc_sem);
+	init_mutex(&c->erase_free_sem);
 	init_waitqueue_head(&c->erase_wait);
 	init_waitqueue_head(&c->inocache_wq);
 	spin_lock_init(&c->erase_completion_lock);
--- linux-2.6.13-rc6-git9-orig/fs/jfs/jfs_dmap.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jfs/jfs_dmap.c	2005-08-18 00:55:13.000000000 +0200
@@ -64,7 +64,7 @@
  *	to the persistent bitmaps in dmaps) is guarded by (busy) buffers.
  */
 
-#define BMAP_LOCK_INIT(bmp)	init_MUTEX(&bmp->db_bmaplock)
+#define BMAP_LOCK_INIT(bmp)	init_mutex(&bmp->db_bmaplock)
 #define BMAP_LOCK(bmp)		down(&bmp->db_bmaplock)
 #define BMAP_UNLOCK(bmp)	up(&bmp->db_bmaplock)
 
--- linux-2.6.13-rc6-git9-orig/fs/jfs/jfs_imap.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jfs/jfs_imap.c	2005-08-18 00:55:13.000000000 +0200
@@ -60,12 +60,12 @@
  * imap locks
  */
 /* iag free list lock */
-#define IAGFREE_LOCK_INIT(imap)		init_MUTEX(&imap->im_freelock)
+#define IAGFREE_LOCK_INIT(imap)		init_mutex(&imap->im_freelock)
 #define IAGFREE_LOCK(imap)		down(&imap->im_freelock)
 #define IAGFREE_UNLOCK(imap)		up(&imap->im_freelock)
 
 /* per ag iag list locks */
-#define AG_LOCK_INIT(imap,index)	init_MUTEX(&(imap->im_aglock[index]))
+#define AG_LOCK_INIT(imap,index)	init_mutex(&(imap->im_aglock[index]))
 #define AG_LOCK(imap,agno)		down(&imap->im_aglock[agno])
 #define AG_UNLOCK(imap,agno)		up(&imap->im_aglock[agno])
 
--- linux-2.6.13-rc6-git9-orig/fs/jfs/jfs_logmgr.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jfs/jfs_logmgr.c	2005-08-18 00:55:13.000000000 +0200
@@ -87,7 +87,7 @@ DECLARE_WAIT_QUEUE_HEAD(jfs_IO_thread_wa
 /*
  *	log read/write serialization (per log)
  */
-#define LOG_LOCK_INIT(log)	init_MUTEX(&(log)->loglock)
+#define LOG_LOCK_INIT(log)	init_mutex(&(log)->loglock)
 #define LOG_LOCK(log)		down(&((log)->loglock))
 #define LOG_UNLOCK(log)		up(&((log)->loglock))
 
--- linux-2.6.13-rc6-git9-orig/fs/jfs/super.c	2005-08-17 21:53:54.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/jfs/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -575,7 +575,7 @@ static void init_once(void *foo, kmem_ca
 		memset(jfs_ip, 0, sizeof(struct jfs_inode_info));
 		INIT_LIST_HEAD(&jfs_ip->anon_inode_list);
 		init_rwsem(&jfs_ip->rdwrlock);
-		init_MUTEX(&jfs_ip->commit_sem);
+		init_mutex(&jfs_ip->commit_sem);
 		init_rwsem(&jfs_ip->xattr_sem);
 		spin_lock_init(&jfs_ip->ag_lock);
 		jfs_ip->active_ag = -1;
--- linux-2.6.13-rc6-git9-orig/fs/libfs.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/libfs.c	2005-08-18 00:55:13.000000000 +0200
@@ -548,7 +548,7 @@ int simple_attr_open(struct inode *inode
 	attr->set = set;
 	attr->data = inode->u.generic_ip;
 	attr->fmt = fmt;
-	init_MUTEX(&attr->sem);
+	init_mutex(&attr->sem);
 
 	file->private_data = attr;
 
--- linux-2.6.13-rc6-git9-orig/fs/lockd/host.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/lockd/host.c	2005-08-18 00:55:13.000000000 +0200
@@ -111,7 +111,7 @@ nlm_lookup_host(int server, struct socka
 	host->h_version    = version;
 	host->h_proto      = proto;
 	host->h_rpcclnt    = NULL;
-	init_MUTEX(&host->h_sema);
+	init_mutex(&host->h_sema);
 	host->h_nextrebind = jiffies + NLM_HOST_REBIND;
 	host->h_expires    = jiffies + NLM_HOST_EXPIRE;
 	atomic_set(&host->h_count, 1);
--- linux-2.6.13-rc6-git9-orig/fs/lockd/svcsubs.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/lockd/svcsubs.c	2005-08-18 00:55:13.000000000 +0200
@@ -81,7 +81,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 	memset(file, 0, sizeof(*file));
 	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
 	file->f_hash = hash;
-	init_MUTEX(&file->f_sema);
+	init_mutex(&file->f_sema);
 
 	/* Open the file. Note that this must not sleep for too long, else
 	 * we would lock up lockd:-) So no NFS re-exports, folks.
--- linux-2.6.13-rc6-git9-orig/fs/ncpfs/inode.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/ncpfs/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -63,7 +63,7 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->open_sem);
+		init_mutex(&ei->open_sem);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -518,7 +518,7 @@ static int ncp_fill_super(struct super_b
 	}
 
 /*	server->lock = 0;	*/
-	init_MUTEX(&server->sem);
+	init_mutex(&server->sem);
 	server->packet = NULL;
 /*	server->buffer_size = 0;	*/
 /*	server->conn_status = 0;	*/
@@ -555,7 +555,7 @@ static int ncp_fill_super(struct super_b
 	server->dentry_ttl = 0;	/* no caching */
 
 	INIT_LIST_HEAD(&server->tx.requests);
-	init_MUTEX(&server->rcv.creq_sem);
+	init_mutex(&server->rcv.creq_sem);
 	server->tx.creq		= NULL;
 	server->rcv.creq	= NULL;
 	server->data_ready	= sock->sk->sk_data_ready;
--- linux-2.6.13-rc6-git9-orig/fs/nfs/idmap.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/nfs/idmap.c	2005-08-18 00:55:13.000000000 +0200
@@ -112,8 +112,8 @@ nfs_idmap_new(struct nfs4_client *clp)
 		return;
 	}
 
-        init_MUTEX(&idmap->idmap_lock);
-        init_MUTEX(&idmap->idmap_im_lock);
+        init_mutex(&idmap->idmap_lock);
+        init_mutex(&idmap->idmap_im_lock);
 	init_waitqueue_head(&idmap->idmap_wq);
 	idmap->idmap_user_hash.h_type = IDMAP_TYPE_USER;
 	idmap->idmap_group_hash.h_type = IDMAP_TYPE_GROUP;
--- linux-2.6.13-rc6-git9-orig/fs/nfs/nfs4state.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/nfs/nfs4state.c	2005-08-18 00:55:13.000000000 +0200
@@ -267,7 +267,7 @@ nfs4_alloc_state_owner(void)
 	sp = kmalloc(sizeof(*sp),GFP_KERNEL);
 	if (!sp)
 		return NULL;
-	init_MUTEX(&sp->so_sema);
+	init_mutex(&sp->so_sema);
 	sp->so_seqid = 0;                 /* arbitrary */
 	INIT_LIST_HEAD(&sp->so_states);
 	INIT_LIST_HEAD(&sp->so_delegations);
@@ -359,7 +359,7 @@ nfs4_alloc_open_state(void)
 	memset(state->stateid.data, 0, sizeof(state->stateid.data));
 	atomic_set(&state->count, 1);
 	INIT_LIST_HEAD(&state->lock_states);
-	init_MUTEX(&state->lock_sema);
+	init_mutex(&state->lock_sema);
 	spin_lock_init(&state->state_lock);
 	return state;
 }
--- linux-2.6.13-rc6-git9-orig/fs/ntfs/inode.c	2005-08-17 21:52:01.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/ntfs/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -381,7 +381,7 @@ void __ntfs_init_inode(struct super_bloc
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	ntfs_init_runlist(&ni->runlist);
-	init_MUTEX(&ni->mrec_lock);
+	init_mutex(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
@@ -393,7 +393,7 @@ void __ntfs_init_inode(struct super_bloc
 	ni->itype.index.collation_rule = 0;
 	ni->itype.index.block_size_bits = 0;
 	ni->itype.index.vcn_size_bits = 0;
-	init_MUTEX(&ni->extent_lock);
+	init_mutex(&ni->extent_lock);
 	ni->nr_extents = 0;
 	ni->ext.base_ntfs_ino = NULL;
 }
--- linux-2.6.13-rc6-git9-orig/fs/smbfs/inode.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/smbfs/inode.c	2005-08-18 00:55:13.000000000 +0200
@@ -528,7 +528,7 @@ static int smb_fill_super(struct super_b
 	server->mnt = NULL;
 	server->sock_file = NULL;
 	init_waitqueue_head(&server->conn_wq);
-	init_MUTEX(&server->sem);
+	init_mutex(&server->sem);
 	INIT_LIST_HEAD(&server->entry);
 	INIT_LIST_HEAD(&server->xmitq);
 	INIT_LIST_HEAD(&server->recvq);
--- linux-2.6.13-rc6-git9-orig/fs/sysfs/file.c	2005-08-17 21:52:02.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/sysfs/file.c	2005-08-18 00:55:13.000000000 +0200
@@ -304,7 +304,7 @@ static int check_perm(struct inode * ino
 	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
-		init_MUTEX(&buffer->sem);
+		init_mutex(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
 		file->private_data = buffer;
--- linux-2.6.13-rc6-git9-orig/fs/udf/super.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/udf/super.c	2005-08-18 00:55:13.000000000 +0200
@@ -1504,7 +1504,7 @@ static int udf_fill_super(struct super_b
 	sb->s_fs_info = sbi;
 	memset(UDF_SB(sb), 0x00, sizeof(struct udf_sb_info));
 
-	init_MUTEX(&sbi->s_alloc_sem);
+	init_mutex(&sbi->s_alloc_sem);
 
 	if (!udf_parse_options((char *)options, &uopt))
 		goto error_out;


