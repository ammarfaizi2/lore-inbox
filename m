Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTDGXjQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTDGXhb (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:37:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25217
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263845AbTDGXY7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:24:59 -0400
Date: Tue, 8 Apr 2003 01:43:50 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080043.h380hoK5009360@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: last batch of audio C99 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/pas2_midi.c linux-2.5.67-ac1/sound/oss/pas2_midi.c
--- linux-2.5.67/sound/oss/pas2_midi.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/pas2_midi.c	2003-04-03 23:35:48.000000000 +0100
@@ -194,17 +194,17 @@
 
 static struct midi_operations pas_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"Pro Audio Spectrum", 0, 0, SNDCARD_PAS},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		pas_midi_open,
-	close:		pas_midi_close,
-	outputc:	pas_midi_out,
-	start_read:	pas_midi_start_read,
-	end_read:	pas_midi_end_read,
-	kick:		pas_midi_kick,
-	buffer_status:	pas_buffer_status,
+	.owner		= THIS_MODULE,
+	.info		= {"Pro Audio Spectrum", 0, 0, SNDCARD_PAS},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= pas_midi_open,
+	.close		= pas_midi_close,
+	.outputc	= pas_midi_out,
+	.start_read	= pas_midi_start_read,
+	.end_read	= pas_midi_end_read,
+	.kick		= pas_midi_kick,
+	.buffer_status	= pas_buffer_status,
 };
 
 void __init pas_midi_init(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/pas2_mixer.c linux-2.5.67-ac1/sound/oss/pas2_mixer.c
--- linux-2.5.67/sound/oss/pas2_mixer.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/pas2_mixer.c	2003-04-03 23:35:48.000000000 +0100
@@ -311,10 +311,10 @@
 
 static struct mixer_operations pas_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"PAS16",
-	name:	"Pro Audio Spectrum 16",
-	ioctl:	pas_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "PAS16",
+	.name	= "Pro Audio Spectrum 16",
+	.ioctl	= pas_mixer_ioctl
 };
 
 int __init
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/pas2_pcm.c linux-2.5.67-ac1/sound/oss/pas2_pcm.c
--- linux-2.5.67/sound/oss/pas2_pcm.c	2003-02-10 18:38:04.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/pas2_pcm.c	2003-04-03 23:35:48.000000000 +0100
@@ -372,16 +372,16 @@
 
 static struct audio_driver pas_audio_driver =
 {
-	owner:		THIS_MODULE,
-	open:		pas_audio_open,
-	close:		pas_audio_close,
-	output_block:	pas_audio_output_block,
-	start_input:	pas_audio_start_input,
-	ioctl:		pas_audio_ioctl,
-	prepare_for_input:	pas_audio_prepare_for_input,
-	prepare_for_output:	pas_audio_prepare_for_output,
-	halt_io:		pas_audio_reset,
-	trigger:	pas_audio_trigger
+	.owner			= THIS_MODULE,
+	.open			= pas_audio_open,
+	.close			= pas_audio_close,
+	.output_block		= pas_audio_output_block,
+	.start_input		= pas_audio_start_input,
+	.ioctl			= pas_audio_ioctl,
+	.prepare_for_input	= pas_audio_prepare_for_input,
+	.prepare_for_output	= pas_audio_prepare_for_output,
+	.halt_io		= pas_audio_reset,
+	.trigger		= pas_audio_trigger
 };
 
 void __init pas_pcm_init(struct address_info *hw_config)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/pss.c linux-2.5.67-ac1/sound/oss/pss.c
--- linux-2.5.67/sound/oss/pss.c	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/pss.c	2003-04-03 23:35:48.000000000 +0100
@@ -601,10 +601,10 @@
 
 static struct mixer_operations pss_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"SOUNDPORT",
-	name:	"PSS-AD1848",
-	ioctl:	pss_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "SOUNDPORT",
+	.name	= "PSS-AD1848",
+	.ioctl	= pss_mixer_ioctl
 };
 
 void disable_all_emulations(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sb_audio.c linux-2.5.67-ac1/sound/oss/sb_audio.c
--- linux-2.5.67/sound/oss/sb_audio.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sb_audio.c	2003-04-03 23:35:48.000000000 +0100
@@ -927,100 +927,100 @@
 
 static struct audio_driver sb1_audio_driver =	/* SB1.x */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sb1_audio_prepare_for_input,
-	prepare_for_output:	sb1_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	trigger:	sb1_audio_trigger,
-	set_speed:	sb1_audio_set_speed,
-	set_bits:	sb1_audio_set_bits,
-	set_channels:	sb1_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sb1_audio_prepare_for_input,
+	.prepare_for_output	= sb1_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.trigger		= sb1_audio_trigger,
+	.set_speed		= sb1_audio_set_speed,
+	.set_bits		= sb1_audio_set_bits,
+	.set_channels		= sb1_audio_set_channels
 };
 
 static struct audio_driver sb20_audio_driver =	/* SB2.0 */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sb1_audio_prepare_for_input,
