Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWAFKqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWAFKqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAFKp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16275 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964908AbWAFKpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:51 -0500
Subject: [patch 6/7] Unlinline a bunch of other functions
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:43:46 +0100
Message-Id: <1136544226.2940.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: uninline: misc
From: Arjan van de Ven <arjan@infradead.org>

Remove the "inline" keyword from a bunch of big functions in the kernel
with the goal of shrinking it by 30kb to 40kb

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/acpi/ec.c                             |    2 -
 drivers/base/firmware_class.c                 |    2 -
 drivers/block/loop.c                          |    2 -
 drivers/bluetooth/hci_bcsp.c                  |    2 -
 drivers/char/drm/r128_state.c                 |    2 -
 drivers/cpufreq/cpufreq.c                     |    7 +---
 drivers/ide/ide-cd.c                          |    4 +-
 drivers/ide/ide-disk.c                        |    2 -
 drivers/ide/ide-taskfile.c                    |    2 -
 drivers/infiniband/core/cm.c                  |    4 +-
 drivers/isdn/hisax/avm_pci.c                  |    2 -
 drivers/isdn/hisax/diva.c                     |    2 -
 drivers/isdn/hisax/hscx_irq.c                 |    4 +-
 drivers/isdn/hisax/jade_irq.c                 |    2 -
 drivers/md/bitmap.c                           |    2 -
 drivers/md/dm-crypt.c                         |    2 -
 drivers/md/dm-ioctl.c                         |    4 +-
 drivers/md/dm-snap.c                          |    2 -
 drivers/md/dm.c                               |    2 -
 drivers/md/raid1.c                            |    4 +-
 drivers/md/raid10.c                           |    4 +-
 drivers/md/raid5.c                            |   10 +++---
 drivers/md/raid6main.c                        |    8 ++--
 drivers/media/video/cx25840/cx25840-audio.c   |    2 -
 drivers/media/video/tvp5150.c                 |    2 -
 drivers/message/fusion/mptlan.c               |    4 +-
 drivers/mtd/devices/doc2000.c                 |    2 -
 drivers/mtd/devices/doc2001.c                 |    2 -
 drivers/mtd/devices/doc2001plus.c             |    2 -
 drivers/mtd/nand/diskonchip.c                 |    2 -
 drivers/net/e100.c                            |   20 ++++++------
 drivers/net/sb1000.c                          |    4 +-
 drivers/net/wireless/hostap/hostap_80211_rx.c |   10 +++---
 drivers/net/wireless/hostap/hostap_hw.c       |    8 ++--
 drivers/net/wireless/ipw2100.c                |   26 ++++++++--------
 drivers/net/wireless/ipw2200.c                |   42 +++++++++++++-------------
 drivers/net/wireless/wavelan.c                |   38 +++++++++++------------
 drivers/scsi/aic7xxx/aic79xx_core.c           |    7 +---
 drivers/scsi/aic7xxx_old.c                    |    4 +-
 drivers/scsi/iscsi_tcp.c                      |    2 -
 drivers/scsi/libata-core.c                    |    6 +--
 drivers/scsi/megaraid/megaraid_mbox.c         |   10 +++---
 drivers/scsi/megaraid/megaraid_sas.c          |   18 +++++------
 drivers/scsi/sr.c                             |    4 +-
 drivers/usb/atm/usbatm.c                      |    4 +-
 drivers/usb/class/audio.c                     |    2 -
 drivers/video/matrox/matroxfb_maven.c         |    2 -
 fs/9p/conv.c                                  |    2 -
 fs/binfmt_elf.c                               |    4 +-
 fs/binfmt_misc.c                              |    2 -
 fs/bio.c                                      |    4 +-
 fs/buffer.c                                   |    6 +--
 fs/compat.c                                   |    4 +-
 fs/dcache.c                                   |    4 +-
 fs/exec.c                                     |    6 +--
 fs/fcntl.c                                    |    2 -
 fs/jffs2/build.c                              |    2 -
 fs/jffs2/nodelist.c                           |    4 +-
 fs/lockd/xdr.c                                |    6 +--
 fs/locks.c                                    |    2 -
 fs/mbcache.c                                  |    6 +--
 fs/namei.c                                    |    8 ++--
 fs/nfsd/nfsxdr.c                              |    4 +-
 fs/pipe.c                                     |    4 +-
 kernel/cpuset.c                               |    2 -
 kernel/exit.c                                 |   10 +++---
 kernel/posix-timers.c                         |    8 ++--
 kernel/sched.c                                |   16 ++++-----
 kernel/signal.c                               |    4 +-
 kernel/workqueue.c                            |    2 -
 net/ieee80211/ieee80211_module.c              |    4 +-
 net/ieee80211/ieee80211_rx.c                  |   14 ++++----
 net/ieee80211/ieee80211_tx.c                  |    4 +-
 net/ieee80211/ieee80211_wx.c                  |    2 -
 net/netfilter/nfnetlink.c                     |    2 -
 security/selinux/avc.c                        |    4 +-
 security/selinux/hooks.c                      |    6 +--
 sound/oss/esssolo1.c                          |    2 -
 sound/pci/es1968.c                            |    2 -
 79 files changed, 224 insertions(+), 228 deletions(-)

