Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTDHAPJ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTDHANl (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:13:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23681
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263822AbTDGXXm (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:23:42 -0400
Date: Tue, 8 Apr 2003 01:42:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080042.h380gXIt009348@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: yet more sound version/c99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/maestro.c linux-2.5.67-ac1/sound/oss/maestro.c
--- linux-2.5.67/sound/oss/maestro.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/maestro.c	2003-04-03 23:52:57.000000000 +0100
@@ -205,7 +205,6 @@
 
 /*****************************************************************************/
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
@@ -2170,11 +2169,11 @@
 }
 
 static /*const*/ struct file_operations ess_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:         no_llseek,
-	ioctl:          ess_ioctl_mixdev,
-	open:           ess_open_mixdev,
-	release:        ess_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= ess_ioctl_mixdev,
+	.open		= ess_open_mixdev,
+	.release	= ess_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -3106,15 +3105,15 @@
 }
 
 static struct file_operations ess_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:         no_llseek,
-	read:           ess_read,
-	write:          ess_write,
-	poll:           ess_poll,
-	ioctl:          ess_ioctl,
-	mmap:           ess_mmap,
-	open:           ess_open,
-	release:        ess_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= ess_read,
+	.write		= ess_write,
+	.poll		= ess_poll,
+	.ioctl		= ess_ioctl,
+	.mmap		= ess_mmap,
+	.open		= ess_open,
+	.release	= ess_release,
 };
 
 static int
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/midi_synth.h linux-2.5.67-ac1/sound/oss/midi_synth.h
--- linux-2.5.67/sound/oss/midi_synth.h	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/midi_synth.h	2003-04-03 23:35:48.000000000 +0100
@@ -22,26 +22,26 @@
 
 static struct synth_operations std_midi_synth =
 {
-	owner:		THIS_MODULE,
-	id:		"MIDI",
-	info:		&std_synth_info,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_MIDI,
-	synth_subtype:	0,
-	open:		midi_synth_open,
-	close:		midi_synth_close,
-	ioctl:		midi_synth_ioctl,
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
+	.id		= "MIDI",
+	.info		= &std_synth_info,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_MIDI,
+	.synth_subtype	= 0,
+	.open		= midi_synth_open,
+	.close		= midi_synth_close,
+	.ioctl		= midi_synth_ioctl,
+	.kill_note	= midi_synth_kill_note,
+	.start_note	= midi_synth_start_note,
+	.set_instr	= midi_synth_set_instr,
+	.reset		= midi_synth_reset,
+	.hw_control	= midi_synth_hw_control,
+	.load_patch	= midi_synth_load_patch,
+	.aftertouch	= midi_synth_aftertouch,
+	.controller	= midi_synth_controller,
+	.panning		= midi_synth_panning,
+	.bender		= midi_synth_bender,
+	.setup_voice	= midi_synth_setup_voice,
+	.send_sysex	= midi_synth_send_sysex
 };
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/mpu401.c linux-2.5.67-ac1/sound/oss/mpu401.c
--- linux-2.5.67/sound/oss/mpu401.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/mpu401.c	2003-04-03 23:35:48.000000000 +0100
@@ -888,45 +888,45 @@
 
 static struct synth_operations mpu401_synth_proto =
 {
-	owner:		THIS_MODULE,
-	id:		"MPU401",
-	info:		NULL,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_MIDI,
-	synth_subtype:	0,
-	open:		mpu_synth_open,
-	close:		mpu_synth_close,
-	ioctl:		mpu_synth_ioctl,
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
+	.id		= "MPU401",
+	.info		= NULL,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_MIDI,
+	.synth_subtype	= 0,
+	.open		= mpu_synth_open,
+	.close		= mpu_synth_close,
+	.ioctl		= mpu_synth_ioctl,
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
 
 static struct synth_operations *mpu401_synth_operations[MAX_MIDI_DEV];
 
 static struct midi_operations mpu401_midi_proto =
 {
-	owner:		THIS_MODULE,
-	info:		{"MPU-401 Midi", 0, MIDI_CAP_MPU401, SNDCARD_MPU401},
-	in_info:	{0},
-	open:		mpu401_open,
-	close:		mpu401_close,
-	ioctl:		mpu401_ioctl,
-	outputc:	mpu401_out,
-	start_read:	mpu401_start_read,
-	end_read:	mpu401_end_read,
-	kick:		mpu401_kick,
-	buffer_status:	mpu401_buffer_status,
-	prefix_cmd:	mpu401_prefix_cmd
+	.owner		= THIS_MODULE,
+	.info		= {"MPU-401 Midi", 0, MIDI_CAP_MPU401, SNDCARD_MPU401},
+	.in_info	= {0},
+	.open		= mpu401_open,
+	.close		= mpu401_close,
+	.ioctl		= mpu401_ioctl,
+	.outputc	= mpu401_out,
+	.start_read	= mpu401_start_read,
+	.end_read	= mpu401_end_read,
+	.kick		= mpu401_kick,
+	.buffer_status	= mpu401_buffer_status,
+	.prefix_cmd	= mpu401_prefix_cmd
 };
 
 static struct midi_operations mpu401_midi_operations[MAX_MIDI_DEV];
@@ -1619,16 +1619,16 @@
 
 static struct sound_timer_operations mpu_timer =
 {
-	owner:		THIS_MODULE,
-	info:		{"MPU-401 Timer", 0},
-	priority:	10,	/* Priority */
-	devlink:	0,	/* Local device link */
-	open:		mpu_timer_open,
-	close:		mpu_timer_close,
-	event:		mpu_timer_event,
-	get_time:	mpu_timer_get_time,
-	ioctl:		mpu_timer_ioctl,
-	arm_timer:	mpu_timer_arm
+	.owner		= THIS_MODULE,
+	.info		= {"MPU-401 Timer", 0},
+	.priority	= 10,	/* Priority */
+	.devlink	= 0,	/* Local device link */
+	.open		= mpu_timer_open,
+	.close		= mpu_timer_close,
+	.event		= mpu_timer_event,
+	.get_time	= mpu_timer_get_time,
+	.ioctl		= mpu_timer_ioctl,
+	.arm_timer	= mpu_timer_arm
 };
 
 static void mpu_timer_interrupt(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/msnd_pinnacle.c linux-2.5.67-ac1/sound/oss/msnd_pinnacle.c
--- linux-2.5.67/sound/oss/msnd_pinnacle.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/msnd_pinnacle.c	2003-04-03 23:52:57.000000000 +0100
@@ -40,7 +40,6 @@
 
 #include <linux/kernel.h>
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1081,12 +1080,12 @@
 }
 
 static struct file_operations dev_fileops = {
-	owner:		THIS_MODULE,
-	read:		dev_read,
-	write:		dev_write,
-	ioctl:		dev_ioctl,
-	open:		dev_open,
-	release:	dev_release,
+	.owner		= THIS_MODULE,
+	.read		= dev_read,
+	.write		= dev_write,
+	.ioctl		= dev_ioctl,
+	.open		= dev_open,
+	.release	= dev_release,
 };
 
 static int reset_dsp(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/nec_vrc5477.c linux-2.5.67-ac1/sound/oss/nec_vrc5477.c
--- linux-2.5.67/sound/oss/nec_vrc5477.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/nec_vrc5477.c	2003-04-03 23:52:57.000000000 +0100
@@ -61,7 +61,6 @@
  *    02.08.2001  0.1   Initial release
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -896,11 +895,11 @@
 }
 
 static /*const*/ struct file_operations vrc5477_ac97_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		vrc5477_ac97_ioctl_mixdev,
-	open:		vrc5477_ac97_open_mixdev,
-	release:	vrc5477_ac97_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= vrc5477_ac97_ioctl_mixdev,
+	.open		= vrc5477_ac97_open_mixdev,
+	.release	= vrc5477_ac97_release_mixdev,
 };
 
 /* --------------------------------------------------------------------- */