-	prepare_for_output:	sb1_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	trigger:	sb20_audio_trigger,
-	set_speed:	sb1_audio_set_speed,
-	set_bits:	sb1_audio_set_bits,
-	set_channels:	sb1_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sb1_audio_prepare_for_input,
+	.prepare_for_output	= sb1_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.trigger		= sb20_audio_trigger,
+	.set_speed		= sb1_audio_set_speed,
+	.set_bits		= sb1_audio_set_bits,
+	.set_channels		= sb1_audio_set_channels
 };
 
 static struct audio_driver sb201_audio_driver =		/* SB2.01 */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sb1_audio_prepare_for_input,
-	prepare_for_output:	sb1_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	trigger:	sb20_audio_trigger,
-	set_speed:	sb201_audio_set_speed,
-	set_bits:	sb1_audio_set_bits,
-	set_channels:	sb1_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sb1_audio_prepare_for_input,
+	.prepare_for_output	= sb1_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.trigger		= sb20_audio_trigger,
+	.set_speed		= sb201_audio_set_speed,
+	.set_bits		= sb1_audio_set_bits,
+	.set_channels		= sb1_audio_set_channels
 };
 
 static struct audio_driver sbpro_audio_driver =		/* SB Pro */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sbpro_audio_prepare_for_input,
-	prepare_for_output:	sbpro_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	trigger:	sb20_audio_trigger,
-	set_speed:	sbpro_audio_set_speed,
-	set_bits:	sb1_audio_set_bits,
-	set_channels:	sbpro_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sbpro_audio_prepare_for_input,
+	.prepare_for_output	= sbpro_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.trigger		= sb20_audio_trigger,
+	.set_speed		= sbpro_audio_set_speed,
+	.set_bits		= sb1_audio_set_bits,
+	.set_channels		= sbpro_audio_set_channels
 };
 
 static struct audio_driver jazz16_audio_driver =	/* Jazz16 and SM Wave */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sbpro_audio_prepare_for_input,
-	prepare_for_output:	sbpro_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	trigger:	sb20_audio_trigger,
-	set_speed:	jazz16_audio_set_speed,
-	set_bits:	sb16_audio_set_bits,
-	set_channels:	sbpro_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sbpro_audio_prepare_for_input,
+	.prepare_for_output	= sbpro_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.trigger		= sb20_audio_trigger,
+	.set_speed		= jazz16_audio_set_speed,
+	.set_bits		= sb16_audio_set_bits,
+	.set_channels		= sbpro_audio_set_channels
 };
 
 static struct audio_driver sb16_audio_driver =	/* SB16 */
 {
-	owner:		THIS_MODULE,
-	open:		sb_audio_open,
-	close:		sb_audio_close,
-	output_block:	sb_set_output_parms,
-	start_input:	sb_set_input_parms,
-	prepare_for_input:	sb16_audio_prepare_for_input,
-	prepare_for_output:	sb16_audio_prepare_for_output,
-	halt_io:	sb1_audio_halt_xfer,
-	copy_user:	sb16_copy_from_user,
-	trigger:	sb16_audio_trigger,
-	set_speed:	sb16_audio_set_speed,
-	set_bits:	sb16_audio_set_bits,
-	set_channels:	sbpro_audio_set_channels,
-	mmap:		sb16_audio_mmap
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= sb_set_output_parms,
+	.start_input		= sb_set_input_parms,
+	.prepare_for_input	= sb16_audio_prepare_for_input,
+	.prepare_for_output	= sb16_audio_prepare_for_output,
+	.halt_io		= sb1_audio_halt_xfer,
+	.copy_user		= sb16_copy_from_user,
+	.trigger		= sb16_audio_trigger,
+	.set_speed		= sb16_audio_set_speed,
+	.set_bits		= sb16_audio_set_bits,
+	.set_channels		= sbpro_audio_set_channels,
+	.mmap			= sb16_audio_mmap
 };
 
 void sb_audio_init(sb_devc * devc, char *name, struct module *owner)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sb_ess.c linux-2.5.67-ac1/sound/oss/sb_ess.c
--- linux-2.5.67/sound/oss/sb_ess.c	2003-02-10 18:38:19.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sb_ess.c	2003-04-03 23:35:48.000000000 +0100
@@ -718,18 +718,18 @@
 
 static struct audio_driver ess_audio_driver =   /* ESS ES688/1688 */
 {
-	owner:			THIS_MODULE,
-	open:			sb_audio_open,
-	close:			sb_audio_close,
-	output_block:	ess_set_output_parms,
-	start_input:	ess_set_input_parms,
-	prepare_for_input:	ess_audio_prepare_for_input,
-	prepare_for_output:	ess_audio_prepare_for_output,
-	halt_io:		ess_audio_halt_xfer,
-	trigger:		ess_audio_trigger,
-	set_speed:		ess_audio_set_speed,
-	set_bits:		ess_audio_set_bits,
-	set_channels:	ess_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= sb_audio_open,
+	.close			= sb_audio_close,
+	.output_block		= ess_set_output_parms,
+	.start_input		= ess_set_input_parms,
+	.prepare_for_input	= ess_audio_prepare_for_input,
+	.prepare_for_output	= ess_audio_prepare_for_output,
+	.halt_io		= ess_audio_halt_xfer,
+	.trigger		= ess_audio_trigger,
+	.set_speed		= ess_audio_set_speed,
+	.set_bits		= ess_audio_set_bits,
+	.set_channels		= ess_audio_set_channels
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sb_midi.c linux-2.5.67-ac1/sound/oss/sb_midi.c
--- linux-2.5.67/sound/oss/sb_midi.c	2003-02-10 18:37:55.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sb_midi.c	2003-04-03 23:35:48.000000000 +0100
@@ -146,16 +146,16 @@
 
 static struct midi_operations sb_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"Sound Blaster", 0, 0, SNDCARD_SB},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		sb_midi_open,
