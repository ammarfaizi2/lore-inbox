Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268969AbTCASoC>; Sat, 1 Mar 2003 13:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268989AbTCASoB>; Sat, 1 Mar 2003 13:44:01 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:7953 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268969AbTCASn5>; Sat, 1 Mar 2003 13:43:57 -0500
Date: Sat, 1 Mar 2003 12:44:27 -0600
From: Art Haas <ahaas@airmail.net>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for sound/pci files
Message-ID: <20030301184427.GA1532@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here is a set of patches for files in sound/pci that convert the files
to use C99 initializers. The patches are against the current BK.

Art Haas

===== sound/pci/intel8x0.c 1.26 vs edited =====
--- 1.26/sound/pci/intel8x0.c	Sun Feb 16 07:47:43 2003
+++ edited/sound/pci/intel8x0.c	Wed Feb 26 18:33:35 2003
@@ -2433,12 +2433,12 @@
 
 static struct pci_driver driver = {
 	.name = "Intel ICH",
-	id_table: snd_intel8x0_ids,
-	probe: snd_intel8x0_probe,
-	remove: __devexit_p(snd_intel8x0_remove),
+	.id_table = snd_intel8x0_ids,
+	.probe = snd_intel8x0_probe,
+	.remove = __devexit_p(snd_intel8x0_remove),
 #ifdef CONFIG_PM
-	suspend: snd_intel8x0_suspend,
-	resume: snd_intel8x0_resume,
+	.suspend = snd_intel8x0_suspend,
+	.resume = snd_intel8x0_resume,
 #endif
 };
 
===== sound/pci/sonicvibes.c 1.12 vs edited =====
--- 1.12/sound/pci/sonicvibes.c	Sat Feb  8 14:10:55 2003
+++ edited/sound/pci/sonicvibes.c	Wed Feb 26 18:33:36 2003
@@ -267,14 +267,14 @@
 MODULE_DEVICE_TABLE(pci, snd_sonic_ids);
 
 static ratden_t sonicvibes_adc_clock = {
-	num_min: 4000 * 65536,
-	num_max: 48000UL * 65536,
-	num_step: 1,
-	den: 65536,
+	.num_min = 4000 * 65536,
+	.num_max = 48000UL * 65536,
+	.num_step = 1,
+	.den = 65536,
 };
 static snd_pcm_hw_constraint_ratdens_t snd_sonicvibes_hw_constraints_adc_clock = {
-	nrats: 1,
-	rats: &sonicvibes_adc_clock,
+	.nrats = 1,
+	.rats = &sonicvibes_adc_clock,
 };
 
 /*
===== sound/pci/ac97/ac97_codec.c 1.29 vs edited =====
--- 1.29/sound/pci/ac97/ac97_codec.c	Fri Feb 21 20:52:09 2003
+++ edited/sound/pci/ac97/ac97_codec.c	Thu Feb 27 15:30:24 2003
@@ -1097,11 +1097,11 @@
 
 static const snd_kcontrol_new_t snd_ac97_ymf753_controls_speaker =
 {
-	iface: SNDRV_CTL_ELEM_IFACE_MIXER,
-	name: "3D Control - Speaker",
-	info: snd_ac97_ymf753_info_speaker,
-	get: snd_ac97_ymf753_get_speaker,
-	put: snd_ac97_ymf753_put_speaker,
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name	= "3D Control - Speaker",
+	.info	= snd_ac97_ymf753_info_speaker,
+	.get	= snd_ac97_ymf753_get_speaker,
+	.put	= snd_ac97_ymf753_put_speaker,
 };
 
 /* It is possible to indicate to the Yamaha YMF753 the source to direct to the S/PDIF output. */
