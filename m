Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVFUHgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVFUHgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFUHgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:36:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:51427 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261986AbVFUGax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:53 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove devfs_remove() function from the kernel tree
In-Reply-To: <11193354434057@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354432042@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove devfs_remove() function from the kernel tree

Removes the devfs_remove() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e20dfbef237b25d9bf7f74a82956b0f5cda6cde5
tree 336755a130f70f51b6354ca43cd7fe70b8444b70
parent 5015d86152443ad3b64c594a32b33d58f030bf70
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:34 -0700

 arch/sparc64/solaris/socksys.c          |    1 -
 drivers/block/acsi_slm.c                |    4 ----
 drivers/block/cpqarray.c                |    2 --
 drivers/block/floppy.c                  |   33 +------------------------------
 drivers/block/loop.c                    |    2 --
 drivers/block/nbd.c                     |    1 -
 drivers/block/paride/pg.c               |    5 +----
 drivers/block/paride/pt.c               |    3 ---
 drivers/block/rd.c                      |    1 -
 drivers/block/sx8.c                     |    1 -
 drivers/block/ub.c                      |    2 --
 drivers/cdrom/sbpcd.c                   |    2 --
 drivers/char/dsp56k.c                   |    1 -
 drivers/char/dtlk.c                     |    1 -
 drivers/char/ftape/zftape/zftape-init.c |    6 ------
 drivers/char/ip2main.c                  |    3 ---
 drivers/char/ipmi/ipmi_devintf.c        |    2 --
 drivers/char/istallion.c                |    5 +----
 drivers/char/lp.c                       |    3 ---
 drivers/char/misc.c                     |    1 -
 drivers/char/ppdev.c                    |    9 +-------
 drivers/char/raw.c                      |    6 ------
 drivers/char/stallion.c                 |    5 +----
 drivers/char/tipar.c                    |    2 --
 drivers/char/tty_io.c                   |    1 -
 drivers/char/vc_screen.c                |    2 --
 drivers/char/viotape.c                  |    2 --
 drivers/i2c/i2c-dev.c                   |    2 --
 drivers/ide/ide-probe.c                 |    4 +---
 drivers/ide/ide-tape.c                  |    2 --
 drivers/ide/ide.c                       |    5 +----
 drivers/ieee1394/amdtp.c                |    7 -------
 drivers/ieee1394/dv1394.c               |    6 ------
 drivers/ieee1394/ieee1394_core.c        |    8 +++-----
 drivers/ieee1394/raw1394.c              |    2 --
 drivers/ieee1394/video1394.c            |    8 ++------
 drivers/input/evdev.c                   |    1 -
 drivers/input/input.c                   |    1 -
 drivers/input/joydev.c                  |    1 -
 drivers/input/mousedev.c                |    2 --
 drivers/input/tsdev.c                   |    2 --
 drivers/isdn/capi/capi.c                |    1 -
 drivers/isdn/hardware/eicon/divamnt.c   |    1 -
 drivers/isdn/hardware/eicon/divasi.c    |    1 -
 drivers/isdn/hardware/eicon/divasmain.c |    1 -
 drivers/md/dm-ioctl.c                   |   13 ------------
 drivers/md/md.c                         |    8 +-------
 drivers/media/dvb/dvb-core/dvbdev.c     |    6 ------
 drivers/media/video/videodev.c          |    1 -
 drivers/mmc/mmc_block.c                 |    1 -
 drivers/mtd/mtd_blkdevs.c               |    1 -
 drivers/net/ppp_generic.c               |    1 -
 drivers/net/wan/cosa.c                  |    5 +----
 drivers/s390/block/dasd.c               |    1 -
 drivers/s390/block/xpram.c              |    2 --
 drivers/sbus/char/bpp.c                 |    3 ---
 drivers/sbus/char/vfc_dev.c             |    2 --
 drivers/scsi/ch.c                       |    1 -
 drivers/scsi/osst.c                     |    8 +-------
 drivers/scsi/scsi.c                     |    1 -
 drivers/scsi/sg.c                       |    5 +----
 drivers/scsi/st.c                       |    2 --
 drivers/telephony/phonedev.c            |    1 -
 drivers/usb/core/file.c                 |    3 ---
 drivers/usb/input/hiddev.c              |    1 -
 drivers/video/fbmem.c                   |    1 -
 fs/coda/psdev.c                         |   10 ++-------
 fs/partitions/check.c                   |    1 -
 include/linux/devfs_fs_kernel.h         |    3 ---
 sound/core/sound.c                      |   10 ---------
 sound/oss/soundcard.c                   |    5 +----
 sound/sound_core.c                      |    2 --
 72 files changed, 19 insertions(+), 240 deletions(-)

diff --git a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -205,5 +205,4 @@ cleanup_socksys(void)
 {
 	if (unregister_chrdev(30, "socksys"))
 		printk ("Couldn't unregister socksys character device\n");
-	devfs_remove ("socksys");
 }
diff --git a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c
+++ b/drivers/block/acsi_slm.c
@@ -1029,10 +1029,6 @@ int init_module(void)
 
 void cleanup_module(void)
 {
-	int i;
-	for (i = 0; i < MAX_SLM; i++)
-		devfs_remove("slm/%d", i);
-	devfs_remove("slm");
 	if (unregister_chrdev( ACSI_MAJOR, "slm" ) != 0)
 		printk( KERN_ERR "acsi_slm: cleanup_module failed\n");
 	atari_stram_free( SLMBuffer );
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -346,7 +346,6 @@ static void __devexit cpqarray_remove_on
 	for(j = 0; j < NWD; j++) {
 		if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
 			del_gendisk(ida_gendisk[i][j]);
-		devfs_remove("ida/c%dd%d",i,j);
 		put_disk(ida_gendisk[i][j]);
 	}
 	blk_cleanup_queue(hba[i]->queue);
@@ -1842,7 +1841,6 @@ static void __exit cpqarray_exit(void)
 		}
 	}
 