-	close:		sb_midi_close,
-	ioctl:		sb_midi_ioctl,
-	outputc:	sb_midi_out,
-	start_read:	sb_midi_start_read,
-	end_read:	sb_midi_end_read,
+	.owner		= THIS_MODULE,
+	.info		= {"Sound Blaster", 0, 0, SNDCARD_SB},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= sb_midi_open,
+	.close		= sb_midi_close,
+	.ioctl		= sb_midi_ioctl,
+	.outputc	= sb_midi_out,
+	.start_read	= sb_midi_start_read,
+	.end_read	= sb_midi_end_read,
 };
 
 void sb_dsp_midi_init(sb_devc * devc, struct module *owner)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sb_mixer.c linux-2.5.67-ac1/sound/oss/sb_mixer.c
--- linux-2.5.67/sound/oss/sb_mixer.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sb_mixer.c	2003-04-03 23:35:48.000000000 +0100
@@ -626,18 +626,18 @@
 
 static struct mixer_operations sb_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"SB",
-	name:	"Sound Blaster",
-	ioctl:	sb_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "SB",
+	.name	= "Sound Blaster",
+	.ioctl	= sb_mixer_ioctl
 };
 
 static struct mixer_operations als007_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"ALS007",
-	name:	"Avance ALS-007",
-	ioctl:	sb_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "ALS007",
+	.name	= "Avance ALS-007",
+	.ioctl	= sb_mixer_ioctl
 };
 
 static void sb_mixer_reset(sb_devc * devc)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sonicvibes.c linux-2.5.67-ac1/sound/oss/sonicvibes.c
--- linux-2.5.67/sound/oss/sonicvibes.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sonicvibes.c	2003-04-03 23:52:57.000000000 +0100
@@ -100,7 +100,6 @@
 
 /*****************************************************************************/
       
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
@@ -1267,11 +1266,11 @@
 }
 
 static /*const*/ struct file_operations sv_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		sv_ioctl_mixdev,
-	open:		sv_open_mixdev,
-	release:	sv_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= sv_ioctl_mixdev,
+	.open		= sv_open_mixdev,
+	.release	= sv_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -1978,15 +1977,15 @@
 }
 
 static /*const*/ struct file_operations sv_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		sv_read,
-	write:		sv_write,
-	poll:		sv_poll,
-	ioctl:		sv_ioctl,
-	mmap:		sv_mmap,
-	open:		sv_open,
-	release:	sv_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= sv_read,
+	.write		= sv_write,
+	.poll		= sv_poll,
+	.ioctl		= sv_ioctl,
+	.mmap		= sv_mmap,
+	.open		= sv_open,
+	.release	= sv_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2260,13 +2259,13 @@
 }
 
 static /*const*/ struct file_operations sv_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		sv_midi_read,
-	write:		sv_midi_write,
-	poll:		sv_midi_poll,
-	open:		sv_midi_open,
-	release:	sv_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= sv_midi_read,
+	.write		= sv_midi_write,
+	.poll		= sv_midi_poll,
+	.open		= sv_midi_open,
+	.release	= sv_midi_release,
 };
 
 /* --------------------------------------------------------------------- */
@@ -2435,11 +2434,11 @@
 }
 
 static /*const*/ struct file_operations sv_dmfm_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		sv_dmfm_ioctl,
