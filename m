Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVBUMIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVBUMIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVBUMIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:08:51 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:37012 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261957AbVBUMI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:08:26 -0500
Date: Mon, 21 Feb 2005 13:08:23 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] Fix a few sparse warnings
Message-ID: <20050221120823.GA21912@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up the following files wrt to bitfield signedness:

arch/i386/kernel/apm.c
drivers/crypto/padlock.h
drivers/isdn/hisax/isdnhdlc.h
drivers/isdn/hisax/st5481_hdlc.h
drivers/media/dvb/dvb-core/dvb_ca_en50221.c
drivers/media/dvb/frontends/l64781.c
drivers/media/video/msp3400.c
drivers/media/video/videocodec.h
drivers/media/video/cx88/cx88.h
include/linux/ac97_codec.h
include/linux/ide.h
include/linux/mtd/flashchip.h
include/sound/emu10k1.h
include/sound/gus.h
include/sound/mixer_oss.h
include/sound/seq_virmidi.h
include/sound/trident.h
include/sound/ymfpci.h
sound/oss/via82cxxx_audio.c
sound/pci/cmipci.c
sound/pci/intel8x0m.c
sound/pci/maestro3.c
sound/pci/ali5451/ali5451.c
sound/pci/ice1712/ice1712.h

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

--


===== arch/i386/kernel/apm.c 1.72 vs edited =====
--- 1.72/arch/i386/kernel/apm.c	2005-01-21 06:02:11 +01:00
+++ edited/arch/i386/kernel/apm.c	2005-02-21 10:36:59 +01:00
@@ -346,10 +346,10 @@
 struct apm_user {
 	int		magic;
 	struct apm_user *	next;
-	int		suser: 1;
-	int		writer: 1;
-	int		reader: 1;
-	int		suspend_wait: 1;
+	unsigned int	suser: 1;
+	unsigned int	writer: 1;
+	unsigned int	reader: 1;
+	unsigned int	suspend_wait: 1;
 	int		suspend_result;
 	int		suspends_pending;
 	int		standbys_pending;
===== drivers/crypto/padlock.h 1.1 vs edited =====
--- 1.1/drivers/crypto/padlock.h	2004-12-01 07:00:15 +01:00
+++ edited/drivers/crypto/padlock.h	2005-02-21 10:43:21 +01:00
@@ -19,9 +19,9 @@
 	struct {
 		int rounds:4;
 		int algo:3;
-		int keygen:1;
-		int interm:1;
-		int encdec:1;
+		unsigned int keygen:1;
+		unsigned int interm:1;
+		unsigned int encdec:1;
 		int ksize:2;
 	} b;
 };
===== drivers/isdn/hisax/isdnhdlc.h 1.1 vs edited =====
--- 1.1/drivers/isdn/hisax/isdnhdlc.h	2004-02-19 05:44:27 +01:00
+++ edited/drivers/isdn/hisax/isdnhdlc.h	2005-02-21 10:40:24 +01:00
@@ -41,10 +41,10 @@
 	unsigned char shift_reg;
 	unsigned char ffvalue;
 
-	int data_received:1; 	// set if transferring data
-	int dchannel:1; 	// set if D channel (send idle instead of flags)
-	int do_adapt56:1; 	// set if 56K adaptation
-        int do_closing:1; 	// set if in closing phase (need to send CRC + flag
+	unsigned int data_received:1; 	// set if transferring data
+	unsigned int dchannel:1; 	// set if D channel (send idle instead of flags)
+	unsigned int do_adapt56:1; 	// set if 56K adaptation
+	unsigned int do_closing:1; 	// set if in closing phase (need to send CRC + flag
 };
 
 
===== drivers/isdn/hisax/st5481_hdlc.h 1.1 vs edited =====
--- 1.1/drivers/isdn/hisax/st5481_hdlc.h	2002-02-05 21:17:18 +01:00
+++ edited/drivers/isdn/hisax/st5481_hdlc.h	2005-02-21 10:41:58 +01:00
@@ -21,10 +21,10 @@
 	int state;
 	int dstpos;
 