-	devfs_remove("ida");
 	remove_proc_entry("cpqarray", proc_root_driver);
 }
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3938,20 +3938,6 @@ static struct block_device_operations fl
 	.media_changed	= check_floppy_change,
 	.revalidate_disk = floppy_revalidate,
 };
-static char *table[] = {
-	"", "d360", "h1200", "u360", "u720", "h360", "h720",
-	"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
-	"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
-	"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
-	"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
-	NULL
-};
-static int t360[] = { 1, 0 },
-	t1200[] = { 2, 5, 6, 10, 12, 14, 16, 18, 20, 23, 0 },
-	t3in[] = { 8, 9, 26, 27, 28, 7, 11, 15, 19, 24, 25, 29, 31, 3, 4, 13,
-			17, 21, 22, 30, 0 };
-static int *table_sup[] =
-    { NULL, t360, t1200, t3in + 5 + 8, t3in + 5, t3in, t3in };
 
 /*
  * Floppy Driver initialization
@@ -4224,7 +4210,7 @@ static int __init floppy_init(void)
 
 	err = register_blkdev(FLOPPY_MAJOR, "fd");
 	if (err)
-		goto out_devfs_remove;
+		goto out_put_disk;
 
 	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
 	if (!floppy_queue) {
@@ -4377,8 +4363,6 @@ out_unreg_region:
 	blk_cleanup_queue(floppy_queue);
 out_unreg_blkdev:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-out_devfs_remove:
-	devfs_remove("floppy");
 out_put_disk:
 	while (dr--) {
 		del_timer(&motor_off_timer[dr]);
@@ -4532,19 +4516,6 @@ static void floppy_release_irq_and_dma(v
 
 static char *floppy;
 
-static void unregister_devfs_entries(int drive)
-{
-	int i;
-
-	if (UDP->cmos < NUMBER(default_drive_params)) {
-		i = 0;
-		do {
-			devfs_remove("floppy/%d%s", drive,
-				     table[table_sup[UDP->cmos][i]]);
-		} while (table_sup[UDP->cmos][i++]);
-	}
-}
-
 static void __init parse_floppy_cfg_string(char *cfg)
 {
 	char *ptr;
@@ -4581,12 +4552,10 @@ void cleanup_module(void)
 		if ((allowed_drive_mask & (1 << drive)) &&
 		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
-			unregister_devfs_entries(drive);
 		}
 		put_disk(disks[drive]);
 	}
 	platform_device_unregister(&floppy_device);
-	devfs_remove("floppy");
 
 	del_timer_sync(&fd_timeout);
 	del_timer_sync(&fd_timer);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1301,7 +1301,6 @@ static int __init loop_init(void)
 out_mem4:
 	while (i--)
 		blk_put_queue(loop_dev[i].lo_queue);
-	devfs_remove("loop");
 	i = max_loop;
 out_mem3:
 	while (i--)
@@ -1324,7 +1323,6 @@ static void loop_exit(void)
 		blk_put_queue(loop_dev[i].lo_queue);
 		put_disk(disks[i]);
 	}
-	devfs_remove("loop");
 	if (unregister_blkdev(LOOP_MAJOR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -721,7 +721,6 @@ static void __exit nbd_cleanup(void)
 			put_disk(disk);
 		}
 	}
-	devfs_remove("nbd");
 	unregister_blkdev(NBD_MAJOR, "nbd");
 	printk(KERN_INFO "nbd: unregistered device at major %d\n", NBD_MAJOR);
 }
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -692,13 +692,10 @@ static void __exit pg_exit(void)
 
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
-		if (dev->present) {
+		if (dev->present)
 			class_device_destroy(pg_class, MKDEV(major, unit));
-			devfs_remove("pg/%u", unit);
-		}
 	}
 	class_destroy(pg_class);
-	devfs_remove("pg");
 	unregister_chrdev(major, name);
 
 	for (unit = 0; unit < PG_UNITS; unit++) {
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -990,12 +990,9 @@ static void __exit pt_exit(void)
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
 			class_device_destroy(pt_class, MKDEV(major, unit));
-			devfs_remove("pt/%d", unit);
 			class_device_destroy(pt_class, MKDEV(major, unit + 128));
-			devfs_remove("pt/%dn", unit);
 		}
 	class_destroy(pt_class);
-	devfs_remove("pt");
 	unregister_chrdev(major, name);
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present)
diff --git a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -411,7 +411,6 @@ static void __exit rd_cleanup(void)
 		put_disk(rd_disks[i]);
 		blk_cleanup_queue(rd_queue[i]);
 	}
-	devfs_remove("rd");
 	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 }
 
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1731,7 +1731,6 @@ static void carm_remove_one (struct pci_
 
 	free_irq(pdev->irq, host);
 	carm_free_disks(host);
-	devfs_remove(DRV_NAME);
 	unregister_blkdev(host->major, host->name);
 	if (host->major == 160)
 		clear_bit(0, &carm_major_alloc);
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -2322,7 +2322,6 @@ static int __init ub_init(void)
 	return 0;
 
 err_register:
-	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 err_regblkdev:
 	return rc;
@@ -2332,7 +2331,6 @@ static void __exit ub_exit(void)
 {
 	usb_deregister(&ub_driver);
 
-	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 }
 
diff --git a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -5909,7 +5909,6 @@ static void sbpcd_exit(void)
 		if (D_S[j].drv_id==-1) continue;
 		del_gendisk(D_S[j].disk);
 		put_disk(D_S[j].disk);
-		devfs_remove("sbp/c0t%d", j);
 		vfree(D_S[j].sbp_buf);
 		if (D_S[j].sbp_audsiz>0) vfree(D_S[j].aud_buf);
 		if ((unregister_cdrom(D_S[j].sbpcd_infop) == -EINVAL))
@@ -5919,7 +5918,6 @@ static void sbpcd_exit(void)
 		}
 		vfree(D_S[j].sbpcd_infop);
 	}
-	devfs_remove("sbp");
 	msg(DBG_INF, "%s module released.\n", major_name);
 }
 
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -532,7 +532,6 @@ static void __exit dsp56k_cleanup_driver
 	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
 	class_destroy(dsp56k_class);
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
-	devfs_remove("dsp56k");
 }
 module_exit(dsp56k_cleanup_driver);
 
diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -354,7 +354,6 @@ static void __exit dtlk_cleanup (void)
 
 	dtlk_write_tts(DTLK_CLEAR);
 	unregister_chrdev(dtlk_major, "dtlk");
-	devfs_remove("dtlk");
 	release_region(dtlk_port_lpc, DTLK_IO_EXTENT);
 }
 
diff --git a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -362,17 +362,11 @@ static void zft_exit(void)
 		TRACE(ft_t_info, "successful");
 	}
         for (i = 0; i < 4; i++) {
-		devfs_remove("qft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i));
-		devfs_remove("nqft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4));
-		devfs_remove("zqft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16));
-		devfs_remove("nzqft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20));
-		devfs_remove("rawqft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32));
-		devfs_remove("nrawqft%i", i);
 		class_device_destroy(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36));
 	}
 	class_destroy(zft_class);
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -415,9 +415,7 @@ cleanup_module(void)
 			/* free io addresses and Tibet */
 			release_region( ip2config.addr[i], 8 );
 			class_device_destroy(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i));