-	open:		sv_dmfm_open,
-	release:	sv_dmfm_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= sv_dmfm_ioctl,
+	.open		= sv_dmfm_open,
+	.release	= sv_dmfm_release,
 };
 
 /* --------------------------------------------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/soundcard.c linux-2.5.67-ac1/sound/oss/soundcard.c
--- linux-2.5.67/sound/oss/soundcard.c	2003-02-10 18:38:37.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/soundcard.c	2003-04-03 23:35:48.000000000 +0100
@@ -491,15 +491,15 @@
 }
 
 struct file_operations oss_sound_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		sound_read,
-	write:		sound_write,
-	poll:		sound_poll,
-	ioctl:		sound_ioctl,
-	mmap:		sound_mmap,
-	open:		sound_open,
-	release:	sound_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= sound_read,
+	.write		= sound_write,
+	.poll		= sound_poll,
+	.ioctl		= sound_ioctl,
+	.mmap		= sound_mmap,
+	.open		= sound_open,
+	.release	= sound_release,
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/sys_timer.c linux-2.5.67-ac1/sound/oss/sys_timer.c
--- linux-2.5.67/sound/oss/sys_timer.c	2003-02-10 18:38:31.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/sys_timer.c	2003-04-03 23:35:48.000000000 +0100
@@ -275,14 +275,14 @@
 
 struct sound_timer_operations default_sound_timer =
 {
-	owner:		THIS_MODULE,
-	info:		{"System clock", 0},
-	priority:	0,	/* Priority */
-	devlink:	0,	/* Local device link */
-	open:		def_tmr_open,
-	close:		def_tmr_close,
-	event:		def_tmr_event,
-	get_time:	def_tmr_get_time,
-	ioctl:		def_tmr_ioctl,
-	arm_timer:	def_tmr_arm
+	.owner		= THIS_MODULE,
+	.info		= {"System clock", 0},
+	.priority	= 0,	/* Priority */
+	.devlink	= 0,	/* Local device link */
+	.open		= def_tmr_open,
+	.close		= def_tmr_close,
+	.event		= def_tmr_event,
+	.get_time	= def_tmr_get_time,
+	.ioctl		= def_tmr_ioctl,
+	.arm_timer	= def_tmr_arm
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/trident.c linux-2.5.67-ac1/sound/oss/trident.c
--- linux-2.5.67/sound/oss/trident.c	2003-03-18 16:46:53.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/trident.c	2003-04-03 23:52:57.000000000 +0100
@@ -181,7 +181,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
@@ -2772,15 +2771,15 @@
 }
 
 static /*const*/ struct file_operations trident_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		trident_read,
-	write:		trident_write,
-	poll:		trident_poll,
-	ioctl:		trident_ioctl,
-	mmap:		trident_mmap,
-	open:		trident_open,
-	release:	trident_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= trident_read,
+	.write		= trident_write,
+	.poll		= trident_poll,
+	.ioctl		= trident_ioctl,
+	.mmap		= trident_mmap,
+	.open		= trident_open,
+	.release	= trident_release,
 };
 
 /* trident specific AC97 functions */
@@ -3894,10 +3893,10 @@
 }
 
 static /*const*/ struct file_operations trident_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		trident_ioctl_mixdev,
-	open:		trident_open_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= trident_ioctl_mixdev,
+	.open		= trident_open_mixdev,
 };
 
 static int ali_reset_5451(struct trident_card *card)
@@ -4376,12 +4375,12 @@
 #define TRIDENT_MODULE_NAME "trident"
 
 static struct pci_driver trident_pci_driver = {
-	name:		TRIDENT_MODULE_NAME,
-	id_table:	trident_pci_tbl,
-	probe:		trident_probe,
-	remove:		__devexit_p(trident_remove),
-	suspend:	trident_suspend,
-	resume:		trident_resume
+	.name		= TRIDENT_MODULE_NAME,
+	.id_table	= trident_pci_tbl,
+	.probe		= trident_probe,
+	.remove		= __devexit_p(trident_remove),
+	.suspend	= trident_suspend,
+	.resume		= trident_resume
 };
 
 static int __init trident_init_module (void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/uart401.c linux-2.5.67-ac1/sound/oss/uart401.c
--- linux-2.5.67/sound/oss/uart401.c	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/uart401.c	2003-04-03 23:35:48.000000000 +0100
@@ -204,17 +204,17 @@
 
 static const struct midi_operations uart401_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"MPU-401 (UART) MIDI", 0, 0, SNDCARD_MPU401},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		uart401_open,
-	close:		uart401_close,
-	outputc:	uart401_out,
-	start_read:	uart401_start_read,
-	end_read:	uart401_end_read,
-	kick:		uart401_kick,
-	buffer_status:	uart401_buffer_status,
+	.owner		= THIS_MODULE,
+	.info		= {"MPU-401 (UART) MIDI", 0, 0, SNDCARD_MPU401},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= uart401_open,
+	.close		= uart401_close,
+	.outputc	= uart401_out,
+	.start_read	= uart401_start_read,
+	.end_read	= uart401_end_read,
+	.kick		= uart401_kick,
+	.buffer_status	= uart401_buffer_status,
 };
 
 static void enter_uart_mode(uart401_devc * devc)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/uart6850.c linux-2.5.67-ac1/sound/oss/uart6850.c
--- linux-2.5.67/sound/oss/uart6850.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/uart6850.c	2003-04-03 23:35:48.000000000 +0100
@@ -231,18 +231,18 @@
 
 static struct midi_operations uart6850_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"6850 UART", 0, 0, SNDCARD_UART6850},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		uart6850_open,