-	int data_received:1; // set if transferring data
-	int dchannel:1; // set if D channel (send idle instead of flags)
-	int do_adapt56:1; // set if 56K adaptation
-        int do_closing:1; // set if in closing phase (need to send CRC + flag
+	unsigned int data_received:1; // set if transferring data
+	unsigned int dchannel:1; // set if D channel (send idle instead of flags)
+	unsigned int do_adapt56:1; // set if 56K adaptation
+	unsigned int do_closing:1; // set if in closing phase (need to send CRC + flag
 
 	unsigned short crc;
 
===== drivers/media/dvb/dvb-core/dvb_ca_en50221.c 1.9 vs edited =====
--- 1.9/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-12-07 15:25:34 +01:00
+++ edited/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-02-21 10:45:59 +01:00
@@ -148,13 +148,13 @@
         wait_queue_head_t thread_queue;
 
         /* Flag indicating when thread should exit */
-        int exit:1;
+        unsigned int exit:1;
 
         /* Flag indicating if the CA device is open */
-        int open:1;
+        unsigned int open:1;
 
         /* Flag indicating the thread should wake up now */
-        int wakeup:1;
+        unsigned int wakeup:1;
 
         /* Delay the main thread should use */
         unsigned long delay;
===== drivers/media/dvb/frontends/l64781.c 1.1 vs edited =====
--- 1.1/drivers/media/dvb/frontends/l64781.c	2004-12-08 01:20:26 +01:00
+++ edited/drivers/media/dvb/frontends/l64781.c	2005-02-21 10:47:20 +01:00
@@ -42,7 +42,7 @@
 	struct dvb_frontend frontend;
 
 	/* private demodulator data */
-   	int first:1;
+	unsigned int first:1;
 };
 
 #define dprintk(args...) \
===== drivers/media/video/msp3400.c 1.34 vs edited =====
--- 1.34/drivers/media/video/msp3400.c	2005-01-25 22:50:27 +01:00
+++ edited/drivers/media/video/msp3400.c	2005-02-21 10:50:03 +01:00
@@ -97,8 +97,8 @@
 	/* thread */
 	struct task_struct   *kthread;
 	wait_queue_head_t    wq;
-	int                  restart:1;
-	int                  watch_stereo:1;
+	unsigned int         restart:1;
+	unsigned int         watch_stereo:1;
 };
 
 #define HAVE_NICAM(msp)   (((msp->rev2>>8) & 0xff) != 00)
