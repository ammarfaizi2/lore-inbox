Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbTDGXeQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTDGXbk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:31:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17537
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263744AbTDGXUs (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:20:48 -0400
Date: Tue, 8 Apr 2003 01:39:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080039.h380dcPp009300@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: C99 for sound
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ad1816.c linux-2.5.67-ac1/sound/oss/ad1816.c
--- linux-2.5.67/sound/oss/ad1816.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ad1816.c	2003-04-03 23:35:48.000000000 +0100
@@ -518,20 +518,20 @@
 
 static struct audio_driver ad1816_audio_driver =
 {
-	owner:		THIS_MODULE,
-	open:		ad1816_open,
-	close:		ad1816_close,
-	output_block:	ad1816_output_block,
-	start_input:	ad1816_start_input,
-	prepare_for_input:	ad1816_prepare_for_input,
-	prepare_for_output:	ad1816_prepare_for_output,
-	halt_io:		ad1816_halt,
-	halt_input:	ad1816_halt_input,
-	halt_output:	ad1816_halt_output,
-	trigger:	ad1816_trigger,
-	set_speed:	ad1816_set_speed,
-	set_bits:	ad1816_set_bits,
-	set_channels:	ad1816_set_channels,
+	.owner			= THIS_MODULE,
+	.open			= ad1816_open,
+	.close			= ad1816_close,
+	.output_block		= ad1816_output_block,
+	.start_input		= ad1816_start_input,
+	.prepare_for_input	= ad1816_prepare_for_input,
+	.prepare_for_output	= ad1816_prepare_for_output,
+	.halt_io		= ad1816_halt,
+	.halt_input		= ad1816_halt_input,
+	.halt_output		= ad1816_halt_output,
+	.trigger		= ad1816_trigger,
+	.set_speed		= ad1816_set_speed,
+	.set_bits		= ad1816_set_bits,
+	.set_channels		= ad1816_set_channels,
 };
 
 
@@ -970,10 +970,10 @@
 /* Mixer structure */
 
 static struct mixer_operations ad1816_mixer_operations = {
-	owner:	THIS_MODULE,
-	id:	"AD1816",
-	name:	"AD1816 Mixer",
-	ioctl:	ad1816_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "AD1816",
+	.name	= "AD1816 Mixer",
+	.ioctl	= ad1816_mixer_ioctl
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/ad1848.c linux-2.5.67-ac1/sound/oss/ad1848.c
--- linux-2.5.67/sound/oss/ad1848.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/ad1848.c	2003-04-03 23:35:48.000000000 +0100
@@ -943,28 +943,28 @@
 
 static struct audio_driver ad1848_audio_driver =
 {
-	owner:		THIS_MODULE,
-	open:		ad1848_open,
-	close:		ad1848_close,
-	output_block:	ad1848_output_block,
-	start_input:	ad1848_start_input,
-	prepare_for_input:	ad1848_prepare_for_input,
-	prepare_for_output:	ad1848_prepare_for_output,
-	halt_io:	ad1848_halt,
-	halt_input:	ad1848_halt_input,
-	halt_output:	ad1848_halt_output,
-	trigger:	ad1848_trigger,
-	set_speed:	ad1848_set_speed,
-	set_bits:	ad1848_set_bits,
-	set_channels:	ad1848_set_channels
+	.owner			= THIS_MODULE,
+	.open			= ad1848_open,
+	.close			= ad1848_close,
+	.output_block		= ad1848_output_block,
+	.start_input		= ad1848_start_input,
+	.prepare_for_input	= ad1848_prepare_for_input,
+	.prepare_for_output	= ad1848_prepare_for_output,
+	.halt_io		= ad1848_halt,
+	.halt_input		= ad1848_halt_input,
+	.halt_output		= ad1848_halt_output,
+	.trigger		= ad1848_trigger,
+	.set_speed		= ad1848_set_speed,
+	.set_bits		= ad1848_set_bits,
+	.set_channels		= ad1848_set_channels
 };
 
 static struct mixer_operations ad1848_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"SOUNDPORT",
-	name:	"AD1848/CS4248/CS4231",
-	ioctl:	ad1848_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "SOUNDPORT",
+	.name	= "AD1848/CS4248/CS4231",
+	.ioctl	= ad1848_mixer_ioctl
 };
 
 static int ad1848_open(int dev, int mode)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/awe_wave.c linux-2.5.67-ac1/sound/oss/awe_wave.c
--- linux-2.5.67/sound/oss/awe_wave.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/awe_wave.c	2003-04-03 23:35:48.000000000 +0100
@@ -493,28 +493,28 @@
 
 static struct synth_operations awe_operations =
 {
-	owner:		THIS_MODULE,
-	id:		"EMU8K",
-	info:		&awe_info,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_SAMPLE,
-	synth_subtype:	SAMPLE_TYPE_AWE32,
-	open:		awe_open,
-	close:		awe_close,
-	ioctl:		awe_ioctl,
-	kill_note:	awe_kill_note,
-	start_note:	awe_start_note,
-	set_instr:	awe_set_instr_2,
-	reset:		awe_reset,
-	hw_control:	awe_hw_control,
-	load_patch:	awe_load_patch,
-	aftertouch:	awe_aftertouch,
-	controller:	awe_controller,
-	panning:	awe_panning,
-	volume_method:	awe_volume_method,
-	bender:		awe_bender,
-	alloc_voice:	awe_alloc,
-	setup_voice:	awe_setup_voice
+	.owner		= THIS_MODULE,
+	.id		= "EMU8K",
+	.info		= &awe_info,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_SAMPLE,
+	.synth_subtype	= SAMPLE_TYPE_AWE32,
+	.open		= awe_open,
+	.close		= awe_close,
+	.ioctl		= awe_ioctl,
+	.kill_note	= awe_kill_note,
+	.start_note	= awe_start_note,
+	.set_instr	= awe_set_instr_2,
+	.reset		= awe_reset,
+	.hw_control	= awe_hw_control,
+	.load_patch	= awe_load_patch,
+	.aftertouch	= awe_aftertouch,
+	.controller	= awe_controller,
+	.panning	= awe_panning,
+	.volume_method	= awe_volume_method,
+	.bender		= awe_bender,
+	.alloc_voice	= awe_alloc,
+	.setup_voice	= awe_setup_voice
 };
 
 
@@ -4287,10 +4287,10 @@
 static int my_mixerdev = -1;
 
 static struct mixer_operations awe_mixer_operations = {
-	owner:	THIS_MODULE,
-	id:	"AWE",
-	name:	"AWE32 Equalizer",
-	ioctl:	awe_mixer_ioctl,
+	.owner	= THIS_MODULE,
+	.id	= "AWE",
+	.name	= "AWE32 Equalizer",
+	.ioctl	= awe_mixer_ioctl,
 };
 
 static void __init attach_mixer(void)
@@ -5232,13 +5232,13 @@
 
 static struct midi_operations awe_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"AWE Midi Emu", 0, 0, SNDCARD_SB},