-	close:		uart6850_close,
-	outputc:	uart6850_out,
-	start_read:	uart6850_start_read,
-	end_read:	uart6850_end_read,
-	kick:		uart6850_kick,
-	command:	uart6850_command,
-	buffer_status:	uart6850_buffer_status
+	.owner		= THIS_MODULE,
+	.info		= {"6850 UART", 0, 0, SNDCARD_UART6850},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= uart6850_open,
+	.close		= uart6850_close,
+	.outputc	= uart6850_out,
+	.start_read	= uart6850_start_read,
+	.end_read	= uart6850_end_read,
+	.kick		= uart6850_kick,
+	.command	= uart6850_command,
+	.buffer_status	= uart6850_buffer_status
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/via82cxxx_audio.c linux-2.5.67-ac1/sound/oss/via82cxxx_audio.c
--- linux-2.5.67/sound/oss/via82cxxx_audio.c	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/via82cxxx_audio.c	2003-04-04 00:55:38.000000000 +0100
@@ -360,10 +360,10 @@
 
 
 static struct pci_driver via_driver = {
-	name:		VIA_MODULE_NAME,
-	id_table:	via_pci_tbl,
-	probe:		via_init_one,
-	remove:		__devexit_p(via_remove_one),
+	.name		= VIA_MODULE_NAME,
+	.id_table	= via_pci_tbl,
+	.probe		= via_init_one,
+	.remove		= __devexit_p(via_remove_one),
 };
 
 
@@ -1412,10 +1412,10 @@
 
 
 static struct file_operations via_mixer_fops = {
-	owner:		THIS_MODULE,
-	open:		via_mixer_open,
-	llseek:		no_llseek,
-	ioctl:		via_mixer_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= via_mixer_open,
+	.llseek		= no_llseek,
+	.ioctl		= via_mixer_ioctl,
 };
 
 
@@ -1783,15 +1783,15 @@
  */
 
 static struct file_operations via_dsp_fops = {
-	owner:		THIS_MODULE,
-	open:		via_dsp_open,
-	release:	via_dsp_release,
-	read:		via_dsp_read,
-	write:		via_dsp_write,
-	poll:		via_dsp_poll,
-	llseek: 	no_llseek,
-	ioctl:		via_dsp_ioctl,
-	mmap:		via_dsp_mmap,
+	.owner		= THIS_MODULE,
+	.open		= via_dsp_open,
+	.release	= via_dsp_release,
+	.read		= via_dsp_read,
+	.write		= via_dsp_write,
+	.poll		= via_dsp_poll,
+	.llseek		= no_llseek,
+	.ioctl		= via_dsp_ioctl,
+	.mmap		= via_dsp_mmap,
 };
 
 
@@ -1902,10 +1902,10 @@
 
 
 struct vm_operations_struct via_mm_ops = {
-	nopage:		via_mm_nopage,
+	.nopage		= via_mm_nopage,
 
 #ifndef VM_RESERVED
-	swapout:	via_mm_swapout,
+	.swapout	= via_mm_swapout,
 #endif
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/vidc.c linux-2.5.67-ac1/sound/oss/vidc.c
--- linux-2.5.67/sound/oss/vidc.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/vidc.c	2003-04-03 23:35:48.000000000 +0100
@@ -366,26 +366,26 @@
 
 static struct audio_driver vidc_audio_driver =
 {
-	owner:			THIS_MODULE,
-	open:			vidc_audio_open,
-	close:			vidc_audio_close,
-	output_block:		vidc_audio_output_block,
-	start_input:		vidc_audio_start_input,
-	prepare_for_input:	vidc_audio_prepare_for_input,
-	prepare_for_output:	vidc_audio_prepare_for_output,
-	halt_io:		vidc_audio_reset,
-	local_qlen:		vidc_audio_local_qlen,
-	trigger:		vidc_audio_trigger,
-	set_speed:		vidc_audio_set_speed,
-	set_bits:		vidc_audio_set_format,
-	set_channels:		vidc_audio_set_channels
+	.owner			= THIS_MODULE,
+	.open			= vidc_audio_open,
+	.close			= vidc_audio_close,
+	.output_block		= vidc_audio_output_block,
+	.start_input		= vidc_audio_start_input,
+	.prepare_for_input	= vidc_audio_prepare_for_input,
+	.prepare_for_output	= vidc_audio_prepare_for_output,
+	.halt_io		= vidc_audio_reset,
+	.local_qlen		= vidc_audio_local_qlen,
+	.trigger		= vidc_audio_trigger,
+	.set_speed		= vidc_audio_set_speed,
+	.set_bits		= vidc_audio_set_format,
+	.set_channels		= vidc_audio_set_channels
 };
 
 static struct mixer_operations vidc_mixer_operations = {
-	owner:		THIS_MODULE,
-	id:		"VIDC",
-	name:		"VIDCsound",
-	ioctl:		vidc_mixer_ioctl
+	.owner		= THIS_MODULE,
+	.id		= "VIDC",
+	.name		= "VIDCsound",
+	.ioctl		= vidc_mixer_ioctl
 };
 
 void vidc_update_filler(int format, int channels)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/v_midi.c linux-2.5.67-ac1/sound/oss/v_midi.c
--- linux-2.5.67/sound/oss/v_midi.c	2003-02-10 18:38:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/v_midi.c	2003-04-03 23:35:48.000000000 +0100
@@ -133,30 +133,30 @@
 
 static struct midi_operations v_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"Loopback MIDI Port 1", 0, 0, SNDCARD_VMIDI},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		v_midi_open,
