Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVHEPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVHEPDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVHEOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:31 -0400
Received: from fep17.inet.fi ([194.251.242.242]:55022 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S263042AbVHEOwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:52:05 -0400
Subject: [PATCH 8/8] ALSA: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:52:04 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arm/sa11xx-uda1341.c              |    2 +-
 core/control.c                    |   12 ++++++------
 core/control_compat.c             |    8 ++++----
 core/device.c                     |    2 +-
 core/hwdep.c                      |    2 +-
 core/info.c                       |    8 ++++----
 core/init.c                       |    4 ++--
 core/oss/mixer_oss.c              |   26 +++++++++++++-------------
 core/oss/pcm_oss.c                |    2 +-
 core/oss/pcm_plugin.c             |    2 +-
 core/pcm.c                        |    6 +++---
 core/pcm_memory.c                 |    2 +-
 core/pcm_native.c                 |    2 +-
 core/rawmidi.c                    |    6 +++---
 core/seq/instr/ainstr_gf1.c       |    2 +-
 core/seq/instr/ainstr_iw.c        |    6 +++---
 core/seq/oss/seq_oss_init.c       |    2 +-
 core/seq/oss/seq_oss_midi.c       |    6 +++---
 core/seq/oss/seq_oss_readq.c      |    2 +-
 core/seq/oss/seq_oss_synth.c      |    4 ++--
 core/seq/oss/seq_oss_timer.c      |    2 +-
 core/seq/oss/seq_oss_writeq.c     |    2 +-
 core/seq/seq_clientmgr.c          |    2 +-
 core/seq/seq_device.c             |    2 +-
 core/seq/seq_dummy.c              |    2 +-
 core/seq/seq_fifo.c               |    2 +-
 core/seq/seq_instr.c              |    4 ++--
 core/seq/seq_memory.c             |    2 +-
 core/seq/seq_midi.c               |    2 +-
 core/seq/seq_midi_event.c         |    2 +-
 core/seq/seq_ports.c              |    4 ++--
 core/seq/seq_prioq.c              |    2 +-
 core/seq/seq_queue.c              |    2 +-
 core/seq/seq_system.c             |    4 ++--
 core/seq/seq_timer.c              |    2 +-
 core/seq/seq_virmidi.c            |    6 +++---
 core/timer.c                      |   10 +++++-----
 drivers/dummy.c                   |    4 ++--
 drivers/mpu401/mpu401_uart.c      |    2 +-
 drivers/mtpav.c                   |    2 +-
 drivers/opl3/opl3_lib.c           |    2 +-
 drivers/opl3/opl3_oss.c           |    2 +-
 drivers/opl4/opl4_lib.c           |    2 +-
 drivers/serial-u16550.c           |    2 +-
 drivers/vx/vx_core.c              |    2 +-
 drivers/vx/vx_pcm.c               |    2 +-
 i2c/cs8427.c                      |    2 +-
 i2c/i2c.c                         |    4 ++--
 i2c/l3/uda1341.c                  |    4 ++--
 i2c/other/ak4114.c                |    2 +-
 i2c/other/ak4117.c                |    2 +-
 i2c/tea6330t.c                    |    2 +-
 isa/ad1816a/ad1816a_lib.c         |    2 +-
 isa/ad1848/ad1848_lib.c           |    2 +-
 isa/cs423x/cs4231_lib.c           |    2 +-
 isa/es1688/es1688_lib.c           |    2 +-
 isa/es18xx.c                      |    2 +-
 isa/gus/gus_main.c                |    2 +-
 isa/gus/gus_mem_proc.c            |    4 ++--
 isa/gus/gus_pcm.c                 |    2 +-
 isa/opl3sa2.c                     |    2 +-
 isa/opti9xx/opti92x-ad1848.c      |    2 +-
 isa/sb/emu8000.c                  |    2 +-
 isa/sb/emu8000_pcm.c              |    2 +-
 isa/sb/sb16_csp.c                 |    2 +-
 isa/sb/sb_common.c                |    2 +-
 pci/ac97/ac97_codec.c             |    4 ++--
 pci/ac97/ak4531_codec.c           |    2 +-
 pci/ali5451/ali5451.c             |    2 +-
 pci/atiixp.c                      |    2 +-
 pci/atiixp_modem.c                |    2 +-
 pci/au88x0/au88x0.c               |    2 +-
 pci/azt3328.c                     |    2 +-
 pci/bt87x.c                       |    2 +-
 pci/ca0106/ca0106_main.c          |    6 +++---
 pci/cmipci.c                      |    2 +-
 pci/cs4281.c                      |    2 +-
 pci/cs46xx/cs46xx_lib.c           |    4 ++--
 pci/emu10k1/emu10k1_main.c        |    2 +-
 pci/emu10k1/emu10k1x.c            |    6 +++---
 pci/emu10k1/emufx.c               |    8 ++++----
 pci/emu10k1/emupcm.c              |   10 +++++-----
 pci/emu10k1/p16v.c                |    4 ++--
 pci/ens1370.c                     |    2 +-
 pci/es1938.c                      |    2 +-
 pci/es1968.c                      |    6 +++---
 pci/fm801.c                       |    2 +-
 pci/hda/hda_codec.c               |    6 +++---
 pci/hda/hda_generic.c             |    4 ++--
 pci/hda/hda_intel.c               |    2 +-
 pci/hda/patch_analog.c            |    6 +++---
 pci/hda/patch_cmedia.c            |    2 +-
 pci/hda/patch_realtek.c           |    6 +++---
 pci/hda/patch_sigmatel.c          |    4 ++--
 pci/ice1712/aureon.c              |    2 +-
 pci/ice1712/ice1712.c             |    2 +-
 pci/ice1712/ice1724.c             |    2 +-
 pci/ice1712/juli.c                |    2 +-
 pci/ice1712/phase.c               |    4 ++--
 pci/ice1712/pontis.c              |    2 +-
 pci/intel8x0.c                    |    2 +-
 pci/intel8x0m.c                   |    2 +-
 pci/korg1212/korg1212.c           |    2 +-
 pci/maestro3.c                    |    2 +-
 pci/mixart/mixart.c               |    4 ++--
 pci/nm256/nm256.c                 |    2 +-
 pci/sonicvibes.c                  |    2 +-
 pci/trident/trident_main.c        |    4 ++--
 pci/via82xx.c                     |    2 +-
 pci/via82xx_modem.c               |    2 +-
 pci/ymfpci/ymfpci_main.c          |    6 +++---
 pcmcia/pdaudiocf/pdaudiocf_core.c |    2 +-
 ppc/pmac.c                        |    2 +-
 sparc/amd7930.c                   |    2 +-
 sparc/cs4231.c                    |    4 ++--
 synth/emux/emux.c                 |    2 +-
 synth/emux/emux_seq.c             |    2 +-
 synth/emux/soundfont.c            |    8 ++++----
 synth/util_mem.c                  |    2 +-
 usb/usbaudio.c                    |    2 +-
 usb/usbmidi.c                     |    6 +++---
 usb/usbmixer.c                    |   10 +++++-----
 usb/usx2y/usbusx2yaudio.c         |    2 +-
 123 files changed, 208 insertions(+), 208 deletions(-)

Index: 2.6/sound/arm/sa11xx-uda1341.c
===================================================================
--- 2.6.orig/sound/arm/sa11xx-uda1341.c
+++ 2.6/sound/arm/sa11xx-uda1341.c
@@ -918,7 +918,7 @@ static int __init sa11xx_uda1341_init(vo
 	if (card == NULL)
 		return -ENOMEM;
 
-	sa11xx_uda1341 = kcalloc(1, sizeof(*sa11xx_uda1341), GFP_KERNEL);
+	sa11xx_uda1341 = kzalloc(sizeof(*sa11xx_uda1341), GFP_KERNEL);
 	if (sa11xx_uda1341 == NULL)
 		return -ENOMEM;	
 	spin_lock_init(&chip->s[0].dma_lock);
Index: 2.6/sound/core/control.c
===================================================================
--- 2.6.orig/sound/core/control.c
+++ 2.6/sound/core/control.c
@@ -69,7 +69,7 @@ static int snd_ctl_open(struct inode *in
 		err = -EFAULT;
 		goto __error2;
 	}
-	ctl = kcalloc(1, sizeof(*ctl), GFP_KERNEL);
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (ctl == NULL) {
 		err = -ENOMEM;
 		goto __error;
@@ -162,7 +162,7 @@ void snd_ctl_notify(snd_card_t *card, un
 				goto _found;
 			}
 		}
-		ev = kcalloc(1, sizeof(*ev), GFP_ATOMIC);
+		ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
 		if (ev) {
 			ev->id = *id;
 			ev->mask = mask;
@@ -195,7 +195,7 @@ snd_kcontrol_t *snd_ctl_new(snd_kcontrol
 	
 	snd_runtime_check(control != NULL, return NULL);
 	snd_runtime_check(control->count > 0, return NULL);
-	kctl = kcalloc(1, sizeof(*kctl) + sizeof(snd_kcontrol_volatile_t) * control->count, GFP_KERNEL);
+	kctl = kzalloc(sizeof(*kctl) + sizeof(snd_kcontrol_volatile_t) * control->count, GFP_KERNEL);
 	if (kctl == NULL)
 		return NULL;
 	*kctl = *control;
@@ -521,7 +521,7 @@ static int snd_ctl_card_info(snd_card_t 
 {
 	snd_ctl_card_info_t *info;
 
-	info = kcalloc(1, sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (! info)
 		return -ENOMEM;
 	down_read(&snd_ioctl_rwsem);
@@ -929,7 +929,7 @@ static int snd_ctl_elem_add(snd_ctl_file
 		return -EINVAL;
 	}
 	private_size *= info->count;
-	ue = kcalloc(1, sizeof(struct user_element) + private_size, GFP_KERNEL);
+	ue = kzalloc(sizeof(struct user_element) + private_size, GFP_KERNEL);
 	if (ue == NULL)
 		return -ENOMEM;
 	ue->info = *info;
@@ -1185,7 +1185,7 @@ static int _snd_ctl_register_ioctl(snd_k
 {
 	snd_kctl_ioctl_t *pn;
 
-	pn = kcalloc(1, sizeof(snd_kctl_ioctl_t), GFP_KERNEL);
+	pn = kzalloc(sizeof(snd_kctl_ioctl_t), GFP_KERNEL);
 	if (pn == NULL)
 		return -ENOMEM;
 	pn->fioctl = fcn;
Index: 2.6/sound/core/control_compat.c
===================================================================
--- 2.6.orig/sound/core/control_compat.c
+++ 2.6/sound/core/control_compat.c
@@ -92,7 +92,7 @@ static int snd_ctl_elem_info_compat(snd_
 	struct sndrv_ctl_elem_info *data;
 	int err;
 
-	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (! data)
 		return -ENOMEM;
 
@@ -271,7 +271,7 @@ static int snd_ctl_elem_read_user_compat
 	struct sndrv_ctl_elem_value *data;
 	int err, type, count;
 
-	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
@@ -291,7 +291,7 @@ static int snd_ctl_elem_write_user_compa
 	struct sndrv_ctl_elem_value *data;
 	int err, type, count;
 
-	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
@@ -313,7 +313,7 @@ static int snd_ctl_elem_add_compat(snd_c
 	struct sndrv_ctl_elem_info *data;
 	int err;
 
-	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (! data)
 		return -ENOMEM;
 
Index: 2.6/sound/core/device.c
===================================================================
--- 2.6.orig/sound/core/device.c
+++ 2.6/sound/core/device.c
@@ -49,7 +49,7 @@ int snd_device_new(snd_card_t *card, snd
 	snd_assert(card != NULL, return -ENXIO);
 	snd_assert(device_data != NULL, return -ENXIO);
 	snd_assert(ops != NULL, return -ENXIO);
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
 		return -ENOMEM;
 	dev->card = card;
Index: 2.6/sound/core/hwdep.c
===================================================================
--- 2.6.orig/sound/core/hwdep.c
+++ 2.6/sound/core/hwdep.c
@@ -359,7 +359,7 @@ int snd_hwdep_new(snd_card_t * card, cha
 	snd_assert(rhwdep != NULL, return -EINVAL);
 	*rhwdep = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	hwdep = kcalloc(1, sizeof(*hwdep), GFP_KERNEL);
+	hwdep = kzalloc(sizeof(*hwdep), GFP_KERNEL);
 	if (hwdep == NULL)
 		return -ENOMEM;
 	hwdep->card = card;
Index: 2.6/sound/core/info.c
===================================================================
--- 2.6.orig/sound/core/info.c
+++ 2.6/sound/core/info.c
@@ -295,7 +295,7 @@ static int snd_info_entry_open(struct in
 		    	goto __error;
 		}
 	}
-	data = kcalloc(1, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		err = -ENOMEM;
 		goto __error;
@@ -304,7 +304,7 @@ static int snd_info_entry_open(struct in
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		if (mode == O_RDONLY || mode == O_RDWR) {
-			buffer = kcalloc(1, sizeof(*buffer), GFP_KERNEL);
+			buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 			if (buffer == NULL) {
 				kfree(data);
 				err = -ENOMEM;
@@ -323,7 +323,7 @@ static int snd_info_entry_open(struct in
 			data->rbuffer = buffer;
 		}
 		if (mode == O_WRONLY || mode == O_RDWR) {
-			buffer = kcalloc(1, sizeof(*buffer), GFP_KERNEL);
+			buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 			if (buffer == NULL) {
 				if (mode == O_RDWR) {
 					vfree(data->rbuffer->buffer);
@@ -752,7 +752,7 @@ char *snd_info_get_str(char *dest, char 
 static snd_info_entry_t *snd_info_create_entry(const char *name)
 {
 	snd_info_entry_t *entry;
-	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (entry == NULL)
 		return NULL;
 	entry->name = kstrdup(name, GFP_KERNEL);
Index: 2.6/sound/core/init.c
===================================================================
--- 2.6.orig/sound/core/init.c
+++ 2.6/sound/core/init.c
@@ -72,7 +72,7 @@ snd_card_t *snd_card_new(int idx, const 
 
 	if (extra_size < 0)
 		extra_size = 0;
-	card = kcalloc(1, sizeof(*card) + extra_size, GFP_KERNEL);
+	card = kzalloc(sizeof(*card) + extra_size, GFP_KERNEL);
 	if (card == NULL)
 		return NULL;
 	if (xid) {
@@ -775,7 +775,7 @@ static struct snd_generic_device *snd_ge
 	}
 	generic_driver_registered++;
 
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (! dev) {
 		generic_driver_unregister();
 		return NULL;
Index: 2.6/sound/core/oss/mixer_oss.c
===================================================================
--- 2.6.orig/sound/core/oss/mixer_oss.c
+++ 2.6/sound/core/oss/mixer_oss.c
@@ -53,7 +53,7 @@ static int snd_mixer_oss_open(struct ino
 	err = snd_card_file_add(card, file);
 	if (err < 0)
 		return err;
-	fmixer = kcalloc(1, sizeof(*fmixer), GFP_KERNEL);
+	fmixer = kzalloc(sizeof(*fmixer), GFP_KERNEL);
 	if (fmixer == NULL) {
 		snd_card_file_remove(card, file);
 		return -ENOMEM;
@@ -517,8 +517,8 @@ static void snd_mixer_oss_get_volume1_vo
 		up_read(&card->controls_rwsem);
 		return;
 	}
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -551,8 +551,8 @@ static void snd_mixer_oss_get_volume1_sw
 		up_read(&card->controls_rwsem);
 		return;
 	}
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -612,8 +612,8 @@ static void snd_mixer_oss_put_volume1_vo
 	down_read(&card->controls_rwsem);
 	if ((kctl = snd_ctl_find_numid(card, numid)) == NULL)
 		return;
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -649,8 +649,8 @@ static void snd_mixer_oss_put_volume1_sw
 		up_read(&fmixer->card->controls_rwsem);
 		return;
 	}
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -768,8 +768,8 @@ static int snd_mixer_oss_get_recsrc2(snd
 	snd_ctl_elem_value_t *uctl;
 	int err, idx;
 	
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
 		err = -ENOMEM;
 		goto __unlock;
@@ -813,8 +813,8 @@ static int snd_mixer_oss_put_recsrc2(snd
 	int err;
 	unsigned int idx;
 
-	uinfo = kcalloc(1, sizeof(*uinfo), GFP_KERNEL);
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
 		err = -ENOMEM;
 		goto __unlock;
Index: 2.6/sound/core/oss/pcm_oss.c
===================================================================
--- 2.6.orig/sound/core/oss/pcm_oss.c
+++ 2.6/sound/core/oss/pcm_oss.c
@@ -1734,7 +1734,7 @@ static int snd_pcm_oss_open_file(struct 
 	snd_assert(rpcm_oss_file != NULL, return -EINVAL);
 	*rpcm_oss_file = NULL;
 
-	pcm_oss_file = kcalloc(1, sizeof(*pcm_oss_file), GFP_KERNEL);
+	pcm_oss_file = kzalloc(sizeof(*pcm_oss_file), GFP_KERNEL);
 	if (pcm_oss_file == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/core/oss/pcm_plugin.c
===================================================================
--- 2.6.orig/sound/core/oss/pcm_plugin.c
+++ 2.6/sound/core/oss/pcm_plugin.c
@@ -171,7 +171,7 @@ int snd_pcm_plugin_build(snd_pcm_plug_t 
 	
 	snd_assert(plug != NULL, return -ENXIO);
 	snd_assert(src_format != NULL && dst_format != NULL, return -ENXIO);
-	plugin = kcalloc(1, sizeof(*plugin) + extra, GFP_KERNEL);
+	plugin = kzalloc(sizeof(*plugin) + extra, GFP_KERNEL);
 	if (plugin == NULL)
 		return -ENOMEM;
 	plugin->name = name;
Index: 2.6/sound/core/pcm.c
===================================================================
--- 2.6.orig/sound/core/pcm.c
+++ 2.6/sound/core/pcm.c
@@ -597,7 +597,7 @@ int snd_pcm_new_stream(snd_pcm_t *pcm, i
 	}
 	prev = NULL;
 	for (idx = 0, prev = NULL; idx < substream_count; idx++) {
-		substream = kcalloc(1, sizeof(*substream), GFP_KERNEL);
+		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL)
 			return -ENOMEM;
 		substream->pcm = pcm;
@@ -657,7 +657,7 @@ int snd_pcm_new(snd_card_t * card, char 
 	snd_assert(rpcm != NULL, return -EINVAL);
 	*rpcm = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	pcm = kcalloc(1, sizeof(*pcm), GFP_KERNEL);
+	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (pcm == NULL)
 		return -ENOMEM;
 	pcm->card = card;
@@ -795,7 +795,7 @@ int snd_pcm_open_substream(snd_pcm_t *pc
 	if (substream == NULL)
 		return -EAGAIN;
 
-	runtime = kcalloc(1, sizeof(*runtime), GFP_KERNEL);
+	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
 	if (runtime == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/core/pcm_memory.c
===================================================================
--- 2.6.orig/sound/core/pcm_memory.c
+++ 2.6/sound/core/pcm_memory.c
@@ -321,7 +321,7 @@ int snd_pcm_lib_malloc_pages(snd_pcm_sub
 	if (substream->dma_buffer.area != NULL && substream->dma_buffer.bytes >= size) {
 		dmab = &substream->dma_buffer; /* use the pre-allocated buffer */
 	} else {
-		dmab = kcalloc(1, sizeof(*dmab), GFP_KERNEL);
+		dmab = kzalloc(sizeof(*dmab), GFP_KERNEL);
 		if (! dmab)
 			return -ENOMEM;
 		dmab->dev = substream->dma_buffer.dev;
Index: 2.6/sound/core/pcm_native.c
===================================================================
--- 2.6.orig/sound/core/pcm_native.c
+++ 2.6/sound/core/pcm_native.c
@@ -1993,7 +1993,7 @@ static int snd_pcm_open_file(struct file
 	snd_assert(rpcm_file != NULL, return -EINVAL);
 	*rpcm_file = NULL;
 
-	pcm_file = kcalloc(1, sizeof(*pcm_file), GFP_KERNEL);
+	pcm_file = kzalloc(sizeof(*pcm_file), GFP_KERNEL);
 	if (pcm_file == NULL) {
 		return -ENOMEM;
 	}
Index: 2.6/sound/core/rawmidi.c
===================================================================
--- 2.6.orig/sound/core/rawmidi.c
+++ 2.6/sound/core/rawmidi.c
@@ -101,7 +101,7 @@ static int snd_rawmidi_runtime_create(sn
 {
 	snd_rawmidi_runtime_t *runtime;
 
-	if ((runtime = kcalloc(1, sizeof(*runtime), GFP_KERNEL)) == NULL)
+	if ((runtime = kzalloc(sizeof(*runtime), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	spin_lock_init(&runtime->lock);
 	init_waitqueue_head(&runtime->sleep);
@@ -1370,7 +1370,7 @@ static int snd_rawmidi_alloc_substreams(
 
 	INIT_LIST_HEAD(&stream->substreams);
 	for (idx = 0; idx < count; idx++) {
-		substream = kcalloc(1, sizeof(*substream), GFP_KERNEL);
+		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL)
 			return -ENOMEM;
 		substream->stream = direction;
@@ -1413,7 +1413,7 @@ int snd_rawmidi_new(snd_card_t * card, c
 	snd_assert(rrawmidi != NULL, return -EINVAL);
 	*rrawmidi = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	rmidi = kcalloc(1, sizeof(*rmidi), GFP_KERNEL);
+	rmidi = kzalloc(sizeof(*rmidi), GFP_KERNEL);
 	if (rmidi == NULL)
 		return -ENOMEM;
 	rmidi->card = card;
Index: 2.6/sound/core/seq/instr/ainstr_gf1.c
===================================================================
--- 2.6.orig/sound/core/seq/instr/ainstr_gf1.c
+++ 2.6/sound/core/seq/instr/ainstr_gf1.c
@@ -61,7 +61,7 @@ static int snd_seq_gf1_copy_wave_from_st
 		return -EFAULT;
 	*data += sizeof(xp);
 	*len -= sizeof(xp);
-	wp = kcalloc(1, sizeof(*wp), gfp_mask);
+	wp = kzalloc(sizeof(*wp), gfp_mask);
 	if (wp == NULL)
 		return -ENOMEM;
 	wp->share_id[0] = le32_to_cpu(xp.share_id[0]);
Index: 2.6/sound/core/seq/instr/ainstr_iw.c
===================================================================
--- 2.6.orig/sound/core/seq/instr/ainstr_iw.c
+++ 2.6/sound/core/seq/instr/ainstr_iw.c
@@ -92,7 +92,7 @@ static int snd_seq_iwffff_copy_env_from_
 		points_size = (le16_to_cpu(rx.nattack) + le16_to_cpu(rx.nrelease)) * 2 * sizeof(__u16);
 		if (points_size > *len)
 			return -EINVAL;
-		rp = kcalloc(1, sizeof(*rp) + points_size, gfp_mask);
+		rp = kzalloc(sizeof(*rp) + points_size, gfp_mask);
 		if (rp == NULL)
 			return -ENOMEM;
 		rp->nattack = le16_to_cpu(rx.nattack);
@@ -139,7 +139,7 @@ static int snd_seq_iwffff_copy_wave_from
 		return -EFAULT;
 	*data += sizeof(xp);
 	*len -= sizeof(xp);
-	wp = kcalloc(1, sizeof(*wp), gfp_mask);
+	wp = kzalloc(sizeof(*wp), gfp_mask);
 	if (wp == NULL)
 		return -ENOMEM;
 	wp->share_id[0] = le32_to_cpu(xp.share_id[0]);
@@ -273,7 +273,7 @@ static int snd_seq_iwffff_put(void *priv
 			snd_seq_iwffff_instr_free(ops, ip, atomic);
 			return -EINVAL;
 		}
-		lp = kcalloc(1, sizeof(*lp), gfp_mask);
+		lp = kzalloc(sizeof(*lp), gfp_mask);
 		if (lp == NULL) {
 			snd_seq_iwffff_instr_free(ops, ip, atomic);
 			return -ENOMEM;
Index: 2.6/sound/core/seq/oss/seq_oss_init.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_init.c
+++ 2.6/sound/core/seq/oss/seq_oss_init.c
@@ -193,7 +193,7 @@ snd_seq_oss_open(struct file *file, int 
 	int i, rc;
 	seq_oss_devinfo_t *dp;
 
-	if ((dp = kcalloc(1, sizeof(*dp), GFP_KERNEL)) == NULL) {
+	if ((dp = kzalloc(sizeof(*dp), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc device info\n");
 		return -ENOMEM;
 	}
Index: 2.6/sound/core/seq/oss/seq_oss_midi.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_midi.c
+++ 2.6/sound/core/seq/oss/seq_oss_midi.c
@@ -76,8 +76,8 @@ snd_seq_oss_midi_lookup_ports(int client
 	snd_seq_client_info_t *clinfo;
 	snd_seq_port_info_t *pinfo;
 
-	clinfo = kcalloc(1, sizeof(*clinfo), GFP_KERNEL);
-	pinfo = kcalloc(1, sizeof(*pinfo), GFP_KERNEL);
+	clinfo = kzalloc(sizeof(*clinfo), GFP_KERNEL);
+	pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
 	if (! clinfo || ! pinfo) {
 		kfree(clinfo);
 		kfree(pinfo);
@@ -172,7 +172,7 @@ snd_seq_oss_midi_check_new_port(snd_seq_
 	/*
 	 * allocate midi info record
 	 */
-	if ((mdev = kcalloc(1, sizeof(*mdev), GFP_KERNEL)) == NULL) {
+	if ((mdev = kzalloc(sizeof(*mdev), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc midi info\n");
 		return -ENOMEM;
 	}
Index: 2.6/sound/core/seq/oss/seq_oss_readq.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_readq.c
+++ 2.6/sound/core/seq/oss/seq_oss_readq.c
@@ -46,7 +46,7 @@ snd_seq_oss_readq_new(seq_oss_devinfo_t 
 {
 	seq_oss_readq_t *q;
 
-	if ((q = kcalloc(1, sizeof(*q), GFP_KERNEL)) == NULL) {
+	if ((q = kzalloc(sizeof(*q), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc read queue\n");
 		return NULL;
 	}
Index: 2.6/sound/core/seq/oss/seq_oss_synth.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_synth.c
+++ 2.6/sound/core/seq/oss/seq_oss_synth.c
@@ -103,7 +103,7 @@ snd_seq_oss_synth_register(snd_seq_devic
 	snd_seq_oss_reg_t *reg = SNDRV_SEQ_DEVICE_ARGPTR(dev);
 	unsigned long flags;
 
-	if ((rec = kcalloc(1, sizeof(*rec), GFP_KERNEL)) == NULL) {
+	if ((rec = kzalloc(sizeof(*rec), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc synth info\n");
 		return -ENOMEM;
 	}
@@ -499,7 +499,7 @@ snd_seq_oss_synth_sysex(seq_oss_devinfo_
 
 	sysex = dp->synths[dev].sysex;
 	if (sysex == NULL) {
-		sysex = kcalloc(1, sizeof(*sysex), GFP_KERNEL);
+		sysex = kzalloc(sizeof(*sysex), GFP_KERNEL);
 		if (sysex == NULL)
 			return -ENOMEM;
 		dp->synths[dev].sysex = sysex;
Index: 2.6/sound/core/seq/oss/seq_oss_timer.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_timer.c
+++ 2.6/sound/core/seq/oss/seq_oss_timer.c
@@ -46,7 +46,7 @@ snd_seq_oss_timer_new(seq_oss_devinfo_t 
 {
 	seq_oss_timer_t *rec;
 
-	rec = kcalloc(1, sizeof(*rec), GFP_KERNEL);
+	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
 	if (rec == NULL)
 		return NULL;
 
Index: 2.6/sound/core/seq/oss/seq_oss_writeq.c
===================================================================
--- 2.6.orig/sound/core/seq/oss/seq_oss_writeq.c
+++ 2.6/sound/core/seq/oss/seq_oss_writeq.c
@@ -38,7 +38,7 @@ snd_seq_oss_writeq_new(seq_oss_devinfo_t
 	seq_oss_writeq_t *q;
 	snd_seq_client_pool_t pool;
 
-	if ((q = kcalloc(1, sizeof(*q), GFP_KERNEL)) == NULL)
+	if ((q = kzalloc(sizeof(*q), GFP_KERNEL)) == NULL)
 		return NULL;
 	q->dp = dp;
 	q->maxlen = maxlen;
Index: 2.6/sound/core/seq/seq_clientmgr.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_clientmgr.c
+++ 2.6/sound/core/seq/seq_clientmgr.c
@@ -203,7 +203,7 @@ static client_t *seq_create_client1(int 
 	client_t *client;
 
 	/* init client data */
-	client = kcalloc(1, sizeof(*client), GFP_KERNEL);
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (client == NULL)
 		return NULL;
 	client->pool = snd_seq_pool_new(poolsize);
Index: 2.6/sound/core/seq/seq_device.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_device.c
+++ 2.6/sound/core/seq/seq_device.c
@@ -200,7 +200,7 @@ int snd_seq_device_new(snd_card_t *card,
 	if (ops == NULL)
 		return -ENOMEM;
 
-	dev = kcalloc(1, sizeof(*dev)*2 + argsize, GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev)*2 + argsize, GFP_KERNEL);
 	if (dev == NULL) {
 		unlock_driver(ops);
 		return -ENOMEM;
Index: 2.6/sound/core/seq/seq_dummy.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_dummy.c
+++ 2.6/sound/core/seq/seq_dummy.c
@@ -153,7 +153,7 @@ create_port(int idx, int type)
 	snd_seq_port_callback_t pcb;
 	snd_seq_dummy_port_t *rec;
 
-	if ((rec = kcalloc(1, sizeof(*rec), GFP_KERNEL)) == NULL)
+	if ((rec = kzalloc(sizeof(*rec), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	rec->client = my_client;
Index: 2.6/sound/core/seq/seq_fifo.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_fifo.c
+++ 2.6/sound/core/seq/seq_fifo.c
@@ -33,7 +33,7 @@ fifo_t *snd_seq_fifo_new(int poolsize)
 {
 	fifo_t *f;
 
-	f = kcalloc(1, sizeof(*f), GFP_KERNEL);
+	f = kzalloc(sizeof(*f), GFP_KERNEL);
 	if (f == NULL) {
 		snd_printd("malloc failed for snd_seq_fifo_new() \n");
 		return NULL;
Index: 2.6/sound/core/seq/seq_instr.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_instr.c
+++ 2.6/sound/core/seq/seq_instr.c
@@ -53,7 +53,7 @@ static snd_seq_kinstr_t *snd_seq_instr_n
 {
 	snd_seq_kinstr_t *instr;
 	
-	instr = kcalloc(1, sizeof(snd_seq_kinstr_t) + add_len, atomic ? GFP_ATOMIC : GFP_KERNEL);
+	instr = kzalloc(sizeof(snd_seq_kinstr_t) + add_len, atomic ? GFP_ATOMIC : GFP_KERNEL);
 	if (instr == NULL)
 		return NULL;
 	instr->add_len = add_len;
@@ -77,7 +77,7 @@ snd_seq_kinstr_list_t *snd_seq_instr_lis
 {
 	snd_seq_kinstr_list_t *list;
 
-	list = kcalloc(1, sizeof(snd_seq_kinstr_list_t), GFP_KERNEL);
+	list = kzalloc(sizeof(snd_seq_kinstr_list_t), GFP_KERNEL);
 	if (list == NULL)
 		return NULL;
 	spin_lock_init(&list->lock);
Index: 2.6/sound/core/seq/seq_memory.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_memory.c
+++ 2.6/sound/core/seq/seq_memory.c
@@ -452,7 +452,7 @@ pool_t *snd_seq_pool_new(int poolsize)
 	pool_t *pool;
 
 	/* create pool block */
-	pool = kcalloc(1, sizeof(*pool), GFP_KERNEL);
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (pool == NULL) {
 		snd_printd("seq: malloc failed for pool\n");
 		return NULL;
Index: 2.6/sound/core/seq/seq_midi.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_midi.c
+++ 2.6/sound/core/seq/seq_midi.c
@@ -322,7 +322,7 @@ snd_seq_midisynth_register_port(snd_seq_
 	client = synths[card->number];
 	if (client == NULL) {
 		newclient = 1;
-		client = kcalloc(1, sizeof(*client), GFP_KERNEL);
+		client = kzalloc(sizeof(*client), GFP_KERNEL);
 		if (client == NULL) {
 			up(&register_mutex);
 			kfree(info);
Index: 2.6/sound/core/seq/seq_midi_event.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_midi_event.c
+++ 2.6/sound/core/seq/seq_midi_event.c
@@ -118,7 +118,7 @@ int snd_midi_event_new(int bufsize, snd_
 	snd_midi_event_t *dev;
 
 	*rdev = NULL;
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
 		return -ENOMEM;
 	if (bufsize > 0) {
Index: 2.6/sound/core/seq/seq_ports.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_ports.c
+++ 2.6/sound/core/seq/seq_ports.c
@@ -141,7 +141,7 @@ client_port_t *snd_seq_create_port(clien
 	}
 
 	/* create a new port */
-	new_port = kcalloc(1, sizeof(*new_port), GFP_KERNEL);
+	new_port = kzalloc(sizeof(*new_port), GFP_KERNEL);
 	if (! new_port) {
 		snd_printd("malloc failed for registering client port\n");
 		return NULL;	/* failure, out of memory */
@@ -488,7 +488,7 @@ int snd_seq_port_connect(client_t *conne
 	unsigned long flags;
 	int exclusive;
 
-	subs = kcalloc(1, sizeof(*subs), GFP_KERNEL);
+	subs = kzalloc(sizeof(*subs), GFP_KERNEL);
 	if (! subs)
 		return -ENOMEM;
 
Index: 2.6/sound/core/seq/seq_prioq.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_prioq.c
+++ 2.6/sound/core/seq/seq_prioq.c
@@ -59,7 +59,7 @@ prioq_t *snd_seq_prioq_new(void)
 {
 	prioq_t *f;
 
-	f = kcalloc(1, sizeof(*f), GFP_KERNEL);
+	f = kzalloc(sizeof(*f), GFP_KERNEL);
 	if (f == NULL) {
 		snd_printd("oops: malloc failed for snd_seq_prioq_new()\n");
 		return NULL;
Index: 2.6/sound/core/seq/seq_queue.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_queue.c
+++ 2.6/sound/core/seq/seq_queue.c
@@ -111,7 +111,7 @@ static queue_t *queue_new(int owner, int
 {
 	queue_t *q;
 
-	q = kcalloc(1, sizeof(*q), GFP_KERNEL);
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (q == NULL) {
 		snd_printd("malloc failed for snd_seq_queue_new()\n");
 		return NULL;
Index: 2.6/sound/core/seq/seq_system.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_system.c
+++ 2.6/sound/core/seq/seq_system.c
@@ -126,8 +126,8 @@ int __init snd_seq_system_client_init(vo
 	snd_seq_client_info_t *inf;
 	snd_seq_port_info_t *port;
 
-	inf = kcalloc(1, sizeof(*inf), GFP_KERNEL);
-	port = kcalloc(1, sizeof(*port), GFP_KERNEL);
+	inf = kzalloc(sizeof(*inf), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (! inf || ! port) {
 		kfree(inf);
 		kfree(port);
Index: 2.6/sound/core/seq/seq_timer.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_timer.c
+++ 2.6/sound/core/seq/seq_timer.c
@@ -60,7 +60,7 @@ seq_timer_t *snd_seq_timer_new(void)
 {
 	seq_timer_t *tmr;
 	
-	tmr = kcalloc(1, sizeof(*tmr), GFP_KERNEL);
+	tmr = kzalloc(sizeof(*tmr), GFP_KERNEL);
 	if (tmr == NULL) {
 		snd_printd("malloc failed for snd_seq_timer_new() \n");
 		return NULL;
Index: 2.6/sound/core/seq/seq_virmidi.c
===================================================================
--- 2.6.orig/sound/core/seq/seq_virmidi.c
+++ 2.6/sound/core/seq/seq_virmidi.c
@@ -205,7 +205,7 @@ static int snd_virmidi_input_open(snd_ra
 	snd_virmidi_t *vmidi;
 	unsigned long flags;
 
-	vmidi = kcalloc(1, sizeof(*vmidi), GFP_KERNEL);
+	vmidi = kzalloc(sizeof(*vmidi), GFP_KERNEL);
 	if (vmidi == NULL)
 		return -ENOMEM;
 	vmidi->substream = substream;
@@ -233,7 +233,7 @@ static int snd_virmidi_output_open(snd_r
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
 	snd_virmidi_t *vmidi;
 
-	vmidi = kcalloc(1, sizeof(*vmidi), GFP_KERNEL);
+	vmidi = kzalloc(sizeof(*vmidi), GFP_KERNEL);
 	if (vmidi == NULL)
 		return -ENOMEM;
 	vmidi->substream = substream;
@@ -508,7 +508,7 @@ int snd_virmidi_new(snd_card_t *card, in
 				   &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, rmidi->id);
-	rdev = kcalloc(1, sizeof(*rdev), GFP_KERNEL);
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
 	if (rdev == NULL) {
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
Index: 2.6/sound/core/timer.c
===================================================================
--- 2.6.orig/sound/core/timer.c
+++ 2.6/sound/core/timer.c
@@ -98,7 +98,7 @@ static void snd_timer_reschedule(snd_tim
 static snd_timer_instance_t *snd_timer_instance_new(char *owner, snd_timer_t *timer)
 {
 	snd_timer_instance_t *timeri;
-	timeri = kcalloc(1, sizeof(*timeri), GFP_KERNEL);
+	timeri = kzalloc(sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
 	timeri->owner = kstrdup(owner, GFP_KERNEL);
@@ -764,7 +764,7 @@ int snd_timer_new(snd_card_t *card, char
 	snd_assert(tid != NULL, return -EINVAL);
 	snd_assert(rtimer != NULL, return -EINVAL);
 	*rtimer = NULL;
-	timer = kcalloc(1, sizeof(*timer), GFP_KERNEL);
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
 	if (timer == NULL)
 		return -ENOMEM;
 	timer->tmr_class = tid->dev_class;
@@ -1015,7 +1015,7 @@ static int snd_timer_register_system(voi
 		return err;
 	strcpy(timer->name, "system timer");
 	timer->hw = snd_timer_system;
-	priv = kcalloc(1, sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL) {
 		snd_timer_free(timer);
 		return -ENOMEM;
@@ -1200,7 +1200,7 @@ static int snd_timer_user_open(struct in
 {
 	snd_timer_user_t *tu;
 	
-	tu = kcalloc(1, sizeof(*tu), GFP_KERNEL);
+	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
 	if (tu == NULL)
 		return -ENOMEM;
 	spin_lock_init(&tu->qlock);
@@ -1511,7 +1511,7 @@ static int snd_timer_user_info(struct fi
 	t = tu->timeri->timer;
 	snd_assert(t != NULL, return -ENXIO);
 
-	info = kcalloc(1, sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (! info)
 		return -ENOMEM;
 	info->card = t->card ? t->card->number : -1;
Index: 2.6/sound/drivers/dummy.c
===================================================================
--- 2.6.orig/sound/drivers/dummy.c
+++ 2.6/sound/drivers/dummy.c
@@ -337,7 +337,7 @@ static int snd_card_dummy_playback_open(
 	snd_card_dummy_pcm_t *dpcm;
 	int err;
 
-	dpcm = kcalloc(1, sizeof(*dpcm), GFP_KERNEL);
+	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 	init_timer(&dpcm->timer);
@@ -368,7 +368,7 @@ static int snd_card_dummy_capture_open(s
 	snd_card_dummy_pcm_t *dpcm;
 	int err;
 
-	dpcm = kcalloc(1, sizeof(*dpcm), GFP_KERNEL);
+	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 	init_timer(&dpcm->timer);
Index: 2.6/sound/drivers/mpu401/mpu401_uart.c
===================================================================
--- 2.6.orig/sound/drivers/mpu401/mpu401_uart.c
+++ 2.6/sound/drivers/mpu401/mpu401_uart.c
@@ -463,7 +463,7 @@ int snd_mpu401_uart_new(snd_card_t * car
 		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(card, "MPU-401U", device, 1, 1, &rmidi)) < 0)
 		return err;
-	mpu = kcalloc(1, sizeof(*mpu), GFP_KERNEL);
+	mpu = kzalloc(sizeof(*mpu), GFP_KERNEL);
 	if (mpu == NULL) {
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
Index: 2.6/sound/drivers/mtpav.c
===================================================================
--- 2.6.orig/sound/drivers/mtpav.c
+++ 2.6/sound/drivers/mtpav.c
@@ -688,7 +688,7 @@ static int snd_mtpav_get_RAWMIDI(mtpav_t
 
 static mtpav_t *new_mtpav(void)
 {
-	mtpav_t *ncrd = kcalloc(1, sizeof(*ncrd), GFP_KERNEL);
+	mtpav_t *ncrd = kzalloc(sizeof(*ncrd), GFP_KERNEL);
 	if (ncrd != NULL) {
 		spin_lock_init(&ncrd->spinlock);
 
Index: 2.6/sound/drivers/opl3/opl3_lib.c
===================================================================
--- 2.6.orig/sound/drivers/opl3/opl3_lib.c
+++ 2.6/sound/drivers/opl3/opl3_lib.c
@@ -354,7 +354,7 @@ int snd_opl3_new(snd_card_t *card,
 	int err;
 
 	*ropl3 = NULL;
-	opl3 = kcalloc(1, sizeof(*opl3), GFP_KERNEL);
+	opl3 = kzalloc(sizeof(*opl3), GFP_KERNEL);
 	if (opl3 == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/drivers/opl3/opl3_oss.c
===================================================================
--- 2.6.orig/sound/drivers/opl3/opl3_oss.c
+++ 2.6/sound/drivers/opl3/opl3_oss.c
@@ -241,7 +241,7 @@ static int snd_opl3_load_patch_seq_oss(s
 		}
 
 		size = sizeof(*put) + sizeof(fm_xinstrument_t);
-		put = kcalloc(1, size, GFP_KERNEL);
+		put = kzalloc(size, GFP_KERNEL);
 		if (put == NULL)
 			return -ENOMEM;
 		/* build header */
Index: 2.6/sound/drivers/opl4/opl4_lib.c
===================================================================
--- 2.6.orig/sound/drivers/opl4/opl4_lib.c
+++ 2.6/sound/drivers/opl4/opl4_lib.c
@@ -204,7 +204,7 @@ int snd_opl4_create(snd_card_t *card,
 	if (ropl4)
 		*ropl4 = NULL;
 
-	opl4 = kcalloc(1, sizeof(*opl4), GFP_KERNEL);
+	opl4 = kzalloc(sizeof(*opl4), GFP_KERNEL);
 	if (!opl4)
 		return -ENOMEM;
 
Index: 2.6/sound/drivers/serial-u16550.c
===================================================================
--- 2.6.orig/sound/drivers/serial-u16550.c
+++ 2.6/sound/drivers/serial-u16550.c
@@ -779,7 +779,7 @@ static int __init snd_uart16550_create(s
 	int err;
 
 
-	if ((uart = kcalloc(1, sizeof(*uart), GFP_KERNEL)) == NULL)
+	if ((uart = kzalloc(sizeof(*uart), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	uart->adaptor = adaptor;
 	uart->card = card;
Index: 2.6/sound/drivers/vx/vx_core.c
===================================================================
--- 2.6.orig/sound/drivers/vx/vx_core.c
+++ 2.6/sound/drivers/vx/vx_core.c
@@ -782,7 +782,7 @@ vx_core_t *snd_vx_create(snd_card_t *car
 
 	snd_assert(card && hw && ops, return NULL);
 
-	chip = kcalloc(1, sizeof(*chip) + extra_size, GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip) + extra_size, GFP_KERNEL);
 	if (! chip) {
 		snd_printk(KERN_ERR "vx_core: no memory\n");
 		return NULL;
Index: 2.6/sound/drivers/vx/vx_pcm.c
===================================================================
--- 2.6.orig/sound/drivers/vx/vx_pcm.c
+++ 2.6/sound/drivers/vx/vx_pcm.c
@@ -473,7 +473,7 @@ static int vx_alloc_pipe(vx_core_t *chip
 		return err;
 
 	/* initialize the pipe record */
-	pipe = kcalloc(1, sizeof(*pipe), GFP_KERNEL);
+	pipe = kzalloc(sizeof(*pipe), GFP_KERNEL);
 	if (! pipe) {
 		/* release the pipe */
 		vx_init_rmh(&rmh, CMD_FREE_PIPE);
Index: 2.6/sound/i2c/cs8427.c
===================================================================
--- 2.6.orig/sound/i2c/cs8427.c
+++ 2.6/sound/i2c/cs8427.c
@@ -200,7 +200,7 @@ int snd_cs8427_create(snd_i2c_bus_t *bus
 
 	if ((err = snd_i2c_device_create(bus, "CS8427", CS8427_ADDR | (addr & 7), &device)) < 0)
 		return err;
-	chip = device->private_data = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = device->private_data = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 	      	snd_i2c_device_free(device);
 		return -ENOMEM;
Index: 2.6/sound/i2c/i2c.c
===================================================================
--- 2.6.orig/sound/i2c/i2c.c
+++ 2.6/sound/i2c/i2c.c
@@ -81,7 +81,7 @@ int snd_i2c_bus_create(snd_card_t *card,
 	};
 
 	*ri2c = NULL;
-	bus = kcalloc(1, sizeof(*bus), GFP_KERNEL);
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return -ENOMEM;
 	init_MUTEX(&bus->lock_mutex);
@@ -108,7 +108,7 @@ int snd_i2c_device_create(snd_i2c_bus_t 
 
 	*rdevice = NULL;
 	snd_assert(bus != NULL, return -EINVAL);
-	device = kcalloc(1, sizeof(*device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL)
 		return -ENOMEM;
 	device->addr = addr;
Index: 2.6/sound/i2c/l3/uda1341.c
===================================================================
--- 2.6.orig/sound/i2c/l3/uda1341.c
+++ 2.6/sound/i2c/l3/uda1341.c
@@ -670,7 +670,7 @@ int __init snd_chip_uda1341_mixer_new(sn
 
 	snd_assert(card != NULL, return -EINVAL);
 
-	uda1341 = kcalloc(1, sizeof(*uda1341), GFP_KERNEL);
+	uda1341 = kzalloc(sizeof(*uda1341), GFP_KERNEL);
 	if (uda1341 == NULL)
 		return -ENOMEM;
          
@@ -707,7 +707,7 @@ static int uda1341_attach(struct l3_clie
 {
 	struct uda1341 *uda;
 
-	uda = kcalloc(1, sizeof(*uda), 0, GFP_KERNEL);
+	uda = kzalloc(sizeof(*uda), 0, GFP_KERNEL);
 	if (!uda)
 		return -ENOMEM;
 
Index: 2.6/sound/i2c/other/ak4114.c
===================================================================
--- 2.6.orig/sound/i2c/other/ak4114.c
+++ 2.6/sound/i2c/other/ak4114.c
@@ -92,7 +92,7 @@ int snd_ak4114_create(snd_card_t *card,
 		.dev_free =     snd_ak4114_dev_free,
 	};
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->lock);
Index: 2.6/sound/i2c/other/ak4117.c
===================================================================
--- 2.6.orig/sound/i2c/other/ak4117.c
+++ 2.6/sound/i2c/other/ak4117.c
@@ -83,7 +83,7 @@ int snd_ak4117_create(snd_card_t *card, 
 		.dev_free =     snd_ak4117_dev_free,
 	};
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->lock);
Index: 2.6/sound/i2c/tea6330t.c
===================================================================
--- 2.6.orig/sound/i2c/tea6330t.c
+++ 2.6/sound/i2c/tea6330t.c
@@ -281,7 +281,7 @@ int snd_tea6330t_update_mixer(snd_card_t
 	u8 default_treble, default_bass;
 	unsigned char bytes[7];
 
-	tea = kcalloc(1, sizeof(*tea), GFP_KERNEL);
+	tea = kzalloc(sizeof(*tea), GFP_KERNEL);
 	if (tea == NULL)
 		return -ENOMEM;
 	if ((err = snd_i2c_device_create(bus, "TEA6330T", TEA6330T_ADDR, &device)) < 0) {
Index: 2.6/sound/isa/ad1816a/ad1816a_lib.c
===================================================================
--- 2.6.orig/sound/isa/ad1816a/ad1816a_lib.c
+++ 2.6/sound/isa/ad1816a/ad1816a_lib.c
@@ -585,7 +585,7 @@ int snd_ad1816a_create(snd_card_t *card,
 
 	*rchip = NULL;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->irq = -1;
Index: 2.6/sound/isa/ad1848/ad1848_lib.c
===================================================================
--- 2.6.orig/sound/isa/ad1848/ad1848_lib.c
+++ 2.6/sound/isa/ad1848/ad1848_lib.c
@@ -890,7 +890,7 @@ int snd_ad1848_create(snd_card_t * card,
 	int err;
 
 	*rchip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
Index: 2.6/sound/isa/cs423x/cs4231_lib.c
===================================================================
--- 2.6.orig/sound/isa/cs423x/cs4231_lib.c
+++ 2.6/sound/isa/cs423x/cs4231_lib.c
@@ -1478,7 +1478,7 @@ static int snd_cs4231_new(snd_card_t * c
 	cs4231_t *chip;
 
 	*rchip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->hardware = hardware;
Index: 2.6/sound/isa/es1688/es1688_lib.c
===================================================================
--- 2.6.orig/sound/isa/es1688/es1688_lib.c
+++ 2.6/sound/isa/es1688/es1688_lib.c
@@ -649,7 +649,7 @@ int snd_es1688_create(snd_card_t * card,
 	int err;
 
 	*rchip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->irq = -1;
Index: 2.6/sound/isa/es18xx.c
===================================================================
--- 2.6.orig/sound/isa/es18xx.c
+++ 2.6/sound/isa/es18xx.c
@@ -1686,7 +1686,7 @@ static int __devinit snd_es18xx_new_devi
 	int err;
 
 	*rchip = NULL;
-        chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+        chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
Index: 2.6/sound/isa/gus/gus_main.c
===================================================================
--- 2.6.orig/sound/isa/gus/gus_main.c
+++ 2.6/sound/isa/gus/gus_main.c
@@ -157,7 +157,7 @@ int snd_gus_create(snd_card_t * card,
 	};
 
 	*rgus = NULL;
-	gus = kcalloc(1, sizeof(*gus), GFP_KERNEL);
+	gus = kzalloc(sizeof(*gus), GFP_KERNEL);
 	if (gus == NULL)
 		return -ENOMEM;
 	gus->gf1.irq = -1;
Index: 2.6/sound/isa/gus/gus_mem_proc.c
===================================================================
--- 2.6.orig/sound/isa/gus/gus_mem_proc.c
+++ 2.6/sound/isa/gus/gus_mem_proc.c
@@ -98,7 +98,7 @@ int snd_gf1_mem_proc_init(snd_gus_card_t
 
 	for (idx = 0; idx < 4; idx++) {
 		if (gus->gf1.mem_alloc.banks_8[idx].size > 0) {
-			priv = kcalloc(1, sizeof(*priv), GFP_KERNEL);
+			priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 			if (priv == NULL)
 				return -ENOMEM;
 			priv->gus = gus;
@@ -115,7 +115,7 @@ int snd_gf1_mem_proc_init(snd_gus_card_t
 	}
 	for (idx = 0; idx < 4; idx++) {
 		if (gus->gf1.rom_present & (1 << idx)) {
-			priv = kcalloc(1, sizeof(*priv), GFP_KERNEL);
+			priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 			if (priv == NULL)
 				return -ENOMEM;
 			priv->rom = 1;
Index: 2.6/sound/isa/gus/gus_pcm.c
===================================================================
--- 2.6.orig/sound/isa/gus/gus_pcm.c
+++ 2.6/sound/isa/gus/gus_pcm.c
@@ -666,7 +666,7 @@ static int snd_gf1_pcm_playback_open(snd
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	pcmp = kcalloc(1, sizeof(*pcmp), GFP_KERNEL);
+	pcmp = kzalloc(sizeof(*pcmp), GFP_KERNEL);
 	if (pcmp == NULL)
 		return -ENOMEM;
 	pcmp->gus = gus;
Index: 2.6/sound/isa/opl3sa2.c
===================================================================
--- 2.6.orig/sound/isa/opl3sa2.c
+++ 2.6/sound/isa/opl3sa2.c
@@ -685,7 +685,7 @@ static int __devinit snd_opl3sa2_probe(i
 		return -ENOMEM;
 	strcpy(card->driver, "OPL3SA2");
 	strcpy(card->shortname, "Yamaha OPL3-SA2");
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		err = -ENOMEM;
 		goto __error;
Index: 2.6/sound/isa/opti9xx/opti92x-ad1848.c
===================================================================
--- 2.6.orig/sound/isa/opti9xx/opti92x-ad1848.c
+++ 2.6/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1274,7 +1274,7 @@ static int snd_opti93x_create(snd_card_t
 	opti93x_t *codec;
 
 	*rcodec = NULL;
-	codec = kcalloc(1, sizeof(*codec), GFP_KERNEL);
+	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
 	codec->irq = -1;
Index: 2.6/sound/isa/sb/emu8000.c
===================================================================
--- 2.6.orig/sound/isa/sb/emu8000.c
+++ 2.6/sound/isa/sb/emu8000.c
@@ -1097,7 +1097,7 @@ snd_emu8000_new(snd_card_t *card, int in
 	if (seq_ports <= 0)
 		return 0;
 
-	hw = kcalloc(1, sizeof(*hw), GFP_KERNEL);
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
 	if (hw == NULL)
 		return -ENOMEM;
 	spin_lock_init(&hw->reg_lock);
Index: 2.6/sound/isa/sb/emu8000_pcm.c
===================================================================
--- 2.6.orig/sound/isa/sb/emu8000_pcm.c
+++ 2.6/sound/isa/sb/emu8000_pcm.c
@@ -233,7 +233,7 @@ static int emu8k_pcm_open(snd_pcm_substr
 	emu8k_pcm_t *rec;
 	snd_pcm_runtime_t *runtime = subs->runtime;
 
-	rec = kcalloc(1, sizeof(*rec), GFP_KERNEL);
+	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
 	if (! rec)
 		return -ENOMEM;
 
Index: 2.6/sound/isa/sb/sb16_csp.c
===================================================================
--- 2.6.orig/sound/isa/sb/sb16_csp.c
+++ 2.6/sound/isa/sb/sb16_csp.c
@@ -124,7 +124,7 @@ int snd_sb_csp_new(sb_t *chip, int devic
 	if ((err = snd_hwdep_new(chip->card, "SB16-CSP", device, &hw)) < 0)
 		return err;
 
-	if ((p = kcalloc(1, sizeof(*p), GFP_KERNEL)) == NULL) {
+	if ((p = kzalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
 		snd_device_free(chip->card, hw);
 		return -ENOMEM;
 	}
Index: 2.6/sound/isa/sb/sb_common.c
===================================================================
--- 2.6.orig/sound/isa/sb/sb_common.c
+++ 2.6/sound/isa/sb/sb_common.c
@@ -221,7 +221,7 @@ int snd_sbdsp_create(snd_card_t *card,
 
 	snd_assert(r_chip != NULL, return -EINVAL);
 	*r_chip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
Index: 2.6/sound/pci/ac97/ac97_codec.c
===================================================================
--- 2.6.orig/sound/pci/ac97/ac97_codec.c
+++ 2.6/sound/pci/ac97/ac97_codec.c
@@ -1789,7 +1789,7 @@ int snd_ac97_bus(snd_card_t *card, int n
 
 	snd_assert(card != NULL, return -EINVAL);
 	snd_assert(rbus != NULL, return -EINVAL);
-	bus = kcalloc(1, sizeof(*bus), GFP_KERNEL);
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL)
 		return -ENOMEM;
 	bus->card = card;
@@ -1863,7 +1863,7 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 	}
 
 	card = bus->card;
-	ac97 = kcalloc(1, sizeof(*ac97), GFP_KERNEL);
+	ac97 = kzalloc(sizeof(*ac97), GFP_KERNEL);
 	if (ac97 == NULL)
 		return -ENOMEM;
 	ac97->private_data = template->private_data;
Index: 2.6/sound/pci/ac97/ak4531_codec.c
===================================================================
--- 2.6.orig/sound/pci/ac97/ak4531_codec.c
+++ 2.6/sound/pci/ac97/ak4531_codec.c
@@ -357,7 +357,7 @@ int snd_ak4531_mixer(snd_card_t * card, 
 	snd_assert(rak4531 != NULL, return -EINVAL);
 	*rak4531 = NULL;
 	snd_assert(card != NULL && _ak4531 != NULL, return -EINVAL);
-	ak4531 = kcalloc(1, sizeof(*ak4531), GFP_KERNEL);
+	ak4531 = kzalloc(sizeof(*ak4531), GFP_KERNEL);
 	if (ak4531 == NULL)
 		return -ENOMEM;
 	*ak4531 = *_ak4531;
Index: 2.6/sound/pci/ali5451/ali5451.c
===================================================================
--- 2.6.orig/sound/pci/ali5451/ali5451.c
+++ 2.6/sound/pci/ali5451/ali5451.c
@@ -2249,7 +2249,7 @@ static int __devinit snd_ali_create(snd_
 		return -ENXIO;
 	}
 
-	if ((codec = kcalloc(1, sizeof(*codec), GFP_KERNEL)) == NULL) {
+	if ((codec = kzalloc(sizeof(*codec), GFP_KERNEL)) == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
Index: 2.6/sound/pci/atiixp.c
===================================================================
--- 2.6.orig/sound/pci/atiixp.c
+++ 2.6/sound/pci/atiixp.c
@@ -1522,7 +1522,7 @@ static int __devinit snd_atiixp_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/atiixp_modem.c
===================================================================
--- 2.6.orig/sound/pci/atiixp_modem.c
+++ 2.6/sound/pci/atiixp_modem.c
@@ -1208,7 +1208,7 @@ static int __devinit snd_atiixp_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/au88x0/au88x0.c
===================================================================
--- 2.6.orig/sound/pci/au88x0/au88x0.c
+++ 2.6/sound/pci/au88x0/au88x0.c
@@ -150,7 +150,7 @@ snd_vortex_create(snd_card_t * card, str
 	}
 	pci_set_dma_mask(pci, VORTEX_DMA_MASK);
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/pci/azt3328.c
===================================================================
--- 2.6.orig/sound/pci/azt3328.c
+++ 2.6/sound/pci/azt3328.c
@@ -1345,7 +1345,7 @@ static int __devinit snd_azf3328_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/bt87x.c
===================================================================
--- 2.6.orig/sound/pci/bt87x.c
+++ 2.6/sound/pci/bt87x.c
@@ -720,7 +720,7 @@ static int __devinit snd_bt87x_create(sn
 	if (err < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/ca0106/ca0106_main.c
===================================================================
--- 2.6.orig/sound/pci/ca0106/ca0106_main.c
+++ 2.6/sound/pci/ca0106/ca0106_main.c
@@ -344,7 +344,7 @@ static int snd_ca0106_pcm_open_playback_
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 
 	if (epcm == NULL)
 		return -ENOMEM;
@@ -411,7 +411,7 @@ static int snd_ca0106_pcm_open_capture_c
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL) {
                 snd_printk("open_capture_channel: failed epcm alloc\n");
 		return -ENOMEM;
@@ -1136,7 +1136,7 @@ static int __devinit snd_ca0106_create(s
 		return -ENXIO;
 	}
   
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/cmipci.c
===================================================================
--- 2.6.orig/sound/pci/cmipci.c
+++ 2.6/sound/pci/cmipci.c
@@ -2801,7 +2801,7 @@ static int __devinit snd_cmipci_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	cm = kcalloc(1, sizeof(*cm), GFP_KERNEL);
+	cm = kzalloc(sizeof(*cm), GFP_KERNEL);
 	if (cm == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/cs4281.c
===================================================================
--- 2.6.orig/sound/pci/cs4281.c
+++ 2.6/sound/pci/cs4281.c
@@ -1394,7 +1394,7 @@ static int __devinit snd_cs4281_create(s
 	*rchip = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/cs46xx/cs46xx_lib.c
===================================================================
--- 2.6.orig/sound/pci/cs46xx/cs46xx_lib.c
+++ 2.6/sound/pci/cs46xx/cs46xx_lib.c
@@ -1304,7 +1304,7 @@ static int _cs46xx_playback_open_channel
 	cs46xx_pcm_t * cpcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	cpcm = kcalloc(1, sizeof(*cpcm), GFP_KERNEL);
+	cpcm = kzalloc(sizeof(*cpcm), GFP_KERNEL);
 	if (cpcm == NULL)
 		return -ENOMEM;
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
@@ -3778,7 +3778,7 @@ int __devinit snd_cs46xx_create(snd_card
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/emu10k1/emu10k1_main.c
===================================================================
--- 2.6.orig/sound/pci/emu10k1/emu10k1_main.c
+++ 2.6/sound/pci/emu10k1/emu10k1_main.c
@@ -857,7 +857,7 @@ int __devinit snd_emu10k1_create(snd_car
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	emu = kcalloc(1, sizeof(*emu), GFP_KERNEL);
+	emu = kzalloc(sizeof(*emu), GFP_KERNEL);
 	if (emu == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/emu10k1/emu10k1x.c
===================================================================
--- 2.6.orig/sound/pci/emu10k1/emu10k1x.c
+++ 2.6/sound/pci/emu10k1/emu10k1x.c
@@ -395,7 +395,7 @@ static int snd_emu10k1x_playback_open(sn
 	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                 return err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = chip;
@@ -571,7 +571,7 @@ static int snd_emu10k1x_pcm_open_capture
 	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
                 return err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 
@@ -920,7 +920,7 @@ static int __devinit snd_emu10k1x_create
 		return -ENXIO;
 	}
   
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/emu10k1/emufx.c
===================================================================
--- 2.6.orig/sound/pci/emu10k1/emufx.c
+++ 2.6/sound/pci/emu10k1/emufx.c
@@ -1036,7 +1036,7 @@ static int __devinit _snd_emu10k1_audigy
 	spin_lock_init(&emu->fx8010.irq_lock);
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
 
-	if ((icode = kcalloc(1, sizeof(*icode), GFP_KERNEL)) == NULL ||
+	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL ||
 	    (icode->gpr_map = (u_int32_t __user *)kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
 	    (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS, sizeof(*controls), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
@@ -1503,11 +1503,11 @@ static int __devinit _snd_emu10k1_init_e
 	spin_lock_init(&emu->fx8010.irq_lock);
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
 
-	if ((icode = kcalloc(1, sizeof(*icode), GFP_KERNEL)) == NULL)
+	if ((icode = kzalloc(sizeof(*icode), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	if ((icode->gpr_map = (u_int32_t __user *)kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
             (controls = kcalloc(SND_EMU10K1_GPR_CONTROLS, sizeof(emu10k1_fx8010_control_gpr_t), GFP_KERNEL)) == NULL ||
-	    (ipcm = kcalloc(1, sizeof(*ipcm), GFP_KERNEL)) == NULL) {
+	    (ipcm = kzalloc(sizeof(*ipcm), GFP_KERNEL)) == NULL) {
 		err = -ENOMEM;
 		goto __err;
 	}
@@ -2217,7 +2217,7 @@ static int snd_emu10k1_fx8010_ioctl(snd_
 		kfree(ipcm);
 		return res;
 	case SNDRV_EMU10K1_IOCTL_PCM_PEEK:
-		ipcm = kcalloc(1, sizeof(*ipcm), GFP_KERNEL);
+		ipcm = kzalloc(sizeof(*ipcm), GFP_KERNEL);
 		if (ipcm == NULL)
 			return -ENOMEM;
 		if (copy_from_user(ipcm, argp, sizeof(*ipcm))) {
Index: 2.6/sound/pci/emu10k1/emupcm.c
===================================================================
--- 2.6.orig/sound/pci/emu10k1/emupcm.c
+++ 2.6/sound/pci/emu10k1/emupcm.c
@@ -1016,7 +1016,7 @@ static int snd_emu10k1_efx_playback_open
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int i;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -1049,7 +1049,7 @@ static int snd_emu10k1_playback_open(snd
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int i, err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -1094,7 +1094,7 @@ static int snd_emu10k1_capture_open(snd_
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_t *epcm;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -1130,7 +1130,7 @@ static int snd_emu10k1_capture_mic_open(
 	emu10k1_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
@@ -1170,7 +1170,7 @@ static int snd_emu10k1_capture_efx_open(
 	int nefx = emu->audigy ? 64 : 32;
 	int idx;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
 		return -ENOMEM;
 	epcm->emu = emu;
Index: 2.6/sound/pci/emu10k1/p16v.c
===================================================================
--- 2.6.orig/sound/pci/emu10k1/p16v.c
+++ 2.6/sound/pci/emu10k1/p16v.c
@@ -178,7 +178,7 @@ static int snd_p16v_pcm_open_playback_ch
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
         //snd_printk("epcm kcalloc: %p\n", epcm);
 
 	if (epcm == NULL)
@@ -214,7 +214,7 @@ static int snd_p16v_pcm_open_capture_cha
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 	//snd_printk("epcm kcalloc: %p\n", epcm);
 
 	if (epcm == NULL)
Index: 2.6/sound/pci/ens1370.c
===================================================================
--- 2.6.orig/sound/pci/ens1370.c
+++ 2.6/sound/pci/ens1370.c
@@ -1950,7 +1950,7 @@ static int __devinit snd_ensoniq_create(
 	*rensoniq = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	ensoniq = kcalloc(1, sizeof(*ensoniq), GFP_KERNEL);
+	ensoniq = kzalloc(sizeof(*ensoniq), GFP_KERNEL);
 	if (ensoniq == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/es1938.c
===================================================================
--- 2.6.orig/sound/pci/es1938.c
+++ 2.6/sound/pci/es1938.c
@@ -1501,7 +1501,7 @@ static int __devinit snd_es1938_create(s
                 return -ENXIO;
         }
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/es1968.c
===================================================================
--- 2.6.orig/sound/pci/es1968.c
+++ 2.6/sound/pci/es1968.c
@@ -1596,7 +1596,7 @@ static int snd_es1968_playback_open(snd_
 	if (apu1 < 0)
 		return apu1;
 
-	es = kcalloc(1, sizeof(*es), GFP_KERNEL);
+	es = kzalloc(sizeof(*es), GFP_KERNEL);
 	if (!es) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		return -ENOMEM;
@@ -1641,7 +1641,7 @@ static int snd_es1968_capture_open(snd_p
 		return apu2;
 	}
 	
-	es = kcalloc(1, sizeof(*es), GFP_KERNEL);
+	es = kzalloc(sizeof(*es), GFP_KERNEL);
 	if (!es) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		snd_es1968_free_apu_pair(chip, apu2);
@@ -2588,7 +2588,7 @@ static int __devinit snd_es1968_create(s
 		return -ENXIO;
 	}
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/fm801.c
===================================================================
--- 2.6.orig/sound/pci/fm801.c
+++ 2.6/sound/pci/fm801.c
@@ -1263,7 +1263,7 @@ static int __devinit snd_fm801_create(sn
 	*rchip = NULL;
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/hda/hda_codec.c
===================================================================
--- 2.6.orig/sound/pci/hda/hda_codec.c
+++ 2.6/sound/pci/hda/hda_codec.c
@@ -288,7 +288,7 @@ static int init_unsol_queue(struct hda_b
 {
 	struct hda_bus_unsolicited *unsol;
 
-	unsol = kcalloc(1, sizeof(*unsol), GFP_KERNEL);
+	unsol = kzalloc(sizeof(*unsol), GFP_KERNEL);
 	if (! unsol) {
 		snd_printk(KERN_ERR "hda_codec: can't allocate unsolicited queue\n");
 		return -ENOMEM;
@@ -358,7 +358,7 @@ int snd_hda_bus_new(snd_card_t *card, co
 	if (busp)
 		*busp = NULL;
 
-	bus = kcalloc(1, sizeof(*bus), GFP_KERNEL);
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (bus == NULL) {
 		snd_printk(KERN_ERR "can't allocate struct hda_bus\n");
 		return -ENOMEM;
@@ -489,7 +489,7 @@ int snd_hda_codec_new(struct hda_bus *bu
 		return -EBUSY;
 	}
 
-	codec = kcalloc(1, sizeof(*codec), GFP_KERNEL);
+	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
 	if (codec == NULL) {
 		snd_printk(KERN_ERR "can't allocate struct hda_codec\n");
 		return -ENOMEM;
Index: 2.6/sound/pci/hda/hda_generic.c
===================================================================
--- 2.6.orig/sound/pci/hda/hda_generic.c
+++ 2.6/sound/pci/hda/hda_generic.c
@@ -98,7 +98,7 @@ static int add_new_node(struct hda_codec
 	struct hda_gnode *node;
 	int nconns;
 
-	node = kcalloc(1, sizeof(*node), GFP_KERNEL);
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (node == NULL)
 		return -ENOMEM;
 	node->nid = nid;
@@ -881,7 +881,7 @@ int snd_hda_parse_generic_codec(struct h
 	struct hda_gspec *spec;
 	int err;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL) {
 		printk(KERN_ERR "hda_generic: can't allocate spec\n");
 		return -ENOMEM;
Index: 2.6/sound/pci/hda/hda_intel.c
===================================================================
--- 2.6.orig/sound/pci/hda/hda_intel.c
+++ 2.6/sound/pci/hda/hda_intel.c
@@ -1303,7 +1303,7 @@ static int __devinit azx_create(snd_card
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	
 	if (NULL == chip) {
 		snd_printk(KERN_ERR SFX "cannot allocate chip\n");
Index: 2.6/sound/pci/hda/patch_analog.c
===================================================================
--- 2.6.orig/sound/pci/hda/patch_analog.c
+++ 2.6/sound/pci/hda/patch_analog.c
@@ -465,7 +465,7 @@ static int patch_ad1986a(struct hda_code
 {
 	struct ad198x_spec *spec;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -623,7 +623,7 @@ static int patch_ad1983(struct hda_codec
 {
 	struct ad198x_spec *spec;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -764,7 +764,7 @@ static int patch_ad1981(struct hda_codec
 {
 	struct ad198x_spec *spec;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/pci/hda/patch_cmedia.c
===================================================================
--- 2.6.orig/sound/pci/hda/patch_cmedia.c
+++ 2.6/sound/pci/hda/patch_cmedia.c
@@ -666,7 +666,7 @@ static int patch_cmi9880(struct hda_code
 {
 	struct cmi_spec *spec;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/pci/hda/patch_realtek.c
===================================================================
--- 2.6.orig/sound/pci/hda/patch_realtek.c
+++ 2.6/sound/pci/hda/patch_realtek.c
@@ -2086,7 +2086,7 @@ static int patch_alc880(struct hda_codec
 	int board_config;
 	int i, err;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -2358,7 +2358,7 @@ static int patch_alc260(struct hda_codec
 	struct alc_spec *spec;
 	int board_config;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -2608,7 +2608,7 @@ static int patch_alc882(struct hda_codec
 {
 	struct alc_spec *spec;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/pci/hda/patch_sigmatel.c
===================================================================
--- 2.6.orig/sound/pci/hda/patch_sigmatel.c
+++ 2.6/sound/pci/hda/patch_sigmatel.c
@@ -919,7 +919,7 @@ static int patch_stac9200(struct hda_cod
 	struct sigmatel_spec *spec;
 	int err;
 
-	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
@@ -957,7 +957,7 @@ static int patch_stac922x(struct hda_cod
 	struct sigmatel_spec *spec;
 	int err;
 
-	spec  = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/pci/ice1712/aureon.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/aureon.c
+++ 2.6/sound/pci/ice1712/aureon.c
@@ -1796,7 +1796,7 @@ static int __devinit aureon_init(ice1712
 	}
 
 	/* to remeber the register values of CS8415 */
-	ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+	ice->akm = kzalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
Index: 2.6/sound/pci/ice1712/ice1712.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/ice1712.c
+++ 2.6/sound/pci/ice1712/ice1712.c
@@ -2535,7 +2535,7 @@ static int __devinit snd_ice1712_create(
 		return -ENXIO;
 	}
 
-	ice = kcalloc(1, sizeof(*ice), GFP_KERNEL);
+	ice = kzalloc(sizeof(*ice), GFP_KERNEL);
 	if (ice == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/ice1712/ice1724.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/ice1724.c
+++ 2.6/sound/pci/ice1712/ice1724.c
@@ -2130,7 +2130,7 @@ static int __devinit snd_vt1724_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	ice = kcalloc(1, sizeof(*ice), GFP_KERNEL);
+	ice = kzalloc(sizeof(*ice), GFP_KERNEL);
 	if (ice == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/ice1712/juli.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/juli.c
+++ 2.6/sound/pci/ice1712/juli.c
@@ -182,7 +182,7 @@ static int __devinit juli_init(ice1712_t
 		ice->num_total_dacs = 2;
 		ice->num_total_adcs = 2;
 
-		ak = ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+		ak = ice->akm = kzalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 		if (! ak)
 			return -ENOMEM;
 		ice->akm_codecs = 1;
Index: 2.6/sound/pci/ice1712/phase.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/phase.c
+++ 2.6/sound/pci/ice1712/phase.c
@@ -122,7 +122,7 @@ static int __devinit phase22_init(ice171
 	}
 
 	// Initialize analog chips
-	ak = ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+	ak = ice->akm = kzalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ak)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
@@ -386,7 +386,7 @@ static int __devinit phase28_init(ice171
 	ice->num_total_adcs = 2;
 
 	// Initialize analog chips
-	ak = ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+	ak = ice->akm = kzalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (!ak)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
Index: 2.6/sound/pci/ice1712/pontis.c
===================================================================
--- 2.6.orig/sound/pci/ice1712/pontis.c
+++ 2.6/sound/pci/ice1712/pontis.c
@@ -781,7 +781,7 @@ static int __devinit pontis_init(ice1712
 	ice->num_total_adcs = 2;
 
 	/* to remeber the register values */
-	ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+	ice->akm = kzalloc(sizeof(akm4xxx_t), GFP_KERNEL);
 	if (! ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
Index: 2.6/sound/pci/intel8x0.c
===================================================================
--- 2.6.orig/sound/pci/intel8x0.c
+++ 2.6/sound/pci/intel8x0.c
@@ -2605,7 +2605,7 @@ static int __devinit snd_intel8x0_create
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/intel8x0m.c
===================================================================
--- 2.6.orig/sound/pci/intel8x0m.c
+++ 2.6/sound/pci/intel8x0m.c
@@ -1158,7 +1158,7 @@ static int __devinit snd_intel8x0m_creat
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/korg1212/korg1212.c
===================================================================
--- 2.6.orig/sound/pci/korg1212/korg1212.c
+++ 2.6/sound/pci/korg1212/korg1212.c
@@ -2220,7 +2220,7 @@ static int __devinit snd_korg1212_create
         if ((err = pci_enable_device(pci)) < 0)
                 return err;
 
-        korg1212 = kcalloc(1, sizeof(*korg1212), GFP_KERNEL);
+        korg1212 = kzalloc(sizeof(*korg1212), GFP_KERNEL);
         if (korg1212 == NULL) {
 		pci_disable_device(pci);
                 return -ENOMEM;
Index: 2.6/sound/pci/maestro3.c
===================================================================
--- 2.6.orig/sound/pci/maestro3.c
+++ 2.6/sound/pci/maestro3.c
@@ -2689,7 +2689,7 @@ snd_m3_create(snd_card_t *card, struct p
 		return -ENXIO;
 	}
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/mixart/mixart.c
===================================================================
--- 2.6.orig/sound/pci/mixart/mixart.c
+++ 2.6/sound/pci/mixart/mixart.c
@@ -1004,7 +1004,7 @@ static int __devinit snd_mixart_create(m
 		.dev_free = snd_mixart_chip_dev_free,
 	};
 
-	mgr->chip[idx] = chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	mgr->chip[idx] = chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
 		snd_printk(KERN_ERR "cannot allocate chip\n");
 		return -ENOMEM;
@@ -1292,7 +1292,7 @@ static int __devinit snd_mixart_probe(st
 
 	/*
 	 */
-	mgr = kcalloc(1, sizeof(*mgr), GFP_KERNEL);
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (! mgr) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/nm256/nm256.c
===================================================================
--- 2.6.orig/sound/pci/nm256/nm256.c
+++ 2.6/sound/pci/nm256/nm256.c
@@ -1349,7 +1349,7 @@ snd_nm256_create(snd_card_t *card, struc
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/sonicvibes.c
===================================================================
--- 2.6.orig/sound/pci/sonicvibes.c
+++ 2.6/sound/pci/sonicvibes.c
@@ -1257,7 +1257,7 @@ static int __devinit snd_sonicvibes_crea
                 return -ENXIO;
         }
 
-	sonic = kcalloc(1, sizeof(*sonic), GFP_KERNEL);
+	sonic = kzalloc(sizeof(*sonic), GFP_KERNEL);
 	if (sonic == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/trident/trident_main.c
===================================================================
--- 2.6.orig/sound/pci/trident/trident_main.c
+++ 2.6/sound/pci/trident/trident_main.c
@@ -2960,7 +2960,7 @@ static int __devinit snd_trident_mixer(t
 		.read = snd_trident_codec_read,
 	};
 
-	uctl = kcalloc(1, sizeof(*uctl), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return -ENOMEM;
 
@@ -3546,7 +3546,7 @@ int __devinit snd_trident_create(snd_car
 		return -ENXIO;
 	}
 	
-	trident = kcalloc(1, sizeof(*trident), GFP_KERNEL);
+	trident = kzalloc(sizeof(*trident), GFP_KERNEL);
 	if (trident == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pci/via82xx.c
===================================================================
--- 2.6.orig/sound/pci/via82xx.c
+++ 2.6/sound/pci/via82xx.c
@@ -2063,7 +2063,7 @@ static int __devinit snd_via82xx_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	if ((chip = kcalloc(1, sizeof(*chip), GFP_KERNEL)) == NULL) {
+	if ((chip = kzalloc(sizeof(*chip), GFP_KERNEL)) == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
Index: 2.6/sound/pci/via82xx_modem.c
===================================================================
--- 2.6.orig/sound/pci/via82xx_modem.c
+++ 2.6/sound/pci/via82xx_modem.c
@@ -1082,7 +1082,7 @@ static int __devinit snd_via82xx_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	if ((chip = kcalloc(1, sizeof(*chip), GFP_KERNEL)) == NULL) {
+	if ((chip = kzalloc(sizeof(*chip), GFP_KERNEL)) == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
Index: 2.6/sound/pci/ymfpci/ymfpci_main.c
===================================================================
--- 2.6.orig/sound/pci/ymfpci/ymfpci_main.c
+++ 2.6/sound/pci/ymfpci/ymfpci_main.c
@@ -838,7 +838,7 @@ static int snd_ymfpci_playback_open_1(sn
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	ymfpci_pcm_t *ypcm;
 
-	ypcm = kcalloc(1, sizeof(*ypcm), GFP_KERNEL);
+	ypcm = kzalloc(sizeof(*ypcm), GFP_KERNEL);
 	if (ypcm == NULL)
 		return -ENOMEM;
 	ypcm->chip = chip;
@@ -951,7 +951,7 @@ static int snd_ymfpci_capture_open(snd_p
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	ymfpci_pcm_t *ypcm;
 
-	ypcm = kcalloc(1, sizeof(*ypcm), GFP_KERNEL);
+	ypcm = kzalloc(sizeof(*ypcm), GFP_KERNEL);
 	if (ypcm == NULL)
 		return -ENOMEM;
 	ypcm->chip = chip;
@@ -2182,7 +2182,7 @@ int __devinit snd_ymfpci_create(snd_card
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
Index: 2.6/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
===================================================================
--- 2.6.orig/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
+++ 2.6/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
@@ -151,7 +151,7 @@ pdacf_t *snd_pdacf_create(snd_card_t *ca
 {
 	pdacf_t *chip;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return NULL;
 	chip->card = card;
Index: 2.6/sound/ppc/pmac.c
===================================================================
--- 2.6.orig/sound/ppc/pmac.c
+++ 2.6/sound/ppc/pmac.c
@@ -1158,7 +1158,7 @@ int __init snd_pmac_new(snd_card_t *card
 	snd_runtime_check(chip_return, return -EINVAL);
 	*chip_return = NULL;
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->card = card;
Index: 2.6/sound/sparc/amd7930.c
===================================================================
--- 2.6.orig/sound/sparc/amd7930.c
+++ 2.6/sound/sparc/amd7930.c
@@ -967,7 +967,7 @@ static int __init snd_amd7930_create(snd
 	int err;
 
 	*ramd = NULL;
-	amd = kcalloc(1, sizeof(*amd), GFP_KERNEL);
+	amd = kzalloc(sizeof(*amd), GFP_KERNEL);
 	if (amd == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/sparc/cs4231.c
===================================================================
--- 2.6.orig/sound/sparc/cs4231.c
+++ 2.6/sound/sparc/cs4231.c
@@ -1966,7 +1966,7 @@ static int __init snd_cs4231_sbus_create
 	int err;
 
 	*rchip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
@@ -2080,7 +2080,7 @@ static int __init snd_cs4231_ebus_create
 	int err;
 
 	*rchip = NULL;
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/synth/emux/emux.c
===================================================================
--- 2.6.orig/sound/synth/emux/emux.c
+++ 2.6/sound/synth/emux/emux.c
@@ -40,7 +40,7 @@ int snd_emux_new(snd_emux_t **remu)
 	snd_emux_t *emu;
 
 	*remu = NULL;
-	emu = kcalloc(1, sizeof(*emu), GFP_KERNEL);
+	emu = kzalloc(sizeof(*emu), GFP_KERNEL);
 	if (emu == NULL)
 		return -ENOMEM;
 
Index: 2.6/sound/synth/emux/emux_seq.c
===================================================================
--- 2.6.orig/sound/synth/emux/emux_seq.c
+++ 2.6/sound/synth/emux/emux_seq.c
@@ -146,7 +146,7 @@ snd_emux_create_port(snd_emux_t *emu, ch
 	int i, type, cap;
 
 	/* Allocate structures for this channel */
-	if ((p = kcalloc(1, sizeof(*p), GFP_KERNEL)) == NULL) {
+	if ((p = kzalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
 		snd_printk("no memory\n");
 		return NULL;
 	}
Index: 2.6/sound/synth/emux/soundfont.c
===================================================================
--- 2.6.orig/sound/synth/emux/soundfont.c
+++ 2.6/sound/synth/emux/soundfont.c
@@ -266,7 +266,7 @@ newsf(snd_sf_list_t *sflist, int type, c
 	}
 
 	/* not found -- create a new one */
-	sf = kcalloc(1, sizeof(*sf), GFP_KERNEL);
+	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
 	if (sf == NULL)
 		return NULL;
 	sf->id = sflist->fonts_size;
@@ -346,7 +346,7 @@ sf_zone_new(snd_sf_list_t *sflist, snd_s
 {
 	snd_sf_zone_t *zp;
 
-	if ((zp = kcalloc(1, sizeof(*zp), GFP_KERNEL)) == NULL)
+	if ((zp = kzalloc(sizeof(*zp), GFP_KERNEL)) == NULL)
 		return NULL;
 	zp->next = sf->zones;
 	sf->zones = zp;
@@ -377,7 +377,7 @@ sf_sample_new(snd_sf_list_t *sflist, snd
 {
 	snd_sf_sample_t *sp;
 
-	if ((sp = kcalloc(1, sizeof(*sp), GFP_KERNEL)) == NULL)
+	if ((sp = kzalloc(sizeof(*sp), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	sp->next = sf->samples;
@@ -1362,7 +1362,7 @@ snd_sf_new(snd_sf_callback_t *callback, 
 {
 	snd_sf_list_t *sflist;
 
-	if ((sflist = kcalloc(1, sizeof(*sflist), GFP_KERNEL)) == NULL)
+	if ((sflist = kzalloc(sizeof(*sflist), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	init_MUTEX(&sflist->presets_mutex);
Index: 2.6/sound/synth/util_mem.c
===================================================================
--- 2.6.orig/sound/synth/util_mem.c
+++ 2.6/sound/synth/util_mem.c
@@ -38,7 +38,7 @@ snd_util_memhdr_new(int memsize)
 {
 	snd_util_memhdr_t *hdr;
 
-	hdr = kcalloc(1, sizeof(*hdr), GFP_KERNEL);
+	hdr = kzalloc(sizeof(*hdr), GFP_KERNEL);
 	if (hdr == NULL)
 		return NULL;
 	hdr->size = memsize;
Index: 2.6/sound/usb/usbaudio.c
===================================================================
--- 2.6.orig/sound/usb/usbaudio.c
+++ 2.6/sound/usb/usbaudio.c
@@ -3080,7 +3080,7 @@ static int snd_usb_audio_create(struct u
 		return -ENOMEM;
 	}
 
-	chip = kcalloc(1, sizeof(*chip), GFP_KERNEL);
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
 		snd_card_free(card);
 		return -ENOMEM;
Index: 2.6/sound/usb/usbmidi.c
===================================================================
--- 2.6.orig/sound/usb/usbmidi.c
+++ 2.6/sound/usb/usbmidi.c
@@ -784,7 +784,7 @@ static int snd_usbmidi_in_endpoint_creat
 	int length;
 
 	rep->in = NULL;
-	ep = kcalloc(1, sizeof(*ep), GFP_KERNEL);
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -854,7 +854,7 @@ static int snd_usbmidi_out_endpoint_crea
 	void* buffer;
 
 	rep->out = NULL;
-	ep = kcalloc(1, sizeof(*ep), GFP_KERNEL);
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -1473,7 +1473,7 @@ int snd_usb_create_midi_interface(snd_us
 	int out_ports, in_ports;
 	int i, err;
 
-	umidi = kcalloc(1, sizeof(*umidi), GFP_KERNEL);
+	umidi = kzalloc(sizeof(*umidi), GFP_KERNEL);
 	if (!umidi)
 		return -ENOMEM;
 	umidi->chip = chip;
Index: 2.6/sound/usb/usbmixer.c
===================================================================
--- 2.6.orig/sound/usb/usbmixer.c
+++ 2.6/sound/usb/usbmixer.c
@@ -824,7 +824,7 @@ static void build_feature_ctl(mixer_buil
 	if (check_ignored_ctl(state, unitid, control))
 		return;
 
-	cval = kcalloc(1, sizeof(*cval), GFP_KERNEL);
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 		return;
@@ -997,7 +997,7 @@ static void build_mixer_unit_ctl(mixer_b
 	if (check_ignored_ctl(state, unitid, 0))
 		return;
 
-	cval = kcalloc(1, sizeof(*cval), GFP_KERNEL);
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval)
 		return;
 
@@ -1244,7 +1244,7 @@ static int build_audio_procunit(mixer_bu
 			continue;
 		if (check_ignored_ctl(state, unitid, valinfo->control))
 			continue;
-		cval = kcalloc(1, sizeof(*cval), GFP_KERNEL);
+		cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 		if (! cval) {
 			snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 			return -ENOMEM;
@@ -1430,7 +1430,7 @@ static int parse_audio_selector_unit(mix
 	if (check_ignored_ctl(state, unitid, 0))
 		return 0;
 
-	cval = kcalloc(1, sizeof(*cval), GFP_KERNEL);
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 		return -ENOMEM;
@@ -1945,7 +1945,7 @@ int snd_usb_create_mixer(snd_usb_audio_t
 
 	strcpy(chip->card->mixername, "USB Mixer");
 
-	mixer = kcalloc(1, sizeof(*mixer), GFP_KERNEL);
+	mixer = kzalloc(sizeof(*mixer), GFP_KERNEL);
 	if (!mixer)
 		return -ENOMEM;
 	mixer->chip = chip;
Index: 2.6/sound/usb/usx2y/usbusx2yaudio.c
===================================================================
--- 2.6.orig/sound/usb/usx2y/usbusx2yaudio.c
+++ 2.6/sound/usb/usx2y/usbusx2yaudio.c
@@ -957,7 +957,7 @@ static int usX2Y_audio_stream_new(snd_ca
 
 	for (i = playback_endpoint ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
 	     i <= SNDRV_PCM_STREAM_CAPTURE; ++i) {
-		usX2Y_substream[i] = kcalloc(1, sizeof(snd_usX2Y_substream_t), GFP_KERNEL);
+		usX2Y_substream[i] = kzalloc(sizeof(snd_usX2Y_substream_t), GFP_KERNEL);
 		if (NULL == usX2Y_substream[i]) {
 			snd_printk(KERN_ERR "cannot malloc\n");
 			return -ENOMEM;
