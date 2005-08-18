Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVHRAQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVHRAQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVHRAPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:15:06 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:46174 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751393AbVHRAOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IsG+K8ncFn/TBY71RpnlRj8u0u1B4t7RD4/5hAMCzJ+ZDP9/Yl5asIKWolEokjDA5mXc6czy3sNwQnbO/GSqX5RChOv42OavjVroZyX98wvRPoeXROE/wuy4mrzcGpKjtZ7wUyh99oy6ponrAIx0/xgrFzuwt8whkdTH5CiLdGc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] rename locking functions - convert init_MUTEX* users, part 4
Date: Thu, 18 Aug 2005 02:11:45 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180211.45947.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert users of init_MUTEX and init_MUTEX_LOCKED to
init_mutex and init_mutex_locked - part 4.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/linux-2.6/xfs_buf.c       |    4 ++--
 kernel/printk.c                  |    2 +-
 mm/slab.c                        |    2 +-
 net/bluetooth/hci_core.c         |    2 +-
 net/unix/af_unix.c               |    2 +-
 security/selinux/hooks.c         |    4 ++--
 sound/arm/aaci.c                 |    2 +-
 sound/core/hwdep.c               |    2 +-
 sound/core/info.c                |    2 +-
 sound/core/init.c                |    2 +-
 sound/core/oss/mixer_oss.c       |    2 +-
 sound/core/pcm.c                 |    4 ++--
 sound/core/rawmidi.c             |    2 +-
 sound/core/seq/seq_clientmgr.c   |    2 +-
 sound/core/seq/seq_device.c      |    2 +-
 sound/core/seq/seq_instr.c       |    2 +-
 sound/core/seq/seq_queue.c       |    2 +-
 sound/core/timer.c               |    2 +-
 sound/drivers/opl3/opl3_lib.c    |    2 +-
 sound/drivers/opl4/opl4_lib.c    |    2 +-
 sound/drivers/vx/vx_core.c       |    2 +-
 sound/i2c/i2c.c                  |    2 +-
 sound/isa/ad1848/ad1848_lib.c    |    2 +-
 sound/isa/cs423x/cs4231_lib.c    |    8 ++++----
 sound/isa/gus/gus_main.c         |    2 +-
 sound/isa/gus/gus_mem.c          |    2 +-
 sound/isa/gus/gus_synth.c        |    2 +-
 sound/isa/sb/sb16_csp.c          |    2 +-
 sound/oss/aci.c                  |    2 +-
 sound/oss/ad1889.c               |    2 +-
 sound/oss/ali5455.c              |    4 ++--
 sound/oss/au1000.c               |    4 ++--
 sound/oss/au1550_ac97.c          |    4 ++--
 sound/oss/btaudio.c              |    2 +-
 sound/oss/cmpci.c                |    2 +-
 sound/oss/cs4281/cs4281m.c       |    6 +++---
 sound/oss/cs46xx.c               |   10 +++++-----
 sound/oss/emu10k1/main.c         |    2 +-
 sound/oss/es1370.c               |    4 ++--
 sound/oss/es1371.c               |    4 ++--
 sound/oss/esssolo1.c             |    2 +-
 sound/oss/forte.c                |    2 +-
 sound/oss/hal2.c                 |    2 +-
 sound/oss/i810_audio.c           |    4 ++--
 sound/oss/ite8172.c              |    2 +-
 sound/oss/maestro.c              |    2 +-
 sound/oss/maestro3.c             |    2 +-
 sound/oss/nec_vrc5477.c          |    2 +-
 sound/oss/rme96xx.c              |    2 +-
 sound/oss/sonicvibes.c           |    2 +-
 sound/oss/swarm_cs4297a.c        |    4 ++--
 sound/oss/trident.c              |    4 ++--
 sound/oss/via82cxxx_audio.c      |    4 ++--
 sound/oss/vwsnd.c                |    6 +++---
 sound/oss/ymfpci.c               |    2 +-
 sound/pci/ac97/ac97_codec.c      |    4 ++--
 sound/pci/ac97/ak4531_codec.c    |    2 +-
 sound/pci/atiixp.c               |    2 +-
 sound/pci/atiixp_modem.c         |    2 +-
 sound/pci/cmipci.c               |    2 +-
 sound/pci/cs46xx/cs46xx_lib.c    |    2 +-
 sound/pci/emu10k1/emu10k1_main.c |    4 ++--
 sound/pci/ens1370.c              |    2 +-
 sound/pci/es1968.c               |    2 +-
 sound/pci/hda/hda_codec.c        |    4 ++--
 sound/pci/hda/hda_intel.c        |    2 +-
 sound/pci/hda/patch_analog.c     |    6 +++---
 sound/pci/hda/patch_realtek.c    |    6 +++---
 sound/pci/ice1712/ice1712.c      |    6 +++---
 sound/pci/ice1712/ice1724.c      |    6 +++---
 sound/pci/korg1212/korg1212.c    |    2 +-
 sound/pci/mixart/mixart.c        |    4 ++--
 sound/pci/mixart/mixart_mixer.c  |    2 +-
 sound/sparc/cs4231.c             |    8 ++++----
 sound/synth/emux/emux.c          |    2 +-
 sound/synth/emux/soundfont.c     |    2 +-
 sound/synth/util_mem.c           |    2 +-
 sound/usb/usx2y/usbusx2y.c       |    2 +-
 78 files changed, 116 insertions(+), 116 deletions(-)

--- linux-2.6.13-rc6-git9-orig/fs/xfs/linux-2.6/xfs_buf.c	2005-08-17 21:52:02.000000000 +0200
+++ linux-2.6.13-rc6-git9/fs/xfs/linux-2.6/xfs_buf.c	2005-08-18 00:55:13.000000000 +0200
@@ -271,10 +271,10 @@ _pagebuf_initialize(
 
 	memset(pb, 0, sizeof(xfs_buf_t));
 	atomic_set(&pb->pb_hold, 1);
-	init_MUTEX_LOCKED(&pb->pb_iodonesema);
+	init_mutex_locked(&pb->pb_iodonesema);
 	INIT_LIST_HEAD(&pb->pb_list);
 	INIT_LIST_HEAD(&pb->pb_hash_list);
-	init_MUTEX_LOCKED(&pb->pb_sema); /* held, no waiters */
+	init_mutex_locked(&pb->pb_sema); /* held, no waiters */
 	PB_SET_OWNER(pb);
 	pb->pb_target = target;
 	pb->pb_file_offset = range_base;
--- linux-2.6.13-rc6-git9-orig/kernel/printk.c	2005-08-17 21:52:07.000000000 +0200
+++ linux-2.6.13-rc6-git9/kernel/printk.c	2005-08-18 00:55:13.000000000 +0200
@@ -469,7 +469,7 @@ static void zap_locks(void)
 	/* If a crash is occurring, make sure we can't deadlock */
 	spin_lock_init(&logbuf_lock);
 	/* And make sure that we print immediately */
-	init_MUTEX(&console_sem);
+	init_mutex(&console_sem);
 }
 
 #if defined(CONFIG_PRINTK_TIME)