-	close:		v_midi_close,
-	ioctl:		v_midi_ioctl,
-	outputc:	v_midi_out,
-	start_read:	v_midi_start_read,
-	end_read:	v_midi_end_read,
+	.owner		= THIS_MODULE,
+	.info		= {"Loopback MIDI Port 1", 0, 0, SNDCARD_VMIDI},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= v_midi_open,
+	.close		= v_midi_close,
+	.ioctl		= v_midi_ioctl,
+	.outputc	= v_midi_out,
+	.start_read	= v_midi_start_read,
+	.end_read	= v_midi_end_read,
 };
 
 static struct midi_operations v_midi_operations2 =
 {
-	owner:		THIS_MODULE,
-	info:		{"Loopback MIDI Port 2", 0, 0, SNDCARD_VMIDI},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		v_midi_open,
-	close:		v_midi_close,
-	ioctl:		v_midi_ioctl,
-	outputc:	v_midi_out,
-	start_read:	v_midi_start_read,
-	end_read:	v_midi_end_read,
+	.owner		= THIS_MODULE,
+	.info		= {"Loopback MIDI Port 2", 0, 0, SNDCARD_VMIDI},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= v_midi_open,
+	.close		= v_midi_close,
+	.ioctl		= v_midi_ioctl,
+	.outputc	= v_midi_out,
+	.start_read	= v_midi_start_read,
+	.end_read	= v_midi_end_read,
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/waveartist.c linux-2.5.67-ac1/sound/oss/waveartist.c
--- linux-2.5.67/sound/oss/waveartist.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/waveartist.c	2003-04-03 23:35:48.000000000 +0100
@@ -815,21 +815,21 @@
 }
 
 static struct audio_driver waveartist_audio_driver = {
-	owner:			THIS_MODULE,
-	open:			waveartist_open,
-	close:			waveartist_close,
-	output_block:		waveartist_output_block,
-	start_input:		waveartist_start_input,
-	ioctl:			waveartist_ioctl,
-	prepare_for_input:	waveartist_prepare_for_input,
-	prepare_for_output:	waveartist_prepare_for_output,
-	halt_io:		waveartist_halt,
-	halt_input:		waveartist_halt_input,
-	halt_output:		waveartist_halt_output,
-	trigger:		waveartist_trigger,
-	set_speed:		waveartist_set_speed,
-	set_bits:		waveartist_set_bits,
-	set_channels:		waveartist_set_channels
+	.owner			= THIS_MODULE,
+	.open			= waveartist_open,
+	.close			= waveartist_close,
+	.output_block		= waveartist_output_block,
+	.start_input		= waveartist_start_input,
+	.ioctl			= waveartist_ioctl,
+	.prepare_for_input	= waveartist_prepare_for_input,
+	.prepare_for_output	= waveartist_prepare_for_output,
+	.halt_io		= waveartist_halt,
+	.halt_input		= waveartist_halt_input,
+	.halt_output		= waveartist_halt_output,
+	.trigger		= waveartist_trigger,
+	.set_speed		= waveartist_set_speed,
+	.set_bits		= waveartist_set_bits,
+	.set_channels		= waveartist_set_channels
 };
 
 
@@ -1062,15 +1062,15 @@
 }
 
 static const struct waveartist_mixer_info waveartist_mixer = {
-	supported_devs:	SUPPORTED_MIXER_DEVICES | SOUND_MASK_IGAIN,
-	recording_devs:	SOUND_MASK_LINE  | SOUND_MASK_MIC   |
+	.supported_devs	= SUPPORTED_MIXER_DEVICES | SOUND_MASK_IGAIN,
+	.recording_devs	= SOUND_MASK_LINE  | SOUND_MASK_MIC   |
 			SOUND_MASK_LINE1 | SOUND_MASK_LINE2 |
 			SOUND_MASK_IMIX,
-	stereo_devs:	(SUPPORTED_MIXER_DEVICES | SOUND_MASK_IGAIN) & ~
+	.stereo_devs	= (SUPPORTED_MIXER_DEVICES | SOUND_MASK_IGAIN) & ~
 			(SOUND_MASK_SPEAKER | SOUND_MASK_IMIX),
-	select_input:	waveartist_select_input,
-	decode_mixer:	waveartist_decode_mixer,
-	get_mixer:	waveartist_get_mixer,
+	.select_input	= waveartist_select_input,
+	.decode_mixer	= waveartist_decode_mixer,
+	.get_mixer	= waveartist_get_mixer,
 };
 
 static void
@@ -1203,10 +1203,10 @@
 
 static struct mixer_operations waveartist_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"WaveArtist",