-	in_info:	{0},
-	open:		awe_midi_open, /*open*/
-	close:		awe_midi_close, /*close*/
-	ioctl:		awe_midi_ioctl, /*ioctl*/
-	outputc:	awe_midi_outputc, /*outputc*/
+	.owner		= THIS_MODULE,
+	.info		= {"AWE Midi Emu", 0, 0, SNDCARD_SB},
+	.in_info	= {0},
+	.open		= awe_midi_open, /*open*/
+	.close		= awe_midi_close, /*close*/
+	.ioctl		= awe_midi_ioctl, /*ioctl*/
+	.outputc	= awe_midi_outputc, /*outputc*/
 };
 
 static int my_mididev = -1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/btaudio.c linux-2.5.67-ac1/sound/oss/btaudio.c
--- linux-2.5.67/sound/oss/btaudio.c	2003-02-10 18:38:04.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/btaudio.c	2003-04-03 23:52:57.000000000 +0100
@@ -19,7 +19,6 @@
 
 */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
@@ -426,11 +425,11 @@
 }
 
 static struct file_operations btaudio_mixer_fops = {
-	owner:   THIS_MODULE,
-	llseek:  no_llseek,
-	open:    btaudio_mixer_open,
-	release: btaudio_mixer_release,
-	ioctl:   btaudio_mixer_ioctl,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= btaudio_mixer_open,
+	.release	= btaudio_mixer_release,
+	.ioctl		= btaudio_mixer_ioctl,
 };
 
 /* -------------------------------------------------------------- */