@@ -1658,15 +1657,15 @@
 }
 
 static /*const*/ struct file_operations vrc5477_ac97_audio_fops = {
-	owner:	THIS_MODULE,
-	llseek:		no_llseek,
-	read:		vrc5477_ac97_read,
-	write:		vrc5477_ac97_write,
-	poll:		vrc5477_ac97_poll,
-	ioctl:		vrc5477_ac97_ioctl,
-	// mmap:	vrc5477_ac97_mmap,
-	open:		vrc5477_ac97_open,
-	release:	vrc5477_ac97_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= vrc5477_ac97_read,
+	.write		= vrc5477_ac97_write,
+	.poll		= vrc5477_ac97_poll,
+	.ioctl		= vrc5477_ac97_ioctl,
+	// .mmap	= vrc5477_ac97_mmap,
+	.open		= vrc5477_ac97_open,
+	.release	= vrc5477_ac97_release,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/nm256_audio.c linux-2.5.67-ac1/sound/oss/nm256_audio.c
--- linux-2.5.67/sound/oss/nm256_audio.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/nm256_audio.c	2003-04-03 23:35:48.000000000 +0100
@@ -925,10 +925,10 @@
 }
 
 static struct mixer_operations nm256_mixer_operations = {
-    owner:	THIS_MODULE,
-    id:		"NeoMagic",
-    name:	"NM256AC97Mixer",
-    ioctl:	nm256_default_mixer_ioctl
+    .owner	= THIS_MODULE,
+    .id		= "NeoMagic",
+    .name	= "NM256AC97Mixer",
+    .ioctl	= nm256_default_mixer_ioctl
 };
 
 /*
@@ -1632,16 +1632,16 @@
 
 static struct audio_driver nm256_audio_driver =
 {
-    owner:		THIS_MODULE,
-    open:		nm256_audio_open,
-    close:		nm256_audio_close,
-    output_block:	nm256_audio_output_block,
-    start_input:	nm256_audio_start_input,
-    ioctl:		nm256_audio_ioctl,
-    prepare_for_input:	nm256_audio_prepare_for_input,
-    prepare_for_output:nm256_audio_prepare_for_output,
-    halt_io:		nm256_audio_reset,
-    local_qlen:		nm256_audio_local_qlen,
+    .owner		= THIS_MODULE,
+    .open		= nm256_audio_open,
+    .close		= nm256_audio_close,
+    .output_block	= nm256_audio_output_block,
+    .start_input	= nm256_audio_start_input,
+    .ioctl		= nm256_audio_ioctl,
+    .prepare_for_input	= nm256_audio_prepare_for_input,
+    .prepare_for_output	= nm256_audio_prepare_for_output,
+    .halt_io		= nm256_audio_reset,
+    .local_qlen		= nm256_audio_local_qlen,
 };
 
 static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/opl3.c linux-2.5.67-ac1/sound/oss/opl3.c
--- linux-2.5.67/sound/oss/opl3.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/opl3.c	2003-04-03 23:35:48.000000000 +0100
@@ -1078,28 +1078,28 @@
 
 static struct synth_operations opl3_operations =
 {
-	owner:		THIS_MODULE,
-	id:		"OPL",
-	info:		NULL,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_FM,
-	synth_subtype:	FM_TYPE_ADLIB,
-	open:		opl3_open,
-	close:		opl3_close,
-	ioctl:		opl3_ioctl,
-	kill_note:	opl3_kill_note,
-	start_note:	opl3_start_note,
-	set_instr:	opl3_set_instr,
-	reset:		opl3_reset,
-	hw_control:	opl3_hw_control,
-	load_patch:	opl3_load_patch,
-	aftertouch:	opl3_aftertouch,
-	controller:	opl3_controller,
-	panning:	opl3_panning,
-	volume_method:	opl3_volume_method,
-	bender:		opl3_bender,
-	alloc_voice:	opl3_alloc_voice,
-	setup_voice:	opl3_setup_voice
+	.owner		= THIS_MODULE,
+	.id		= "OPL",
+	.info		= NULL,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_FM,
+	.synth_subtype	= FM_TYPE_ADLIB,
+	.open		= opl3_open,
+	.close		= opl3_close,
+	.ioctl		= opl3_ioctl,
+	.kill_note	= opl3_kill_note,
+	.start_note	= opl3_start_note,
+	.set_instr	= opl3_set_instr,
+	.reset		= opl3_reset,
+	.hw_control	= opl3_hw_control,
+	.load_patch	= opl3_load_patch,
+	.aftertouch	= opl3_aftertouch,
+	.controller	= opl3_controller,
+	.panning	= opl3_panning,
+	.volume_method	= opl3_volume_method,
+	.bender		= opl3_bender,
+	.alloc_voice	= opl3_alloc_voice,
+	.setup_voice	= opl3_setup_voice
 };
 
 int opl3_init(int ioaddr, int *osp, struct module *owner)
