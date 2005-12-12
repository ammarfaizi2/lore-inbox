Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVLLXtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVLLXtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVLLXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:48:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932284AbVLLXrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:47:02 -0500
Date: Mon, 12 Dec 2005 23:45:49 GMT
Message-Id: <200512122345.jBCNjnNQ009063@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 19/19] MUTEX: Sound changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the sound files to use the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-sound-2615rc5.diff
 include/sound/ac97_codec.h          |    4 ++--
 include/sound/ad1848.h              |    2 +-
 include/sound/ak4531_codec.h        |    2 +-
 include/sound/core.h                |    4 ++--
 include/sound/cs4231.h              |    4 ++--
 include/sound/cs46xx.h              |    2 +-
 include/sound/emu10k1.h             |    4 ++--
 include/sound/emux_synth.h          |    2 +-
 include/sound/gus.h                 |    6 +++---
 include/sound/hwdep.h               |    2 +-
 include/sound/i2c.h                 |    2 +-
 include/sound/info.h                |    2 +-
 include/sound/mixer_oss.h           |    2 +-
 include/sound/opl3.h                |    2 +-
 include/sound/pcm.h                 |    2 +-
 include/sound/pcm_oss.h             |    2 +-
 include/sound/rawmidi.h             |    4 ++--
 include/sound/sb16_csp.h            |    2 +-
 include/sound/seq_instr.h           |    2 +-
 include/sound/soundfont.h           |    2 +-
 include/sound/util_mem.h            |    2 +-
 include/sound/vx_core.h             |    2 +-
 sound/arm/aaci.h                    |    2 +-
 sound/arm/pxa2xx-ac97.c             |    2 +-
 sound/arm/sa11xx-uda1341.c          |    2 +-
 sound/core/memalloc.c               |    2 +-
 sound/core/seq/seq_clientmgr.h      |    2 +-
 sound/core/seq/seq_device.c         |    2 +-
 sound/core/seq/seq_midi.c           |    2 +-
 sound/core/seq/seq_queue.h          |    2 +-
 sound/core/timer.c                  |    2 +-
 sound/drivers/opl4/opl4_local.h     |    2 +-
 sound/oss/ac97_codec.c              |    2 +-
 sound/oss/aci.c                     |    4 ++--
 sound/oss/ad1889.h                  |    2 +-
 sound/oss/ali5455.c                 |    2 +-
 sound/oss/au1000.c                  |    4 ++--
 sound/oss/au1550_ac97.c             |    4 ++--
 sound/oss/btaudio.c                 |    2 +-
 sound/oss/cmpci.c                   |    2 +-
 sound/oss/cs4281/cs4281m.c          |    6 +++---
 sound/oss/cs46xx.c                  |    6 +++---
 sound/oss/dmasound/dmasound_awacs.c |    2 +-
 sound/oss/emu10k1/hwaccess.h        |    2 +-
 sound/oss/es1370.c                  |    4 ++--
 sound/oss/es1371.c                  |    4 ++--
 sound/oss/esssolo1.c                |    2 +-
 sound/oss/forte.c                   |    2 +-
 sound/oss/hal2.c                    |    2 +-
 sound/oss/i810_audio.c              |    2 +-
 sound/oss/ite8172.c                 |    2 +-
 sound/oss/maestro.c                 |    2 +-
 sound/oss/maestro3.c                |    2 +-
 sound/oss/nec_vrc5477.c             |    2 +-
 sound/oss/rme96xx.c                 |    2 +-
 sound/oss/sonicvibes.c              |    2 +-
 sound/oss/swarm_cs4297a.c           |    6 +++---
 sound/oss/trident.c                 |    4 ++--
 sound/oss/via82cxxx_audio.c         |    6 +++---
 sound/oss/vwsnd.c                   |    8 ++++----
 sound/oss/ymfpci.h                  |    2 +-
 sound/pci/atiixp.c                  |    2 +-
 sound/pci/atiixp_modem.c            |    2 +-
 sound/pci/cmipci.c                  |    2 +-
 sound/pci/ens1370.c                 |    2 +-
 sound/pci/es1968.c                  |    2 +-
 sound/pci/hda/hda_codec.h           |    4 ++--
 sound/pci/hda/hda_intel.c           |    2 +-
 sound/pci/hda/patch_analog.c        |    2 +-
 sound/pci/ice1712/ice1712.h         |    6 +++---
 sound/pci/korg1212/korg1212.c       |    2 +-
 sound/pci/mixart/mixart.h           |    6 +++---
 sound/pci/nm256/nm256.c             |    2 +-
 sound/sparc/cs4231.c                |    4 ++--
 sound/usb/usx2y/usbusx2y.h          |    2 +-
 75 files changed, 105 insertions(+), 105 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/ac97_codec.h linux-2.6.15-rc5-mutex/include/sound/ac97_codec.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/ac97_codec.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/ac97_codec.h	2005-12-12 19:38:31.000000000 +0000