@@ -791,25 +790,25 @@
 }
 
 static struct file_operations btaudio_digital_dsp_fops = {
-	owner:   THIS_MODULE,
-	llseek:  no_llseek,
-	open:    btaudio_dsp_open_digital,
-	release: btaudio_dsp_release,
-	read:    btaudio_dsp_read,
-	write:   btaudio_dsp_write,
-	ioctl:   btaudio_dsp_ioctl,
-	poll:    btaudio_dsp_poll,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= btaudio_dsp_open_digital,
+	.release	= btaudio_dsp_release,
+	.read		= btaudio_dsp_read,
+	.write		= btaudio_dsp_write,
+	.ioctl		= btaudio_dsp_ioctl,
+	.poll		= btaudio_dsp_poll,
 };
 
 static struct file_operations btaudio_analog_dsp_fops = {
-	owner:   THIS_MODULE,
-	llseek:  no_llseek,
-	open:    btaudio_dsp_open_analog,
-	release: btaudio_dsp_release,
-	read:    btaudio_dsp_read,
-	write:   btaudio_dsp_write,
-	ioctl:   btaudio_dsp_ioctl,
-	poll:    btaudio_dsp_poll,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= btaudio_dsp_open_analog,
+	.release	= btaudio_dsp_release,
+	.read		= btaudio_dsp_read,
+	.write		= btaudio_dsp_write,
+	.ioctl		= btaudio_dsp_ioctl,
+	.poll		= btaudio_dsp_poll,
 };
 
 /* -------------------------------------------------------------- */
@@ -882,12 +881,12 @@
 
 static struct cardinfo cards[] = {
 	[0] = {
-		name: "default",
-		rate: 32000,
+		.name	= "default",
+		.rate	= 32000,
 	},
 	[BTA_OSPREY200] = {
-		name: "Osprey 200",
-		rate: 44100,
+		.name	= "Osprey 200",
+		.rate	= 44100,
 	},
 };
 
@@ -1062,31 +1061,31 @@
 
 static struct pci_device_id btaudio_pci_tbl[] __devinitdata = {
         {
-		vendor:       PCI_VENDOR_ID_BROOKTREE,
-		device:       0x0878,
-		subvendor:    0x0070,
-		subdevice:    0xff01,
-		driver_data:  BTA_OSPREY200,
+		.vendor		= PCI_VENDOR_ID_BROOKTREE,
+		.device		= 0x0878,
+		.subvendor	= 0x0070,
+		.subdevice	= 0xff01,
+		.driver_data	= BTA_OSPREY200,
 	},{
-		vendor:       PCI_VENDOR_ID_BROOKTREE,
-		device:       0x0878,
-		subvendor:    PCI_ANY_ID,
-		subdevice:    PCI_ANY_ID,
+		.vendor		= PCI_VENDOR_ID_BROOKTREE,
+		.device		= 0x0878,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 	},{
-		vendor:       PCI_VENDOR_ID_BROOKTREE,
-		device:       0x0878,
-		subvendor:    PCI_ANY_ID,
-		subdevice:    PCI_ANY_ID,
+		.vendor		= PCI_VENDOR_ID_BROOKTREE,
+		.device		= 0x0878,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
         },{
 		/* --- end of list --- */
 	}
 };
 
 static struct pci_driver btaudio_pci_driver = {
-        name:     "btaudio",
-        id_table: btaudio_pci_tbl,
-        probe:    btaudio_probe,
-        remove:   __devexit_p(btaudio_remove),
+        .name		= "btaudio",
+        .id_table	= btaudio_pci_tbl,
+        .probe		= btaudio_probe,
+        .remove		=  __devexit_p(btaudio_remove),
 };
 
 static int btaudio_init_module(void)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/cmpci.c linux-2.5.67-ac1/sound/oss/cmpci.c
--- linux-2.5.67/sound/oss/cmpci.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/cmpci.c	2003-04-03 23:52:57.000000000 +0100
@@ -87,7 +87,6 @@
  */
 /*****************************************************************************/
       
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