@@ -1182,18 +1182,18 @@
 
 static const snd_kcontrol_new_t snd_ac97_ymf753_controls_spdif[3] = {
 	{
-		iface: SNDRV_CTL_ELEM_IFACE_MIXER,
-		name: SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		info: snd_ac97_ymf753_spdif_source_info,
-		get: snd_ac97_ymf753_spdif_source_get,
-		put: snd_ac97_ymf753_spdif_source_put,
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
+		.info	= snd_ac97_ymf753_spdif_source_info,
+		.get	= snd_ac97_ymf753_spdif_source_get,
+		.put	= snd_ac97_ymf753_spdif_source_put,
 	},
 	{
-		iface: SNDRV_CTL_ELEM_IFACE_MIXER,
-		name: SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Output Pin",
-		info: snd_ac97_ymf753_spdif_output_pin_info,
-		get: snd_ac97_ymf753_spdif_output_pin_get,
-		put: snd_ac97_ymf753_spdif_output_pin_put,
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Output Pin",
+		.info	= snd_ac97_ymf753_spdif_output_pin_info,
+		.get	= snd_ac97_ymf753_spdif_output_pin_get,
+		.put	= snd_ac97_ymf753_spdif_output_pin_put,
 	},
 	AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",NONE,NONE) "Mute", AC97_YMF753_DIT_CTRL2, 2, 1, 1)
 };
===== sound/pci/emu10k1/emuproc.c 1.7 vs edited =====
--- 1.7/sound/pci/emu10k1/emuproc.c	Mon Jan 27 11:30:53 2003
+++ edited/sound/pci/emu10k1/emuproc.c	Wed Feb 26 18:33:33 2003
@@ -232,7 +232,7 @@
 }
 
 static struct snd_info_entry_ops snd_emu10k1_proc_ops_fx8010 = {
-	read: snd_emu10k1_fx8010_read,
+	.read = snd_emu10k1_fx8010_read,
 };
 
 int __devinit snd_emu10k1_proc_init(emu10k1_t * emu)
===== sound/pci/rme9652/hdsp.c 1.14 vs edited =====
--- 1.14/sound/pci/rme9652/hdsp.c	Sun Feb 16 07:47:44 2003
+++ edited/sound/pci/rme9652/hdsp.c	Wed Feb 26 18:33:34 2003
@@ -2634,16 +2634,16 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (r->min > 48000) {
 		snd_interval_t t = {
-			min: hdsp->ds_channels,
-			max: hdsp->ds_channels,
-			integer: 1,
+			.min = hdsp->ds_channels,
+			.max = hdsp->ds_channels,
+			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);
 	} else if (r->max < 64000) {
 		snd_interval_t t = {
-			min: hdsp->ss_channels,
-			max: hdsp->ss_channels,
-			integer: 1,
+			.min = hdsp->ss_channels,
+			.max = hdsp->ss_channels,
+			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);
 	}
@@ -2658,16 +2658,16 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (c->min >= hdsp->ss_channels) {
 		snd_interval_t t = {
-			min: 32000,
-			max: 48000,
-			integer: 1,
+			.min = 32000,
+			.max = 48000,
+			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= hdsp->ds_channels) {
 		snd_interval_t t = {
-			min: 64000,
-			max: 96000,
-			integer: 1,
+			.min = 64000,
+			.max = 96000,
+			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
 	}
===== sound/pci/rme9652/rme9652.c 1.15 vs edited =====
--- 1.15/sound/pci/rme9652/rme9652.c	Sat Feb  8 14:10:55 2003
+++ edited/sound/pci/rme9652/rme9652.c	Wed Feb 26 18:33:34 2003
@@ -2326,16 +2326,16 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (r->min > 48000) {
 		snd_interval_t t = {
-			min: rme9652->ds_channels,
-			max: rme9652->ds_channels,
-			integer: 1,
+			.min = rme9652->ds_channels,
+			.max = rme9652->ds_channels,
+			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);
 	} else if (r->max < 88200) {
 		snd_interval_t t = {
-			min: rme9652->ss_channels,
-			max: rme9652->ss_channels,
-			integer: 1,
+			.min = rme9652->ss_channels,
+			.max = rme9652->ss_channels,
+			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);
 	}
@@ -2350,16 +2350,16 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (c->min >= rme9652->ss_channels) {
 		snd_interval_t t = {
-			min: 44100,
-			max: 48000,
-			integer: 1,
+			.min = 44100,
+			.max = 48000,
+			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= rme9652->ds_channels) {
 		snd_interval_t t = {
-			min: 88200,
-			max: 96000,
-			integer: 1,
+			.min = 88200,
+			.max = 96000,
+			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
 	}
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