-	name:	"WaveArtist",
-	ioctl:	waveartist_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "WaveArtist",
+	.name	= "WaveArtist",
+	.ioctl	= waveartist_mixer_ioctl
 };
 
 static void
@@ -1692,24 +1692,24 @@
  * Waveartist specific mixer information.
  */
 static const struct waveartist_mixer_info netwinder_mixer = {
-	supported_devs:	SOUND_MASK_VOLUME  | SOUND_MASK_SYNTH   |
+	.supported_devs	= SOUND_MASK_VOLUME  | SOUND_MASK_SYNTH   |
 			SOUND_MASK_PCM     | SOUND_MASK_SPEAKER |
 			SOUND_MASK_LINE    | SOUND_MASK_MIC     |
 			SOUND_MASK_IMIX    | SOUND_MASK_LINE1   |
 			SOUND_MASK_PHONEIN | SOUND_MASK_PHONEOUT|
 			SOUND_MASK_IGAIN,
 
-	recording_devs:	SOUND_MASK_LINE    | SOUND_MASK_MIC     |
+	.recording_devs	= SOUND_MASK_LINE    | SOUND_MASK_MIC     |
 			SOUND_MASK_IMIX    | SOUND_MASK_LINE1   |
 			SOUND_MASK_PHONEIN,
 
-	stereo_devs:	SOUND_MASK_VOLUME  | SOUND_MASK_SYNTH   |
+	.stereo_devs	= SOUND_MASK_VOLUME  | SOUND_MASK_SYNTH   |
 			SOUND_MASK_PCM     | SOUND_MASK_LINE    |
 			SOUND_MASK_IMIX    | SOUND_MASK_IGAIN,
 
-	select_input:	netwinder_select_input,
-	decode_mixer:	netwinder_decode_mixer,
-	get_mixer:	netwinder_get_mixer,
+	.select_input	= netwinder_select_input,
+	.decode_mixer	= netwinder_decode_mixer,
+	.get_mixer	= netwinder_get_mixer,
 };
 
 static void
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/wavfront.c linux-2.5.67-ac1/sound/oss/wavfront.c
--- linux-2.5.67/sound/oss/wavfront.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/wavfront.c	2003-04-03 23:35:48.000000000 +0100
@@ -1961,11 +1961,11 @@
 }
 
 static /*const*/ struct file_operations wavefront_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		wavefront_ioctl,
-	open:		wavefront_open,
-	release:	wavefront_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= wavefront_ioctl,
+	.open		= wavefront_open,
+	.release	= wavefront_release,
 };
 
 
@@ -2078,25 +2078,25 @@
 
 static struct synth_operations wavefront_operations =
 {
-	owner:		THIS_MODULE,
-	id:		"WaveFront",
-	info:		&wavefront_info,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_SAMPLE,
-	synth_subtype:	SAMPLE_TYPE_WAVEFRONT,
-	open:		wavefront_oss_open,
-	close:		wavefront_oss_close,
-	ioctl:		wavefront_oss_ioctl,
-	kill_note:	midi_synth_kill_note,
-	start_note:	midi_synth_start_note,
-	set_instr:	midi_synth_set_instr,
-	reset:		midi_synth_reset,
-	load_patch:	midi_synth_load_patch,
-	aftertouch:	midi_synth_aftertouch,
-	controller:	midi_synth_controller,
-	panning:	midi_synth_panning,
-	bender:		midi_synth_bender,
-	setup_voice:	midi_synth_setup_voice
+	.owner		= THIS_MODULE,
+	.id		= "WaveFront",
+	.info		= &wavefront_info,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_SAMPLE,
+	.synth_subtype	= SAMPLE_TYPE_WAVEFRONT,
+	.open		= wavefront_oss_open,
+	.close		= wavefront_oss_close,
+	.ioctl		= wavefront_oss_ioctl,
+	.kill_note	= midi_synth_kill_note,
+	.start_note	= midi_synth_start_note,
+	.set_instr	= midi_synth_set_instr,
+	.reset		= midi_synth_reset,
+	.load_patch	= midi_synth_load_patch,
+	.aftertouch	= midi_synth_aftertouch,
+	.controller	= midi_synth_controller,
+	.panning	= midi_synth_panning,
+	.bender		= midi_synth_bender,
+	.setup_voice	= midi_synth_setup_voice
 };
 #endif /* OSS_SUPPORT_SEQ */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/wf_midi.c linux-2.5.67-ac1/sound/oss/wf_midi.c