--- linux-2.6.13-rc6-git9-orig/mm/slab.c	2005-08-17 21:52:08.000000000 +0200
+++ linux-2.6.13-rc6-git9/mm/slab.c	2005-08-18 00:55:13.000000000 +0200
@@ -787,7 +787,7 @@ void __init kmem_cache_init(void)
 	 */
 
 	/* 1) create the cache_cache */
-	init_MUTEX(&cache_chain_sem);
+	init_mutex(&cache_chain_sem);
 	INIT_LIST_HEAD(&cache_chain);
 	list_add(&cache_cache.next, &cache_chain);
 	cache_cache.colour_off = cache_line_size();
--- linux-2.6.13-rc6-git9-orig/net/bluetooth/hci_core.c	2005-08-17 21:52:08.000000000 +0200
+++ linux-2.6.13-rc6-git9/net/bluetooth/hci_core.c	2005-08-18 00:55:13.000000000 +0200
@@ -858,7 +858,7 @@ int hci_register_dev(struct hci_dev *hde
 	skb_queue_head_init(&hdev->raw_q);
 
 	init_waitqueue_head(&hdev->req_wait_q);
-	init_MUTEX(&hdev->req_lock);
+	init_mutex(&hdev->req_lock);
 
 	inquiry_cache_init(hdev);
 
--- linux-2.6.13-rc6-git9-orig/net/unix/af_unix.c	2005-08-17 21:52:16.000000000 +0200
+++ linux-2.6.13-rc6-git9/net/unix/af_unix.c	2005-08-18 00:55:13.000000000 +0200
@@ -566,7 +566,7 @@ static struct sock * unix_create1(struct
 	u->mnt	  = NULL;
 	rwlock_init(&u->lock);
 	atomic_set(&u->inflight, sock ? 0 : -1);
-	init_MUTEX(&u->readsem); /* single task reading lock */
+	init_mutex(&u->readsem); /* single task reading lock */
 	init_waitqueue_head(&u->peer_wait);
 	unix_insert_socket(unix_sockets_unbound, sk);
 out:
--- linux-2.6.13-rc6-git9-orig/security/selinux/hooks.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/security/selinux/hooks.c	2005-08-18 00:55:13.000000000 +0200
@@ -156,7 +156,7 @@ static int inode_alloc_security(struct i
 		return -ENOMEM;
 
 	memset(isec, 0, sizeof(struct inode_security_struct));
-	init_MUTEX(&isec->sem);
+	init_mutex(&isec->sem);
 	INIT_LIST_HEAD(&isec->list);
 	isec->magic = SELINUX_MAGIC;
 	isec->inode = inode;
@@ -232,7 +232,7 @@ static int superblock_alloc_security(str
 		return -ENOMEM;
 
 	memset(sbsec, 0, sizeof(struct superblock_security_struct));
-	init_MUTEX(&sbsec->sem);
+	init_mutex(&sbsec->sem);
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
--- linux-2.6.13-rc6-git9-orig/sound/arm/aaci.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/arm/aaci.c	2005-08-18 00:55:13.000000000 +0200
@@ -788,7 +788,7 @@ static struct aaci * __devinit aaci_init
 		 card->shortname, dev->res.start, dev->irq[0]);
 
 	aaci = card->private_data;
-	init_MUTEX(&aaci->ac97_sem);
+	init_mutex(&aaci->ac97_sem);
 	spin_lock_init(&aaci->lock);
 	aaci->card = card;
 	aaci->dev = dev;
--- linux-2.6.13-rc6-git9-orig/sound/core/hwdep.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/hwdep.c	2005-08-18 00:55:13.000000000 +0200
@@ -375,7 +375,7 @@ int snd_hwdep_new(snd_card_t * card, cha
 		return err;
 	}
 	init_waitqueue_head(&hwdep->open_wait);
-	init_MUTEX(&hwdep->open_mutex);
+	init_mutex(&hwdep->open_mutex);
 	*rhwdep = hwdep;
 	return 0;
 }
--- linux-2.6.13-rc6-git9-orig/sound/core/info.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/info.c	2005-08-18 00:55:13.000000000 +0200
@@ -762,7 +762,7 @@ static snd_info_entry_t *snd_info_create
 	}
 	entry->mode = S_IFREG | S_IRUGO;
 	entry->content = SNDRV_INFO_CONTENT_TEXT;
-	init_MUTEX(&entry->access);
+	init_mutex(&entry->access);
 	return entry;
 }
 