-			devfs_remove("ip2/ipl%d", i);
 			class_device_destroy(ip2_class, MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
-			devfs_remove("ip2/stat%d", i);
 		}
 		/* Disable and remove interrupt handler. */
 		if ( (ip2config.irq[i] > 0) && have_requested_irq(ip2config.irq[i]) ) {	
@@ -426,7 +424,6 @@ cleanup_module(void)
 		}
 	}
 	class_destroy(ip2_class);
-	devfs_remove("ip2");
 	if ( ( err = tty_unregister_driver ( ip2_tty_driver ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister tty driver (%d)\n", err);
 	}
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -532,7 +532,6 @@ static void ipmi_new_smi(int if_num)
 static void ipmi_smi_gone(int if_num)
 {
 	class_device_destroy(ipmi_class, MKDEV(ipmi_major, if_num));
-	devfs_remove("ipmidev/%d", if_num);
 }
 
 static struct ipmi_smi_watcher smi_watcher =
@@ -585,7 +584,6 @@ static __exit void cleanup_ipmi(void)
 {
 	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
-	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);
 }
 module_exit(cleanup_ipmi);
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -852,11 +852,8 @@ static void __exit istallion_module_exit
 		return;
 	}
 	put_tty_driver(stli_serial);
-	for (i = 0; i < 4; i++) {
-		devfs_remove("staliomem/%d", i);
+	for (i = 0; i < 4; i++)
 		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, i));
-	}
-	devfs_remove("staliomem");
 	class_destroy(istallion_class);
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -929,7 +929,6 @@ static int __init lp_init (void)
 out_class:
 	class_destroy(lp_class);
 out_devfs:
-	devfs_remove("printers");
 	unregister_chrdev(LP_MAJOR, "lp");
 	return err;
 }
@@ -977,10 +976,8 @@ static void lp_cleanup_module (void)
 		if (lp_table[offset].dev == NULL)
 			continue;
 		parport_unregister_device(lp_table[offset].dev);
-		devfs_remove("printers/%d", offset);
 		class_device_destroy(lp_class, MKDEV(LP_MAJOR, offset));
 	}