Index: linux-gcc.q/drivers/acpi/ec.c
===================================================================
--- linux-gcc.q.orig/drivers/acpi/ec.c
+++ linux-gcc.q/drivers/acpi/ec.c
@@ -153,7 +153,7 @@ static int acpi_ec_polling_mode = EC_POL
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static inline u32 acpi_ec_read_status(union acpi_ec *ec)
+static u32 acpi_ec_read_status(union acpi_ec *ec)
 {
 	u32 status = 0;
 
Index: linux-gcc.q/drivers/base/firmware_class.c
===================================================================
--- linux-gcc.q.orig/drivers/base/firmware_class.c
+++ linux-gcc.q/drivers/base/firmware_class.c
@@ -47,7 +47,7 @@ struct firmware_priv {
 	struct timer_list timeout;
 };
 
-static inline void
+static void
 fw_load_abort(struct firmware_priv *fw_priv)
 {
 	set_bit(FW_STATUS_ABORT, &fw_priv->status);
Index: linux-gcc.q/drivers/block/loop.c
===================================================================
--- linux-gcc.q.orig/drivers/block/loop.c
+++ linux-gcc.q/drivers/block/loop.c
@@ -281,7 +281,7 @@ fail:
  * This helper just factors out common code between do_lo_send_direct_write()
  * and do_lo_send_write().
  */
-static inline int __do_lo_send_write(struct file *file,
+static int __do_lo_send_write(struct file *file,
 		u8 __user *buf, const int len, loff_t pos)
 {
 	ssize_t bw;
Index: linux-gcc.q/drivers/bluetooth/hci_bcsp.c
===================================================================
--- linux-gcc.q.orig/drivers/bluetooth/hci_bcsp.c
+++ linux-gcc.q/drivers/bluetooth/hci_bcsp.c
@@ -494,7 +494,7 @@ static inline void bcsp_unslip_one_byte(
 	}
 }
 
-static inline void bcsp_complete_rx_pkt(struct hci_uart *hu)
+static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 {
 	struct bcsp_struct *bcsp = hu->priv;
 	int pass_up;
Index: linux-gcc.q/drivers/char/drm/r128_state.c
===================================================================
--- linux-gcc.q.orig/drivers/char/drm/r128_state.c
+++ linux-gcc.q/drivers/char/drm/r128_state.c
@@ -220,7 +220,7 @@ static __inline__ void r128_emit_tex1(dr
 	ADVANCE_RING();
 }
 
-static __inline__ void r128_emit_state(drm_r128_private_t * dev_priv)
+static void r128_emit_state(drm_r128_private_t * dev_priv)
 {
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	unsigned int dirty = sarea_priv->dirty;
Index: linux-gcc.q/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-gcc.q.orig/drivers/cpufreq/cpufreq.c
+++ linux-gcc.q/drivers/cpufreq/cpufreq.c
@@ -41,7 +41,6 @@ static DEFINE_SPINLOCK(cpufreq_driver_lo
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static void handle_update(void *data);
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci);
 
 /**
  * Two notifier lists: the "policy" list is involved in the 
@@ -127,7 +126,7 @@ static unsigned int debug_ratelimit = 1;
 static unsigned int disable_ratelimit = 1;
 static DEFINE_SPINLOCK(disable_ratelimit_lock);
 
-static inline void cpufreq_debug_enable_ratelimit(void)
+static void cpufreq_debug_enable_ratelimit(void)
 {
 	unsigned long flags;
 
@@ -137,7 +136,7 @@ static inline void cpufreq_debug_enable_
 	spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
 }
 
-static inline void cpufreq_debug_disable_ratelimit(void)
+static void cpufreq_debug_disable_ratelimit(void)
 {
 	unsigned long flags;
 
@@ -206,7 +205,7 @@ static inline void cpufreq_debug_disable
 static unsigned long l_p_j_ref;
 static unsigned int  l_p_j_ref_freq;
 
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 {
 	if (ci->flags & CPUFREQ_CONST_LOOPS)
 		return;
Index: linux-gcc.q/drivers/ide/ide-cd.c
===================================================================
--- linux-gcc.q.orig/drivers/ide/ide-cd.c
+++ linux-gcc.q/drivers/ide/ide-cd.c
@@ -980,7 +980,7 @@ static void cdrom_buffer_sectors (ide_dr
  * and attempt to recover if there are problems.  Returns  0 if everything's
  * ok; nonzero if the request has been terminated.
  */
-static inline
+static
 int cdrom_read_check_ireason (ide_drive_t *drive, int len, int ireason)
 {
 	if (ireason == 2)
@@ -1541,7 +1541,7 @@ int cdrom_queue_packet_command(ide_drive
 /*
  * Write handling
  */
-static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
+static int cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
 {
 	/* Two notes about IDE interrupt reason here - 0 means that
 	 * the drive wants to receive data from us, 2 means that
Index: linux-gcc.q/drivers/ide/ide-disk.c
===================================================================
--- linux-gcc.q.orig/drivers/ide/ide-disk.c
+++ linux-gcc.q/drivers/ide/ide-disk.c
@@ -477,7 +477,7 @@ static inline int idedisk_supports_lba48
 	       && id->lba_capacity_2;
 }
 
-static inline void idedisk_check_hpa(ide_drive_t *drive)
+static void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
 	int lba48 = idedisk_supports_lba48(drive->id);
Index: linux-gcc.q/drivers/ide/ide-taskfile.c
===================================================================
--- linux-gcc.q.orig/drivers/ide/ide-taskfile.c
+++ linux-gcc.q/drivers/ide/ide-taskfile.c
@@ -308,7 +308,7 @@ static void ide_pio_multi(ide_drive_t *d
 		ide_pio_sector(drive, write);
 }
 
-static inline void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
+static void ide_pio_datablock(ide_drive_t *drive, struct request *rq,
 				     unsigned int write)
 {
 	if (rq->bio)	/* fs request */
Index: linux-gcc.q/drivers/infiniband/core/cm.c
===================================================================
--- linux-gcc.q.orig/drivers/infiniband/core/cm.c
+++ linux-gcc.q/drivers/infiniband/core/cm.c
@@ -850,7 +850,7 @@ static void cm_format_req(struct cm_req_
 		       param->private_data_len);
 }
 
-static inline int cm_validate_req_param(struct ib_cm_req_param *param)
+static int cm_validate_req_param(struct ib_cm_req_param *param)
 {
 	/* peer-to-peer not supported */
 	if (param->peer_to_peer)
@@ -999,7 +999,7 @@ static inline int cm_is_active_peer(__be
 		 (be32_to_cpu(local_qpn) > be32_to_cpu(remote_qpn))));
 }
 
-static inline void cm_format_paths_from_req(struct cm_req_msg *req_msg,
+static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 					    struct ib_sa_path_rec *primary_path,
 					    struct ib_sa_path_rec *alt_path)
 {
Index: linux-gcc.q/drivers/isdn/hisax/avm_pci.c
===================================================================
--- linux-gcc.q.orig/drivers/isdn/hisax/avm_pci.c
+++ linux-gcc.q/drivers/isdn/hisax/avm_pci.c
@@ -358,7 +358,7 @@ hdlc_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 HDLC_irq(struct BCState *bcs, u_int stat) {
 	int len;
 	struct sk_buff *skb;
Index: linux-gcc.q/drivers/isdn/hisax/diva.c
===================================================================
--- linux-gcc.q.orig/drivers/isdn/hisax/diva.c
+++ linux-gcc.q/drivers/isdn/hisax/diva.c
@@ -476,7 +476,7 @@ Memhscx_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 Memhscx_interrupt(struct IsdnCardState *cs, u_char val, u_char hscx)
 {
 	u_char r;
Index: linux-gcc.q/drivers/isdn/hisax/hscx_irq.c
===================================================================
--- linux-gcc.q.orig/drivers/isdn/hisax/hscx_irq.c
+++ linux-gcc.q/drivers/isdn/hisax/hscx_irq.c
@@ -119,7 +119,7 @@ hscx_fill_fifo(struct BCState *bcs)
 	}
 }
 
-static inline void
+static void
 hscx_interrupt(struct IsdnCardState *cs, u_char val, u_char hscx)
 {
 	u_char r;
@@ -221,7 +221,7 @@ hscx_interrupt(struct IsdnCardState *cs,
 	}
 }
 
-static inline void
+static void
 hscx_int_main(struct IsdnCardState *cs, u_char val)
 {
 
Index: linux-gcc.q/drivers/isdn/hisax/jade_irq.c
===================================================================
--- linux-gcc.q.orig/drivers/isdn/hisax/jade_irq.c
+++ linux-gcc.q/drivers/isdn/hisax/jade_irq.c
@@ -110,7 +110,7 @@ jade_fill_fifo(struct BCState *bcs)
 }
 
 
-static inline void
+static void
 jade_interrupt(struct IsdnCardState *cs, u_char val, u_char jade)
 {
 	u_char r;
Index: linux-gcc.q/drivers/md/bitmap.c
===================================================================
--- linux-gcc.q.orig/drivers/md/bitmap.c
+++ linux-gcc.q/drivers/md/bitmap.c
@@ -200,7 +200,7 @@ out:
 /* if page is completely empty, put it back on the free list, or dealloc it */
 /* if page was hijacked, unmark the flag so it might get alloced next time */
 /* Note: lock should be held when calling this */
-static inline void bitmap_checkfree(struct bitmap *bitmap, unsigned long page)
+static void bitmap_checkfree(struct bitmap *bitmap, unsigned long page)
 {
 	char *ptr;
 
Index: linux-gcc.q/drivers/md/dm-crypt.c
===================================================================
--- linux-gcc.q.orig/drivers/md/dm-crypt.c
+++ linux-gcc.q/drivers/md/dm-crypt.c
@@ -228,7 +228,7 @@ static struct crypt_iv_operations crypt_
 };
 
 
-static inline int
+static int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
                           struct scatterlist *in, unsigned int length,
                           int write, sector_t sector)
Index: linux-gcc.q/drivers/md/dm-ioctl.c
===================================================================
--- linux-gcc.q.orig/drivers/md/dm-ioctl.c
+++ linux-gcc.q/drivers/md/dm-ioctl.c
@@ -588,7 +588,7 @@ static int dev_create(struct dm_ioctl *p
 /*
  * Always use UUID for lookups if it's present, otherwise use name or dev.
  */
-static inline struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
+static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
 	if (*param->uuid)
 		return __get_uuid_cell(param->uuid);
@@ -598,7 +598,7 @@ static inline struct hash_cell *__find_d
 		return dm_get_mdptr(huge_decode_dev(param->dev));
 }
 
-static inline struct mapped_device *find_device(struct dm_ioctl *param)
+static struct mapped_device *find_device(struct dm_ioctl *param)
 {
 	struct hash_cell *hc;
 	struct mapped_device *md = NULL;
Index: linux-gcc.q/drivers/md/dm-snap.c
===================================================================
--- linux-gcc.q.orig/drivers/md/dm-snap.c
+++ linux-gcc.q/drivers/md/dm-snap.c
@@ -677,7 +677,7 @@ static void copy_callback(int read_err, 
 /*
  * Dispatches the copy operation to kcopyd.
  */
-static inline void start_copy(struct pending_exception *pe)
+static void start_copy(struct pending_exception *pe)
 {
 	struct dm_snapshot *s = pe->snap;
 	struct io_region src, dest;
Index: linux-gcc.q/drivers/md/dm.c
===================================================================
--- linux-gcc.q.orig/drivers/md/dm.c
+++ linux-gcc.q/drivers/md/dm.c
@@ -292,7 +292,7 @@ struct dm_table *dm_get_table(struct map
  * Decrements the number of outstanding ios that a bio has been
  * cloned into, completing the original io if necc.
  */
-static inline void dec_pending(struct dm_io *io, int error)
+static void dec_pending(struct dm_io *io, int error)
 {
 	if (error)
 		io->error = error;
Index: linux-gcc.q/drivers/md/raid1.c
===================================================================
--- linux-gcc.q.orig/drivers/md/raid1.c
+++ linux-gcc.q/drivers/md/raid1.c
@@ -158,7 +158,7 @@ static void put_all_bios(conf_t *conf, r
 	}
 }
 
-static inline void free_r1bio(r1bio_t *r1_bio)
+static void free_r1bio(r1bio_t *r1_bio)
 {
 	unsigned long flags;
 
@@ -179,7 +179,7 @@ static inline void free_r1bio(r1bio_t *r
 	mempool_free(r1_bio, conf->r1bio_pool);
 }
 
-static inline void put_buf(r1bio_t *r1_bio)
+static void put_buf(r1bio_t *r1_bio)
 {
 	conf_t *conf = mddev_to_conf(r1_bio->mddev);
 	unsigned long flags;
Index: linux-gcc.q/drivers/md/raid10.c
===================================================================
--- linux-gcc.q.orig/drivers/md/raid10.c
+++ linux-gcc.q/drivers/md/raid10.c
@@ -173,7 +173,7 @@ static void put_all_bios(conf_t *conf, r
 	}
 }
 
-static inline void free_r10bio(r10bio_t *r10_bio)
+static void free_r10bio(r10bio_t *r10_bio)
 {
 	unsigned long flags;
 
@@ -194,7 +194,7 @@ static inline void free_r10bio(r10bio_t 
 	mempool_free(r10_bio, conf->r10bio_pool);
 }
 
-static inline void put_buf(r10bio_t *r10_bio)
+static void put_buf(r10bio_t *r10_bio)
 {
 	conf_t *conf = mddev_to_conf(r10_bio->mddev);
 	unsigned long flags;
Index: linux-gcc.q/drivers/md/raid5.c
===================================================================
--- linux-gcc.q.orig/drivers/md/raid5.c
+++ linux-gcc.q/drivers/md/raid5.c
@@ -71,7 +71,7 @@
 
 static void print_raid5_conf (raid5_conf_t *conf);
 
-static inline void __release_stripe(raid5_conf_t *conf, struct stripe_head *sh)
+static void __release_stripe(raid5_conf_t *conf, struct stripe_head *sh)
 {
 	if (atomic_dec_and_test(&sh->count)) {
 		if (!list_empty(&sh->lru))
@@ -125,7 +125,7 @@ static void remove_hash(struct stripe_he
 	}
 }
 
-static __inline__ void insert_hash(raid5_conf_t *conf, struct stripe_head *sh)
+static void insert_hash(raid5_conf_t *conf, struct stripe_head *sh)
 {
 	struct stripe_head **shp = &stripe_hash(conf, sh->sector);
 
@@ -188,7 +188,7 @@ static int grow_buffers(struct stripe_he
 
 static void raid5_build_block (struct stripe_head *sh, int i);
 
-static inline void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx)
+static void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx)
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = conf->raid_disks, i;
@@ -1421,7 +1421,7 @@ static void handle_stripe(struct stripe_
 	}
 }
 
-static inline void raid5_activate_delayed(raid5_conf_t *conf)
+static void raid5_activate_delayed(raid5_conf_t *conf)
 {
 	if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD) {
 		while (!list_empty(&conf->delayed_list)) {
@@ -1437,7 +1437,7 @@ static inline void raid5_activate_delaye
 	}
 }
 
-static inline void activate_bit_delay(raid5_conf_t *conf)
+static void activate_bit_delay(raid5_conf_t *conf)
 {
 	/* device_lock is held */
 	struct list_head head;
Index: linux-gcc.q/drivers/md/raid6main.c
===================================================================
--- linux-gcc.q.orig/drivers/md/raid6main.c
+++ linux-gcc.q/drivers/md/raid6main.c
@@ -90,7 +90,7 @@ static inline int raid6_next_disk(int di
 
 static void print_raid6_conf (raid6_conf_t *conf);
 
-static inline void __release_stripe(raid6_conf_t *conf, struct stripe_head *sh)
+static void __release_stripe(raid6_conf_t *conf, struct stripe_head *sh)
 {
 	if (atomic_dec_and_test(&sh->count)) {
 		if (!list_empty(&sh->lru))
@@ -207,7 +207,7 @@ static int grow_buffers(struct stripe_he
 
 static void raid6_build_block (struct stripe_head *sh, int i);
 
-static inline void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx)
+static void init_stripe(struct stripe_head *sh, sector_t sector, int pd_idx)
 {
 	raid6_conf_t *conf = sh->raid_conf;
 	int disks = conf->raid_disks, i;
@@ -1501,7 +1501,7 @@ static void handle_stripe(struct stripe_
 	}
 }
 
-static inline void raid6_activate_delayed(raid6_conf_t *conf)
+static void raid6_activate_delayed(raid6_conf_t *conf)
 {
 	if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD) {
 		while (!list_empty(&conf->delayed_list)) {
@@ -1517,7 +1517,7 @@ static inline void raid6_activate_delaye
 	}
 }
 
-static inline void activate_bit_delay(raid6_conf_t *conf)
+static void activate_bit_delay(raid6_conf_t *conf)
 {
 	/* device_lock is held */
 	struct list_head head;
Index: linux-gcc.q/drivers/media/video/cx25840/cx25840-audio.c
===================================================================
--- linux-gcc.q.orig/drivers/media/video/cx25840/cx25840-audio.c
+++ linux-gcc.q/drivers/media/video/cx25840/cx25840-audio.c
@@ -23,7 +23,7 @@
 
 #include "cx25840.h"
 
-inline static int set_audclk_freq(struct i2c_client *client,
+static int set_audclk_freq(struct i2c_client *client,
 				 enum v4l2_audio_clock_freq freq)
 {
 	struct cx25840_state *state = i2c_get_clientdata(client);
Index: linux-gcc.q/drivers/media/video/tvp5150.c
===================================================================
--- linux-gcc.q.orig/drivers/media/video/tvp5150.c
+++ linux-gcc.q/drivers/media/video/tvp5150.c
@@ -87,7 +87,7 @@ struct tvp5150 {
 	int sat;
 };
 
-static inline int tvp5150_read(struct i2c_client *c, unsigned char addr)
+static int tvp5150_read(struct i2c_client *c, unsigned char addr)
 {
 	unsigned char buffer[1];
 	int rc;
Index: linux-gcc.q/drivers/message/fusion/mptlan.c
===================================================================
--- linux-gcc.q.orig/drivers/message/fusion/mptlan.c
+++ linux-gcc.q/drivers/message/fusion/mptlan.c
@@ -848,7 +848,7 @@ mpt_lan_sdu_send (struct sk_buff *skb, s
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-static inline void
+static void
 mpt_lan_wake_post_buckets_task(struct net_device *dev, int priority)
 /*
  * @priority: 0 = put it on the timer queue, 1 = put it on the immediate queue
@@ -870,7 +870,7 @@ mpt_lan_wake_post_buckets_task(struct ne
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-static inline int
+static int
 mpt_lan_receive_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	struct mpt_lan_priv *priv = dev->priv;
Index: linux-gcc.q/drivers/mtd/devices/doc2000.c
===================================================================
--- linux-gcc.q.orig/drivers/mtd/devices/doc2000.c
+++ linux-gcc.q/drivers/mtd/devices/doc2000.c
@@ -138,7 +138,7 @@ static inline int DoC_WaitReady(struct D
    bypass the internal pipeline. Each of 4 delay cycles (read from the NOP register) is
    required after writing to CDSN Control register, see Software Requirement 11.4 item 3. */
 
-static inline int DoC_Command(struct DiskOnChip *doc, unsigned char command,
+static int DoC_Command(struct DiskOnChip *doc, unsigned char command,
 			      unsigned char xtraflags)
 {
 	void __iomem *docptr = doc->virtadr;
Index: linux-gcc.q/drivers/mtd/devices/doc2001.c
===================================================================
--- linux-gcc.q.orig/drivers/mtd/devices/doc2001.c
+++ linux-gcc.q/drivers/mtd/devices/doc2001.c
@@ -103,7 +103,7 @@ static inline int DoC_WaitReady(void __i
    with the internal pipeline. Each of 4 delay cycles (read from the NOP register) is
    required after writing to CDSN Control register, see Software Requirement 11.4 item 3. */
 
-static inline void DoC_Command(void __iomem * docptr, unsigned char command,
+static void DoC_Command(void __iomem * docptr, unsigned char command,
 			       unsigned char xtraflags)
 {
 	/* Assert the CLE (Command Latch Enable) line to the flash chip */
Index: linux-gcc.q/drivers/mtd/devices/doc2001plus.c
===================================================================
--- linux-gcc.q.orig/drivers/mtd/devices/doc2001plus.c
+++ linux-gcc.q/drivers/mtd/devices/doc2001plus.c
@@ -118,7 +118,7 @@ static inline void DoC_CheckASIC(void __
 /* DoC_Command: Send a flash command to the flash chip through the Flash
  * command register. Need 2 Write Pipeline Terminates to complete send.
  */
-static inline void DoC_Command(void __iomem * docptr, unsigned char command,
+static void DoC_Command(void __iomem * docptr, unsigned char command,
 			       unsigned char xtraflags)
 {
 	WriteDOC(command, docptr, Mplus_FlashCmd);
Index: linux-gcc.q/drivers/mtd/nand/diskonchip.c
===================================================================
--- linux-gcc.q.orig/drivers/mtd/nand/diskonchip.c
+++ linux-gcc.q/drivers/mtd/nand/diskonchip.c
@@ -1506,7 +1506,7 @@ static inline int __init doc2001plus_ini
 	return 1;
 }
 
-static inline int __init doc_probe(unsigned long physadr)
+static int __init doc_probe(unsigned long physadr)
 {
 	unsigned char ChipID;
 	struct mtd_info *mtd;
Index: linux-gcc.q/drivers/net/e100.c
===================================================================
--- linux-gcc.q.orig/drivers/net/e100.c
+++ linux-gcc.q/drivers/net/e100.c
@@ -587,7 +587,7 @@ static inline void e100_write_flush(stru
 	(void)readb(&nic->csr->scb.status);
 }
 
-static inline void e100_enable_irq(struct nic *nic)
+static void e100_enable_irq(struct nic *nic)
 {
 	unsigned long flags;
 
@@ -597,7 +597,7 @@ static inline void e100_enable_irq(struc
 	e100_write_flush(nic);
 }
 
-static inline void e100_disable_irq(struct nic *nic)
+static void e100_disable_irq(struct nic *nic)
 {
 	unsigned long flags;
 
@@ -786,7 +786,7 @@ static int e100_eeprom_save(struct nic *
 
 #define E100_WAIT_SCB_TIMEOUT 20000 /* we might have to wait 100ms!!! */
 #define E100_WAIT_SCB_FAST 20       /* delay like the old code */
-static inline int e100_exec_cmd(struct nic *nic, u8 cmd, dma_addr_t dma_addr)
+static int e100_exec_cmd(struct nic *nic, u8 cmd, dma_addr_t dma_addr)
 {
 	unsigned long flags;
 	unsigned int i;
@@ -817,7 +817,7 @@ err_unlock:
 	return err;
 }
 
-static inline int e100_exec_cb(struct nic *nic, struct sk_buff *skb,
+static int e100_exec_cb(struct nic *nic, struct sk_buff *skb,
 	void (*cb_prepare)(struct nic *, struct cb *, struct sk_buff *))
 {
 	struct cb *cb;
@@ -1542,7 +1542,7 @@ static void e100_watchdog(unsigned long 
 	mod_timer(&nic->watchdog, jiffies + E100_WATCHDOG_PERIOD);
 }
 
-static inline void e100_xmit_prepare(struct nic *nic, struct cb *cb,
+static void e100_xmit_prepare(struct nic *nic, struct cb *cb,
 	struct sk_buff *skb)
 {
 	cb->command = nic->tx_command;
@@ -1592,7 +1592,7 @@ static int e100_xmit_frame(struct sk_buf
 	return 0;
 }
 
-static inline int e100_tx_clean(struct nic *nic)
+static int e100_tx_clean(struct nic *nic)
 {
 	struct cb *cb;
 	int tx_cleaned = 0;
@@ -1687,7 +1687,7 @@ static int e100_alloc_cbs(struct nic *ni
 	return 0;
 }
 
-static inline void e100_start_receiver(struct nic *nic, struct rx *rx)
+static void e100_start_receiver(struct nic *nic, struct rx *rx)
 {
 	if(!nic->rxs) return;
 	if(RU_SUSPENDED != nic->ru_running) return;
@@ -1703,7 +1703,7 @@ static inline void e100_start_receiver(s
 }
 
 #define RFD_BUF_LEN (sizeof(struct rfd) + VLAN_ETH_FRAME_LEN)
-static inline int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
+static int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
 {
 	if(!(rx->skb = dev_alloc_skb(RFD_BUF_LEN + NET_IP_ALIGN)))
 		return -ENOMEM;
@@ -1737,7 +1737,7 @@ static inline int e100_rx_alloc_skb(stru
 	return 0;
 }
 
-static inline int e100_rx_indicate(struct nic *nic, struct rx *rx,
+static int e100_rx_indicate(struct nic *nic, struct rx *rx,
 	unsigned int *work_done, unsigned int work_to_do)
 {
 	struct sk_buff *skb = rx->skb;
@@ -1797,7 +1797,7 @@ static inline int e100_rx_indicate(struc
 	return 0;
 }
 
-static inline void e100_rx_clean(struct nic *nic, unsigned int *work_done,
+static void e100_rx_clean(struct nic *nic, unsigned int *work_done,
 	unsigned int work_to_do)
 {
 	struct rx *rx;
Index: linux-gcc.q/drivers/net/sb1000.c
===================================================================
--- linux-gcc.q.orig/drivers/net/sb1000.c
+++ linux-gcc.q/drivers/net/sb1000.c
@@ -94,7 +94,7 @@ static inline int card_wait_for_busy_cle
 	const char* name);
 static inline int card_wait_for_ready(const int ioaddr[], const char* name,
 	unsigned char in[]);
-static inline int card_send_command(const int ioaddr[], const char* name,
+static int card_send_command(const int ioaddr[], const char* name,
 	const unsigned char out[], unsigned char in[]);
 
 /* SB1000 hardware routines to be used during frame rx interrupt */
@@ -309,7 +309,7 @@ card_wait_for_ready(const int ioaddr[], 
 }
 
 /* Card Send Command (cannot be used during an interrupt) */
-static inline int
+static int
 card_send_command(const int ioaddr[], const char* name,
 	const unsigned char out[], unsigned char in[])
 {
Index: linux-gcc.q/drivers/net/wireless/hostap/hostap_80211_rx.c
===================================================================
--- linux-gcc.q.orig/drivers/net/wireless/hostap/hostap_80211_rx.c
+++ linux-gcc.q/drivers/net/wireless/hostap/hostap_80211_rx.c
@@ -435,7 +435,7 @@ static void hostap_rx_sta_beacon(local_i
 }
 
 
-static inline int
+static int
 hostap_rx_frame_mgmt(local_info_t *local, struct sk_buff *skb,
 		     struct hostap_80211_rx_status *rx_stats, u16 type,
 		     u16 stype)
@@ -499,7 +499,7 @@ hostap_rx_frame_mgmt(local_info_t *local
 
 
 /* Called only as a tasklet (software IRQ) */
-static inline struct net_device *prism2_rx_get_wds(local_info_t *local,
+static struct net_device *prism2_rx_get_wds(local_info_t *local,
 						   u8 *addr)
 {
 	struct hostap_interface *iface = NULL;
@@ -519,7 +519,7 @@ static inline struct net_device *prism2_
 }
 
 
-static inline int
+static int
 hostap_rx_frame_wds(local_info_t *local, struct ieee80211_hdr_4addr *hdr,
 		    u16 fc, struct net_device **wds)
 {
@@ -615,7 +615,7 @@ static int hostap_is_eapol_frame(local_i
 
 
 /* Called only as a tasklet (software IRQ) */
-static inline int
+static int
 hostap_rx_frame_decrypt(local_info_t *local, struct sk_buff *skb,
 			struct ieee80211_crypt_data *crypt)
 {
@@ -654,7 +654,7 @@ hostap_rx_frame_decrypt(local_info_t *lo
 
 
 /* Called only as a tasklet (software IRQ) */
-static inline int
+static int
 hostap_rx_frame_decrypt_msdu(local_info_t *local, struct sk_buff *skb,
 			     int keyidx, struct ieee80211_crypt_data *crypt)
 {
Index: linux-gcc.q/drivers/net/wireless/hostap/hostap_hw.c
===================================================================
--- linux-gcc.q.orig/drivers/net/wireless/hostap/hostap_hw.c
+++ linux-gcc.q/drivers/net/wireless/hostap/hostap_hw.c
@@ -253,7 +253,7 @@ static void prism2_clear_cmd_queue(local
  * @dev: pointer to net_device
  * @entry: Prism2 command queue entry to be issued
  */
-static inline int hfa384x_cmd_issue(struct net_device *dev,
+static int hfa384x_cmd_issue(struct net_device *dev,
 				    struct hostap_cmd_queue *entry)
 {
 	struct hostap_interface *iface;
@@ -743,7 +743,7 @@ static void prism2_cmd_ev(struct net_dev
 }
 
 
-static inline int hfa384x_wait_offset(struct net_device *dev, u16 o_off)
+static int hfa384x_wait_offset(struct net_device *dev, u16 o_off)
 {
 	int tries = HFA384X_BAP_BUSY_TIMEOUT;
 	int res = HFA384X_INW(o_off) & HFA384X_OFFSET_BUSY;
@@ -1904,7 +1904,7 @@ fail:
  * and will try to get the correct fid eventually. */
 #define EXTRA_FID_READ_TESTS
 
-static inline u16 prism2_read_fid_reg(struct net_device *dev, u16 reg)
+static u16 prism2_read_fid_reg(struct net_device *dev, u16 reg)
 {
 #ifdef EXTRA_FID_READ_TESTS
 	u16 val, val2, val3;
@@ -2581,7 +2581,7 @@ static void prism2_ev_tick(struct net_de
 
 
 /* Called only from hardware IRQ */
-static inline void prism2_check_magic(local_info_t *local)
+static void prism2_check_magic(local_info_t *local)
 {
 	/* at least PCI Prism2.5 with bus mastering seems to sometimes
 	 * return 0x0000 in SWSUPPORT0 for unknown reason, but re-reading the
Index: linux-gcc.q/drivers/net/wireless/ipw2100.c
===================================================================
--- linux-gcc.q.orig/drivers/net/wireless/ipw2100.c
+++ linux-gcc.q/drivers/net/wireless/ipw2100.c
@@ -411,7 +411,7 @@ static inline void write_nic_dword_auto_
 	write_register(dev, IPW_REG_AUTOINCREMENT_DATA, val);
 }
 
-static inline void write_nic_memory(struct net_device *dev, u32 addr, u32 len,
+static void write_nic_memory(struct net_device *dev, u32 addr, u32 len,
 				    const u8 * buf)
 {
 	u32 aligned_addr;
@@ -449,7 +449,7 @@ static inline void write_nic_memory(stru
 				    *buf);
 }
 
-static inline void read_nic_memory(struct net_device *dev, u32 addr, u32 len,
+static void read_nic_memory(struct net_device *dev, u32 addr, u32 len,
 				   u8 * buf)
 {
 	u32 aligned_addr;
@@ -657,7 +657,7 @@ static void printk_buf(int level, const 
 
 #define MAX_RESET_BACKOFF 10
 
-static inline void schedule_reset(struct ipw2100_priv *priv)
+static void schedule_reset(struct ipw2100_priv *priv)
 {
 	unsigned long now = get_seconds();
 
@@ -1130,7 +1130,7 @@ static inline void ipw2100_hw_set_gpio(s
 	write_register(priv->net_dev, IPW_REG_GPIO, reg);
 }
 
-static inline int rf_kill_active(struct ipw2100_priv *priv)
+static int rf_kill_active(struct ipw2100_priv *priv)
 {
 #define MAX_RF_KILL_CHECKS 5
 #define RF_KILL_CHECK_DELAY 40
@@ -2177,7 +2177,7 @@ static const char *frame_types[] = {
 };
 #endif
 
-static inline int ipw2100_alloc_skb(struct ipw2100_priv *priv,
+static int ipw2100_alloc_skb(struct ipw2100_priv *priv,
 				    struct ipw2100_rx_packet *packet)
 {
 	packet->skb = dev_alloc_skb(sizeof(struct ipw2100_rx));
@@ -2201,7 +2201,7 @@ static inline int ipw2100_alloc_skb(stru
 #define SEARCH_SNAPSHOT 1
 
 #define SNAPSHOT_ADDR(ofs) (priv->snapshot[((ofs) >> 12) & 0xff] + ((ofs) & 0xfff))
-static inline int ipw2100_snapshot_alloc(struct ipw2100_priv *priv)
+static int ipw2100_snapshot_alloc(struct ipw2100_priv *priv)
 {
 	int i;
 	if (priv->snapshot[0])
@@ -2221,7 +2221,7 @@ static inline int ipw2100_snapshot_alloc
 	return 1;
 }
 
-static inline void ipw2100_snapshot_free(struct ipw2100_priv *priv)
+static void ipw2100_snapshot_free(struct ipw2100_priv *priv)
 {
 	int i;
 	if (!priv->snapshot[0])
@@ -2231,7 +2231,7 @@ static inline void ipw2100_snapshot_free
 	priv->snapshot[0] = NULL;
 }
 
-static inline u32 ipw2100_match_buf(struct ipw2100_priv *priv, u8 * in_buf,
+static u32 ipw2100_match_buf(struct ipw2100_priv *priv, u8 * in_buf,
 				    size_t len, int mode)
 {
 	u32 i, j;
@@ -2288,7 +2288,7 @@ static inline u32 ipw2100_match_buf(stru
 static u8 packet_data[IPW_RX_NIC_BUFFER_LENGTH];
 #endif
 
-static inline void ipw2100_corruption_detected(struct ipw2100_priv *priv, int i)
+static void ipw2100_corruption_detected(struct ipw2100_priv *priv, int i)
 {
 #ifdef CONFIG_IPW_DEBUG_C3
 	struct ipw2100_status *status = &priv->status_queue.drv[i];
@@ -2346,7 +2346,7 @@ static inline void ipw2100_corruption_de
 	schedule_reset(priv);
 }
 
-static inline void isr_rx(struct ipw2100_priv *priv, int i,
+static void isr_rx(struct ipw2100_priv *priv, int i,
 			  struct ieee80211_rx_stats *stats)
 {
 	struct ipw2100_status *status = &priv->status_queue.drv[i];
@@ -2425,7 +2425,7 @@ static inline void isr_rx(struct ipw2100
 	priv->rx_queue.drv[i].host_addr = packet->dma_addr;
 }
 
-static inline int ipw2100_corruption_check(struct ipw2100_priv *priv, int i)
+static int ipw2100_corruption_check(struct ipw2100_priv *priv, int i)
 {
 	struct ipw2100_status *status = &priv->status_queue.drv[i];
 	struct ipw2100_rx *u = priv->rx_buffers[i].rxp;
@@ -2481,7 +2481,7 @@ static inline int ipw2100_corruption_che
  * The WRITE index is cached in the variable 'priv->rx_queue.next'.
  *
  */
-static inline void __ipw2100_rx_process(struct ipw2100_priv *priv)
+static void __ipw2100_rx_process(struct ipw2100_priv *priv)
 {
 	struct ipw2100_bd_queue *rxq = &priv->rx_queue;
 	struct ipw2100_status_queue *sq = &priv->status_queue;
@@ -2634,7 +2634,7 @@ static inline void __ipw2100_rx_process(
  * for use by future command and data packets.
  *
  */
-static inline int __ipw2100_tx_process(struct ipw2100_priv *priv)
+static int __ipw2100_tx_process(struct ipw2100_priv *priv)
 {
 	struct ipw2100_bd_queue *txq = &priv->tx_queue;
 	struct ipw2100_bd *tbd;
Index: linux-gcc.q/drivers/net/wireless/ipw2200.c
===================================================================
--- linux-gcc.q.orig/drivers/net/wireless/ipw2200.c
+++ linux-gcc.q/drivers/net/wireless/ipw2200.c
@@ -813,7 +813,7 @@ static void ipw_bg_led_link_off(void *da
 	up(&priv->sem);
 }
 
-static inline void __ipw_led_activity_on(struct ipw_priv *priv)
+static void __ipw_led_activity_on(struct ipw_priv *priv)
 {
 	u32 led;
 
@@ -1508,7 +1508,7 @@ static ssize_t store_direct_dword(struct
 static DEVICE_ATTR(direct_dword, S_IWUSR | S_IRUGO,
 		   show_direct_dword, store_direct_dword);
 
-static inline int rf_kill_active(struct ipw_priv *priv)
+static int rf_kill_active(struct ipw_priv *priv)
 {
 	if (0 == (ipw_read32(priv, 0x30) & 0x10000))
 		priv->status |= STATUS_RF_KILL_HW;
@@ -2359,7 +2359,7 @@ static inline void eeprom_write_reg(stru
 }
 
 /* perform a chip select operation */
-static inline void eeprom_cs(struct ipw_priv *priv)
+static void eeprom_cs(struct ipw_priv *priv)
 {
 	eeprom_write_reg(priv, 0);
 	eeprom_write_reg(priv, EEPROM_BIT_CS);
@@ -2368,7 +2368,7 @@ static inline void eeprom_cs(struct ipw_
 }
 
 /* perform a chip select operation */
-static inline void eeprom_disable_cs(struct ipw_priv *priv)
+static void eeprom_disable_cs(struct ipw_priv *priv)
 {
 	eeprom_write_reg(priv, EEPROM_BIT_CS);
 	eeprom_write_reg(priv, 0);
@@ -2475,7 +2475,7 @@ static void ipw_eeprom_init_sram(struct 
 	IPW_DEBUG_TRACE("<<\n");
 }
 
-static inline void ipw_zero_memory(struct ipw_priv *priv, u32 start, u32 count)
+static void ipw_zero_memory(struct ipw_priv *priv, u32 start, u32 count)
 {
 	count >>= 2;
 	if (!count)
@@ -2772,7 +2772,7 @@ static inline int ipw_alive(struct ipw_p
 	return ipw_read32(priv, 0x90) == 0xd55555d5;
 }
 
-static inline int ipw_poll_bit(struct ipw_priv *priv, u32 addr, u32 mask,
+static int ipw_poll_bit(struct ipw_priv *priv, u32 addr, u32 mask,
 			       int timeout)
 {
 	int i = 0;
@@ -3150,7 +3150,7 @@ static int ipw_get_fw(struct ipw_priv *p
 
 #define IPW_RX_BUF_SIZE (3000)
 
-static inline void ipw_rx_queue_reset(struct ipw_priv *priv,
+static void ipw_rx_queue_reset(struct ipw_priv *priv,
 				      struct ipw_rx_queue *rxq)
 {
 	unsigned long flags;
@@ -3608,7 +3608,7 @@ static void ipw_tx_queue_free(struct ipw
 	ipw_queue_tx_free(priv, &priv->txq[3]);
 }
 
-static inline void ipw_create_bssid(struct ipw_priv *priv, u8 * bssid)
+static void ipw_create_bssid(struct ipw_priv *priv, u8 * bssid)
 {
 	/* First 3 bytes are manufacturer */
 	bssid[0] = priv->mac_addr[0];
@@ -3622,7 +3622,7 @@ static inline void ipw_create_bssid(stru
 	bssid[0] |= 0x02;	/* set local assignment bit (IEEE802) */
 }
 
-static inline u8 ipw_add_station(struct ipw_priv *priv, u8 * bssid)
+static u8 ipw_add_station(struct ipw_priv *priv, u8 * bssid)
 {
 	struct ipw_station_entry entry;
 	int i;
@@ -3655,7 +3655,7 @@ static inline u8 ipw_add_station(struct 
 	return i;
 }
 
-static inline u8 ipw_find_station(struct ipw_priv *priv, u8 * bssid)
+static u8 ipw_find_station(struct ipw_priv *priv, u8 * bssid)
 {
 	int i;
 
@@ -3794,7 +3794,7 @@ static void inline average_init(struct a
 	memset(avg, 0, sizeof(*avg));
 }
 
-static void inline average_add(struct average *avg, s16 val)
+static void average_add(struct average *avg, s16 val)
 {
 	avg->sum -= avg->entries[avg->pos];
 	avg->sum += val;
@@ -3805,7 +3805,7 @@ static void inline average_add(struct av
 	}
 }
 
-static s16 inline average_value(struct average *avg)
+static s16 average_value(struct average *avg)
 {
 	if (!unlikely(avg->init)) {
 		if (avg->pos)
@@ -3847,7 +3847,7 @@ static void ipw_reset_stats(struct ipw_p
 
 }
 
-static inline u32 ipw_get_max_rate(struct ipw_priv *priv)
+static u32 ipw_get_max_rate(struct ipw_priv *priv)
 {
 	u32 i = 0x80000000;
 	u32 mask = priv->rates_mask;
@@ -4087,7 +4087,7 @@ static void ipw_bg_gather_stats(void *da
  * roaming_threshold -> disassociate_threshold, scan and roam for better signal.
  * Above disassociate threshold, give up and stop scanning.
  * Roaming is disabled if disassociate_threshold <= roaming_threshold  */
-static inline void ipw_handle_missed_beacon(struct ipw_priv *priv,
+static void ipw_handle_missed_beacon(struct ipw_priv *priv,
 					    int missed_count)
 {
 	priv->notif_missed_beacons = missed_count;
@@ -4157,7 +4157,7 @@ static inline void ipw_handle_missed_bea
  * Handle host notification packet.
  * Called from interrupt routine
  */
-static inline void ipw_rx_notification(struct ipw_priv *priv,
+static void ipw_rx_notification(struct ipw_priv *priv,
 				       struct ipw_rx_notification *notif)
 {
 	notif->size = le16_to_cpu(notif->size);
@@ -5096,7 +5096,7 @@ static int ipw_compatible_rates(struct i
 	return 1;
 }
 
-static inline void ipw_copy_rates(struct ipw_supported_rates *dest,
+static void ipw_copy_rates(struct ipw_supported_rates *dest,
 				  const struct ipw_supported_rates *src)
 {
 	u8 i;
@@ -5857,7 +5857,7 @@ static void ipw_debug_config(struct ipw_
 #define ipw_debug_config(x) do {} while (0)
 #endif
 
-static inline void ipw_set_fixed_rate(struct ipw_priv *priv, int mode)
+static void ipw_set_fixed_rate(struct ipw_priv *priv, int mode)
 {
 	/* TODO: Verify that this works... */
 	struct ipw_fixed_rate fr = {
@@ -7636,7 +7636,7 @@ static void ipw_handle_data_packet_monit
 }
 #endif
 
-static inline int is_network_packet(struct ipw_priv *priv,
+static int is_network_packet(struct ipw_priv *priv,
 				    struct ieee80211_hdr_4addr *header)
 {
 	/* Filter incoming packets to determine if they are targetted toward
@@ -7676,7 +7676,7 @@ static inline int is_network_packet(stru
 
 #define IPW_PACKET_RETRY_TIME HZ
 
-static inline int is_duplicate_packet(struct ipw_priv *priv,
+static  int is_duplicate_packet(struct ipw_priv *priv,
 				      struct ieee80211_hdr_4addr *header)
 {
 	u16 sc = le16_to_cpu(header->seq_ctl);
@@ -9585,7 +9585,7 @@ static struct iw_statistics *ipw_get_wir
 
 /* net device stuff */
 
-static inline void init_sys_config(struct ipw_sys_config *sys_config)
+static  void init_sys_config(struct ipw_sys_config *sys_config)
 {
 	memset(sys_config, 0, sizeof(struct ipw_sys_config));
 	sys_config->bt_coexistence = 1;	/* We may need to look into prvStaBtConfig */
@@ -9631,7 +9631,7 @@ modify to send one tfd per fragment inst
 we need to heavily modify the ieee80211_skb_to_txb.
 */
 
-static inline int ipw_tx_skb(struct ipw_priv *priv, struct ieee80211_txb *txb,
+static int ipw_tx_skb(struct ipw_priv *priv, struct ieee80211_txb *txb,
 			     int pri)
 {
 	struct ieee80211_hdr_3addr *hdr = (struct ieee80211_hdr_3addr *)
Index: linux-gcc.q/drivers/net/wireless/wavelan.c
===================================================================
--- linux-gcc.q.orig/drivers/net/wireless/wavelan.c
+++ linux-gcc.q/drivers/net/wireless/wavelan.c
@@ -102,7 +102,7 @@ static inline void hacr_write(unsigned l
  * Write to card's Host Adapter Command Register. Include a delay for
  * those times when it is needed.
  */
-static inline void hacr_write_slow(unsigned long ioaddr, u16 hacr)
+static void hacr_write_slow(unsigned long ioaddr, u16 hacr)
 {
 	hacr_write(ioaddr, hacr);
 	/* delay might only be needed sometimes */
@@ -242,7 +242,7 @@ static void psa_write(unsigned long ioad
  * The Windows drivers don't use the CRC, but the AP and the PtP tool
  * depend on it.
  */
-static inline u16 psa_crc(u8 * psa,	/* The PSA */
+static u16 psa_crc(u8 * psa,	/* The PSA */
 			      int size)
 {				/* Number of short for CRC */
 	int byte_cnt;		/* Loop on the PSA */
@@ -310,7 +310,7 @@ static void update_psa_checksum(struct n
 /*
  * Write 1 byte to the MMC.
  */
-static inline void mmc_out(unsigned long ioaddr, u16 o, u8 d)
+static void mmc_out(unsigned long ioaddr, u16 o, u8 d)
 {
 	int count = 0;
 
@@ -326,7 +326,7 @@ static inline void mmc_out(unsigned long
  * Routine to write bytes to the Modem Management Controller.
  * We start at the end because it is the way it should be!
  */
-static inline void mmc_write(unsigned long ioaddr, u8 o, u8 * b, int n)
+static void mmc_write(unsigned long ioaddr, u8 o, u8 * b, int n)
 {
 	o += n;
 	b += n;
@@ -340,7 +340,7 @@ static inline void mmc_write(unsigned lo
  * Read a byte from the MMC.
  * Optimised version for 1 byte, avoid using memory.
  */
-static inline u8 mmc_in(unsigned long ioaddr, u16 o)
+static u8 mmc_in(unsigned long ioaddr, u16 o)
 {
 	int count = 0;
 
@@ -587,7 +587,7 @@ static void wv_ack(struct net_device * d
  * Set channel attention bit and busy wait until command has
  * completed, then acknowledge completion of the command.
  */
-static inline int wv_synchronous_cmd(struct net_device * dev, const char *str)
+static int wv_synchronous_cmd(struct net_device * dev, const char *str)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
@@ -633,7 +633,7 @@ static inline int wv_synchronous_cmd(str
  * Configuration commands completion interrupt.
  * Check if done, and if OK.
  */
-static inline int
+static int
 wv_config_complete(struct net_device * dev, unsigned long ioaddr, net_local * lp)
 {
 	unsigned short mcs_addr;
@@ -843,7 +843,7 @@ if (lp->tx_n_in_use > 0)
  * wavelan_interrupt is not an option), so you may experience
  * delays sometimes.
  */
-static inline void wv_82586_reconfig(struct net_device * dev)
+static void wv_82586_reconfig(struct net_device * dev)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long flags;
@@ -1281,7 +1281,7 @@ static inline void wv_packet_info(u8 * p
  * This is the information which is displayed by the driver at startup.
  * There are lots of flags for configuring it to your liking.
  */
-static inline void wv_init_info(struct net_device * dev)
+static void wv_init_info(struct net_device * dev)
 {
 	short ioaddr = dev->base_addr;
 	net_local *lp = (net_local *) dev->priv;
@@ -1502,7 +1502,7 @@ static int wavelan_set_mac_address(struc
  * It's a bit complicated and you don't really want to look into it.
  * (called in wavelan_ioctl)
  */
-static inline int wv_set_frequency(unsigned long ioaddr,	/* I/O port of the card */
+static int wv_set_frequency(unsigned long ioaddr,	/* I/O port of the card */
 				   iw_freq * frequency)
 {
 	const int BAND_NUM = 10;	/* Number of bands */
@@ -1677,7 +1677,7 @@ static inline int wv_set_frequency(unsig
 /*
  * Give the list of available frequencies.
  */
-static inline int wv_frequency_list(unsigned long ioaddr,	/* I/O port of the card */
+static int wv_frequency_list(unsigned long ioaddr,	/* I/O port of the card */
 				    iw_freq * list,	/* List of frequencies to fill */
 				    int max)
 {				/* Maximum number of frequencies */
@@ -2489,7 +2489,7 @@ static iw_stats *wavelan_get_wireless_st
  * Note: if any errors occur, the packet is "dropped on the floor".
  * (called by wv_packet_rcv())
  */
-static inline void
+static void
 wv_packet_read(struct net_device * dev, u16 buf_off, int sksize)
 {
 	net_local *lp = (net_local *) dev->priv;
@@ -2585,7 +2585,7 @@ wv_packet_read(struct net_device * dev, 
  * (called in wavelan_interrupt()).
  * Note : the spinlock is already grabbed for us.
  */
-static inline void wv_receive(struct net_device * dev)
+static void wv_receive(struct net_device * dev)
 {
 	unsigned long ioaddr = dev->base_addr;
 	net_local *lp = (net_local *) dev->priv;
@@ -2768,7 +2768,7 @@ static inline void wv_receive(struct net
  *
  * (called in wavelan_packet_xmit())
  */
-static inline int wv_packet_write(struct net_device * dev, void *buf, short length)
+static int wv_packet_write(struct net_device * dev, void *buf, short length)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
@@ -2964,7 +2964,7 @@ static int wavelan_packet_xmit(struct sk
  * Routine to initialize the Modem Management Controller.
  * (called by wv_hw_reset())
  */
-static inline int wv_mmc_init(struct net_device * dev)
+static int wv_mmc_init(struct net_device * dev)
 {
 	unsigned long ioaddr = dev->base_addr;
 	net_local *lp = (net_local *) dev->priv;
@@ -3136,7 +3136,7 @@ static inline int wv_mmc_init(struct net
  * Start the receive unit.
  * (called by wv_hw_reset())
  */
-static inline int wv_ru_start(struct net_device * dev)
+static int wv_ru_start(struct net_device * dev)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
@@ -3228,7 +3228,7 @@ static inline int wv_ru_start(struct net
  *
  * (called by wv_hw_reset())
  */
-static inline int wv_cu_start(struct net_device * dev)
+static int wv_cu_start(struct net_device * dev)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
@@ -3329,7 +3329,7 @@ static inline int wv_cu_start(struct net
  *
  * (called by wv_hw_reset())
  */
-static inline int wv_82586_start(struct net_device * dev)
+static int wv_82586_start(struct net_device * dev)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
@@ -3641,7 +3641,7 @@ static void wv_82586_config(struct net_d
  * WaveLAN controller (i82586).
  * (called by wavelan_close())
  */
-static inline void wv_82586_stop(struct net_device * dev)
+static void wv_82586_stop(struct net_device * dev)
 {
 	net_local *lp = (net_local *) dev->priv;
 	unsigned long ioaddr = dev->base_addr;
Index: linux-gcc.q/drivers/scsi/aic7xxx_old.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/aic7xxx_old.c
+++ linux-gcc.q/drivers/scsi/aic7xxx_old.c
@@ -1290,7 +1290,7 @@ static void aic7xxx_check_scbs(struct ai
  *
  ***************************************************************************/
 
-static inline unsigned char
+static unsigned char
 aic_inb(struct aic7xxx_host *p, long port)
 {
 #ifdef MMAPIO
@@ -1309,7 +1309,7 @@ aic_inb(struct aic7xxx_host *p, long por
 #endif
 }
 
-static inline void
+static void
 aic_outb(struct aic7xxx_host *p, unsigned char val, long port)
 {
 #ifdef MMAPIO
Index: linux-gcc.q/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/iscsi_tcp.c
+++ linux-gcc.q/drivers/scsi/iscsi_tcp.c
@@ -1437,7 +1437,7 @@ iscsi_buf_data_digest_update(struct iscs
 	}
 }
 
-static inline int
+static int
 iscsi_digest_final_send(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
 			struct iscsi_buf *buf, uint32_t *digest, int final)
 {
Index: linux-gcc.q/drivers/scsi/libata-core.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/libata-core.c
+++ linux-gcc.q/drivers/scsi/libata-core.c
@@ -1660,7 +1660,7 @@ static const struct {
 	{ ATA_SHIFT_PIO,	XFER_PIO_0 },
 };
 
-static inline u8 base_from_shift(unsigned int shift)
+static u8 base_from_shift(unsigned int shift)
 {
 	int i;
 
Index: linux-gcc.q/drivers/scsi/megaraid/megaraid_mbox.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/megaraid/megaraid_mbox.c
+++ linux-gcc.q/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1331,7 +1331,7 @@ megaraid_mbox_teardown_dma_pools(adapter
  * return the scb from the head of the free list. NULL if there are none
  * available
  **/
-static inline scb_t *
+static scb_t *
 megaraid_alloc_scb(adapter_t *adapter, struct scsi_cmnd *scp)
 {
 	struct list_head	*head = &adapter->kscb_pool;
@@ -1394,7 +1394,7 @@ megaraid_dealloc_scb(adapter_t *adapter,
  *
  * prepare the scatter-gather list
  */
-static inline int
+static int
 megaraid_mbox_mksgl(adapter_t *adapter, scb_t *scb)
 {
 	struct scatterlist	*sgl;
@@ -1467,7 +1467,7 @@ megaraid_mbox_mksgl(adapter_t *adapter, 
  *
  * post the command to the controller if mailbox is availble.
  */
-static inline int
+static int
 mbox_post_cmd(adapter_t *adapter, scb_t *scb)
 {
 	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
@@ -2135,7 +2135,7 @@ megaraid_mbox_prepare_epthru(adapter_t *
  *
  * Returns:	1 if the interrupt is valid, 0 otherwise
  */
-static inline int
+static int
 megaraid_ack_sequence(adapter_t *adapter)
 {
 	mraid_device_t		*raid_dev = ADAP2RAIDDEV(adapter);
@@ -2273,7 +2273,7 @@ megaraid_isr(int irq, void *devp, struct
  *
  * DMA sync if required.
  */
-static inline void
+static void
 megaraid_mbox_sync_scb(adapter_t *adapter, scb_t *scb)
 {
 	mbox_ccb_t	*ccb;
Index: linux-gcc.q/drivers/scsi/megaraid/megaraid_sas.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/megaraid/megaraid_sas.c
+++ linux-gcc.q/drivers/scsi/megaraid/megaraid_sas.c
@@ -80,7 +80,7 @@ static DECLARE_MUTEX(megasas_async_queue
  *
  * Returns a free command from the pool
  */
-static inline struct megasas_cmd *megasas_get_cmd(struct megasas_instance
+static struct megasas_cmd *megasas_get_cmd(struct megasas_instance
 						  *instance)
 {
 	unsigned long flags;
@@ -262,7 +262,7 @@ megasas_issue_blocked_abort_cmd(struct m
  * If successful, this function returns the number of SG elements. Otherwise,
  * it returnes -1.
  */
-static inline int
+static int
 megasas_make_sgl32(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   union megasas_sgl *mfi_sgl)
 {
@@ -310,7 +310,7 @@ megasas_make_sgl32(struct megasas_instan
  * If successful, this function returns the number of SG elements. Otherwise,
  * it returnes -1.
  */
-static inline int
+static int
 megasas_make_sgl64(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   union megasas_sgl *mfi_sgl)
 {
@@ -359,7 +359,7 @@ megasas_make_sgl64(struct megasas_instan
  * This function prepares CDB commands. These are typcially pass-through
  * commands to the devices.
  */
-static inline int
+static int
 megasas_build_dcdb(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
@@ -440,7 +440,7 @@ megasas_build_dcdb(struct megasas_instan
  *
  * Frames (and accompanying SGLs) for regular SCSI IOs use this function.
  */
-static inline int
+static int
 megasas_build_ldio(struct megasas_instance *instance, struct scsi_cmnd *scp,
 		   struct megasas_cmd *cmd)
 {
@@ -562,7 +562,7 @@ megasas_build_ldio(struct megasas_instan
  * @scp:		SCSI command
  * @frame_count:	[OUT] Number of frames used to prepare this command
  */
-static inline struct megasas_cmd *megasas_build_cmd(struct megasas_instance
+static struct megasas_cmd *megasas_build_cmd(struct megasas_instance
 						    *instance,
 						    struct scsi_cmnd *scp,
 						    int *frame_count)
@@ -913,7 +913,7 @@ megasas_complete_abort(struct megasas_in
  * @instance:			Adapter soft state
  * @cmd:			Completed command
  */
-static inline void
+static void
 megasas_unmap_sgbuf(struct megasas_instance *instance, struct megasas_cmd *cmd)
 {
 	dma_addr_t buf_h;
@@ -957,7 +957,7 @@ megasas_unmap_sgbuf(struct megasas_insta
  * 				an alternate status (as in the case of aborted
  * 				commands)
  */
-static inline void
+static void
 megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 		     u8 alt_status)
 {
@@ -1104,7 +1104,7 @@ megasas_complete_cmd(struct megasas_inst
  * 					SCSI mid-layer instead of the status
  * 					returned by the FW
  */
-static inline int
+static int
 megasas_deplete_reply_queue(struct megasas_instance *instance, u8 alt_status)
 {
 	u32 status;
Index: linux-gcc.q/drivers/scsi/sr.c
===================================================================
--- linux-gcc.q.orig/drivers/scsi/sr.c
+++ linux-gcc.q/drivers/scsi/sr.c
@@ -150,7 +150,7 @@ static inline struct scsi_cd *scsi_cd_ge
 	return cd;
 }
 
-static inline void scsi_cd_put(struct scsi_cd *cd)
+static void scsi_cd_put(struct scsi_cd *cd)
 {
 	struct scsi_device *sdev = cd->device;
 
Index: linux-gcc.q/drivers/usb/atm/usbatm.c
===================================================================
--- linux-gcc.q.orig/drivers/usb/atm/usbatm.c
+++ linux-gcc.q/drivers/usb/atm/usbatm.c
@@ -207,7 +207,7 @@ static inline void usbatm_pop(struct atm
 **  urbs  **
 ************/
 
-static inline struct urb *usbatm_pop_urb(struct usbatm_channel *channel)
+static struct urb *usbatm_pop_urb(struct usbatm_channel *channel)
 {
 	struct urb *urb;
 
@@ -224,7 +224,7 @@ static inline struct urb *usbatm_pop_urb
 	return urb;
 }
 
-static inline int usbatm_submit_urb(struct urb *urb)
+static int usbatm_submit_urb(struct urb *urb)
 {
 	struct usbatm_channel *channel = urb->context;
 	int ret;
Index: linux-gcc.q/drivers/usb/class/audio.c
===================================================================
--- linux-gcc.q.orig/drivers/usb/class/audio.c
+++ linux-gcc.q/drivers/usb/class/audio.c
@@ -3246,7 +3246,7 @@ static void prepmixch(struct consmixstat
 
 static void usb_audio_recurseunit(struct consmixstate *state, unsigned char unitid);
 
-static inline int checkmixbmap(unsigned char *bmap, unsigned char flg, unsigned int inidx, unsigned int numoch)
+static int checkmixbmap(unsigned char *bmap, unsigned char flg, unsigned int inidx, unsigned int numoch)
 {
 	unsigned int idx;
 
Index: linux-gcc.q/drivers/video/matrox/matroxfb_maven.c
===================================================================
--- linux-gcc.q.orig/drivers/video/matrox/matroxfb_maven.c
+++ linux-gcc.q/drivers/video/matrox/matroxfb_maven.c
@@ -968,7 +968,7 @@ static inline int maven_compute_timming(
 	return 0;
 }
 
-static inline int maven_program_timming(struct maven_data* md,
+static int maven_program_timming(struct maven_data* md,
 		const struct mavenregs* m) {
 	struct i2c_client* c = md->client;
 
Index: linux-gcc.q/fs/9p/conv.c
===================================================================
--- linux-gcc.q.orig/fs/9p/conv.c
+++ linux-gcc.q/fs/9p/conv.c
@@ -350,7 +350,7 @@ serialize_stat(struct v9fs_session_info 
  *
  */
 
-static inline int
+static int
 deserialize_stat(struct v9fs_session_info *v9ses, struct cbuf *bufp,
 		 struct v9fs_stat *stat, struct cbuf *dbufp)
 {
Index: linux-gcc.q/fs/binfmt_elf.c
===================================================================
--- linux-gcc.q.orig/fs/binfmt_elf.c
+++ linux-gcc.q/fs/binfmt_elf.c
@@ -1212,7 +1212,7 @@ static int writenote(struct memelfnote *
 	if (!dump_seek(file, (off))) \
 		goto end_coredump;
 
-static inline void fill_elf_header(struct elfhdr *elf, int segs)
+static void fill_elf_header(struct elfhdr *elf, int segs)
 {
 	memcpy(elf->e_ident, ELFMAG, SELFMAG);
 	elf->e_ident[EI_CLASS] = ELF_CLASS;
@@ -1237,7 +1237,7 @@ static inline void fill_elf_header(struc
 	return;
 }
 
-static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t offset)
+static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, off_t offset)
 {
 	phdr->p_type = PT_NOTE;
 	phdr->p_offset = offset;
Index: linux-gcc.q/fs/binfmt_misc.c
===================================================================
--- linux-gcc.q.orig/fs/binfmt_misc.c
+++ linux-gcc.q/fs/binfmt_misc.c
@@ -264,7 +264,7 @@ static int unquote(char *from)
 	return p - from;
 }
 
-static inline char * check_special_flags (char * sfs, Node * e)
+static char * check_special_flags (char * sfs, Node * e)
 {
 	char * p = sfs;
 	int cont = 1;
Index: linux-gcc.q/fs/bio.c
===================================================================
--- linux-gcc.q.orig/fs/bio.c
+++ linux-gcc.q/fs/bio.c
@@ -123,7 +123,7 @@ static void bio_fs_destructor(struct bio
 	bio_free(bio, fs_bio_set);
 }
 
-inline void bio_init(struct bio *bio)
+void bio_init(struct bio *bio)
 {
 	bio->bi_next = NULL;
 	bio->bi_flags = 1 << BIO_UPTODATE;
@@ -252,7 +252,7 @@ inline int bio_hw_segments(request_queue
  *	the actual data it points to. Reference count of returned
  * 	bio will be one.
  */
-inline void __bio_clone(struct bio *bio, struct bio *bio_src)
+void __bio_clone(struct bio *bio, struct bio *bio_src)
 {
 	request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
 
Index: linux-gcc.q/fs/buffer.c
===================================================================
--- linux-gcc.q.orig/fs/buffer.c
+++ linux-gcc.q/fs/buffer.c
@@ -1170,7 +1170,7 @@ failed:
  * some of those buffers may be aliases of filesystem data.
  * grow_dev_page() will go BUG() if this happens.
  */
-static inline int
+static int
 grow_buffers(struct block_device *bdev, sector_t block, int size)
 {
 	struct page *page;
@@ -1396,7 +1396,7 @@ static void bh_lru_install(struct buffer
 /*
  * Look up the bh in this cpu's LRU.  If it's there, move it to the head.
  */
-static inline struct buffer_head *
+static struct buffer_head *
 lookup_bh_lru(struct block_device *bdev, sector_t block, int size)
 {
 	struct buffer_head *ret = NULL;
@@ -1546,7 +1546,7 @@ EXPORT_SYMBOL(set_bh_page);
 /*
  * Called when truncating a buffer on a page completely.
  */
-static inline void discard_buffer(struct buffer_head * bh)
+static void discard_buffer(struct buffer_head * bh)
 {
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
Index: linux-gcc.q/fs/compat.c
===================================================================
--- linux-gcc.q.orig/fs/compat.c
+++ linux-gcc.q/fs/compat.c
@@ -1523,7 +1523,7 @@ out_ret:
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
  * 64-bit unsigned longs.
  */
-static inline
+static
 int compat_get_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
 			unsigned long *fdset)
 {
@@ -1556,7 +1556,7 @@ int compat_get_fd_set(unsigned long nr, 
 	return 0;
 }
 
-static inline
+static
 void compat_set_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
 			unsigned long *fdset)
 {
Index: linux-gcc.q/fs/dcache.c
===================================================================
--- linux-gcc.q.orig/fs/dcache.c
+++ linux-gcc.q/fs/dcache.c
@@ -94,7 +94,7 @@ static void d_free(struct dentry *dentry
  * d_iput() operation if defined.
  * Called with dcache_lock and per dentry lock held, drops both.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static void dentry_iput(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -362,7 +362,7 @@ restart:
  * removed.
  * Called with dcache_lock, drops it and then regains.
  */
-static inline void prune_one_dentry(struct dentry * dentry)
+static void prune_one_dentry(struct dentry * dentry)
 {
 	struct dentry * parent;
 
Index: linux-gcc.q/fs/exec.c
===================================================================
--- linux-gcc.q.orig/fs/exec.c
+++ linux-gcc.q/fs/exec.c
@@ -575,7 +575,7 @@ static int exec_mmap(struct mm_struct *m
  * disturbing other processes.  (Other processes might share the signal
  * table via the CLONE_SIGHAND option to clone().)
  */
-static inline int de_thread(struct task_struct *tsk)
+static int de_thread(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *newsighand, *oldsighand = tsk->sighand;
@@ -780,7 +780,7 @@ no_thread_group:
  * so that a new one can be started
  */
 
-static inline void flush_old_files(struct files_struct * files)
+static void flush_old_files(struct files_struct * files)
 {
 	long j = -1;
 	struct fdtable *fdt;
@@ -964,7 +964,7 @@ int prepare_binprm(struct linux_binprm *
 
 EXPORT_SYMBOL(prepare_binprm);
 
-static inline int unsafe_exec(struct task_struct *p)
+static int unsafe_exec(struct task_struct *p)
 {
 	int unsafe = 0;
 	if (p->ptrace & PT_PTRACED) {
Index: linux-gcc.q/fs/fcntl.c
===================================================================
--- linux-gcc.q.orig/fs/fcntl.c
+++ linux-gcc.q/fs/fcntl.c
@@ -35,7 +35,7 @@ void fastcall set_close_on_exec(unsigned
 	spin_unlock(&files->file_lock);
 }
 
-static inline int get_close_on_exec(unsigned int fd)
+static int get_close_on_exec(unsigned int fd)
 {
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
Index: linux-gcc.q/fs/jffs2/build.c
===================================================================
--- linux-gcc.q.orig/fs/jffs2/build.c
+++ linux-gcc.q/fs/jffs2/build.c
@@ -47,7 +47,7 @@ next_inode(int *i, struct jffs2_inode_ca
 	     ic = next_inode(&i, ic, (c)))
 
 
-static inline void jffs2_build_inode_pass1(struct jffs2_sb_info *c,
+static void jffs2_build_inode_pass1(struct jffs2_sb_info *c,
 					struct jffs2_inode_cache *ic)
 {
 	struct jffs2_full_dirent *fd;
Index: linux-gcc.q/fs/jffs2/nodelist.c
===================================================================
--- linux-gcc.q.orig/fs/jffs2/nodelist.c
+++ linux-gcc.q/fs/jffs2/nodelist.c
@@ -134,7 +134,7 @@ static void jffs2_fragtree_insert(struct
 /*
  * Allocate and initializes a new fragment.
  */
-static inline struct jffs2_node_frag * new_fragment(struct jffs2_full_dnode *fn, uint32_t ofs, uint32_t size)
+static struct jffs2_node_frag * new_fragment(struct jffs2_full_dnode *fn, uint32_t ofs, uint32_t size)
 {
 	struct jffs2_node_frag *newfrag;
 
@@ -513,7 +513,7 @@ free_out:
  *
  * Checks the node if we are in the checking stage.
  */
-static inline int check_node(struct jffs2_sb_info *c, struct jffs2_inode_info *f, struct jffs2_tmp_dnode_info *tn)
+static int check_node(struct jffs2_sb_info *c, struct jffs2_inode_info *f, struct jffs2_tmp_dnode_info *tn)
 {
 	int ret;
 
Index: linux-gcc.q/fs/lockd/xdr.c
===================================================================
--- linux-gcc.q.orig/fs/lockd/xdr.c
+++ linux-gcc.q/fs/lockd/xdr.c
@@ -44,7 +44,7 @@ loff_t_to_s32(loff_t offset)
 /*
  * XDR functions for basic NLM types
  */
-static inline u32 *nlm_decode_cookie(u32 *p, struct nlm_cookie *c)
+static u32 *nlm_decode_cookie(u32 *p, struct nlm_cookie *c)
 {
 	unsigned int	len;
 
@@ -79,7 +79,7 @@ nlm_encode_cookie(u32 *p, struct nlm_coo
 	return p;
 }
 
-static inline u32 *
+static u32 *
 nlm_decode_fh(u32 *p, struct nfs_fh *f)
 {
 	unsigned int	len;
@@ -119,7 +119,7 @@ nlm_encode_oh(u32 *p, struct xdr_netobj 
 	return xdr_encode_netobj(p, oh);
 }
 
-static inline u32 *
+static u32 *
 nlm_decode_lock(u32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
Index: linux-gcc.q/fs/locks.c
===================================================================
--- linux-gcc.q.orig/fs/locks.c
+++ linux-gcc.q/fs/locks.c
@@ -154,7 +154,7 @@ static struct file_lock *locks_alloc_loc
 }
 
 /* Free a lock which is not in use. */
-static inline void locks_free_lock(struct file_lock *fl)
+static void locks_free_lock(struct file_lock *fl)
 {
 	if (fl == NULL) {
 		BUG();
Index: linux-gcc.q/fs/mbcache.c
===================================================================
--- linux-gcc.q.orig/fs/mbcache.c
+++ linux-gcc.q/fs/mbcache.c
@@ -126,7 +126,7 @@ __mb_cache_entry_is_hashed(struct mb_cac
 }
 
 
-static inline void
+static void
 __mb_cache_entry_unhash(struct mb_cache_entry *ce)
 {
 	int n;
@@ -139,7 +139,7 @@ __mb_cache_entry_unhash(struct mb_cache_
 }
 
 
-static inline void
+static void
 __mb_cache_entry_forget(struct mb_cache_entry *ce, gfp_t gfp_mask)
 {
 	struct mb_cache *cache = ce->e_cache;
@@ -158,7 +158,7 @@ __mb_cache_entry_forget(struct mb_cache_
 }
 
 
-static inline void
+static void
 __mb_cache_entry_release_unlock(struct mb_cache_entry *ce)
 {
 	/* Wake up all processes queuing for this cache entry. */
Index: linux-gcc.q/fs/namei.c
===================================================================
--- linux-gcc.q.orig/fs/namei.c
+++ linux-gcc.q/fs/namei.c
@@ -112,7 +112,7 @@
  * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
  * PATH_MAX includes the nul terminator --RR.
  */
-static inline int do_getname(const char __user *filename, char *page)
+static int do_getname(const char __user *filename, char *page)
 {
 	int retval;
 	unsigned long len = PATH_MAX;
@@ -395,7 +395,7 @@ static struct dentry * cached_lookup(str
  * short-cut DAC fails, then call permission() to do more
  * complete permission check.
  */
-static inline int exec_permission_lite(struct inode *inode,
+static int exec_permission_lite(struct inode *inode,
 				       struct nameidata *nd)
 {
 	umode_t	mode = inode->i_mode;
@@ -1293,7 +1293,7 @@ static inline int check_sticky(struct in
  * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static inline int may_delete(struct inode *dir,struct dentry *victim,int isdir)
+static int may_delete(struct inode *dir,struct dentry *victim,int isdir)
 {
 	int error;
 
@@ -2314,7 +2314,7 @@ int vfs_rename(struct inode *old_dir, st
 	return error;
 }
 
-static inline int do_rename(const char * oldname, const char * newname)
+static int do_rename(const char * oldname, const char * newname)
 {
 	int error = 0;
 	struct dentry * old_dir, * new_dir;
Index: linux-gcc.q/fs/nfsd/nfsxdr.c
===================================================================
--- linux-gcc.q.orig/fs/nfsd/nfsxdr.c
+++ linux-gcc.q/fs/nfsd/nfsxdr.c
@@ -37,7 +37,7 @@ static u32	nfs_ftypes[] = {
 /*
  * XDR functions for basic NFS types
  */
-static inline u32 *
+static u32 *
 decode_fh(u32 *p, struct svc_fh *fhp)
 {
 	fh_init(fhp, NFS_FHSIZE);
@@ -151,7 +151,7 @@ decode_sattr(u32 *p, struct iattr *iap)
 	return p;
 }
 
-static inline u32 *
+static u32 *
 encode_fattr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
 {
 	struct vfsmount *mnt = fhp->fh_export->ex_mnt;
Index: linux-gcc.q/fs/pipe.c
===================================================================
--- linux-gcc.q.orig/fs/pipe.c
+++ linux-gcc.q/fs/pipe.c
@@ -50,7 +50,7 @@ void pipe_wait(struct inode * inode)
 	down(PIPE_SEM(*inode));
 }
 
-static inline int
+static int
 pipe_iov_copy_from_user(void *to, struct iovec *iov, unsigned long len)
 {
 	unsigned long copy;
@@ -70,7 +70,7 @@ pipe_iov_copy_from_user(void *to, struct
 	return 0;
 }
 
-static inline int
+static int
 pipe_iov_copy_to_user(struct iovec *iov, const void *from, unsigned long len)
 {
 	unsigned long copy;
Index: linux-gcc.q/kernel/cpuset.c
===================================================================
--- linux-gcc.q.orig/kernel/cpuset.c
+++ linux-gcc.q/kernel/cpuset.c
@@ -1252,7 +1252,7 @@ struct ctr_struct {
  * when reading out p->cpuset, as we don't really care if it changes
  * on the next cycle, and we are not going to try to dereference it.
  */
-static inline int pid_array_load(pid_t *pidarray, int npids, struct cpuset *cs)
+static int pid_array_load(pid_t *pidarray, int npids, struct cpuset *cs)
 {
 	int n = 0;
 	struct task_struct *g, *p;
Index: linux-gcc.q/kernel/exit.c
===================================================================
--- linux-gcc.q.orig/kernel/exit.c
+++ linux-gcc.q/kernel/exit.c
@@ -192,7 +192,7 @@ int is_orphaned_pgrp(int pgrp)
 	return retval;
 }
 
-static inline int has_stopped_jobs(int pgrp)
+static int has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
 	struct task_struct *p;
@@ -229,7 +229,7 @@ static inline int has_stopped_jobs(int p
  *
  * NOTE that reparent_to_init() gives the caller full capabilities.
  */
-static inline void reparent_to_init(void)
+static void reparent_to_init(void)
 {
 	write_lock_irq(&tasklist_lock);
 
@@ -366,7 +366,7 @@ void daemonize(const char *name, ...)
 
 EXPORT_SYMBOL(daemonize);
 
-static inline void close_files(struct files_struct * files)
+static void close_files(struct files_struct * files)
 {
 	int i, j;
 	struct fdtable *fdt;
@@ -540,7 +540,7 @@ static inline void choose_new_parent(tas
 	p->real_parent = reaper;
 }
 
-static inline void reparent_thread(task_t *p, task_t *father, int traced)
+static void reparent_thread(task_t *p, task_t *father, int traced)
 {
 	/* We don't want people slaying init.  */
 	if (p->exit_signal != -1)
@@ -604,7 +604,7 @@ static inline void reparent_thread(task_
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
-static inline void forget_original_parent(struct task_struct * father,
+static void forget_original_parent(struct task_struct * father,
 					  struct list_head *to_release)
 {
 	struct task_struct *p, *reaper = father;
Index: linux-gcc.q/kernel/posix-timers.c
===================================================================
--- linux-gcc.q.orig/kernel/posix-timers.c
+++ linux-gcc.q/kernel/posix-timers.c
@@ -203,7 +203,7 @@ static inline int common_clock_set(clock
 	return do_sys_settimeofday(tp, NULL);
 }
 
-static inline int common_timer_create(struct k_itimer *new_timer)
+static int common_timer_create(struct k_itimer *new_timer)
 {
 	INIT_LIST_HEAD(&new_timer->it.real.abs_timer_entry);
 	init_timer(&new_timer->it.real.timer);
@@ -513,7 +513,7 @@ static void posix_timer_fn(unsigned long
 }
 
 
-static inline struct task_struct * good_sigevent(sigevent_t * event)
+static struct task_struct * good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn = current->group_leader;
 
@@ -939,7 +939,7 @@ static int adjust_abs_time(struct k_cloc
 
 /* Set a POSIX.1b interval timer. */
 /* timr->it_lock is taken. */
-static inline int
+static int
 common_timer_set(struct k_itimer *timr, int flags,
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
@@ -1122,7 +1122,7 @@ retry_delete:
 /*
  * return timer owned by the process, used by exit_itimers
  */
-static inline void itimer_delete(struct k_itimer *timer)
+static void itimer_delete(struct k_itimer *timer)
 {
 	unsigned long flags;
 
Index: linux-gcc.q/kernel/sched.c
===================================================================
--- linux-gcc.q.orig/kernel/sched.c
+++ linux-gcc.q/kernel/sched.c
@@ -512,7 +512,7 @@ static inline void sched_info_dequeued(t
  * long it was waiting to run.  We also note when it began so that we
  * can keep stats on how long its timeslice is.
  */
-static inline void sched_info_arrive(task_t *t)
+static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
 	struct runqueue *rq = task_rq(t);
@@ -994,7 +994,7 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static inline unsigned long __source_load(int cpu, int type, enum idle_type idle)
+static unsigned long __source_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long running = rq->nr_running;
@@ -1849,7 +1849,7 @@ void sched_exec(void)
  * pull_task - move a task from a remote runqueue to the local runqueue.
  * Both runqueues must be locked.
  */
-static inline
+static
 void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
@@ -1871,7 +1871,7 @@ void pull_task(runqueue_t *src_rq, prio_
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
-static inline
+static
 int can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu,
 		     struct sched_domain *sd, enum idle_type idle,
 		     int *all_pinned)
@@ -2357,7 +2357,7 @@ out_balanced:
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static inline void idle_balance(int this_cpu, runqueue_t *this_rq)
+static void idle_balance(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *sd;
 
@@ -2741,7 +2741,7 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
-static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
@@ -2795,7 +2795,7 @@ static inline unsigned long smt_slice(ta
 	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
 }
 
-static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
+static int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
@@ -5505,7 +5505,7 @@ next_sg:
  * Detach sched domains from a group of cpus specified in cpu_map
  * These cpus will now be attached to the NULL domain
  */
-static inline void detach_destroy_domains(const cpumask_t *cpu_map)
+static void detach_destroy_domains(const cpumask_t *cpu_map)
 {
 	int i;
 
Index: linux-gcc.q/kernel/signal.c
===================================================================
--- linux-gcc.q.orig/kernel/signal.c
+++ linux-gcc.q/kernel/signal.c
@@ -465,7 +465,7 @@ unblock_all_signals(void)
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 }
 
-static inline int collect_signal(int sig, struct sigpending *list, siginfo_t *info)
+static int collect_signal(int sig, struct sigpending *list, siginfo_t *info)
 {
 	struct sigqueue *q, *first = NULL;
 	int still_pending = 0;
@@ -1786,7 +1786,7 @@ do_signal_stop(int signr)
  * We return zero if we still hold the siglock and should look
  * for another signal without checking group_stop_count again.
  */
-static inline int handle_group_stop(void)
+static int handle_group_stop(void)
 {
 	int stop_count;
 
Index: linux-gcc.q/kernel/workqueue.c
===================================================================
--- linux-gcc.q.orig/kernel/workqueue.c
+++ linux-gcc.q/kernel/workqueue.c
@@ -144,7 +144,7 @@ int fastcall queue_delayed_work(struct w
 	return ret;
 }
 
-static inline void run_workqueue(struct cpu_workqueue_struct *cwq)
+static void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	unsigned long flags;
 
Index: linux-gcc.q/net/ieee80211/ieee80211_module.c
===================================================================
--- linux-gcc.q.orig/net/ieee80211/ieee80211_module.c
+++ linux-gcc.q/net/ieee80211/ieee80211_module.c
@@ -62,7 +62,7 @@ MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
 
-static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
+static int ieee80211_networks_allocate(struct ieee80211_device *ieee)
 {
 	if (ieee->networks)
 		return 0;
@@ -90,7 +90,7 @@ static inline void ieee80211_networks_fr
 	ieee->networks = NULL;
 }
 
-static inline void ieee80211_networks_initialize(struct ieee80211_device *ieee)
+static void ieee80211_networks_initialize(struct ieee80211_device *ieee)
 {
 	int i;
 
Index: linux-gcc.q/net/ieee80211/ieee80211_rx.c
===================================================================
--- linux-gcc.q.orig/net/ieee80211/ieee80211_rx.c
+++ linux-gcc.q/net/ieee80211/ieee80211_rx.c
@@ -35,7 +35,7 @@
 
 #include <net/ieee80211.h>
 
-static inline void ieee80211_monitor_rx(struct ieee80211_device *ieee,
+static void ieee80211_monitor_rx(struct ieee80211_device *ieee,
 					struct sk_buff *skb,
 					struct ieee80211_rx_stats *rx_stats)
 {
@@ -165,7 +165,7 @@ static int ieee80211_frag_cache_invalida
  * Responsible for handling management control frames
  *
  * Called by ieee80211_rx */
-static inline int
+static int
 ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee, struct sk_buff *skb,
 			struct ieee80211_rx_stats *rx_stats, u16 type,
 			u16 stype)
@@ -266,7 +266,7 @@ static int ieee80211_is_eapol_frame(stru
 }
 
 /* Called only as a tasklet (software IRQ), by ieee80211_rx */
-static inline int
+static int
 ieee80211_rx_frame_decrypt(struct ieee80211_device *ieee, struct sk_buff *skb,
 			   struct ieee80211_crypt_data *crypt)
 {
@@ -297,7 +297,7 @@ ieee80211_rx_frame_decrypt(struct ieee80
 }
 
 /* Called only as a tasklet (software IRQ), by ieee80211_rx */
-static inline int
+static int
 ieee80211_rx_frame_decrypt_msdu(struct ieee80211_device *ieee,
 				struct sk_buff *skb, int keyidx,
 				struct ieee80211_crypt_data *crypt)
@@ -1157,7 +1157,7 @@ static int ieee80211_handle_assoc_resp(s
 
 /***************************************************/
 
-static inline int ieee80211_network_init(struct ieee80211_device *ieee, struct ieee80211_probe_response
+static int ieee80211_network_init(struct ieee80211_device *ieee, struct ieee80211_probe_response
 					 *beacon,
 					 struct ieee80211_network *network,
 					 struct ieee80211_rx_stats *stats)
@@ -1236,7 +1236,7 @@ static inline int is_same_network(struct
 		!memcmp(src->ssid, dst->ssid, src->ssid_len));
 }
 
-static inline void update_network(struct ieee80211_network *dst,
+static void update_network(struct ieee80211_network *dst,
 				  struct ieee80211_network *src)
 {
 	int qos_active;
@@ -1295,7 +1295,7 @@ static inline int is_beacon(int fc)
 	return (WLAN_FC_GET_STYPE(le16_to_cpu(fc)) == IEEE80211_STYPE_BEACON);
 }
 
-static inline void ieee80211_process_probe_response(struct ieee80211_device
+static void ieee80211_process_probe_response(struct ieee80211_device
 						    *ieee, struct
 						    ieee80211_probe_response
 						    *beacon, struct ieee80211_rx_stats
Index: linux-gcc.q/net/ieee80211/ieee80211_tx.c
===================================================================
--- linux-gcc.q.orig/net/ieee80211/ieee80211_tx.c
+++ linux-gcc.q/net/ieee80211/ieee80211_tx.c
@@ -127,7 +127,7 @@ payload of each frame is reduced to 492 
 static u8 P802_1H_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0xf8 };
 static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
 
-static inline int ieee80211_copy_snap(u8 * data, u16 h_proto)
+static int ieee80211_copy_snap(u8 * data, u16 h_proto)
 {
 	struct ieee80211_snap_hdr *snap;
 	u8 *oui;
@@ -150,7 +150,7 @@ static inline int ieee80211_copy_snap(u8
 	return SNAP_SIZE + sizeof(u16);
 }
 
-static inline int ieee80211_encrypt_fragment(struct ieee80211_device *ieee,
+static int ieee80211_encrypt_fragment(struct ieee80211_device *ieee,
 					     struct sk_buff *frag, int hdr_len)
 {
 	struct ieee80211_crypt_data *crypt = ieee->crypt[ieee->tx_keyidx];
Index: linux-gcc.q/net/ieee80211/ieee80211_wx.c
===================================================================
--- linux-gcc.q.orig/net/ieee80211/ieee80211_wx.c
+++ linux-gcc.q/net/ieee80211/ieee80211_wx.c
@@ -42,7 +42,7 @@ static const char *ieee80211_modes[] = {
 };
 
 #define MAX_CUSTOM_LEN 64
-static inline char *ipw2100_translate_scan(struct ieee80211_device *ieee,
+static char *ipw2100_translate_scan(struct ieee80211_device *ieee,
 					   char *start, char *stop,
 					   struct ieee80211_network *network)
 {
Index: linux-gcc.q/net/netfilter/nfnetlink.c
===================================================================
--- linux-gcc.q.orig/net/netfilter/nfnetlink.c
+++ linux-gcc.q/net/netfilter/nfnetlink.c
@@ -212,7 +212,7 @@ int nfnetlink_unicast(struct sk_buff *sk
 }
 
 /* Process one complete nfnetlink message. */
-static inline int nfnetlink_rcv_msg(struct sk_buff *skb,
+static int nfnetlink_rcv_msg(struct sk_buff *skb,
 				    struct nlmsghdr *nlh, int *errp)
 {
 	struct nfnl_callback *nc;
Index: linux-gcc.q/security/selinux/hooks.c
===================================================================
--- linux-gcc.q.orig/security/selinux/hooks.c
+++ linux-gcc.q/security/selinux/hooks.c
@@ -1018,7 +1018,7 @@ static inline int dentry_has_perm(struct
    has the same SID as the process.  If av is zero, then
    access to the file is not checked, e.g. for cases
    where only the descriptor is affected like seek. */
-static inline int file_has_perm(struct task_struct *tsk,
+static int file_has_perm(struct task_struct *tsk,
 				struct file *file,
 				u32 av)
 {
Index: linux-gcc.q/sound/oss/esssolo1.c
===================================================================
--- linux-gcc.q.orig/sound/oss/esssolo1.c
+++ linux-gcc.q/sound/oss/esssolo1.c
@@ -515,7 +515,7 @@ static inline int prog_dmabuf_adc(struct
 	return 0;
 }
 
-static inline int prog_dmabuf_dac(struct solo1_state *s)
+static int prog_dmabuf_dac(struct solo1_state *s)
 {
 	unsigned long va;
 	int c;
Index: linux-gcc.q/sound/pci/es1968.c
===================================================================
--- linux-gcc.q.orig/sound/pci/es1968.c
+++ linux-gcc.q/sound/pci/es1968.c
@@ -731,7 +731,7 @@ static void __apu_set_register(es1968_t 
 	apu_data_set(chip, data);
 }
 
-static inline void apu_set_register(es1968_t *chip, u16 channel, u8 reg, u16 data)
+static void apu_set_register(es1968_t *chip, u16 channel, u8 reg, u16 data)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&chip->reg_lock, flags);