@@ -486,8 +486,8 @@ struct _snd_ac97 {
 	snd_info_entry_t *proc_regs;
 	unsigned short subsystem_vendor;
 	unsigned short subsystem_device;
-	struct semaphore reg_mutex;
-	struct semaphore page_mutex;	/* mutex for AD18xx multi-codecs and paging (2.3) */
+	struct mutex reg_mutex;
+	struct mutex page_mutex; /* mutex for AD18xx multi-codecs and paging (2.3) */
 	unsigned short num;	/* number of codec: 0 = primary, 1 = secondary */
 	unsigned short addr;	/* physical address of codec [0-3] */
 	unsigned int id;	/* identification of codec */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/ad1848.h linux-2.6.15-rc5-mutex/include/sound/ad1848.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/ad1848.h	2005-03-02 12:09:01.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/ad1848.h	2005-12-12 19:41:15.000000000 +0000
@@ -149,7 +149,7 @@ struct _snd_ad1848 {
 	int thinkpad_flag;		/* Thinkpad CS4248 needs some extra help */
 
 	spinlock_t reg_lock;
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 };
 
 typedef struct _snd_ad1848 ad1848_t;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/ak4531_codec.h linux-2.6.15-rc5-mutex/include/sound/ak4531_codec.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/ak4531_codec.h	2005-03-02 12:09:01.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/ak4531_codec.h	2005-12-12 19:39:14.000000000 +0000
@@ -72,7 +72,7 @@ struct _snd_ak4531 {
 	void (*private_free) (ak4531_t *ak4531);
 	/* --- */
 	unsigned char regs[0x20];
-	struct semaphore reg_mutex;
+	struct mutex reg_mutex;
 };
 
 int snd_ak4531_mixer(snd_card_t * card, ak4531_t * _ak4531, ak4531_t ** rak4531);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/core.h linux-2.6.15-rc5-mutex/include/sound/core.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/core.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/core.h	2005-12-12 22:12:49.000000000 +0000
@@ -23,7 +23,7 @@
  */
 
 #include <linux/sched.h>		/* wake_up() */
-#include <asm/semaphore.h>		/* struct semaphore */
+#include <linux/semaphore.h>		/* struct mutex */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct workqueue_struct */
 #include <linux/pm.h>			/* pm_message_t */
@@ -176,7 +176,7 @@ struct _snd_card {
 	int (*pm_resume)(snd_card_t *card);
 	void *pm_private_data;
 	unsigned int power_state;	/* power state */
-	struct semaphore power_lock;	/* power lock */
+	struct mutex power_lock;	/* power lock */
 	wait_queue_head_t power_sleep;
 #endif
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/cs4231.h linux-2.6.15-rc5-mutex/include/sound/cs4231.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/cs4231.h	2005-03-02 12:09:01.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/cs4231.h	2005-12-12 19:38:41.000000000 +0000
@@ -287,8 +287,8 @@ struct _snd_cs4231 {
 #endif
 
 	spinlock_t reg_lock;
-	struct semaphore mce_mutex;
-	struct semaphore open_mutex;
+	struct mutex mce_mutex;
+	struct mutex open_mutex;
 
 	int (*rate_constraint) (snd_pcm_runtime_t *runtime);
 	void (*set_playback_format) (cs4231_t *chip, snd_pcm_hw_params_t *hw_params, unsigned char pdfr);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/cs46xx.h linux-2.6.15-rc5-mutex/include/sound/cs46xx.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/cs46xx.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/cs46xx.h	2005-12-12 19:41:15.000000000 +0000
@@ -1712,7 +1712,7 @@ struct _snd_cs46xx {
 	int current_gpio;
 #endif
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	struct semaphore spos_mutex;
+	struct mutex spos_mutex;
 
 	dsp_spos_instance_t * dsp_spos_instance;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/emu10k1.h linux-2.6.15-rc5-mutex/include/sound/emu10k1.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/emu10k1.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/emu10k1.h	2005-12-12 19:41:15.000000000 +0000
@@ -1024,7 +1024,7 @@ typedef struct {
 	int gpr_size;			/* size of allocated GPR controls */
 	int gpr_count;			/* count of used kcontrols */
 	struct list_head gpr_ctl;	/* GPR controls */
-	struct semaphore lock;
+	struct mutex lock;
 	snd_emu10k1_fx8010_pcm_t pcm[8];
 	spinlock_t irq_lock;
 	snd_emu10k1_fx8010_irq_t *irq_handlers;
@@ -1118,7 +1118,7 @@ struct _snd_emu10k1 {
 	spinlock_t reg_lock;
 	spinlock_t emu_lock;
 	spinlock_t voice_lock;
-	struct semaphore ptb_lock;
+	struct mutex ptb_lock;
 
 	emu10k1_voice_t voices[NUM_G];
 	emu10k1_voice_t p16v_voices[4];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/emux_synth.h linux-2.6.15-rc5-mutex/include/sound/emux_synth.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/emux_synth.h	2004-06-18 13:44:05.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/emux_synth.h	2005-12-12 19:41:15.000000000 +0000
@@ -112,7 +112,7 @@ struct snd_emux {
 	snd_emux_voice_t *voices;	/* Voices (EMU 'channel') */
 	int use_time;	/* allocation counter */
 	spinlock_t voice_lock;	/* Lock for voice access */
-	struct semaphore register_mutex;
+	struct mutex register_mutex;
 	int client;		/* For the sequencer client */
 	int ports[SNDRV_EMUX_MAX_PORTS];	/* The ports for this device */
 	snd_emux_port_t *portptrs[SNDRV_EMUX_MAX_PORTS];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/gus.h linux-2.6.15-rc5-mutex/include/sound/gus.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/gus.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/gus.h	2005-12-12 19:39:26.000000000 +0000
@@ -210,7 +210,7 @@ typedef struct _snd_gf1_mem {
 	snd_gf1_bank_info_t banks_16[4];
 	snd_gf1_mem_block_t *first;
 	snd_gf1_mem_block_t *last;
-	struct semaphore memory_mutex;
+	struct mutex memory_mutex;
 } snd_gf1_mem_t;
 
 typedef struct snd_gf1_dma_block {
@@ -468,8 +468,8 @@ struct _snd_gus_card {
 	spinlock_t dma_lock;
 	spinlock_t pcm_volume_level_lock;
 	spinlock_t uart_cmd_lock;
-	struct semaphore dma_mutex;
-	struct semaphore register_mutex;
+	struct mutex dma_mutex;
+	struct mutex register_mutex;
 };
 
 /* I/O functions for GF1/InterWave chip - gus_io.c */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/hwdep.h linux-2.6.15-rc5-mutex/include/sound/hwdep.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/hwdep.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/hwdep.h	2005-12-12 19:38:54.000000000 +0000
@@ -62,7 +62,7 @@ struct _snd_hwdep {
 	void *private_data;
 	void (*private_free) (snd_hwdep_t *hwdep);
 
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 	int used;
 	unsigned int dsp_loaded;
 	unsigned int exclusive: 1;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/i2c.h linux-2.6.15-rc5-mutex/include/sound/i2c.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/i2c.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/i2c.h	2005-12-12 19:39:11.000000000 +0000
@@ -58,7 +58,7 @@ struct _snd_i2c_bus {
 	snd_card_t *card;	/* card which I2C belongs to */
 	char name[32];		/* some useful label */
 
-	struct semaphore lock_mutex;
+	struct mutex lock_mutex;
 
 	snd_i2c_bus_t *master;	/* master bus when SCK/SCL is shared */
 	struct list_head buses;	/* master: slave buses sharing SCK/SCL, slave: link list */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/info.h linux-2.6.15-rc5-mutex/include/sound/info.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/info.h	2005-03-02 12:09:01.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/info.h	2005-12-12 19:38:46.000000000 +0000
@@ -86,7 +86,7 @@ struct snd_info_entry {
 	void *private_data;
 	void (*private_free)(snd_info_entry_t *entry);
 	struct proc_dir_entry *p;
-	struct semaphore access;
+	struct mutex access;
 };
 
 extern int snd_info_check_reserved_words(const char *str);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/mixer_oss.h linux-2.6.15-rc5-mutex/include/sound/mixer_oss.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/mixer_oss.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/mixer_oss.h	2005-12-12 19:39:05.000000000 +0000
@@ -59,7 +59,7 @@ struct _snd_oss_mixer {
 	snd_mixer_oss_put_recsrce_t put_recsrc;
 	void *private_data_recsrc;
 	void (*private_free_recsrc)(snd_mixer_oss_t *mixer);
-	struct semaphore reg_mutex;
+	struct mutex reg_mutex;
 	snd_info_entry_t *proc_entry;
 	int oss_dev_alloc;
 	/* --- */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/opl3.h linux-2.6.15-rc5-mutex/include/sound/opl3.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/opl3.h	2005-01-04 11:13:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/opl3.h	2005-12-12 19:38:35.000000000 +0000
@@ -312,7 +312,7 @@ struct snd_opl3 {
 	int sys_timer_status;		/* system timer run status */
 	spinlock_t sys_timer_lock;	/* Lock for system timer access */
 #endif
-	struct semaphore access_mutex;	/* locking */
+	struct mutex access_mutex;	/* locking */
 };
 
 /* opl3.c */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/pcm.h linux-2.6.15-rc5-mutex/include/sound/pcm.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/pcm.h	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/pcm.h	2005-12-12 19:38:51.000000000 +0000
@@ -445,7 +445,7 @@ struct _snd_pcm {
 	char id[64];
 	char name[80];
 	snd_pcm_str_t streams[2];
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 	wait_queue_head_t open_wait;
 	void *private_data;
 	void (*private_free) (snd_pcm_t *pcm);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/pcm_oss.h linux-2.6.15-rc5-mutex/include/sound/pcm_oss.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/pcm_oss.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/pcm_oss.h	2005-12-12 19:37:46.000000000 +0000
@@ -76,7 +76,7 @@ typedef struct _snd_pcm_oss_substream {
 
 typedef struct _snd_pcm_oss_stream {
 	snd_pcm_oss_setup_t *setup_list;	/* setup list */
-        struct semaphore setup_mutex;
+        struct mutex setup_mutex;
 	snd_info_entry_t *proc_entry;
 } snd_pcm_oss_stream_t;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/rawmidi.h linux-2.6.15-rc5-mutex/include/sound/rawmidi.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/rawmidi.h	2005-06-22 13:52:33.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/rawmidi.h	2005-12-12 22:12:49.000000000 +0000
@@ -26,7 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
 #include "seq_device.h"
@@ -136,7 +136,7 @@ struct _snd_rawmidi {
 	void *private_data;
 	void (*private_free) (snd_rawmidi_t *rmidi);
 
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 	wait_queue_head_t open_wait;
 
 	snd_info_entry_t *dev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/sb16_csp.h linux-2.6.15-rc5-mutex/include/sound/sb16_csp.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/sb16_csp.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/sb16_csp.h	2005-12-12 19:41:15.000000000 +0000
@@ -158,7 +158,7 @@ struct snd_sb_csp {
 	snd_kcontrol_t *qsound_switch;
 	snd_kcontrol_t *qsound_space;
 
-	struct semaphore access_mutex;	/* locking */
+	struct mutex access_mutex;	/* locking */
 };
 
 int snd_sb_csp_new(sb_t *chip, int device, snd_hwdep_t ** rhwdep);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/seq_instr.h linux-2.6.15-rc5-mutex/include/sound/seq_instr.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/seq_instr.h	2004-06-18 13:44:06.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/seq_instr.h	2005-12-12 19:39:20.000000000 +0000
@@ -66,7 +66,7 @@ typedef struct {
 
 	spinlock_t lock;
 	spinlock_t ops_lock;
-	struct semaphore ops_mutex;
+	struct mutex ops_mutex;
 	unsigned long ops_flags;
 } snd_seq_kinstr_list_t;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/soundfont.h linux-2.6.15-rc5-mutex/include/sound/soundfont.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/soundfont.h	2005-03-02 12:09:01.000000000 +0000
+++ linux-2.6.15-rc5-mutex/include/sound/soundfont.h	2005-12-12 19:41:15.000000000 +0000
@@ -96,7 +96,7 @@ typedef struct snd_sf_list {
 	int sample_locked;	/* locked time for sample */
 	snd_sf_callback_t callback;	/* callback functions */
 	int presets_locked;
-	struct semaphore presets_mutex;
+	struct mutex presets_mutex;
 	spinlock_t lock;
 	snd_util_memhdr_t *memhdr;
 } snd_sf_list_t;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/util_mem.h linux-2.6.15-rc5-mutex/include/sound/util_mem.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/util_mem.h	2004-06-18 13:42:21.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/util_mem.h	2005-12-12 19:38:48.000000000 +0000
@@ -44,7 +44,7 @@ struct snd_util_memhdr {
 	int nblocks;			/* # of allocated blocks */
 	snd_util_unit_t used;		/* used memory size */
 	int block_extra_size;		/* extra data size of chunk */
-	struct semaphore block_mutex;	/* lock */
+	struct mutex block_mutex;	/* lock */
 };
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/sound/vx_core.h linux-2.6.15-rc5-mutex/include/sound/vx_core.h
--- /warthog/kernels/linux-2.6.15-rc5/include/sound/vx_core.h	2005-08-30 13:56:38.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/sound/vx_core.h	2005-12-12 19:41:15.000000000 +0000
@@ -207,7 +207,7 @@ struct snd_vx_core {
 	int audio_monitor[4];			/* playback hw-monitor level */
 	unsigned char audio_monitor_active[4];	/* playback hw-monitor mute/unmute */
 
-	struct semaphore mixer_mutex;
+	struct mutex mixer_mutex;
 
 	const struct firmware *firmware[4]; /* loaded firmware data */
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/arm/aaci.h linux-2.6.15-rc5-mutex/sound/arm/aaci.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/arm/aaci.h	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/arm/aaci.h	2005-12-12 20:40:39.000000000 +0000
@@ -227,7 +227,7 @@ struct aaci {
 	unsigned int		fifosize;
 
 	/* AC'97 */
-	struct semaphore	ac97_sem;
+	struct mutex		ac97_sem;
 	ac97_bus_t		*ac97_bus;
 
 	u32			maincr;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/arm/pxa2xx-ac97.c linux-2.6.15-rc5-mutex/sound/arm/pxa2xx-ac97.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/arm/pxa2xx-ac97.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/arm/pxa2xx-ac97.c	2005-12-12 22:12:50.000000000 +0000
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
+#include <linux/semaphore.h>
 
 #include <sound/driver.h>
 #include <sound/core.h>
@@ -25,7 +26,6 @@
 #include <sound/initval.h>
 
 #include <asm/irq.h>
-#include <asm/semaphore.h>
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/audio.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/arm/sa11xx-uda1341.c linux-2.6.15-rc5-mutex/sound/arm/sa11xx-uda1341.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/arm/sa11xx-uda1341.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/arm/sa11xx-uda1341.c	2005-12-12 22:12:50.000000000 +0000
@@ -79,7 +79,7 @@
 #include <asm/dma.h>
 
 #ifdef CONFIG_H3600_HAL
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/arch/h3600_hal.h>
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/memalloc.c linux-2.6.15-rc5-mutex/sound/core/memalloc.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/memalloc.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/memalloc.c	2005-12-12 22:12:50.000000000 +0000
@@ -31,7 +31,7 @@
 #include <asm/uaccess.h>
 #include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <sound/memalloc.h>
 #ifdef CONFIG_SBUS
 #include <asm/sbus.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_clientmgr.h linux-2.6.15-rc5-mutex/sound/core/seq/seq_clientmgr.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_clientmgr.h	2005-03-02 12:09:12.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_clientmgr.h	2005-12-12 20:41:17.000000000 +0000
@@ -61,7 +61,7 @@ struct _snd_seq_client {
 	int num_ports;		/* number of ports */
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
-	struct semaphore ports_mutex;
+	struct mutex ports_mutex;
 	int convert32;		/* convert 32->64bit */
 
 	/* output pool */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_device.c linux-2.6.15-rc5-mutex/sound/core/seq/seq_device.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_device.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_device.c	2005-12-12 20:41:14.000000000 +0000
@@ -74,7 +74,7 @@ struct ops_list {
 	struct list_head dev_list;	/* list of devices */
 	int num_devices;	/* number of associated devices */
 	int num_init_devices;	/* number of initialized devices */
-	struct semaphore reg_mutex;
+	struct mutex reg_mutex;
 
 	struct list_head list;	/* next driver */
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_midi.c linux-2.6.15-rc5-mutex/sound/core/seq/seq_midi.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_midi.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_midi.c	2005-12-12 22:12:50.000000000 +0000
@@ -32,7 +32,7 @@ Possible options for midisynth module:
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/moduleparam.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <sound/core.h>
 #include <sound/rawmidi.h>
 #include <sound/seq_kernel.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_queue.h linux-2.6.15-rc5-mutex/sound/core/seq/seq_queue.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/seq/seq_queue.h	2005-08-30 13:56:45.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_queue.h	2005-12-12 20:41:11.000000000 +0000
@@ -54,7 +54,7 @@ struct _snd_seq_queue {
 	/* clients which uses this queue (bitmap) */
 	DECLARE_BITMAP(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
 	unsigned int clients;	/* users of this queue */
-	struct semaphore timer_mutex;
+	struct mutex timer_mutex;
 
 	snd_use_lock_t use_lock;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/core/timer.c linux-2.6.15-rc5-mutex/sound/core/timer.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/core/timer.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/timer.c	2005-12-12 20:41:08.000000000 +0000
@@ -70,7 +70,7 @@ typedef struct {
 	struct timespec tstamp;		/* trigger tstamp */
 	wait_queue_head_t qchange_sleep;
 	struct fasync_struct *fasync;
-	struct semaphore tread_sem;
+	struct mutex tread_sem;
 } snd_timer_user_t;
 
 /* list of timers */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/drivers/opl4/opl4_local.h linux-2.6.15-rc5-mutex/sound/drivers/opl4/opl4_local.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/drivers/opl4/opl4_local.h	2004-10-19 10:42:23.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/drivers/opl4/opl4_local.h	2005-12-12 20:45:26.000000000 +0000
@@ -182,7 +182,7 @@ struct opl4 {
 	snd_info_entry_t *proc_entry;
 	int memory_access;
 #endif
-	struct semaphore access_mutex;
+	struct mutex access_mutex;
 
 #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
 	int used;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/ac97_codec.c linux-2.6.15-rc5-mutex/sound/oss/ac97_codec.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/ac97_codec.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/ac97_codec.c	2005-12-12 22:12:50.000000000 +0000
@@ -54,8 +54,8 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/ac97_codec.h>
+#include <linux/semaphore.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 
 #define CODEC_ID_BUFSZ 14
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/aci.c linux-2.6.15-rc5-mutex/sound/oss/aci.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/aci.c	2005-03-02 12:09:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/aci.c	2005-12-12 22:12:50.000000000 +0000
@@ -56,7 +56,7 @@
 #include <linux/module.h> 
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "sound_config.h"
@@ -79,7 +79,7 @@ static int aci_micpreamp=3; /* microphon
 			 * checked with ACI versions prior to 0xb0	*/
 
 static int mixer_device;
-static struct semaphore aci_sem;
+static struct mutex aci_sem;
 
 #ifdef MODULE
 static int reset;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/ad1889.h linux-2.6.15-rc5-mutex/sound/oss/ad1889.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/ad1889.h	2005-01-04 11:14:02.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/ad1889.h	2005-12-12 20:41:45.000000000 +0000
@@ -100,7 +100,7 @@ typedef struct ad1889_state {
 		unsigned int subdivision;
 	} dmabuf;
 
-	struct semaphore sem;
+	struct mutex sem;
 } ad1889_state_t;
 
 typedef struct ad1889_dev {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/ali5455.c linux-2.6.15-rc5-mutex/sound/oss/ali5455.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/ali5455.c	2005-06-22 13:52:38.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/ali5455.c	2005-12-12 20:43:28.000000000 +0000
@@ -234,7 +234,7 @@ struct ali_state {
 	struct ali_card *card;	/* Card info */
 
 	/* single open lock mechanism, only used for recording */
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	wait_queue_head_t open_wait;
 
 	/* file mode */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/au1000.c linux-2.6.15-rc5-mutex/sound/oss/au1000.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/au1000.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/au1000.c	2005-12-12 20:43:55.000000000 +0000
@@ -120,8 +120,8 @@ struct au1000_state {
 	int             no_vra;	// do not use VRA
 
 	spinlock_t      lock;
-	struct semaphore open_sem;
-	struct semaphore sem;
+	struct mutex open_sem;
+	struct mutex sem;
 	mode_t          open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/au1550_ac97.c linux-2.6.15-rc5-mutex/sound/oss/au1550_ac97.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/au1550_ac97.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/au1550_ac97.c	2005-12-12 20:43:16.000000000 +0000
@@ -90,8 +90,8 @@ static struct au1550_state {
 	int             no_vra;		/* do not use VRA */
 
 	spinlock_t      lock;
-	struct semaphore open_sem;
-	struct semaphore sem;
+	struct mutex open_sem;
+	struct mutex sem;
 	mode_t          open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/btaudio.c linux-2.6.15-rc5-mutex/sound/oss/btaudio.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/btaudio.c	2005-06-22 13:52:38.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/btaudio.c	2005-12-12 20:41:39.000000000 +0000
@@ -108,7 +108,7 @@ struct btaudio {
 
 	/* locking */
 	int            users;
-	struct semaphore lock;
+	struct mutex   lock;
 
 	/* risc instructions */
 	unsigned int   risc_size;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/cmpci.c linux-2.6.15-rc5-mutex/sound/oss/cmpci.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/cmpci.c	2005-08-30 13:56:46.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/cmpci.c	2005-12-12 20:44:06.000000000 +0000
@@ -392,7 +392,7 @@ struct cm_state {
 	unsigned char fmt, enable;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/cs4281/cs4281m.c linux-2.6.15-rc5-mutex/sound/oss/cs4281/cs4281m.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/cs4281/cs4281m.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/cs4281/cs4281m.c	2005-12-12 20:41:30.000000000 +0000
@@ -245,9 +245,9 @@ struct cs4281_state {
 	void *tmpbuff;		// tmp buffer for sample conversions
 	unsigned ena;
 	spinlock_t lock;
-	struct semaphore open_sem;
-	struct semaphore open_sem_adc;
-	struct semaphore open_sem_dac;
+	struct mutex open_sem;
+	struct mutex open_sem_adc;
+	struct mutex open_sem_dac;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 	wait_queue_head_t open_wait_adc;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/cs46xx.c linux-2.6.15-rc5-mutex/sound/oss/cs46xx.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/cs46xx.c	2005-08-30 13:56:46.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/cs46xx.c	2005-12-12 20:43:37.000000000 +0000
@@ -238,7 +238,7 @@ struct cs_state {
 	struct cs_card *card;	/* Card info */
 
 	/* single open lock mechanism, only used for recording */
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	wait_queue_head_t open_wait;
 
 	/* file mode */
@@ -297,7 +297,7 @@ struct cs_state {
 		unsigned subdivision;
 	} dmabuf;
 	/* Guard against mmap/write/read races */
-	struct semaphore sem;
+	struct mutex sem;
 };
 
 struct cs_card {
@@ -375,7 +375,7 @@ struct cs_card {
 		unsigned char ibuf[CS_MIDIINBUF];
 		unsigned char obuf[CS_MIDIOUTBUF];
 		mode_t open_mode;
-		struct semaphore open_sem;
+		struct mutex open_sem;
 	} midi;
 	struct cs46xx_pm pm;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/dmasound/dmasound_awacs.c linux-2.6.15-rc5-mutex/sound/oss/dmasound/dmasound_awacs.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/dmasound/dmasound_awacs.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/dmasound/dmasound_awacs.c	2005-12-12 22:12:50.000000000 +0000
@@ -80,7 +80,7 @@
 #include <linux/kmod.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #ifdef CONFIG_ADB_CUDA
 #include <linux/cuda.h>
 #endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/emu10k1/hwaccess.h linux-2.6.15-rc5-mutex/sound/oss/emu10k1/hwaccess.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/emu10k1/hwaccess.h	2005-03-02 12:09:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/emu10k1/hwaccess.h	2005-12-12 20:43:59.000000000 +0000
@@ -181,7 +181,7 @@ struct emu10k1_card 
 	struct emu10k1_mpuout	*mpuout;
 	struct emu10k1_mpuin	*mpuin;
 
-	struct semaphore	open_sem;
+	struct mutex		open_sem;
 	mode_t			open_mode;
 	wait_queue_head_t	open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/es1370.c linux-2.6.15-rc5-mutex/sound/oss/es1370.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/es1370.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/es1370.c	2005-12-12 20:43:50.000000000 +0000
@@ -346,7 +346,7 @@ struct es1370_state {
 	unsigned sctrl;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
@@ -393,7 +393,7 @@ struct es1370_state {
 	struct gameport *gameport;
 #endif
 
-	struct semaphore sem;
+	struct mutex sem;
 };
 
 /* --------------------------------------------------------------------- */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/es1371.c linux-2.6.15-rc5-mutex/sound/oss/es1371.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/es1371.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/es1371.c	2005-12-12 20:44:25.000000000 +0000
@@ -419,7 +419,7 @@ struct es1371_state {
 	unsigned dac1rate, dac2rate, adcrate;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
@@ -462,7 +462,7 @@ struct es1371_state {
 	struct gameport *gameport;
 #endif
 
-	struct semaphore sem;
+	struct mutex sem;
 };
 
 /* --------------------------------------------------------------------- */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/esssolo1.c linux-2.6.15-rc5-mutex/sound/oss/esssolo1.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/esssolo1.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/esssolo1.c	2005-12-12 20:41:23.000000000 +0000
@@ -191,7 +191,7 @@ struct solo1_state {
 	unsigned ena;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/forte.c linux-2.6.15-rc5-mutex/sound/oss/forte.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/forte.c	2005-03-02 12:09:13.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/forte.c	2005-12-12 20:43:40.000000000 +0000
@@ -185,7 +185,7 @@ struct forte_chip {
 	unsigned long		iobase;
 	int			irq;
 
-	struct semaphore	open_sem; 	/* Device access */
+	struct mutex		open_sem; 	/* Device access */
 	spinlock_t		lock;		/* State */
 
 	spinlock_t		ac97_lock;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/hal2.c linux-2.6.15-rc5-mutex/sound/oss/hal2.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/hal2.c	2004-09-16 12:06:29.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/hal2.c	2005-12-12 20:43:45.000000000 +0000
@@ -92,7 +92,7 @@ struct hal2_codec {
 
 	wait_queue_head_t dma_wait;
 	spinlock_t lock;
-	struct semaphore sem;
+	struct mutex sem;
 
 	int usecount;			/* recording and playback are
 					 * independent */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/i810_audio.c linux-2.6.15-rc5-mutex/sound/oss/i810_audio.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/i810_audio.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/i810_audio.c	2005-12-12 20:41:42.000000000 +0000
@@ -330,7 +330,7 @@ struct i810_state {
 	struct i810_card *card;	/* Card info */
 
 	/* single open lock mechanism, only used for recording */
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	wait_queue_head_t open_wait;
 
 	/* file mode */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/ite8172.c linux-2.6.15-rc5-mutex/sound/oss/ite8172.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/ite8172.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/ite8172.c	2005-12-12 20:43:43.000000000 +0000
@@ -304,7 +304,7 @@ struct it8172_state {
 	unsigned dacrate, adcrate;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/maestro3.c linux-2.6.15-rc5-mutex/sound/oss/maestro3.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/maestro3.c	2005-06-22 13:52:39.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/maestro3.c	2005-12-12 20:44:31.000000000 +0000
@@ -205,7 +205,7 @@ struct m3_state {
 		when irqhandler uses s->lock
 		and m3_assp_read uses card->lock ?
 		*/
-    struct semaphore open_sem;
+    struct mutex open_sem;
     wait_queue_head_t open_wait;
     mode_t open_mode;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/maestro.c linux-2.6.15-rc5-mutex/sound/oss/maestro.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/maestro.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/maestro.c	2005-12-12 20:43:09.000000000 +0000
@@ -401,7 +401,7 @@ struct ess_state {
 	/* this locks around the oss state in the driver */
 	spinlock_t lock;
 	/* only let 1 be opening at a time */
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	wait_queue_head_t open_wait;
 	mode_t open_mode;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/nec_vrc5477.c linux-2.6.15-rc5-mutex/sound/oss/nec_vrc5477.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/nec_vrc5477.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/nec_vrc5477.c	2005-12-12 20:44:11.000000000 +0000
@@ -198,7 +198,7 @@ struct vrc5477_ac97_state {
 	unsigned short extended_status;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/rme96xx.c linux-2.6.15-rc5-mutex/sound/oss/rme96xx.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/rme96xx.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/rme96xx.c	2005-12-12 20:43:12.000000000 +0000
@@ -326,7 +326,7 @@ typedef struct _rme96xx_info {
 
 		/* waiting and locking */
 		wait_queue_head_t wait;
-		struct semaphore  open_sem;
+		struct mutex  open_sem;
 		wait_queue_head_t open_wait;
 
 	} dma[RME96xx_MAX_DEVS]; 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/sonicvibes.c linux-2.6.15-rc5-mutex/sound/oss/sonicvibes.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/sonicvibes.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/sonicvibes.c	2005-12-12 20:41:34.000000000 +0000
@@ -328,7 +328,7 @@ struct sv_state {
 	unsigned char fmt, enable;
 
 	spinlock_t lock;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/swarm_cs4297a.c linux-2.6.15-rc5-mutex/sound/oss/swarm_cs4297a.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/swarm_cs4297a.c	2005-03-02 12:09:15.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/swarm_cs4297a.c	2005-12-12 20:43:25.000000000 +0000
@@ -291,9 +291,9 @@ struct cs4297a_state {
 	unsigned conversion:1;	// conversion from 16 to 8 bit in progress
 	unsigned ena;
 	spinlock_t lock;
-	struct semaphore open_sem;
-	struct semaphore open_sem_adc;
-	struct semaphore open_sem_dac;
+	struct mutex open_sem;
+	struct mutex open_sem_adc;
+	struct mutex open_sem_dac;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 	wait_queue_head_t open_wait_adc;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/trident.c linux-2.6.15-rc5-mutex/sound/oss/trident.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/trident.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/trident.c	2005-12-12 20:44:04.000000000 +0000
@@ -351,7 +351,7 @@ struct trident_state {
 	unsigned chans_num;
 	unsigned long fmt_flag;
 	/* Guard against mmap/write/read races */
-	struct semaphore sem;
+	struct mutex sem;
 
 };
 
@@ -404,7 +404,7 @@ struct trident_card {
 	struct trident_card *next;
 
 	/* single open lock mechanism, only used for recording */
-	struct semaphore open_sem;
+	struct mutex open_sem;
 
 	/* The trident has a certain amount of cross channel interaction
 	   so we use a single per card lock */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/via82cxxx_audio.c linux-2.6.15-rc5-mutex/sound/oss/via82cxxx_audio.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/via82cxxx_audio.c	2005-08-30 13:56:47.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/oss/via82cxxx_audio.c	2005-12-12 22:12:50.000000000 +0000
@@ -36,9 +36,9 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/semaphore.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include "sound_config.h"
 #include "dev_table.h"
 #include "mpu401.h"
@@ -311,8 +311,8 @@ struct via_info {
 	
 	int mixer_vol;		/* 8233/35 volume  - not yet implemented */
 
-	struct semaphore syscall_sem;
-	struct semaphore open_sem;
+	struct mutex syscall_sem;
+	struct mutex open_sem;
 
 	/* The 8233/8235 have 4 DX audio channels, two record and
 	   one six channel out. We bind ch_in to DX 1, ch_out to multichannel
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/vwsnd.c linux-2.6.15-rc5-mutex/sound/oss/vwsnd.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/vwsnd.c	2005-03-02 12:09:15.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/vwsnd.c	2005-12-12 22:12:50.000000000 +0000
@@ -148,7 +148,7 @@
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
 #include <linux/interrupt.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/mach-visws/cobalt.h>
 
 #include "sound_config.h"
@@ -1507,9 +1507,9 @@ typedef struct vwsnd_dev {
 	int		audio_minor;	/* minor number of audio device */
 	int		mixer_minor;	/* minor number of mixer device */
 
-	struct semaphore open_sema;
-	struct semaphore io_sema;
-	struct semaphore mix_sema;
+	struct mutex open_sema;
+	struct mutex io_sema;
+	struct mutex mix_sema;
 	mode_t		open_mode;
 	wait_queue_head_t open_wait;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/oss/ymfpci.h linux-2.6.15-rc5-mutex/sound/oss/ymfpci.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/oss/ymfpci.h	2005-01-04 11:14:03.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/ymfpci.h	2005-12-12 20:44:28.000000000 +0000
@@ -279,7 +279,7 @@ struct ymf_unit {
 
 	/* soundcore stuff */
 	int dev_audio;
-	struct semaphore open_sem;
+	struct mutex open_sem;
 
 	struct list_head ymf_devs;
 	struct list_head states;	/* List of states for this unit */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/atiixp.c linux-2.6.15-rc5-mutex/sound/pci/atiixp.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/atiixp.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/atiixp.c	2005-12-12 20:45:15.000000000 +0000
@@ -280,7 +280,7 @@ struct snd_atiixp {
 	unsigned int codec_not_ready_bits;	/* for codec detection */
 
 	int spdif_over_aclink;		/* passed from the module option */
-	struct semaphore open_mutex;	/* playback open mutex */
+	struct mutex open_mutex;	/* playback open mutex */
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/atiixp_modem.c linux-2.6.15-rc5-mutex/sound/pci/atiixp_modem.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/atiixp_modem.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/atiixp_modem.c	2005-12-12 20:45:13.000000000 +0000
@@ -258,7 +258,7 @@ struct snd_atiixp {
 	unsigned int codec_not_ready_bits;	/* for codec detection */
 
 	int spdif_over_aclink;		/* passed from the module option */
-	struct semaphore open_mutex;	/* playback open mutex */
+	struct mutex open_mutex;	/* playback open mutex */
 };
 
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/cmipci.c linux-2.6.15-rc5-mutex/sound/pci/cmipci.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/cmipci.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/cmipci.c	2005-12-12 20:45:08.000000000 +0000
@@ -440,7 +440,7 @@ struct snd_stru_cmipci {
 	snd_pcm_hardware_t *hw_info[3]; /* for playbacks */
 
 	int opened[2];	/* open mode */
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 
 	unsigned int mixer_insensitive: 1;
 	snd_kcontrol_t *mixer_res_ctl[CM_SAVED_MIXERS];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/ens1370.c linux-2.6.15-rc5-mutex/sound/pci/ens1370.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/ens1370.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/ens1370.c	2005-12-12 20:44:36.000000000 +0000
@@ -364,7 +364,7 @@ typedef struct _snd_ensoniq ensoniq_t;
 
 struct _snd_ensoniq {
 	spinlock_t reg_lock;
-	struct semaphore src_mutex;
+	struct mutex src_mutex;
 
 	int irq;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/es1968.c linux-2.6.15-rc5-mutex/sound/pci/es1968.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/es1968.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/es1968.c	2005-12-12 20:45:10.000000000 +0000
@@ -573,7 +573,7 @@ struct snd_es1968 {
 	u16 maestro_map[32];
 	int bobclient;		/* active timer instancs */
 	int bob_freq;		/* timer frequency */
-	struct semaphore memory_mutex;	/* memory lock */
+	struct mutex memory_mutex;	/* memory lock */
 
 	/* APU states */
 	unsigned char apu[NR_APUS];
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/hda_codec.h linux-2.6.15-rc5-mutex/sound/pci/hda/hda_codec.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/hda_codec.h	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/hda/hda_codec.h	2005-12-12 21:45:18.000000000 +0000
@@ -432,7 +432,7 @@ struct hda_bus {
 	struct list_head codec_list;
 	struct hda_codec *caddr_tbl[HDA_MAX_CODEC_ADDRESS + 1]; /* caddr -> codec */
 
-	struct semaphore cmd_mutex;
+	struct mutex cmd_mutex;
 
 	/* unsolicited event queue */
 	struct hda_bus_unsolicited *unsol;
@@ -547,7 +547,7 @@ struct hda_codec {
 	int num_amp_entries;
 	struct hda_amp_info amp_info[128]; /* big enough? */
 
-	struct semaphore spdif_mutex;
+	struct mutex spdif_mutex;
 	unsigned int spdif_status;	/* IEC958 status bits */
 	unsigned short spdif_ctls;	/* SPDIF control bits */
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/hda_intel.c linux-2.6.15-rc5-mutex/sound/pci/hda/hda_intel.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/hda_intel.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/hda/hda_intel.c	2005-12-12 21:45:18.000000000 +0000
@@ -298,7 +298,7 @@ struct snd_azx {
 
 	/* locks */
 	spinlock_t reg_lock;
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 
 	/* streams (x num_streams) */
 	azx_dev_t *azx_dev;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/patch_analog.c linux-2.6.15-rc5-mutex/sound/pci/hda/patch_analog.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/hda/patch_analog.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/hda/patch_analog.c	2005-12-12 21:45:18.000000000 +0000
@@ -58,7 +58,7 @@ struct ad198x_spec {
 	/* PCM information */
 	struct hda_pcm pcm_rec[2];	/* used in alc_build_pcms() */
 
-	struct semaphore amp_mutex;	/* PCM volume/mute control mutex */
+	struct mutex amp_mutex;	/* PCM volume/mute control mutex */
 	unsigned int spdif_route;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/ice1712/ice1712.h linux-2.6.15-rc5-mutex/sound/pci/ice1712/ice1712.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/ice1712/ice1712.h	2005-08-30 13:56:48.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/pci/ice1712/ice1712.h	2005-12-12 20:45:01.000000000 +0000
@@ -334,7 +334,7 @@ struct _snd_ice1712 {
 	unsigned int num_total_adcs;	/* total ADCs */
 	unsigned int cur_rate;		/* current rate */
 
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 	snd_pcm_substream_t *pcm_reserved[4];
 	snd_pcm_hw_constraint_list_t *hw_rates; /* card-specific rate constraints */
 
@@ -342,7 +342,7 @@ struct _snd_ice1712 {
 	akm4xxx_t *akm;
 	struct snd_ice1712_spdif spdif;
 
-	struct semaphore i2c_mutex;	/* I2C mutex for ICE1724 registers */
+	struct mutex i2c_mutex;	/* I2C mutex for ICE1724 registers */
 	snd_i2c_bus_t *i2c;		/* I2C bus */
 	snd_i2c_device_t *cs8427;	/* CS8427 I2C device */
 	unsigned int cs8427_timeout;	/* CS8427 reset timeout in HZ/100 */
@@ -360,7 +360,7 @@ struct _snd_ice1712 {
 		void (*set_pro_rate)(ice1712_t *ice, unsigned int rate);
 		void (*i2s_mclk_changed)(ice1712_t *ice);
 	} gpio;
-	struct semaphore gpio_mutex;
+	struct mutex gpio_mutex;
 
 	/* other board-specific data */
 	union {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/korg1212/korg1212.c linux-2.6.15-rc5-mutex/sound/pci/korg1212/korg1212.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/korg1212/korg1212.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/korg1212/korg1212.c	2005-12-12 20:44:34.000000000 +0000
@@ -324,7 +324,7 @@ struct _snd_korg1212 {
         int irq;
 
         spinlock_t    lock;
-	struct semaphore open_mutex;
+	struct mutex open_mutex;
 
 	struct timer_list timer;	/* timer callback for checking ack of stop request */
 	int stop_pending_cnt;		/* counter for stop pending check */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/mixart/mixart.h linux-2.6.15-rc5-mutex/sound/pci/mixart/mixart.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/mixart/mixart.h	2005-06-22 13:52:39.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/pci/mixart/mixart.h	2005-12-12 20:45:19.000000000 +0000
@@ -107,9 +107,9 @@ struct snd_mixart_mgr {
 
 	spinlock_t lock;              /* interrupt spinlock */
 	spinlock_t msg_lock;          /* mailbox spinlock */
-	struct semaphore msg_mutex;   /* mutex for blocking_requests */
+	struct mutex msg_mutex;   /* mutex for blocking_requests */
 
-	struct semaphore setup_mutex; /* mutex used in hw_params, open and close */
+	struct mutex setup_mutex; /* mutex used in hw_params, open and close */
 
 	/* hardware interface */
 	unsigned int dsp_loaded;      /* bit flags of loaded dsp indices */
@@ -122,7 +122,7 @@ struct snd_mixart_mgr {
 	int sample_rate;
 	int ref_count_rate;
 
-	struct semaphore mixer_mutex; /* mutex for mixer */
+	struct mutex mixer_mutex; /* mutex for mixer */
 
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/pci/nm256/nm256.c linux-2.6.15-rc5-mutex/sound/pci/nm256/nm256.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/pci/nm256/nm256.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/pci/nm256/nm256.c	2005-12-12 20:45:23.000000000 +0000
@@ -242,7 +242,7 @@ struct snd_nm256 {
 	int irq_acks;
 	irqreturn_t (*interrupt)(int, void *, struct pt_regs *);
 	int badintrcount;		/* counter to check bogus interrupts */
-	struct semaphore irq_mutex;
+	struct mutex irq_mutex;
 
 	nm256_stream_t streams[2];
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/sparc/cs4231.c linux-2.6.15-rc5-mutex/sound/sparc/cs4231.c
--- /warthog/kernels/linux-2.6.15-rc5/sound/sparc/cs4231.c	2005-12-08 16:23:59.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/sparc/cs4231.c	2005-12-12 20:40:31.000000000 +0000
@@ -116,8 +116,8 @@ struct snd_cs4231 {
 	unsigned char		image[32];	/* registers image */
 	int			mce_bit;
 	int			calibrate_mute;
-	struct semaphore	mce_mutex;
-	struct semaphore	open_mutex;
+	struct mutex		mce_mutex;
+	struct mutex		open_mutex;
 
 	union {
 #ifdef SBUS_SUPPORT
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/sound/usb/usx2y/usbusx2y.h linux-2.6.15-rc5-mutex/sound/usb/usx2y/usbusx2y.h
--- /warthog/kernels/linux-2.6.15-rc5/sound/usb/usx2y/usbusx2y.h	2005-03-02 12:09:17.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/usb/usx2y/usbusx2y.h	2005-12-12 20:40:25.000000000 +0000
@@ -35,7 +35,7 @@ typedef struct {
 	unsigned int		rate,
 				format;
 	int			chip_status;
-	struct semaphore	prepare_mutex;
+	struct mutex		prepare_mutex;
 	us428ctls_sharedmem_t	*us428ctls_sharedmem;
 	int			wait_iso_frame;
 	wait_queue_head_t	us428ctls_wait_queue_head;