-	devfs_remove("printers");
 	class_destroy(lp_class);
 }
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -275,7 +275,6 @@ int misc_deregister(struct miscdevice * 
 	down(&misc_sem);
 	list_del(&misc->list);
 	class_device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
-	devfs_remove(misc->devfs_name);
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
 	}
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -769,7 +769,7 @@ static struct parport_driver pp_driver =
 
 static int __init ppdev_init (void)
 {
-	int i, err = 0;
+	int err = 0;
 
 	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
@@ -790,9 +790,6 @@ static int __init ppdev_init (void)
 	goto out;
 
 out_class:
-	for (i = 0; i < PARPORT_MAX; i++)
-		devfs_remove("parports/%d", i);
-	devfs_remove("parports");
 	class_destroy(ppdev_class);
 out_chrdev:
 	unregister_chrdev(PP_MAJOR, CHRDEV);
@@ -802,12 +799,8 @@ out:
 
 static void __exit ppdev_cleanup (void)
 {
-	int i;
 	/* Clean up all parport stuff */
-	for (i = 0; i < PARPORT_MAX; i++)
-		devfs_remove("parports/%d", i);
 	parport_unregister_driver(&pp_driver);
-	devfs_remove("parports");
 	class_destroy(ppdev_class);
 	unregister_chrdev (PP_MAJOR, CHRDEV);
 }
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -317,12 +317,6 @@ error:
 
 static void __exit raw_exit(void)
 {
-	int i;
-
-	for (i = 1; i < MAX_RAW_MINORS; i++)
-		devfs_remove("raw/raw%d", i);
-	devfs_remove("raw/rawctl");
-	devfs_remove("raw");
 	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
 	class_destroy(raw_class);
 	cdev_del(&raw_cdev);
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -775,11 +775,8 @@ static void __exit stallion_module_exit(
 		restore_flags(flags);
 		return;
 	}
-	for (i = 0; i < 4; i++) {
-		devfs_remove("staliomem/%d", i);
+	for (i = 0; i < 4; i++)
 		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
-	}
-	devfs_remove("staliomem");
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -527,10 +527,8 @@ tipar_cleanup_module(void)
 			continue;
 		parport_unregister_device(table[i].dev);
 		class_device_destroy(tipar_class, MKDEV(TIPAR_MAJOR, i));
-		devfs_remove("ticables/par/%d", i);
 	}
 	class_destroy(tipar_class);
-	devfs_remove("ticables/par");
 
 	pr_info("tipar: module unloaded\n");
 }
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2697,7 +2697,6 @@ void tty_register_device(struct tty_driv
  */
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
-	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
 	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
 }
 
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -483,8 +483,6 @@ void vcs_make_devfs(struct tty_struct *t
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
-	devfs_remove("vcc/%u", tty->index + 1);
-	devfs_remove("vcc/a%u", tty->index + 1);
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
 }
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -971,8 +971,6 @@ static int viotape_remove(struct vio_dev
 {
 	int i = vdev->unit_address;
 
-	devfs_remove("iseries/nvt%d", i);
-	devfs_remove("iseries/vt%d", i);
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80));
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i));
 	return 0;
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -464,7 +464,6 @@ static int i2cdev_detach_adapter(struct 
 		return -ENODEV;
 
 	init_completion(&i2c_dev->released);
-	devfs_remove("i2c/%d", i2c_dev->minor);
 	return_i2c_dev(i2c_dev);
 	class_device_unregister(&i2c_dev->class_dev);
 	wait_for_completion(&i2c_dev->released);
@@ -535,7 +534,6 @@ static void __exit i2c_dev_exit(void)
 {
 	i2c_del_driver(&i2cdev_driver);
 	class_unregister(&i2c_dev_class);
-	devfs_remove("i2c");
 	unregister_chrdev(I2C_MAJOR,"i2c");
 }
 
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1308,10 +1308,8 @@ static void drive_release_dev (struct de
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
 	spin_lock_irq(&ide_lock);
-	if (drive->devfs_name[0] != '\0') {
-		devfs_remove(drive->devfs_name);
+	if (drive->devfs_name[0] != '\0')
 		drive->devfs_name[0] = '\0';
-	}
 	ide_remove_drive_from_hwgroup(drive);
 	if (drive->id != NULL) {
 		kfree(drive->id);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4705,8 +4705,6 @@ static void ide_tape_release(struct kref
 
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
-	devfs_remove("%s/mt", drive->devfs_name);
-	devfs_remove("%s/mtn", drive->devfs_name);
 	idetape_devs[tape->minor] = NULL;
 	g->private_data = NULL;
 	put_disk(g);
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -594,10 +594,8 @@ void ide_unregister(unsigned int index)
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present) {
-			if (drive->devfs_name[0] != '\0') {
-				devfs_remove(drive->devfs_name);
+			if (drive->devfs_name[0] != '\0')
 				drive->devfs_name[0] = '\0';
-			}
 			continue;
 		}
 		spin_unlock_irq(&ide_lock);
@@ -1997,7 +1995,6 @@ void cleanup_module (void)
 #ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
 #endif
-	devfs_remove("ide");
 
 	bus_unregister(&ide_bus_type);
 }
diff --git a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c
+++ b/drivers/ieee1394/amdtp.c
@@ -1242,12 +1242,6 @@ static void amdtp_add_host(struct hpsb_h
 
 static void amdtp_remove_host(struct hpsb_host *host)
 {
-	struct amdtp_host *ah = hpsb_get_hostinfo(&amdtp_highlevel, host);
-
-	if (ah)
-		devfs_remove("amdtp/%d", ah->host->id);
-
-	return;
 }
 
 static struct hpsb_highlevel amdtp_highlevel = {
@@ -1284,7 +1278,6 @@ static int __init amdtp_init_module (voi
 static void __exit amdtp_exit_module (void)
 {
         hpsb_unregister_highlevel(&amdtp_highlevel);
-	devfs_remove("amdtp");
 	cdev_del(&amdtp_cdev);
 
 	HPSB_INFO("Unloaded AMDTP driver");
diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2296,7 +2296,6 @@ static void dv1394_un_init(struct video_
 		(video->mode == MODE_RECEIVE ? "in" : "out")
 		);
 
-	devfs_remove("ieee1394/%s", buf);
 	kfree(video);
 }
 
@@ -2333,9 +2332,6 @@ static void dv1394_remove_host (struct h
 
 	class_device_destroy(hpsb_protocol_class,
 		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)));
-	devfs_remove("ieee1394/dv/host%d/NTSC", id);
-	devfs_remove("ieee1394/dv/host%d/PAL", id);
-	devfs_remove("ieee1394/dv/host%d", id);
 }
 
 static void dv1394_add_host (struct hpsb_host *host)
@@ -2611,7 +2607,6 @@ static void __exit dv1394_exit_module(vo
 
 	hpsb_unregister_highlevel(&dv1394_highlevel);
 	cdev_del(&dv1394_cdev);
-	devfs_remove("ieee1394/dv");
 }
 
 static int __init dv1394_init_module(void)
@@ -2633,7 +2628,6 @@ static int __init dv1394_init_module(voi
 	if (ret) {
 		printk(KERN_ERR "dv1394: failed to register protocol\n");
 		hpsb_unregister_highlevel(&dv1394_highlevel);
-		devfs_remove("ieee1394/dv");
 		cdev_del(&dv1394_cdev);
 		return ret;
 	}
diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -1095,7 +1095,7 @@ static int __init ieee1394_init(void)
 	ret = bus_register(&ieee1394_bus_type);
 	if (ret < 0) {
 		HPSB_INFO("bus register failed");
-		goto release_devfs;
+		goto release_chardev;
 	}
 
 	for (i = 0; fw_bus_attrs[i]; i++) {
@@ -1106,7 +1106,7 @@ static int __init ieee1394_init(void)
 						fw_bus_attrs[i--]);
 			}
 			bus_unregister(&ieee1394_bus_type);
-			goto release_devfs;
+			goto release_chardev;
 		}
 	}
 
@@ -1159,8 +1159,7 @@ release_all_bus:
 	for (i = 0; fw_bus_attrs[i]; i++)
 		bus_remove_file(&ieee1394_bus_type, fw_bus_attrs[i]);
 	bus_unregister(&ieee1394_bus_type);
-release_devfs:
-	devfs_remove("ieee1394");
+release_chardev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
 	if (khpsbpkt_pid >= 0) {
@@ -1197,7 +1196,6 @@ static void __exit ieee1394_cleanup(void
 	hpsb_cleanup_config_roms();
 
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
-	devfs_remove("ieee1394");
 }
 
 module_init(ieee1394_init);
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -2929,7 +2929,6 @@ static int __init init_raw1394(void)
 	goto out;
 
 out_dev:
-	devfs_remove(RAW1394_DEVICE_NAME);
 	class_device_destroy(hpsb_protocol_class,
 		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
 out_unreg:
@@ -2943,7 +2942,6 @@ static void __exit cleanup_raw1394(void)
 	class_device_destroy(hpsb_protocol_class,
 		MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16));
 	cdev_del(&raw1394_cdev);
-	devfs_remove(RAW1394_DEVICE_NAME);
 	hpsb_unregister_highlevel(&raw1394_highlevel);
 	hpsb_unregister_protocol(&raw1394_driver);
 }
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -1380,12 +1380,10 @@ static void video1394_remove_host (struc
 {
 	struct ti_ohci *ohci = hpsb_get_hostinfo(&video1394_highlevel, host);
 
-	if (ohci) {
+	if (ohci)
 		class_device_destroy(hpsb_protocol_class, MKDEV(IEEE1394_MAJOR,
 			IEEE1394_MINOR_BLOCK_VIDEO1394 * 16 + ohci->host->id));
-		devfs_remove("%s/%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
-	}
-	
+
 	return;
 }
 
@@ -1529,7 +1527,6 @@ static void __exit video1394_exit_module
 
 	hpsb_unregister_highlevel(&video1394_highlevel);
 
-	devfs_remove(VIDEO1394_DRIVER_NAME);
 	cdev_del(&video1394_cdev);
 
 	PRINT_G(KERN_INFO, "Removed " VIDEO1394_DRIVER_NAME " module");
@@ -1554,7 +1551,6 @@ static int __init video1394_init_module 
 	if (ret) {
 		PRINT_G(KERN_ERR, "video1394: failed to register protocol");
 		hpsb_unregister_highlevel(&video1394_highlevel);
-		devfs_remove(VIDEO1394_DRIVER_NAME);
 		cdev_del(&video1394_cdev);
 		return ret;
 	}
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -443,7 +443,6 @@ static void evdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
-	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
 	if (evdev->open) {
diff --git a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -730,7 +730,6 @@ static void __exit input_exit(void)
 	remove_proc_entry("handlers", proc_bus_input_dir);
 	remove_proc_entry("input", proc_bus);
 
-	devfs_remove("input");
 	unregister_chrdev(INPUT_MAJOR, "input");
 	class_destroy(input_class);
 }
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -463,7 +463,6 @@ static void joydev_disconnect(struct inp
 	struct joydev_list *list;
 
 	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
-	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
 	if (joydev->open) {
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -659,7 +659,6 @@ static void mousedev_disconnect(struct i
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
-	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
 	if (mousedev->open) {
@@ -751,7 +750,6 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	devfs_remove("input/mice");
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -424,8 +424,6 @@ static void tsdev_disconnect(struct inpu
 
 	class_device_destroy(input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
-	devfs_remove("input/ts%d", tsdev->minor);
-	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1540,7 +1540,6 @@ static void __exit capi_exit(void)
 	class_device_destroy(capi_class, MKDEV(capi_major, 0));
 	class_destroy(capi_class);
 	unregister_chrdev(capi_major, "capi20");
-	devfs_remove("isdn/capi20");
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	capinc_tty_exit();
diff --git a/drivers/isdn/hardware/eicon/divamnt.c b/drivers/isdn/hardware/eicon/divamnt.c
--- a/drivers/isdn/hardware/eicon/divamnt.c
+++ b/drivers/isdn/hardware/eicon/divamnt.c
@@ -178,7 +178,6 @@ static struct file_operations divas_main
 
 static void divas_maint_unregister_chrdev(void)
 {
-	devfs_remove(DEVNAME);
 	unregister_chrdev(major, DEVNAME);
 }
 
diff --git a/drivers/isdn/hardware/eicon/divasi.c b/drivers/isdn/hardware/eicon/divasi.c
--- a/drivers/isdn/hardware/eicon/divasi.c
+++ b/drivers/isdn/hardware/eicon/divasi.c
@@ -145,7 +145,6 @@ static struct file_operations divas_idi_
 
 static void divas_idi_unregister_chrdev(void)
 {
-	devfs_remove(DEVNAME);
 	unregister_chrdev(major, DEVNAME);
 }
 
diff --git a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -678,7 +678,6 @@ static struct file_operations divas_fops
 
 static void divas_unregister_chrdev(void)
 {
-	devfs_remove(DEVNAME);
 	unregister_chrdev(major, DEVNAME);
 }
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -72,7 +72,6 @@ static int dm_hash_init(void)
 static void dm_hash_exit(void)
 {
 	dm_hash_remove_all();
-	devfs_remove(DM_DIR);
 }
 
 /*-----------------------------------------------------------------
@@ -173,15 +172,6 @@ static void free_cell(struct hash_cell *
 }
 
 /*
- * devfs stuff.
- */
-static int unregister_with_devfs(struct hash_cell *hc)
-{
-	devfs_remove(DM_DIR"/%s", hc->name);
-	return 0;
-}
-
-/*
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
  */
@@ -229,7 +219,6 @@ static void __hash_remove(struct hash_ce
 	/* remove from the dev hash */
 	list_del(&hc->uuid_list);
 	list_del(&hc->name_list);
-	unregister_with_devfs(hc);
 	dm_set_mdptr(hc->md, NULL);
 	dm_put(hc->md);
 	if (hc->new_map)
@@ -294,8 +283,6 @@ static int dm_hash_rename(const char *ol
 	/*
 	 * rename and move the name cell.
 	 */
-	unregister_with_devfs(hc);
-
 	list_del(&hc->name_list);
 	old_name = hc->name;
 	hc->name = new_name;
diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3689,15 +3689,9 @@ static __exit void md_exit(void)
 {
 	mddev_t *mddev;
 	struct list_head *tmp;
-	int i;
+
 	blk_unregister_region(MKDEV(MAJOR_NR,0), MAX_MD_DEVS);
 	blk_unregister_region(MKDEV(mdp_major,0), MAX_MD_DEVS << MdpMinorShift);
-	for (i=0; i < MAX_MD_DEVS; i++)
-		devfs_remove("md/%d", i);
-	for (i=0; i < MAX_MD_DEVS; i++)
-		devfs_remove("md/d%d", i);
-
-	devfs_remove("md");
 
 	unregister_blkdev(MAJOR_NR,"md");
 	unregister_blkdev(mdp_major, "mdp");
diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -248,9 +248,6 @@ void dvb_unregister_device(struct dvb_de
 	if (!dvbdev)
 		return;
 
-	devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
-			dnames[dvbdev->type], dvbdev->id);
-
 	class_device_destroy(dvb_class, MKDEV(DVB_MAJOR, nums2minor(dvbdev->adapter->num,
 					dvbdev->type, dvbdev->id)));
 
@@ -313,8 +310,6 @@ EXPORT_SYMBOL(dvb_register_adapter);
 
 int dvb_unregister_adapter(struct dvb_adapter *adap)
 {
-	devfs_remove("dvb/adapter%d", adap->num);
-
 	if (down_interruptible (&dvbdev_register_lock))
 		return -ERESTARTSYS;
 	list_del (&adap->list_head);
@@ -420,7 +415,6 @@ error:
 
 static void __exit exit_dvbdev(void)
 {
-        devfs_remove("dvb");
 	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
         unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -366,7 +366,6 @@ void video_unregister_device(struct vide
 	if(video_device[vfd->minor]!=vfd)
 		panic("videodev: bad unregister");
 
-	devfs_remove(vfd->devfs_name);
 	video_device[vfd->minor]=NULL;
 	class_device_unregister(&vfd->class_dev);
 	up(&videodev_lock);
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -497,7 +497,6 @@ static int __init mmc_blk_init(void)
 static void __exit mmc_blk_exit(void)
 {
 	mmc_unregister_driver(&mmc_driver);
-	devfs_remove("mmc");
 	unregister_blkdev(major, "mmc");
 }
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -443,7 +443,6 @@ int deregister_mtd_blktrans(struct mtd_b
 		tr->remove_dev(dev);
 	}
 
-	devfs_remove(tr->name);
 	blk_cleanup_queue(tr->blkcore_priv->rq);
 	unregister_blkdev(tr->major, tr->name);
 
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -2646,7 +2646,6 @@ static void __exit ppp_cleanup(void)
 	cardmap_destroy(&all_ppp_units);
 	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
-	devfs_remove("ppp");
 	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
 	class_destroy(ppp_class);
 }
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -418,12 +418,9 @@ static void __exit cosa_exit(void)
 	int i;
 	printk(KERN_INFO "Unloading the cosa module\n");
 
-	for (i=0; i<nr_cards; i++) {
+	for (i=0; i<nr_cards; i++)
 		class_device_destroy(cosa_class, MKDEV(cosa_major, i));
-		devfs_remove("cosa/%d", i);
-	}
 	class_destroy(cosa_class);
-	devfs_remove("cosa");
 	for (cosa=cosa_cards; nr_cards--; cosa++) {
 		/* Clean up the per-channel data */
 		for (i=0; i<cosa->nchannels; i++) {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1742,7 +1742,6 @@ dasd_exit(void)
 	dasd_ioctl_exit();
 	dasd_gendisk_exit();
 	dasd_devmap_exit();
-	devfs_remove("dasd");
 	if (dasd_debug_area != NULL) {
 		debug_unregister(dasd_debug_area);
 		dasd_debug_area = NULL;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -478,7 +478,6 @@ static int __init xpram_setup_blkdev(voi
 
 	return 0;
 out_unreg:
-	devfs_remove("slram");
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 out:
 	while (i--)
@@ -497,7 +496,6 @@ static void __exit xpram_exit(void)
 		put_disk(xpram_disks[i]);
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
-	devfs_remove("slram");
 	blk_cleanup_queue(xpram_queue);
 	sysdev_unregister(&xpram_sys_device);
 	sysdev_class_unregister(&xpram_sysclass);
diff --git a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c
+++ b/drivers/sbus/char/bpp.c
@@ -1056,9 +1056,6 @@ static void __exit bpp_cleanup(void)
 {
 	unsigned idx;
 
-	for (idx = 0; idx < BPP_NO; idx++)
-		devfs_remove("bpp/%d", idx);
-	devfs_remove("bpp");
 	unregister_chrdev(BPP_MAJOR, dev_name);
 
 	for (idx = 0;  idx < BPP_NO; idx++) {
diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -713,7 +713,6 @@ static void deinit_vfc_device(struct vfc
 {
 	if(dev == NULL)
 		return;
-	devfs_remove("vfc/%d", dev->instance);
 	sbus_iounmap((unsigned long)dev->regs, sizeof(struct vfc_regs));
 	kfree(dev);
 }
@@ -727,7 +726,6 @@ void cleanup_module(void)
 	for (devp = vfc_dev_lst; *devp; devp++)
 		deinit_vfc_device(*devp);
 
-	devfs_remove("vfc");
 	kfree(vfc_dev_lst);
 	return;
 }
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -972,7 +972,6 @@ static int ch_remove(struct device *dev)
 
 	class_device_destroy(ch_sysfs_class,
 			     MKDEV(SCSI_CHANGER_MAJOR,ch->minor));
-	devfs_remove(ch->name);
 	kfree(ch->dt);
 	kfree(ch);
 	ch_devcount--;
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -107,8 +107,6 @@ static struct osst_dev_parm {
 };
 #endif
 
-static char *osst_formats[ST_NBR_MODES] ={"", "l", "m", "a"};
-
 /* Some default definitions have been moved to osst_options.h */
 #define OSST_BUFFER_SIZE (OSST_BUFFER_BLOCKS * ST_KILOBYTE)
 #define OSST_WRITE_THRESHOLD (OSST_WRITE_THRESHOLD_BLOCKS * ST_KILOBYTE)
@@ -5821,7 +5819,7 @@ static int osst_remove(struct device *de
 {
 	struct scsi_device * SDp = to_scsi_device(dev);
 	struct osst_tape * tpnt;
-	int i, mode;
+	int i;
 
 	if ((SDp->type != TYPE_TAPE) || (osst_nr_dev <= 0))
 		return 0;
@@ -5832,10 +5830,6 @@ static int osst_remove(struct device *de
 			osst_sysfs_destroy(MKDEV(OSST_MAJOR, i));
 			osst_sysfs_destroy(MKDEV(OSST_MAJOR, i+128));
 			tpnt->device = NULL;
-			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-				devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
-				devfs_remove("%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
-			}
 			put_disk(tpnt->drive);
 			os_scsi_tapes[i] = NULL;
 			osst_nr_dev--;
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -1363,7 +1363,6 @@ static void __exit exit_scsi(void)
 	scsi_exit_sysctl();
 	scsi_exit_hosts();
 	scsi_exit_devinfo();
-	devfs_remove("scsi");
 	scsi_exit_procfs();
 	scsi_exit_queue();
 	unregister_scsi_cpu();
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1540,10 +1540,8 @@ sg_add(struct class_device *cl_dev)
 	sdp = sg_dev_arr[k];
 
 	error = cdev_add(cdev, MKDEV(SCSI_GENERIC_MAJOR, k), 1);
-	if (error) {
-		devfs_remove("%s/generic", scsidp->devfs_name);
+	if (error)
 		goto out;
-	}
 	sdp->cdev = cdev;
 	if (sg_sysfs_valid) {
 		struct class_device * sg_class_member;
@@ -1636,7 +1634,6 @@ sg_remove(struct class_device *cl_dev)
 		class_device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, k));
 		cdev_del(sdp->cdev);
 		sdp->cdev = NULL;
-		devfs_remove("%s/generic", scsidp->devfs_name);
 		put_disk(sdp->disk);
 		sdp->disk = NULL;
 		if (NULL == sdp->headfp)
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4052,8 +4052,6 @@ static int st_remove(struct device *dev)
 					  "tape");
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 				j = mode << (4 - ST_NBR_MODE_BITS);
-				devfs_remove("%s/mt%s", SDp->devfs_name, st_formats[j]);
-				devfs_remove("%s/mt%sn", SDp->devfs_name, st_formats[j]);
 				for (j=0; j < 2; j++) {
 					class_device_destroy(st_sysfs_class,
 							     MKDEV(SCSI_TAPE_MAJOR,
diff --git a/drivers/telephony/phonedev.c b/drivers/telephony/phonedev.c
--- a/drivers/telephony/phonedev.c
+++ b/drivers/telephony/phonedev.c
@@ -122,7 +122,6 @@ void phone_unregister_device(struct phon
 	down(&phone_lock);
 	if (phone_device[pfd->minor] != pfd)
 		panic("phone: bad unregister");
-	devfs_remove("phone/%d", pfd->minor);
 	phone_device[pfd->minor] = NULL;
 	up(&phone_lock);
 }
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -95,7 +95,6 @@ out:
 void usb_major_cleanup(void)
 {
 	class_destroy(usb_class);
-	devfs_remove("usb");
 	unregister_chrdev(USB_MAJOR, "usb");
 }
 
@@ -174,7 +173,6 @@ int usb_register_dev(struct usb_interfac
 		spin_lock (&minor_lock);
 		usb_minors[intf->minor] = NULL;
 		spin_unlock (&minor_lock);
-		devfs_remove (name);
 		retval = PTR_ERR(intf->class_dev);
 	}
 exit:
@@ -217,7 +215,6 @@ void usb_deregister_dev(struct usb_inter
 	spin_unlock (&minor_lock);
 
 	snprintf(name, BUS_ID_SIZE, class_driver->name, intf->minor - minor_base);
-	devfs_remove (name);
 	class_device_destroy(usb_class, MKDEV(USB_MAJOR, intf->minor));
 	intf->class_dev = NULL;
 	intf->minor = -1;
diff --git a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c
+++ b/drivers/usb/input/hiddev.c
@@ -839,5 +839,4 @@ int __init hiddev_init(void)
 void hiddev_exit(void)
 {
 	usb_deregister(&hiddev_driver);
-	devfs_remove("usb/hid");
 }
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1124,7 +1124,6 @@ unregister_framebuffer(struct fb_info *f
 	i = fb_info->node;
 	if (!registered_fb[i])
 		return -EINVAL;
-	devfs_remove("fb/%d", i);
 
 	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -414,12 +414,9 @@ static int __init init_coda(void)
 	}
 	return 0;
 out:
-	for (i = 0; i < MAX_CODADEVS; i++) {
+	for (i = 0; i < MAX_CODADEVS; i++)
 		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
-		devfs_remove("coda/%d", i);
-	}
 	class_destroy(coda_psdev_class);
-	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 	coda_sysctl_clean();
 out1:
@@ -436,12 +433,9 @@ static void __exit exit_coda(void)
         if ( err != 0 ) {
                 printk("coda: failed to unregister filesystem\n");
         }
-	for (i = 0; i < MAX_CODADEVS; i++) {
+	for (i = 0; i < MAX_CODADEVS; i++)
 		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
-		devfs_remove("coda/%d", i);
-	}
 	class_destroy(coda_psdev_class);
-	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 	coda_sysctl_clean();
 	coda_destroy_inodecache();
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -274,7 +274,6 @@ void delete_partition(struct gendisk *di
 	p->start_sect = 0;
 	p->nr_sects = 0;
 	p->reads = p->writes = p->read_sectors = p->write_sectors = 0;
-	devfs_remove("%s/part%d", disk->devfs_name, part);
 	kobject_unregister(&p->kobj);
 }
 
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h
+++ b/include/linux/devfs_fs_kernel.h
@@ -7,7 +7,4 @@
 #include <linux/types.h>
 #include <asm/semaphore.h>
 
-static inline void devfs_remove(const char *fmt, ...)
-{
-}
 #endif				/*  _LINUX_DEVFS_FS_KERNEL_H  */
diff --git a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -254,8 +254,6 @@ int snd_unregister_device(int type, snd_
 		return -EINVAL;
 	}
 
-	if (strncmp(mptr->name, "controlC", 8) || card->number >= cards_limit) /* created in sound.c */
-		devfs_remove("snd/%s", mptr->name);
 	class_device_destroy(sound_class, MKDEV(major, minor));
 
 	list_del(&mptr->list);
@@ -334,14 +332,12 @@ static int __init alsa_sound_init(void)
 		return err;
 	if (register_chrdev(major, "alsa", &snd_fops)) {
 		snd_printk(KERN_ERR "unable to register native major device number %d\n", major);
-		devfs_remove("snd");
 		return -EIO;
 	}
 	snd_memory_init();
 	if (snd_info_init() < 0) {
 		snd_memory_done();
 		unregister_chrdev(major, "alsa");
-		devfs_remove("snd");
 		return -ENOMEM;
 	}
 	snd_info_minor_register();
@@ -353,17 +349,11 @@ static int __init alsa_sound_init(void)
 
 static void __exit alsa_sound_exit(void)
 {
-	short controlnum;
-
-	for (controlnum = 0; controlnum < cards_limit; controlnum++)
-		devfs_remove("snd/controlC%d", controlnum);
-
 	snd_info_minor_unregister();
 	snd_info_done();
 	snd_memory_done();
 	if (unregister_chrdev(major, "alsa") != 0)
 		snd_printk(KERN_ERR "unable to unregister major device number %d\n", major);
-	devfs_remove("snd");
 }
 
 module_init(alsa_sound_init)
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -588,14 +588,11 @@ static void __exit oss_cleanup(void)
 	int i, j;
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		devfs_remove("sound/%s", dev_list[i].name);
 		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
-		for (j = 1; j < *dev_list[i].num; j++) {
-			devfs_remove("sound/%s%d", dev_list[i].name, j);
+		for (j = 1; j < *dev_list[i].num; j++)
 			class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
-		}
 	}
 	
 	unregister_sound_special(1);
diff --git a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -195,7 +195,6 @@ static void sound_remove_unit(struct sou
 	p = __sound_remove_unit(list, unit);
 	spin_unlock(&sound_loader_lock);
 	if (p) {
-		devfs_remove(p->name);
 		class_device_destroy(sound_class, MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
@@ -559,7 +558,6 @@ static void __exit cleanup_soundcore(voi
 	/* We have nothing to really do here - we know the lists must be
 	   empty */
 	unregister_chrdev(SOUND_MAJOR, "sound");
-	devfs_remove("sound");
 	class_destroy(sound_class);
 }
 