--- linux-2.6.13-rc6-git9-orig/sound/core/init.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/init.c	2005-08-18 00:55:13.000000000 +0200
@@ -116,7 +116,7 @@ snd_card_t *snd_card_new(int idx, const 
 	init_waitqueue_head(&card->shutdown_sleep);
 	INIT_WORK(&card->free_workq, snd_card_free_thread, card);
 #ifdef CONFIG_PM
-	init_MUTEX(&card->power_lock);
+	init_mutex(&card->power_lock);
 	init_waitqueue_head(&card->power_sleep);
 #endif
 	/* the control interface cannot be accessed from the user space until */
--- linux-2.6.13-rc6-git9-orig/sound/core/oss/mixer_oss.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/oss/mixer_oss.c	2005-08-18 00:55:13.000000000 +0200
@@ -1265,7 +1265,7 @@ static int snd_mixer_oss_notify_handler(
 		mixer = kcalloc(2, sizeof(*mixer), GFP_KERNEL);
 		if (mixer == NULL)
 			return -ENOMEM;
-		init_MUTEX(&mixer->reg_mutex);
+		init_mutex(&mixer->reg_mutex);
 		sprintf(name, "mixer%i%i", card->number, 0);
 		if ((err = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MIXER,
 						   card, 0,
--- linux-2.6.13-rc6-git9-orig/sound/core/pcm.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/pcm.c	2005-08-18 00:55:13.000000000 +0200
@@ -584,7 +584,7 @@ int snd_pcm_new_stream(snd_pcm_t *pcm, i
 	snd_pcm_substream_t *substream, *prev;
 
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
-	init_MUTEX(&pstr->oss.setup_mutex);
+	init_mutex(&pstr->oss.setup_mutex);
 #endif
 	pstr->stream = stream;
 	pstr->pcm = pcm;
@@ -673,7 +673,7 @@ int snd_pcm_new(snd_card_t * card, char 
 		snd_pcm_free(pcm);
 		return err;
 	}
-	init_MUTEX(&pcm->open_mutex);
+	init_mutex(&pcm->open_mutex);
 	init_waitqueue_head(&pcm->open_wait);
 	if ((err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops)) < 0) {
 		snd_pcm_free(pcm);
--- linux-2.6.13-rc6-git9-orig/sound/core/rawmidi.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/rawmidi.c	2005-08-18 00:55:13.000000000 +0200
@@ -1418,7 +1418,7 @@ int snd_rawmidi_new(snd_card_t * card, c
 		return -ENOMEM;
 	rmidi->card = card;
 	rmidi->device = device;
-	init_MUTEX(&rmidi->open_mutex);
+	init_mutex(&rmidi->open_mutex);
 	init_waitqueue_head(&rmidi->open_wait);
 	if (id != NULL)
 		strlcpy(rmidi->id, id, sizeof(rmidi->id));
--- linux-2.6.13-rc6-git9-orig/sound/core/seq/seq_clientmgr.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/seq/seq_clientmgr.c	2005-08-18 00:55:13.000000000 +0200
@@ -214,7 +214,7 @@ static client_t *seq_create_client1(int 
 	client->type = NO_CLIENT;
 	snd_use_lock_init(&client->use_lock);
 	rwlock_init(&client->ports_lock);
-	init_MUTEX(&client->ports_mutex);
+	init_mutex(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
 
 	/* find free slot in the client table */
--- linux-2.6.13-rc6-git9-orig/sound/core/seq/seq_device.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/seq/seq_device.c	2005-08-18 00:55:13.000000000 +0200
@@ -377,7 +377,7 @@ static ops_list_t * create_driver(char *
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
-	init_MUTEX(&ops->reg_mutex);
+	init_mutex(&ops->reg_mutex);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
 	/* lock this instance */
--- linux-2.6.13-rc6-git9-orig/sound/core/seq/seq_instr.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/seq/seq_instr.c	2005-08-18 00:55:13.000000000 +0200
@@ -82,7 +82,7 @@ snd_seq_kinstr_list_t *snd_seq_instr_lis
 		return NULL;
 	spin_lock_init(&list->lock);
 	spin_lock_init(&list->ops_lock);
-	init_MUTEX(&list->ops_mutex);
+	init_mutex(&list->ops_mutex);
 	list->owner = -1;
 	return list;
 }
--- linux-2.6.13-rc6-git9-orig/sound/core/seq/seq_queue.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/seq/seq_queue.c	2005-08-18 00:55:13.000000000 +0200
@@ -119,7 +119,7 @@ static queue_t *queue_new(int owner, int
 
 	spin_lock_init(&q->owner_lock);
 	spin_lock_init(&q->check_lock);
-	init_MUTEX(&q->timer_mutex);
+	init_mutex(&q->timer_mutex);
 	snd_use_lock_init(&q->use_lock);
 	q->queue = -1;
 
--- linux-2.6.13-rc6-git9-orig/sound/core/timer.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/core/timer.c	2005-08-18 00:55:13.000000000 +0200
@@ -1205,7 +1205,7 @@ static int snd_timer_user_open(struct in
 		return -ENOMEM;
 	spin_lock_init(&tu->qlock);
 	init_waitqueue_head(&tu->qchange_sleep);
-	init_MUTEX(&tu->tread_sem);
+	init_mutex(&tu->tread_sem);
 	tu->ticks = 1;
 	tu->queue_size = 128;
 	tu->queue = (snd_timer_read_t *)kmalloc(tu->queue_size * sizeof(snd_timer_read_t), GFP_KERNEL);
--- linux-2.6.13-rc6-git9-orig/sound/drivers/opl3/opl3_lib.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/drivers/opl3/opl3_lib.c	2005-08-18 00:55:14.000000000 +0200
@@ -362,7 +362,7 @@ int snd_opl3_new(snd_card_t *card,
 	opl3->hardware = hardware;
 	spin_lock_init(&opl3->reg_lock);
 	spin_lock_init(&opl3->timer_lock);
-	init_MUTEX(&opl3->access_mutex);
+	init_mutex(&opl3->access_mutex);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_CODEC, opl3, &ops)) < 0) {
 		snd_opl3_free(opl3);
--- linux-2.6.13-rc6-git9-orig/sound/drivers/opl4/opl4_lib.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/drivers/opl4/opl4_lib.c	2005-08-18 00:55:14.000000000 +0200
@@ -220,7 +220,7 @@ int snd_opl4_create(snd_card_t *card,
 	opl4->fm_port = fm_port;
 	opl4->pcm_port = pcm_port;
 	spin_lock_init(&opl4->reg_lock);
-	init_MUTEX(&opl4->access_mutex);
+	init_mutex(&opl4->access_mutex);
 
 	err = snd_opl4_detect(opl4);
 	if (err < 0) {
--- linux-2.6.13-rc6-git9-orig/sound/drivers/vx/vx_core.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/drivers/vx/vx_core.c	2005-08-18 00:55:14.000000000 +0200
@@ -794,7 +794,7 @@ vx_core_t *snd_vx_create(snd_card_t *car
 	chip->type = hw->type;
 	chip->ops = ops;
 	tasklet_init(&chip->tq, vx_interrupt, (unsigned long)chip);
-	init_MUTEX(&chip->mixer_mutex);
+	init_mutex(&chip->mixer_mutex);
 
 	chip->card = card;
 	card->private_data = chip;
--- linux-2.6.13-rc6-git9-orig/sound/i2c/i2c.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/i2c/i2c.c	2005-08-18 00:55:14.000000000 +0200
@@ -84,7 +84,7 @@ int snd_i2c_bus_create(snd_card_t *card,
 	bus = kcalloc(1, sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return -ENOMEM;
-	init_MUTEX(&bus->lock_mutex);
+	init_mutex(&bus->lock_mutex);
 	INIT_LIST_HEAD(&bus->devices);
 	INIT_LIST_HEAD(&bus->buses);
 	bus->card = card;
--- linux-2.6.13-rc6-git9-orig/sound/isa/ad1848/ad1848_lib.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/ad1848/ad1848_lib.c	2005-08-18 00:55:14.000000000 +0200
@@ -894,7 +894,7 @@ int snd_ad1848_create(snd_card_t * card,
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->port = port;
 	chip->irq = -1;
--- linux-2.6.13-rc6-git9-orig/sound/isa/cs423x/cs4231_lib.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/cs423x/cs4231_lib.c	2005-08-18 00:55:14.000000000 +0200
@@ -1485,8 +1485,8 @@ static int snd_cs4231_new(snd_card_t * c
 	chip->hwshare = hwshare;
 
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->mce_mutex);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->mce_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->rate_constraint = snd_cs4231_xrate;
 	chip->set_playback_format = snd_cs4231_playback_format;
@@ -1625,8 +1625,8 @@ int snd_cs4231_pcm(cs4231_t *chip, int d
 		return err;
 
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->mce_mutex);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->mce_mutex);
+	init_mutex(&chip->open_mutex);
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_cs4231_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_cs4231_capture_ops);
--- linux-2.6.13-rc6-git9-orig/sound/isa/gus/gus_main.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/gus/gus_main.c	2005-08-18 00:55:14.000000000 +0200
@@ -231,7 +231,7 @@ int snd_gus_create(snd_card_t * card,
 	spin_lock_init(&gus->dma_lock);
 	spin_lock_init(&gus->pcm_volume_level_lock);
 	spin_lock_init(&gus->uart_cmd_lock);
-	init_MUTEX(&gus->dma_mutex);
+	init_mutex(&gus->dma_mutex);
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, gus, &ops)) < 0) {
 		snd_gus_free(gus);
 		return err;
--- linux-2.6.13-rc6-git9-orig/sound/isa/gus/gus_mem.c	2005-08-17 21:52:17.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/gus/gus_mem.c	2005-08-18 00:55:14.000000000 +0200
@@ -244,7 +244,7 @@ int snd_gf1_mem_init(snd_gus_card_t * gu
 #endif
 
 	alloc = &gus->gf1.mem_alloc;
-	init_MUTEX(&alloc->memory_mutex);
+	init_mutex(&alloc->memory_mutex);
 	alloc->first = alloc->last = NULL;
 	if (!gus->gf1.memory)
 		return 0;
--- linux-2.6.13-rc6-git9-orig/sound/isa/gus/gus_synth.c	2005-08-17 21:52:18.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/gus/gus_synth.c	2005-08-18 00:55:14.000000000 +0200
@@ -225,7 +225,7 @@ static int snd_gus_synth_new_device(snd_
 	if (gus == NULL)
 		return -EINVAL;
 
-	init_MUTEX(&gus->register_mutex);
+	init_mutex(&gus->register_mutex);
 	gus->gf1.seq_client = -1;
 	
 	cinfo = kmalloc(sizeof(*cinfo), GFP_KERNEL);
--- linux-2.6.13-rc6-git9-orig/sound/isa/sb/sb16_csp.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/isa/sb/sb16_csp.c	2005-08-18 00:55:14.000000000 +0200
@@ -139,7 +139,7 @@ int snd_sb_csp_new(sb_t *chip, int devic
 	p->ops.csp_stop = snd_sb_csp_stop;
 	p->ops.csp_qsound_transfer = snd_sb_csp_qsound_transfer;
 
-	init_MUTEX(&p->access_mutex);
+	init_mutex(&p->access_mutex);
 	sprintf(hw->name, "CSP v%d.%d", (version >> 4), (version & 0x0f));
 	hw->iface = SNDRV_HWDEP_IFACE_SB16CSP;
 	hw->private_data = p;
--- linux-2.6.13-rc6-git9-orig/sound/oss/aci.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/aci.c	2005-08-18 00:55:14.000000000 +0200
@@ -603,7 +603,7 @@ static int __init attach_aci(void)
 	char *boardname;
 	int i, rc = -EBUSY;
 
-	init_MUTEX(&aci_sem);
+	init_mutex(&aci_sem);
 
 	outb(0xE3, 0xf8f); /* Write MAD16 password */
 	aci_port = (inb(0xf90) & 0x10) ?
--- linux-2.6.13-rc6-git9-orig/sound/oss/ad1889.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/ad1889.c	2005-08-18 00:55:14.000000000 +0200
@@ -238,7 +238,7 @@ static ad1889_dev_t *ad1889_alloc_dev(st
 
 	for (i = 0; i < AD_MAX_STATES; i++) {
 		dev->state[i].card = dev;
-		init_MUTEX(&dev->state[i].sem);
+		init_mutex(&dev->state[i].sem);
 		init_waitqueue_head(&dev->state[i].dmabuf.wait);
 	}
 
--- linux-2.6.13-rc6-git9-orig/sound/oss/ali5455.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/ali5455.c	2005-08-18 00:55:14.000000000 +0200
@@ -2807,7 +2807,7 @@ found_virt:
 	state->card = card;
 	state->magic = ALI5455_STATE_MAGIC;
 	init_waitqueue_head(&dmabuf->wait);
-	init_MUTEX(&state->open_sem);
+	init_mutex(&state->open_sem);
 	file->private_data = state;
 	dmabuf->trigger = 0;
 	/* allocate hardware channels */
@@ -3359,7 +3359,7 @@ static void __devinit ali_configure_cloc
 		state->card = card;
 		state->magic = ALI5455_STATE_MAGIC;
 		init_waitqueue_head(&dmabuf->wait);
-		init_MUTEX(&state->open_sem);
+		init_mutex(&state->open_sem);
 		dmabuf->fmt = ALI5455_FMT_STEREO | ALI5455_FMT_16BIT;
 		dmabuf->trigger = PCM_ENABLE_OUTPUT;
 		ali_set_dac_rate(state, 48000);
--- linux-2.6.13-rc6-git9-orig/sound/oss/au1000.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/au1000.c	2005-08-18 00:55:14.000000000 +0200
@@ -1880,7 +1880,7 @@ static int  au1000_open(struct inode *in
 
 	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&s->open_sem);
-	init_MUTEX(&s->sem);
+	init_mutex(&s->sem);
 	return nonseekable_open(inode, file);
 }
 
@@ -1996,7 +1996,7 @@ static int __devinit au1000_probe(void)
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->codec.private_data = s;
 	s->codec.id = 0;
--- linux-2.6.13-rc6-git9-orig/sound/oss/au1550_ac97.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/au1550_ac97.c	2005-08-18 00:55:14.000000000 +0200
@@ -1835,7 +1835,7 @@ au1550_open(struct inode *inode, struct 
 
 	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&s->open_sem);
-	init_MUTEX(&s->sem);
+	init_mutex(&s->sem);
 	return 0;
 }
 
@@ -1896,7 +1896,7 @@ au1550_probe(void)
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 
 	s->codec = ac97_alloc_codec();
--- linux-2.6.13-rc6-git9-orig/sound/oss/btaudio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/btaudio.c	2005-08-18 00:55:14.000000000 +0200
@@ -941,7 +941,7 @@ static int __devinit btaudio_probe(struc
 	if (rate)
 		bta->rate = rate;
 	
-	init_MUTEX(&bta->lock);
+	init_mutex(&bta->lock);
         init_waitqueue_head(&bta->readq);
 
 	if (-1 != latency) {
--- linux-2.6.13-rc6-git9-orig/sound/oss/cmpci.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/cmpci.c	2005-08-18 00:55:14.000000000 +0200
@@ -3080,7 +3080,7 @@ static int __devinit cm_probe(struct pci
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->magic = CM_MAGIC;
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/cs4281/cs4281m.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/cs4281/cs4281m.c	2005-08-18 00:55:14.000000000 +0200
@@ -4303,9 +4303,9 @@ static int __devinit cs4281_probe(struct
 	init_waitqueue_head(&s->open_wait_dac);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
-	init_MUTEX(&s->open_sem_adc);
-	init_MUTEX(&s->open_sem_dac);
+	init_mutex(&s->open_sem);
+	init_mutex(&s->open_sem_adc);
+	init_mutex(&s->open_sem_dac);
 	spin_lock_init(&s->lock);
 	s->pBA0phys = pci_resource_start(pcidev, 0);
 	s->pBA1phys = pci_resource_start(pcidev, 1);
--- linux-2.6.13-rc6-git9-orig/sound/oss/cs46xx.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/cs46xx.c	2005-08-18 00:55:14.000000000 +0200
@@ -3204,7 +3204,7 @@ static int cs_open(struct inode *inode, 
 			if (state == NULL)
 				return -ENOMEM;
 			memset(state, 0, sizeof(struct cs_state));
-			init_MUTEX(&state->sem);
+			init_mutex(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 			if(dmabuf->pbuf==NULL)
@@ -3245,7 +3245,7 @@ static int cs_open(struct inode *inode, 
 		state->virt = 0;
 		state->magic = CS_STATE_MAGIC;
 		init_waitqueue_head(&dmabuf->wait);
-		init_MUTEX(&state->open_sem);
+		init_mutex(&state->open_sem);
 		file->private_data = card;
 
 		down(&state->open_sem);
@@ -3275,7 +3275,7 @@ static int cs_open(struct inode *inode, 
 			if (state == NULL)
 				return -ENOMEM;
 			memset(state, 0, sizeof(struct cs_state));
-			init_MUTEX(&state->sem);
+			init_mutex(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 			if(dmabuf->pbuf==NULL)
@@ -3316,7 +3316,7 @@ static int cs_open(struct inode *inode, 
 		state->virt = 1;
 		state->magic = CS_STATE_MAGIC;
 		init_waitqueue_head(&dmabuf->wait);
-		init_MUTEX(&state->open_sem);
+		init_mutex(&state->open_sem);
 		file->private_data = card;
 
 		down(&state->open_sem);
@@ -5512,7 +5512,7 @@ static int __devinit cs46xx_probe(struct
 	}
 
         init_waitqueue_head(&card->midi.open_wait);
-        init_MUTEX(&card->midi.open_sem);
+        init_mutex(&card->midi.open_sem);
         init_waitqueue_head(&card->midi.iwait);
         init_waitqueue_head(&card->midi.owait);
         cs461x_pokeBA0(card, BA0_MIDCR, MIDCR_MRST);   
--- linux-2.6.13-rc6-git9-orig/sound/oss/emu10k1/main.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/emu10k1/main.c	2005-08-18 00:55:14.000000000 +0200
@@ -1320,7 +1320,7 @@ static int __devinit emu10k1_probe(struc
 	card->is_aps = (subsysvid == EMU_APS_SUBID);
 
 	spin_lock_init(&card->lock);
-	init_MUTEX(&card->open_sem);
+	init_mutex(&card->open_sem);
 	card->open_mode = 0;
 	init_waitqueue_head(&card->open_wait);
 
--- linux-2.6.13-rc6-git9-orig/sound/oss/es1370.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/es1370.c	2005-08-18 00:55:14.000000000 +0200
@@ -1794,7 +1794,7 @@ static int es1370_open(struct inode *ino
 	spin_unlock_irqrestore(&s->lock, flags);
 	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&s->open_sem);
-	init_MUTEX(&s->sem);
+	init_mutex(&s->sem);
 	return nonseekable_open(inode, file);
 }
 
@@ -2638,7 +2638,7 @@ static int __devinit es1370_probe(struct
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->magic = ES1370_MAGIC;
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/es1371.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/es1371.c	2005-08-18 00:55:14.000000000 +0200
@@ -1983,7 +1983,7 @@ static int es1371_open(struct inode *ino
 	spin_unlock_irqrestore(&s->lock, flags);
 	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&s->open_sem);
-	init_MUTEX(&s->sem);
+	init_mutex(&s->sem);
 	return nonseekable_open(inode, file);
 }
 
@@ -2884,7 +2884,7 @@ static int __devinit es1371_probe(struct
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->magic = ES1371_MAGIC;
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/esssolo1.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/esssolo1.c	2005-08-18 00:55:14.000000000 +0200
@@ -2362,7 +2362,7 @@ static int __devinit solo1_probe(struct 
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->magic = SOLO1_MAGIC;
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/forte.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/forte.c	2005-08-18 00:55:14.000000000 +0200
@@ -2011,7 +2011,7 @@ forte_probe (struct pci_dev *pci_dev, co
 	memset (chip, 0, sizeof (struct forte_chip));
 	chip->pci_dev = pci_dev;
 
-	init_MUTEX(&chip->open_sem);
+	init_mutex(&chip->open_sem);
 	spin_lock_init (&chip->lock);
 	spin_lock_init (&chip->ac97_lock);
 
--- linux-2.6.13-rc6-git9-orig/sound/oss/hal2.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/hal2.c	2005-08-18 00:55:14.000000000 +0200
@@ -1400,7 +1400,7 @@ static void hal2_init_codec(struct hal2_
 	codec->pbus.pbusnr = index;
 	codec->pbus.pbus = &hpc3->pbdma[index];
 	init_waitqueue_head(&codec->dma_wait);
-	init_MUTEX(&codec->sem);
+	init_mutex(&codec->sem);
 	spin_lock_init(&codec->lock);
 }
 
--- linux-2.6.13-rc6-git9-orig/sound/oss/i810_audio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/i810_audio.c	2005-08-18 00:55:14.000000000 +0200
@@ -2596,7 +2596,7 @@ found_virt:
 	state->card = card;
 	state->magic = I810_STATE_MAGIC;
 	init_waitqueue_head(&dmabuf->wait);
-	init_MUTEX(&state->open_sem);
+	init_mutex(&state->open_sem);
 	file->private_data = state;
 	dmabuf->trigger = 0;
 
@@ -3212,7 +3212,7 @@ static void __devinit i810_configure_clo
 		state->card = card;
 		state->magic = I810_STATE_MAGIC;
 		init_waitqueue_head(&dmabuf->wait);
-		init_MUTEX(&state->open_sem);
+		init_mutex(&state->open_sem);
 		dmabuf->fmt = I810_FMT_STEREO | I810_FMT_16BIT;
 		dmabuf->trigger = PCM_ENABLE_OUTPUT;
 		i810_set_spdif_output(state, -1, 0);
--- linux-2.6.13-rc6-git9-orig/sound/oss/ite8172.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/ite8172.c	2005-08-18 00:55:14.000000000 +0200
@@ -1997,7 +1997,7 @@ static int __devinit it8172_probe(struct
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->dev = pcidev;
 	s->io = pci_resource_start(pcidev, 0);
--- linux-2.6.13-rc6-git9-orig/sound/oss/maestro.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/maestro.c	2005-08-18 00:55:14.000000000 +0200
@@ -3475,7 +3475,7 @@ maestro_probe(struct pci_dev *pcidev,con
 		init_waitqueue_head(&s->dma_dac.wait);
 		init_waitqueue_head(&s->open_wait);
 		spin_lock_init(&s->lock);
-		init_MUTEX(&s->open_sem);
+		init_mutex(&s->open_sem);
 		s->magic = ESS_STATE_MAGIC;
 		
 		s->apu[0] = 6*i;
--- linux-2.6.13-rc6-git9-orig/sound/oss/maestro3.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/maestro3.c	2005-08-18 00:55:14.000000000 +0200
@@ -2679,7 +2679,7 @@ static int __devinit m3_probe(struct pci
         init_waitqueue_head(&s->dma_adc.wait);
         init_waitqueue_head(&s->dma_dac.wait);
         init_waitqueue_head(&s->open_wait);
-        init_MUTEX(&(s->open_sem));
+        init_mutex(&(s->open_sem));
         s->magic = M3_STATE_MAGIC;
 
         m3_assp_client_init(s);
--- linux-2.6.13-rc6-git9-orig/sound/oss/nec_vrc5477.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/nec_vrc5477.c	2005-08-18 00:55:14.000000000 +0200
@@ -1867,7 +1867,7 @@ static int __devinit vrc5477_ac97_probe(
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/rme96xx.c	2005-08-17 21:52:19.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/rme96xx.c	2005-08-18 00:55:14.000000000 +0200
@@ -843,7 +843,7 @@ static void busmaster_free(void* ptr,int
 
 static int rme96xx_dmabuf_init(rme96xx_info * s,struct dmabuf* dma,int ioffset,int ooffset) {
 
-	init_MUTEX(&dma->open_sem);
+	init_mutex(&dma->open_sem);
 	init_waitqueue_head(&dma->open_wait);
 	init_waitqueue_head(&dma->wait);
 	dma->s = s; 
--- linux-2.6.13-rc6-git9-orig/sound/oss/sonicvibes.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/sonicvibes.c	2005-08-18 00:55:14.000000000 +0200
@@ -2582,7 +2582,7 @@ static int __devinit sv_probe(struct pci
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
+	init_mutex(&s->open_sem);
 	spin_lock_init(&s->lock);
 	s->magic = SV_MAGIC;
 	s->dev = pcidev;
--- linux-2.6.13-rc6-git9-orig/sound/oss/swarm_cs4297a.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/swarm_cs4297a.c	2005-08-18 00:55:14.000000000 +0200
@@ -2631,8 +2631,8 @@ static int __init cs4297a_init(void)
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->open_wait_adc);
 	init_waitqueue_head(&s->open_wait_dac);
-	init_MUTEX(&s->open_sem_adc);
-	init_MUTEX(&s->open_sem_dac);
+	init_mutex(&s->open_sem_adc);
+	init_mutex(&s->open_sem_dac);
 	spin_lock_init(&s->lock);
 
         s->irq = K_INT_SER_1;
--- linux-2.6.13-rc6-git9-orig/sound/oss/trident.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/trident.c	2005-08-18 00:55:14.000000000 +0200
@@ -2746,7 +2746,7 @@ trident_open(struct inode *inode, struct
 					return -ENOMEM;
 				}
 				memset(state, 0, sizeof(*state));
-				init_MUTEX(&state->sem);
+				init_mutex(&state->sem);
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -4407,7 +4407,7 @@ trident_probe(struct pci_dev *pci_dev, c
 	card->banks[BANK_B].addresses = &bank_b_addrs;
 	card->banks[BANK_B].bitmap = 0UL;
 
-	init_MUTEX(&card->open_sem);
+	init_mutex(&card->open_sem);
 	spin_lock_init(&card->lock);
 	init_timer(&card->timer);
 
--- linux-2.6.13-rc6-git9-orig/sound/oss/via82cxxx_audio.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/via82cxxx_audio.c	2005-08-18 00:55:14.000000000 +0200
@@ -3414,8 +3414,8 @@ static int __devinit via_init_one (struc
 	card->card_num = via_num_cards++;
 	spin_lock_init (&card->lock);
 	spin_lock_init (&card->ac97_lock);
-	init_MUTEX (&card->syscall_sem);
-	init_MUTEX (&card->open_sem);
+	init_mutex (&card->syscall_sem);
+	init_mutex (&card->open_sem);
 
 	/* we must init these now, in case the intr handler needs them */
 	via_chan_init_defaults (card, &card->ch_out);
--- linux-2.6.13-rc6-git9-orig/sound/oss/vwsnd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/vwsnd.c	2005-08-18 00:55:14.000000000 +0200
@@ -3376,9 +3376,9 @@ static int __init attach_vwsnd(struct ad
 
 	/* Initialize as much of *devc as possible */
 
-	init_MUTEX(&devc->open_sema);
-	init_MUTEX(&devc->io_sema);
-	init_MUTEX(&devc->mix_sema);
+	init_mutex(&devc->open_sema);
+	init_mutex(&devc->io_sema);
+	init_mutex(&devc->mix_sema);
 	devc->open_mode = 0;
 	spin_lock_init(&devc->rport.lock);
 	init_waitqueue_head(&devc->rport.queue);
--- linux-2.6.13-rc6-git9-orig/sound/oss/ymfpci.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/oss/ymfpci.c	2005-08-18 00:55:14.000000000 +0200
@@ -2531,7 +2531,7 @@ static int __devinit ymf_probe_one(struc
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
 	spin_lock_init(&codec->ac97_lock);
-	init_MUTEX(&codec->open_sem);
+	init_mutex(&codec->open_sem);
 	INIT_LIST_HEAD(&codec->states);
 	codec->pci = pcidev;
 
--- linux-2.6.13-rc6-git9-orig/sound/pci/ac97/ac97_codec.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/ac97/ac97_codec.c	2005-08-18 00:55:14.000000000 +0200
@@ -1876,8 +1876,8 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 	ac97->limited_regs = template->limited_regs;
 	memcpy(ac97->reg_accessed, template->reg_accessed, sizeof(ac97->reg_accessed));
 	bus->codec[ac97->num] = ac97;
-	init_MUTEX(&ac97->reg_mutex);
-	init_MUTEX(&ac97->page_mutex);
+	init_mutex(&ac97->reg_mutex);
+	init_mutex(&ac97->page_mutex);
 
 	if (ac97->pci) {
 		pci_read_config_word(ac97->pci, PCI_SUBSYSTEM_VENDOR_ID, &ac97->subsystem_vendor);
--- linux-2.6.13-rc6-git9-orig/sound/pci/ac97/ak4531_codec.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/ac97/ak4531_codec.c	2005-08-18 00:55:14.000000000 +0200
@@ -361,7 +361,7 @@ int snd_ak4531_mixer(snd_card_t * card, 
 	if (ak4531 == NULL)
 		return -ENOMEM;
 	*ak4531 = *_ak4531;
-	init_MUTEX(&ak4531->reg_mutex);
+	init_mutex(&ak4531->reg_mutex);
 	if ((err = snd_component_add(card, "AK4531")) < 0) {
 		snd_ak4531_free(ak4531);
 		return err;
--- linux-2.6.13-rc6-git9-orig/sound/pci/atiixp.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/atiixp.c	2005-08-18 00:55:14.000000000 +0200
@@ -1529,7 +1529,7 @@ static int __devinit snd_atiixp_create(s
 	}
 
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
--- linux-2.6.13-rc6-git9-orig/sound/pci/atiixp_modem.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/atiixp_modem.c	2005-08-18 00:55:14.000000000 +0200
@@ -1215,7 +1215,7 @@ static int __devinit snd_atiixp_create(s
 	}
 
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
--- linux-2.6.13-rc6-git9-orig/sound/pci/cmipci.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/cmipci.c	2005-08-18 00:55:14.000000000 +0200
@@ -2808,7 +2808,7 @@ static int __devinit snd_cmipci_create(s
 	}
 
 	spin_lock_init(&cm->reg_lock);
-	init_MUTEX(&cm->open_mutex);
+	init_mutex(&cm->open_mutex);
 	cm->device = pci->device;
 	cm->card = card;
 	cm->pci = pci;
--- linux-2.6.13-rc6-git9-orig/sound/pci/cs46xx/cs46xx_lib.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/cs46xx/cs46xx_lib.c	2005-08-18 00:55:14.000000000 +0200
@@ -3785,7 +3785,7 @@ int __devinit snd_cs46xx_create(snd_card
 	}
 	spin_lock_init(&chip->reg_lock);
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	init_MUTEX(&chip->spos_mutex);
+	init_mutex(&chip->spos_mutex);
 #endif
 	chip->card = card;
 	chip->pci = pci;
--- linux-2.6.13-rc6-git9-orig/sound/pci/emu10k1/emu10k1_main.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/emu10k1/emu10k1_main.c	2005-08-18 00:55:14.000000000 +0200
@@ -868,8 +868,8 @@ int __devinit snd_emu10k1_create(snd_car
 	spin_lock_init(&emu->voice_lock);
 	spin_lock_init(&emu->synth_lock);
 	spin_lock_init(&emu->memblk_lock);
-	init_MUTEX(&emu->ptb_lock);
-	init_MUTEX(&emu->fx8010.lock);
+	init_mutex(&emu->ptb_lock);
+	init_mutex(&emu->fx8010.lock);
 	INIT_LIST_HEAD(&emu->mapped_link_head);
 	INIT_LIST_HEAD(&emu->mapped_order_link_head);
 	emu->pci = pci;
--- linux-2.6.13-rc6-git9-orig/sound/pci/ens1370.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/ens1370.c	2005-08-18 00:55:14.000000000 +0200
@@ -1956,7 +1956,7 @@ static int __devinit snd_ensoniq_create(
 		return -ENOMEM;
 	}
 	spin_lock_init(&ensoniq->reg_lock);
-	init_MUTEX(&ensoniq->src_mutex);
+	init_mutex(&ensoniq->src_mutex);
 	ensoniq->card = card;
 	ensoniq->pci = pci;
 	ensoniq->irq = -1;
--- linux-2.6.13-rc6-git9-orig/sound/pci/es1968.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/es1968.c	2005-08-18 00:55:14.000000000 +0200
@@ -2601,7 +2601,7 @@ static int __devinit snd_es1968_create(s
 	INIT_LIST_HEAD(&chip->buf_list);
 	INIT_LIST_HEAD(&chip->substream_list);
 	spin_lock_init(&chip->ac97_lock);
-	init_MUTEX(&chip->memory_mutex);
+	init_mutex(&chip->memory_mutex);
 	tasklet_init(&chip->hwvol_tq, es1968_update_hw_volume, (unsigned long)chip);
 	chip->card = card;
 	chip->pci = pci;
--- linux-2.6.13-rc6-git9-orig/sound/pci/hda/hda_codec.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/hda/hda_codec.c	2005-08-18 00:55:14.000000000 +0200
@@ -370,7 +370,7 @@ int snd_hda_bus_new(snd_card_t *card, co
 	bus->modelname = temp->modelname;
 	bus->ops = temp->ops;
 
-	init_MUTEX(&bus->cmd_mutex);
+	init_mutex(&bus->cmd_mutex);
 	INIT_LIST_HEAD(&bus->codec_list);
 
 	init_unsol_queue(bus);
@@ -497,7 +497,7 @@ int snd_hda_codec_new(struct hda_bus *bu
 
 	codec->bus = bus;
 	codec->addr = codec_addr;
-	init_MUTEX(&codec->spdif_mutex);
+	init_mutex(&codec->spdif_mutex);
 	init_amp_hash(codec);
 
 	list_add_tail(&codec->list, &bus->codec_list);
--- linux-2.6.13-rc6-git9-orig/sound/pci/hda/hda_intel.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/hda/hda_intel.c	2005-08-18 00:55:14.000000000 +0200
@@ -1312,7 +1312,7 @@ static int __devinit azx_create(snd_card
 	}
 
 	spin_lock_init(&chip->reg_lock);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
--- linux-2.6.13-rc6-git9-orig/sound/pci/hda/patch_analog.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/hda/patch_analog.c	2005-08-18 00:55:14.000000000 +0200
@@ -469,7 +469,7 @@ static int patch_ad1986a(struct hda_code
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->amp_mutex);
+	init_mutex(&spec->amp_mutex);
 	codec->spec = spec;
 
 	spec->multiout.max_channels = 6;
@@ -627,7 +627,7 @@ static int patch_ad1983(struct hda_codec
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->amp_mutex);
+	init_mutex(&spec->amp_mutex);
 	codec->spec = spec;
 
 	spec->multiout.max_channels = 2;
@@ -768,7 +768,7 @@ static int patch_ad1981(struct hda_codec
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->amp_mutex);
+	init_mutex(&spec->amp_mutex);
 	codec->spec = spec;
 
 	spec->multiout.max_channels = 2;
--- linux-2.6.13-rc6-git9-orig/sound/pci/hda/patch_realtek.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/hda/patch_realtek.c	2005-08-18 00:55:14.000000000 +0200
@@ -2090,7 +2090,7 @@ static int patch_alc880(struct hda_codec
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->bind_mutex);
+	init_mutex(&spec->bind_mutex);
 	codec->spec = spec;
 
 	board_config = snd_hda_check_board_config(codec, alc880_cfg_tbl);
@@ -2362,7 +2362,7 @@ static int patch_alc260(struct hda_codec
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->bind_mutex);
+	init_mutex(&spec->bind_mutex);
 	codec->spec = spec;
 
 	board_config = snd_hda_check_board_config(codec, alc260_cfg_tbl);
@@ -2612,7 +2612,7 @@ static int patch_alc882(struct hda_codec
 	if (spec == NULL)
 		return -ENOMEM;
 
-	init_MUTEX(&spec->bind_mutex);
+	init_mutex(&spec->bind_mutex);
 	codec->spec = spec;
 
 	spec->mixers[spec->num_mixers] = alc882_base_mixer;
--- linux-2.6.13-rc6-git9-orig/sound/pci/ice1712/ice1712.c	2005-08-17 21:52:20.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/ice1712/ice1712.c	2005-08-18 00:55:14.000000000 +0200
@@ -2547,9 +2547,9 @@ static int __devinit snd_ice1712_create(
 		cs8427_timeout = 1000;
 	ice->cs8427_timeout = cs8427_timeout;
 	spin_lock_init(&ice->reg_lock);
-	init_MUTEX(&ice->gpio_mutex);
-	init_MUTEX(&ice->i2c_mutex);
-	init_MUTEX(&ice->open_mutex);
+	init_mutex(&ice->gpio_mutex);
+	init_mutex(&ice->i2c_mutex);
+	init_mutex(&ice->open_mutex);
 	ice->gpio.set_mask = snd_ice1712_set_gpio_mask;
 	ice->gpio.set_dir = snd_ice1712_set_gpio_dir;
 	ice->gpio.set_data = snd_ice1712_set_gpio_data;
--- linux-2.6.13-rc6-git9-orig/sound/pci/ice1712/ice1724.c	2005-08-17 21:52:21.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/ice1712/ice1724.c	2005-08-18 00:55:14.000000000 +0200
@@ -2137,9 +2137,9 @@ static int __devinit snd_vt1724_create(s
 	}
 	ice->vt1724 = 1;
 	spin_lock_init(&ice->reg_lock);
-	init_MUTEX(&ice->gpio_mutex);
-	init_MUTEX(&ice->open_mutex);
-	init_MUTEX(&ice->i2c_mutex);
+	init_mutex(&ice->gpio_mutex);
+	init_mutex(&ice->open_mutex);
+	init_mutex(&ice->i2c_mutex);
 	ice->gpio.set_mask = snd_vt1724_set_gpio_mask;
 	ice->gpio.set_dir = snd_vt1724_set_gpio_dir;
 	ice->gpio.set_data = snd_vt1724_set_gpio_data;
--- linux-2.6.13-rc6-git9-orig/sound/pci/korg1212/korg1212.c	2005-08-17 21:52:21.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/korg1212/korg1212.c	2005-08-18 00:55:14.000000000 +0200
@@ -2231,7 +2231,7 @@ static int __devinit snd_korg1212_create
 
         init_waitqueue_head(&korg1212->wait);
         spin_lock_init(&korg1212->lock);
-	init_MUTEX(&korg1212->open_mutex);
+	init_mutex(&korg1212->open_mutex);
 	init_timer(&korg1212->timer);
 	korg1212->timer.function = snd_korg1212_timer_func;
 	korg1212->timer.data = (unsigned long)korg1212;
--- linux-2.6.13-rc6-git9-orig/sound/pci/mixart/mixart.c	2005-08-17 21:52:21.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/mixart/mixart.c	2005-08-18 00:55:14.000000000 +0200
@@ -1331,12 +1331,12 @@ static int __devinit snd_mixart_probe(st
 	mgr->msg_fifo_writeptr = 0;
 
 	spin_lock_init(&mgr->msg_lock);
-	init_MUTEX(&mgr->msg_mutex);
+	init_mutex(&mgr->msg_mutex);
 	init_waitqueue_head(&mgr->msg_sleep);
 	atomic_set(&mgr->msg_processed, 0);
 
 	/* init setup mutex*/
-	init_MUTEX(&mgr->setup_mutex);
+	init_mutex(&mgr->setup_mutex);
 
 	/* init message taslket */
 	tasklet_init( &mgr->msg_taskq, snd_mixart_msg_tasklet, (unsigned long) mgr);
--- linux-2.6.13-rc6-git9-orig/sound/pci/mixart/mixart_mixer.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/pci/mixart/mixart_mixer.c	2005-08-18 00:55:14.000000000 +0200
@@ -1059,7 +1059,7 @@ int snd_mixart_create_mixer(mixart_mgr_t
 	mixart_t *chip;
 	int err, i;
 
-	init_MUTEX(&mgr->mixer_mutex); /* can be in another place */
+	init_mutex(&mgr->mixer_mutex); /* can be in another place */
 
 	for(i=0; i<mgr->num_cards; i++) {
 		snd_kcontrol_new_t temp;
--- linux-2.6.13-rc6-git9-orig/sound/sparc/cs4231.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/sparc/cs4231.c	2005-08-18 00:55:14.000000000 +0200
@@ -1971,8 +1971,8 @@ static int __init snd_cs4231_sbus_create
 		return -ENOMEM;
 
 	spin_lock_init(&chip->lock);
-	init_MUTEX(&chip->mce_mutex);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->mce_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->card = card;
 	chip->dev_u.sdev = sdev;
 	chip->regs_size = sdev->reg_addrs[0].reg_size;
@@ -2087,8 +2087,8 @@ static int __init snd_cs4231_ebus_create
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->eb2c.lock);
 	spin_lock_init(&chip->eb2p.lock);
-	init_MUTEX(&chip->mce_mutex);
-	init_MUTEX(&chip->open_mutex);
+	init_mutex(&chip->mce_mutex);
+	init_mutex(&chip->open_mutex);
 	chip->flags |= CS4231_FLAG_EBUS;
 	chip->card = card;
 	chip->dev_u.pdev = edev->bus->self;
--- linux-2.6.13-rc6-git9-orig/sound/synth/emux/emux.c	2005-08-17 21:52:21.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/synth/emux/emux.c	2005-08-18 00:55:14.000000000 +0200
@@ -45,7 +45,7 @@ int snd_emux_new(snd_emux_t **remu)
 		return -ENOMEM;
 
 	spin_lock_init(&emu->voice_lock);
-	init_MUTEX(&emu->register_mutex);
+	init_mutex(&emu->register_mutex);
 
 	emu->client = -1;
 #ifdef CONFIG_SND_SEQUENCER_OSS
--- linux-2.6.13-rc6-git9-orig/sound/synth/emux/soundfont.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/synth/emux/soundfont.c	2005-08-18 00:55:14.000000000 +0200
@@ -1365,7 +1365,7 @@ snd_sf_new(snd_sf_callback_t *callback, 
 	if ((sflist = kcalloc(1, sizeof(*sflist), GFP_KERNEL)) == NULL)
 		return NULL;
 
-	init_MUTEX(&sflist->presets_mutex);
+	init_mutex(&sflist->presets_mutex);
 	spin_lock_init(&sflist->lock);
 	sflist->memhdr = hdr;
 
--- linux-2.6.13-rc6-git9-orig/sound/synth/util_mem.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/synth/util_mem.c	2005-08-18 00:55:14.000000000 +0200
@@ -42,7 +42,7 @@ snd_util_memhdr_new(int memsize)
 	if (hdr == NULL)
 		return NULL;
 	hdr->size = memsize;
-	init_MUTEX(&hdr->block_mutex);
+	init_mutex(&hdr->block_mutex);
 	INIT_LIST_HEAD(&hdr->block);
 
 	return hdr;
--- linux-2.6.13-rc6-git9-orig/sound/usb/usx2y/usbusx2y.c	2005-08-17 21:52:21.000000000 +0200
+++ linux-2.6.13-rc6-git9/sound/usb/usx2y/usbusx2y.c	2005-08-18 00:55:14.000000000 +0200
@@ -354,7 +354,7 @@ static snd_card_t* usX2Y_create_card(str
 	usX2Y(card)->chip.dev = device;
 	usX2Y(card)->chip.card = card;
 	init_waitqueue_head(&usX2Y(card)->prepare_wait_queue);
-	init_MUTEX (&usX2Y(card)->prepare_mutex);
+	init_mutex (&usX2Y(card)->prepare_mutex);
 	INIT_LIST_HEAD(&usX2Y(card)->chip.midi_list);
 	strcpy(card->driver, "USB "NAME_ALLCAPS"");
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");