--- linux-2.5.67/sound/oss/wf_midi.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/wf_midi.c	2003-04-03 23:35:48.000000000 +0100
@@ -552,16 +552,16 @@
 
 static struct midi_operations wf_mpu_midi_proto =
 {
-	owner:		THIS_MODULE,
-	info:		{"WF-MPU MIDI", 0, MIDI_CAP_MPU401, SNDCARD_MPU401},
-	in_info:	{0},   /* in_info */
-	open:		wf_mpu_open,
-	close:		wf_mpu_close,
-	ioctl:		wf_mpu_ioctl,
-	outputc:	wf_mpu_out,
-	start_read:	wf_mpu_start_read,
-	end_read:	wf_mpu_end_read,
-	buffer_status:	wf_mpu_buffer_status,
+	.owner		= THIS_MODULE,
+	.info		= {"WF-MPU MIDI", 0, MIDI_CAP_MPU401, SNDCARD_MPU401},
+	.in_info	= {0},   /* in_info */
+	.open		= wf_mpu_open,
+	.close		= wf_mpu_close,
+	.ioctl		= wf_mpu_ioctl,
+	.outputc	= wf_mpu_out,
+	.start_read	= wf_mpu_start_read,
+	.end_read	= wf_mpu_end_read,
+	.buffer_status	= wf_mpu_buffer_status,
 };
 
 static struct synth_info wf_mpu_synth_info_proto =
@@ -668,27 +668,27 @@
 
 static struct synth_operations wf_mpu_synth_proto =
 {
-	owner:		THIS_MODULE,
-	id:		"WaveFront (ICS2115)",
-	info:		NULL,  /* info field, filled in during configuration */
-	midi_dev:	0,     /* MIDI dev XXX should this be -1 ? */
-	synth_type:	SYNTH_TYPE_MIDI,
-	synth_subtype:	SAMPLE_TYPE_WAVEFRONT,
-	open:		wf_mpu_synth_open,
-	close:		wf_mpu_synth_close,
-	ioctl:		wf_mpu_synth_ioctl,
-	kill_note:	midi_synth_kill_note,
-	start_note:	midi_synth_start_note,
-	set_instr:	midi_synth_set_instr,
-	reset:		midi_synth_reset,
-	hw_control:	midi_synth_hw_control,
-	load_patch:	midi_synth_load_patch,
-	aftertouch:	midi_synth_aftertouch,
-	controller:	midi_synth_controller,
-	panning:	midi_synth_panning,
-	bender:		midi_synth_bender,
-	setup_voice:	midi_synth_setup_voice,
-	send_sysex:	midi_synth_send_sysex
+	.owner		= THIS_MODULE,
+	.id		= "WaveFront (ICS2115)",
+	.info		= NULL,  /* info field, filled in during configuration */
+	.midi_dev	= 0,     /* MIDI dev XXX should this be -1 ? */
+	.synth_type	= SYNTH_TYPE_MIDI,
+	.synth_subtype	= SAMPLE_TYPE_WAVEFRONT,
+	.open		= wf_mpu_synth_open,
+	.close		= wf_mpu_synth_close,
+	.ioctl		= wf_mpu_synth_ioctl,
+	.kill_note	= midi_synth_kill_note,
+	.start_note	= midi_synth_start_note,
+	.set_instr	= midi_synth_set_instr,
+	.reset		= midi_synth_reset,
+	.hw_control	= midi_synth_hw_control,
+	.load_patch	= midi_synth_load_patch,
+	.aftertouch	= midi_synth_aftertouch,
+	.controller	= midi_synth_controller,
+	.panning	= midi_synth_panning,
+	.bender		= midi_synth_bender,
+	.setup_voice	= midi_synth_setup_voice,
+	.send_sysex	= midi_synth_send_sysex
 };
 
 static int
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ymfpci.c linux-2.5.67-ac1/sound/oss/ymfpci.c
--- linux-2.5.67/sound/oss/ymfpci.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ymfpci.c	2003-04-03 23:35:48.000000000 +0100
@@ -2038,23 +2038,23 @@
 }
 
 static /*const*/ struct file_operations ymf_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		ymf_read,
-	write:		ymf_write,
-	poll:		ymf_poll,
-	ioctl:		ymf_ioctl,
-	mmap:		ymf_mmap,
-	open:		ymf_open,
-	release:	ymf_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= ymf_read,
+	.write		= ymf_write,
+	.poll		= ymf_poll,
+	.ioctl		= ymf_ioctl,
+	.mmap		= ymf_mmap,
+	.open		= ymf_open,
+	.release	= ymf_release,
 };
 
 static /*const*/ struct file_operations ymf_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		ymf_ioctl_mixdev,
-	open:		ymf_open_mixdev,
-	release:	ymf_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= ymf_ioctl_mixdev,
+	.open		= ymf_open_mixdev,
+	.release	= ymf_release_mixdev,
 };
 
 /*
@@ -2650,12 +2650,12 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver ymfpci_driver = {
-	name:		"ymfpci",
-	id_table:	ymf_id_tbl,
-	probe:		ymf_probe_one,
-	remove:		__devexit_p(ymf_remove_one),
-	suspend:	ymf_suspend,
-	resume:		ymf_resume
+	.name		= "ymfpci",
+	.id_table	= ymf_id_tbl,
+	.probe		= ymf_probe_one,
+	.remove		= __devexit_p(ymf_remove_one),
+	.suspend	= ymf_suspend,
+	.resume		= ymf_resume
 };
 
 static int __init ymf_init_module(void)