===== drivers/media/video/videocodec.h 1.3 vs edited =====
--- 1.3/drivers/media/video/videocodec.h	2005-01-05 03:48:33 +01:00
+++ edited/drivers/media/video/videocodec.h	2005-02-21 10:51:00 +01:00
@@ -222,14 +222,14 @@
 /* ========================= */
 
 struct vfe_polarity {
-	int vsync_pol:1;
-	int hsync_pol:1;
-	int field_pol:1;
-	int blank_pol:1;
-	int subimg_pol:1;
-	int poe_pol:1;
-	int pvalid_pol:1;
-	int vclk_pol:1;
+	unsigned int vsync_pol:1;
+	unsigned int hsync_pol:1;
+	unsigned int field_pol:1;
+	unsigned int blank_pol:1;
+	unsigned int subimg_pol:1;
+	unsigned int poe_pol:1;
+	unsigned int pvalid_pol:1;
+	unsigned int vclk_pol:1;
 };
 
 struct vfe_settings {
===== drivers/media/video/cx88/cx88.h 1.7 vs edited =====
--- 1.7/drivers/media/video/cx88/cx88.h	2004-11-19 14:52:58 +01:00
+++ edited/drivers/media/video/cx88/cx88.h	2005-02-21 10:49:00 +01:00
@@ -182,8 +182,8 @@
 	int                     tda9887_conf;
 	struct cx88_input       input[8];
 	struct cx88_input       radio;
-	int                     blackbird:1;
-	int                     dvb:1;
+	unsigned int            blackbird:1;
+	unsigned int            dvb:1;
 };
 
 struct cx88_subid {
===== include/linux/ac97_codec.h 1.10 vs edited =====
--- 1.10/include/linux/ac97_codec.h	2005-01-31 07:33:41 +01:00
+++ edited/include/linux/ac97_codec.h	2005-02-21 11:30:56 +01:00
@@ -259,7 +259,7 @@
 	int type;
 	u32 model;
 
-	int modem:1;
+	unsigned int modem:1;
 
 	struct ac97_ops *codec_ops;
 
===== include/linux/ide.h 1.176 vs edited =====
--- 1.176/include/linux/ide.h	2005-02-05 02:40:02 +01:00
+++ edited/include/linux/ide.h	2005-02-21 11:32:00 +01:00
@@ -934,9 +934,9 @@
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
-	int sleeping	: 1;
+	unsigned int sleeping	: 1;
 		/* BOOL: polling active & poll_timeout field valid */
-	int polling	: 1;
+	unsigned int polling	: 1;
 		/* current drive */
 	ide_drive_t *drive;
 		/* ptr to current hwif in linked-list */
===== include/linux/mtd/flashchip.h 1.5 vs edited =====
--- 1.5/include/linux/mtd/flashchip.h	2004-11-16 19:57:52 +01:00
+++ edited/include/linux/mtd/flashchip.h	2005-02-21 11:32:44 +01:00
@@ -62,8 +62,8 @@
 	flstate_t state;
 	flstate_t oldstate;
 
-	int write_suspended:1;
-	int erase_suspended:1;
+	unsigned int write_suspended:1;
+	unsigned int erase_suspended:1;
 	unsigned long in_progress_block_addr;
 
 	spinlock_t *mutex;
===== include/sound/emu10k1.h 1.41 vs edited =====
--- 1.41/include/sound/emu10k1.h	2004-11-22 11:42:01 +01:00
+++ edited/include/sound/emu10k1.h	2005-02-21 11:36:32 +01:00
@@ -790,10 +790,10 @@
 struct _snd_emu10k1_voice {
 	emu10k1_t *emu;
 	int number;
-	int use: 1,
-	    pcm: 1,
-	    synth: 1,
-	    midi: 1;
+	unsigned int use: 1,
+	             pcm: 1,
+	             synth: 1,
+	             midi: 1;
 	void (*interrupt)(emu10k1_t *emu, emu10k1_voice_t *pvoice);
 
 	emu10k1_pcm_t *epcm;
@@ -938,11 +938,11 @@
 	int irq;
 
 	unsigned long port;			/* I/O port number */
-	int APS: 1,				/* APS flag */
-	    no_ac97: 1,				/* no AC'97 */
-	    tos_link: 1,			/* tos link detected */
-	    rear_ac97: 1,			/* rear channels are on AC'97 */
-	    spk71:1;				/* 7.1 configuration (Audigy 2 ZS) */
+	unsigned int APS: 1,			/* APS flag */
+	             no_ac97: 1,		/* no AC'97 */
+	             tos_link: 1,		/* tos link detected */
+	             rear_ac97: 1,		/* rear channels are on AC'97 */
+	             spk71:1;			/* 7.1 configuration (Audigy 2 ZS) */
 	unsigned int audigy;			/* is Audigy? */
 	unsigned int revision;			/* chip revision */
 	unsigned int serial;			/* serial number */
===== include/sound/gus.h 1.6 vs edited =====
--- 1.6/include/sound/gus.h	2004-11-25 08:17:52 +01:00
+++ edited/include/sound/gus.h	2005-02-21 11:38:11 +01:00
@@ -230,7 +230,7 @@
 	int mode;		/* operation mode */
 	int client;		/* sequencer client number */
 	int port;		/* sequencer port number */
-	int midi_has_voices: 1;
+	unsigned int midi_has_voices: 1;
 } snd_gus_port_t;
 
 typedef struct _snd_gus_voice snd_gus_voice_t;
@@ -264,10 +264,10 @@
 
 struct _snd_gus_voice {
 	int number;
-	int use: 1,
-	    pcm: 1,
-	    synth:1,
-	    midi: 1;
+	unsigned int use: 1,
+	             pcm: 1,
+	             synth:1,
+	             midi: 1;
 	unsigned int flags;
 	unsigned char client;
 	unsigned char port;
===== include/sound/mixer_oss.h 1.6 vs edited =====
--- 1.6/include/sound/mixer_oss.h	2003-02-08 21:10:44 +01:00
+++ edited/include/sound/mixer_oss.h	2005-02-21 11:39:08 +01:00
@@ -38,7 +38,7 @@
 
 struct _snd_oss_mixer_slot {
 	int number;
-	int stereo: 1;
+	unsigned int stereo: 1;
 	snd_mixer_oss_get_volume_t get_volume;
 	snd_mixer_oss_put_volume_t put_volume;
 	snd_mixer_oss_get_recsrc_t get_recsrc;
===== include/sound/seq_virmidi.h 1.2 vs edited =====
--- 1.2/include/sound/seq_virmidi.h	2002-09-29 22:20:47 +02:00
+++ edited/include/sound/seq_virmidi.h	2005-02-21 11:39:36 +01:00
@@ -38,7 +38,7 @@
 	int seq_mode;
 	int client;
 	int port;
-	int trigger: 1;
+	unsigned int trigger: 1;
 	snd_midi_event_t *parser;
 	snd_seq_event_t event;
 	snd_virmidi_dev_t *rdev;
===== include/sound/trident.h 1.16 vs edited =====
--- 1.16/include/sound/trident.h	2004-11-22 11:36:04 +01:00
+++ edited/include/sound/trident.h	2005-02-21 11:41:54 +01:00
@@ -290,7 +290,7 @@
 	int mode;		/* operation mode */
 	int client;		/* sequencer client number */
 	int port;		/* sequencer port number */
-	int midi_has_voices: 1;
+	unsigned int midi_has_voices: 1;
 } snd_trident_port_t;
 
 typedef struct snd_trident_memblk_arg {
@@ -308,10 +308,10 @@
 
 struct _snd_trident_voice {
 	unsigned int number;
-	int use: 1,
-	    pcm: 1,
-	    synth:1,
-	    midi: 1;
+	unsigned int use: 1,
+	             pcm: 1,
+	             synth:1,
+	             midi: 1;
 	unsigned int flags;
 	unsigned char client;
 	unsigned char port;
@@ -347,13 +347,13 @@
 	trident_t *trident;
 	snd_pcm_substream_t *substream;
 	snd_trident_voice_t *extra;	/* extra PCM voice (acts as interrupt generator) */
-	int running: 1,
-            capture: 1,
-            spdif: 1,
-            foldback: 1,
-            isync: 1,
-            isync2: 1,
-            isync3: 1;
+	unsigned int running: 1,
+		     capture: 1,
+		     spdif: 1,
+		     foldback: 1,
+		     isync: 1,
+		     isync2: 1,
+		     isync3: 1;
 	int foldback_chan;		/* foldback subdevice number */
 	unsigned int stimer;		/* global sample timer (to detect spurious interrupts) */
 	unsigned int spurious_threshold; /* spurious threshold */
===== include/sound/ymfpci.h 1.14 vs edited =====
--- 1.14/include/sound/ymfpci.h	2004-11-22 11:36:04 +01:00
+++ edited/include/sound/ymfpci.h	2005-02-21 11:44:22 +01:00
@@ -262,10 +262,10 @@
 struct _snd_ymfpci_voice {
 	ymfpci_t *chip;
 	int number;
-	int use: 1,
-	    pcm: 1,
-	    synth: 1,
-	    midi: 1;
+	unsigned int use: 1,
+	             pcm: 1,
+	             synth: 1,
+	             midi: 1;
 	snd_ymfpci_playback_bank_t *bank;
 	dma_addr_t bank_addr;
 	void (*interrupt)(ymfpci_t *chip, ymfpci_voice_t *voice);
@@ -288,9 +288,9 @@
 	snd_ymfpci_pcm_type_t type;
 	snd_pcm_substream_t *substream;
 	ymfpci_voice_t *voices[2];	/* playback only */
-	int running: 1;
-	int output_front: 1;
-	int output_rear: 1;
+	unsigned int running: 1;
+	unsigned int output_front: 1;
+	unsigned int output_rear: 1;
 	u32 period_size;		/* cached from runtime->period_size */
 	u32 buffer_size;		/* cached from runtime->buffer_size */
 	u32 period_pos;
===== sound/oss/via82cxxx_audio.c 1.44 vs edited =====
--- 1.44/sound/oss/via82cxxx_audio.c	2005-01-09 02:05:19 +01:00
+++ edited/sound/oss/via82cxxx_audio.c	2005-02-21 11:48:25 +01:00
@@ -306,7 +306,7 @@
 	unsigned sixchannel: 1;	/* 8233/35 with 6 channel support */
 	unsigned volume: 1;
 
-	int locked_rate : 1;
+	unsigned int locked_rate : 1;
 	
 	int mixer_vol;		/* 8233/35 volume  - not yet implemented */
 
===== sound/pci/cmipci.c 1.56 vs edited =====
--- 1.56/sound/pci/cmipci.c	2005-01-03 15:11:58 +01:00
+++ edited/sound/pci/cmipci.c	2005-02-21 11:52:01 +01:00
@@ -458,7 +458,7 @@
 	int opened[2];	/* open mode */
 	struct semaphore open_mutex;
 
-	int mixer_insensitive: 1;
+	unsigned int mixer_insensitive: 1;
 	snd_kcontrol_t *mixer_res_ctl[CM_SAVED_MIXERS];
 	int mixer_res_status[CM_SAVED_MIXERS];
 
@@ -2108,8 +2108,8 @@
 	int reg;		/* register index */
 	unsigned int mask;	/* mask bits */
 	unsigned int mask_on;	/* mask bits to turn on */
-	int is_byte: 1;		/* byte access? */
-	int ac3_sensitive: 1;	/* access forbidden during non-audio operation? */
+	unsigned int is_byte: 1;	/* byte access? */
+	unsigned int ac3_sensitive: 1;	/* access forbidden during non-audio operation? */
 } snd_cmipci_switch_args_t;
 
 static int snd_cmipci_uswitch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
===== sound/pci/intel8x0m.c 1.26 vs edited =====
--- 1.26/sound/pci/intel8x0m.c	2005-01-03 15:12:00 +01:00
+++ edited/sound/pci/intel8x0m.c	2005-02-21 11:53:26 +01:00
@@ -247,7 +247,7 @@
 	snd_pcm_t *pcm[2];
 	ichdev_t ichd[2];
 
-	int in_ac97_init: 1;
+	unsigned int in_ac97_init: 1;
 
 	ac97_bus_t *ac97_bus;
 	ac97_t *ac97;
===== sound/pci/maestro3.c 1.53 vs edited =====
--- 1.53/sound/pci/maestro3.c	2005-01-03 15:12:00 +01:00
+++ edited/sound/pci/maestro3.c	2005-02-21 11:53:57 +01:00
@@ -820,7 +820,7 @@
 	unsigned long iobase;
 
 	int irq;
-	int allegro_flag : 1;
+	unsigned int allegro_flag : 1;
 
 	ac97_t *ac97;
 
===== sound/pci/ali5451/ali5451.c 1.53 vs edited =====
--- 1.53/sound/pci/ali5451/ali5451.c	2005-01-03 15:12:02 +01:00
+++ edited/sound/pci/ali5451/ali5451.c	2005-02-21 11:49:33 +01:00
@@ -188,18 +188,18 @@
 
 struct snd_ali_stru_voice {
 	unsigned int number;
-	int use: 1,
-	    pcm: 1,
-	    midi: 1,
-	    mode: 1,
-	    synth: 1;
+	unsigned int use: 1,
+	             pcm: 1,
+	             midi: 1,
+	             mode: 1,
+	             synth: 1;
 
 	/* PCM data */
 	ali_t *codec;
 	snd_pcm_substream_t *substream;
 	snd_ali_voice_t *extra;
 	
-	int running: 1;
+	unsigned int running: 1;
 
 	int eso;                /* final ESO value for channel */
 	int count;              /* runtime->period_size */
===== sound/pci/ice1712/ice1712.h 1.23 vs edited =====
--- 1.23/sound/pci/ice1712/ice1712.h	2004-12-03 06:17:13 +01:00
+++ edited/sound/pci/ice1712/ice1712.h	2005-02-21 11:52:59 +01:00
@@ -477,7 +477,7 @@
 	char *driver;
 	int (*chip_init)(ice1712_t *);
 	int (*build_controls)(ice1712_t *);
-	int no_mpu401: 1;
+	unsigned int no_mpu401: 1;
 	unsigned int eeprom_size;
 	unsigned char *eeprom_data;
 };
