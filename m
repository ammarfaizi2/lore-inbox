Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbTDBSAH>; Wed, 2 Apr 2003 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbTDBSAH>; Wed, 2 Apr 2003 13:00:07 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:49798 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S263169AbTDBR54>; Wed, 2 Apr 2003 12:57:56 -0500
Date: Wed, 2 Apr 2003 20:09:18 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 Initializers for sound/oss [2.5.66]
Message-ID: <Pine.LNX.4.51.0304022008220.3564@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i converted the initializers to C99 for all the files in sound/oss.

41 patches total.

The diffs look like they are against 2.5.64, but that's just a directory
name. It's 2.5.66-bk7 actually.

Regards,
Maciej Soltysiak

diff -Nru linux-2.5.64.orig/sound/oss/ad1816.c linux-2.5.64/sound/oss/ad1816.c
--- linux-2.5.64.orig/sound/oss/ad1816.c	2003-03-05 04:29:35.000000000 +0100
+++ linux-2.5.64/sound/oss/ad1816.c	2003-04-02 17:40:41.000000000 +0200
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


diff -Nru linux-2.5.64.orig/sound/oss/ad1848.c linux-2.5.64/sound/oss/ad1848.c
--- linux-2.5.64.orig/sound/oss/ad1848.c	2003-03-05 04:29:24.000000000 +0100
+++ linux-2.5.64/sound/oss/ad1848.c	2003-04-02 17:42:30.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/awe_wave.c linux-2.5.64/sound/oss/awe_wave.c
--- linux-2.5.64.orig/sound/oss/awe_wave.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/awe_wave.c	2003-04-02 17:52:51.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/btaudio.c linux-2.5.64/sound/oss/btaudio.c
--- linux-2.5.64.orig/sound/oss/btaudio.c	2003-03-05 04:29:03.000000000 +0100
+++ linux-2.5.64/sound/oss/btaudio.c	2003-04-02 17:58:03.000000000 +0200
@@ -426,11 +426,11 @@
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
@@ -791,25 +791,25 @@
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
@@ -882,12 +882,12 @@

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

@@ -1062,31 +1062,31 @@

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
diff -Nru linux-2.5.64.orig/sound/oss/es1370.c linux-2.5.64/sound/oss/es1370.c
--- linux-2.5.64.orig/sound/oss/es1370.c	2003-03-05 04:29:54.000000000 +0100
+++ linux-2.5.64/sound/oss/es1370.c	2003-04-02 18:01:07.000000000 +0200
@@ -1054,11 +1054,11 @@
 }

 static /*const*/ struct file_operations es1370_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		es1370_ioctl_mixdev,
-	open:		es1370_open_mixdev,
-	release:	es1370_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= es1370_ioctl_mixdev,
+	.open		= es1370_open_mixdev,
+	.release	= es1370_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -1816,15 +1816,15 @@
 }

 static /*const*/ struct file_operations es1370_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1370_read,
-	write:		es1370_write,
-	poll:		es1370_poll,
-	ioctl:		es1370_ioctl,
-	mmap:		es1370_mmap,
-	open:		es1370_open,
-	release:	es1370_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1370_read,
+	.write		= es1370_write,
+	.poll		= es1370_poll,
+	.ioctl		= es1370_ioctl,
+	.mmap		= es1370_mmap,
+	.open		= es1370_open,
+	.release	= es1370_release,
 };

 /* --------------------------------------------------------------------- */
@@ -2240,14 +2240,14 @@
 }

 static /*const*/ struct file_operations es1370_dac_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	write:		es1370_write_dac,
-	poll:		es1370_poll_dac,
-	ioctl:		es1370_ioctl_dac,
-	mmap:		es1370_mmap_dac,
-	open:		es1370_open_dac,
-	release:	es1370_release_dac,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= es1370_write_dac,
+	.poll		= es1370_poll_dac,
+	.ioctl		= es1370_ioctl_dac,
+	.mmap		= es1370_mmap_dac,
+	.open		= es1370_open_dac,
+	.release	= es1370_release_dac,
 };

 /* --------------------------------------------------------------------- */
@@ -2513,13 +2513,13 @@
 }

 static /*const*/ struct file_operations es1370_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1370_midi_read,
-	write:		es1370_midi_write,
-	poll:		es1370_midi_poll,
-	open:		es1370_midi_open,
-	release:	es1370_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1370_midi_read,
+	.write		= es1370_midi_write,
+	.poll		= es1370_midi_poll,
+	.open		= es1370_midi_open,
+	.release	= es1370_midi_release,
 };

 /* --------------------------------------------------------------------- */
diff -Nru linux-2.5.64.orig/sound/oss/es1371.c linux-2.5.64/sound/oss/es1371.c
--- linux-2.5.64.orig/sound/oss/es1371.c	2003-03-05 04:29:32.000000000 +0100
+++ linux-2.5.64/sound/oss/es1371.c	2003-04-02 18:02:42.000000000 +0200
@@ -1243,11 +1243,11 @@
 }

 static /*const*/ struct file_operations es1371_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		es1371_ioctl_mixdev,
-	open:		es1371_open_mixdev,
-	release:	es1371_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= es1371_ioctl_mixdev,
+	.open		= es1371_open_mixdev,
+	.release	= es1371_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -2004,15 +2004,15 @@
 }

 static /*const*/ struct file_operations es1371_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1371_read,
-	write:		es1371_write,
-	poll:		es1371_poll,
-	ioctl:		es1371_ioctl,
-	mmap:		es1371_mmap,
-	open:		es1371_open,
-	release:	es1371_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1371_read,
+	.write		= es1371_write,
+	.poll		= es1371_poll,
+	.ioctl		= es1371_ioctl,
+	.mmap		= es1371_mmap,
+	.open		= es1371_open,
+	.release	= es1371_release,
 };

 /* --------------------------------------------------------------------- */
@@ -2418,14 +2418,14 @@
 }

 static /*const*/ struct file_operations es1371_dac_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	write:		es1371_write_dac,
-	poll:		es1371_poll_dac,
-	ioctl:		es1371_ioctl_dac,
-	mmap:		es1371_mmap_dac,
-	open:		es1371_open_dac,
-	release:	es1371_release_dac,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= es1371_write_dac,
+	.poll		= es1371_poll_dac,
+	.ioctl		= es1371_ioctl_dac,
+	.mmap		= es1371_mmap_dac,
+	.open		= es1371_open_dac,
+	.release	= es1371_release_dac,
 };

 /* --------------------------------------------------------------------- */
@@ -2690,13 +2690,13 @@
 }

 static /*const*/ struct file_operations es1371_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		es1371_midi_read,
-	write:		es1371_midi_write,
-	poll:		es1371_midi_poll,
-	open:		es1371_midi_open,
-	release:	es1371_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= es1371_midi_read,
+	.write		= es1371_midi_write,
+	.poll		= es1371_midi_poll,
+	.open		= es1371_midi_open,
+	.release	= es1371_midi_release,
 };

 /* --------------------------------------------------------------------- */
diff -Nru linux-2.5.64.orig/sound/oss/esssolo1.c linux-2.5.64/sound/oss/esssolo1.c
--- linux-2.5.64.orig/sound/oss/esssolo1.c	2003-03-05 04:28:59.000000000 +0100
+++ linux-2.5.64/sound/oss/esssolo1.c	2003-04-02 18:04:20.000000000 +0200
@@ -951,11 +951,11 @@
 }

 static /*const*/ struct file_operations solo1_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		solo1_ioctl_mixdev,
-	open:		solo1_open_mixdev,
-	release:	solo1_release_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= solo1_ioctl_mixdev,
+	.open		= solo1_open_mixdev,
+	.release	= solo1_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -1650,15 +1650,15 @@
 }

 static /*const*/ struct file_operations solo1_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		solo1_read,
-	write:		solo1_write,
-	poll:		solo1_poll,
-	ioctl:		solo1_ioctl,
-	mmap:		solo1_mmap,
-	open:		solo1_open,
-	release:	solo1_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= solo1_read,
+	.write		= solo1_write,
+	.poll		= solo1_poll,
+	.ioctl		= solo1_ioctl,
+	.mmap		= solo1_mmap,
+	.open		= solo1_open,
+	.release	= solo1_release,
 };

 /* --------------------------------------------------------------------- */
@@ -2001,13 +2001,13 @@
 }

 static /*const*/ struct file_operations solo1_midi_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		solo1_midi_read,
-	write:		solo1_midi_write,
-	poll:		solo1_midi_poll,
-	open:		solo1_midi_open,
-	release:	solo1_midi_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= solo1_midi_read,
+	.write		= solo1_midi_write,
+	.poll		= solo1_midi_poll,
+	.open		= solo1_midi_open,
+	.release	= solo1_midi_release,
 };

 /* --------------------------------------------------------------------- */
@@ -2189,11 +2189,11 @@
 }

 static /*const*/ struct file_operations solo1_dmfm_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		solo1_dmfm_ioctl,
-	open:		solo1_dmfm_open,
-	release:	solo1_dmfm_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= solo1_dmfm_ioctl,
+	.open		= solo1_dmfm_open,
+	.release	= solo1_dmfm_release,
 };

 /* --------------------------------------------------------------------- */
diff -Nru linux-2.5.64.orig/sound/oss/gus_midi.c linux-2.5.64/sound/oss/gus_midi.c
--- linux-2.5.64.orig/sound/oss/gus_midi.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/gus_midi.c	2003-04-02 18:08:05.000000000 +0200
@@ -188,17 +188,17 @@

 static struct midi_operations gus_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"Gravis UltraSound Midi", 0, 0, SNDCARD_GUS},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		gus_midi_open,
-	close:		gus_midi_close,
-	outputc:	gus_midi_out,
-	start_read:	gus_midi_start_read,
-	end_read:	gus_midi_end_read,
-	kick:		gus_midi_kick,
-	buffer_status:	gus_midi_buffer_status,
+	.owner		= THIS_MODULE,
+	.info		= {"Gravis UltraSound Midi", 0, 0, SNDCARD_GUS},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= gus_midi_open,
+	.close		= gus_midi_close,
+	.outputc	= gus_midi_out,
+	.start_read	= gus_midi_start_read,
+	.end_read	= gus_midi_end_read,
+	.kick		= gus_midi_kick,
+	.buffer_status	= gus_midi_buffer_status,
 };

 void __init gus_midi_init(struct address_info *hw_config)
diff -Nru linux-2.5.64.orig/sound/oss/gus_wave.c linux-2.5.64/sound/oss/gus_wave.c
--- linux-2.5.64.orig/sound/oss/gus_wave.c	2003-03-05 04:29:03.000000000 +0100
+++ linux-2.5.64/sound/oss/gus_wave.c	2003-04-02 18:11:29.000000000 +0200
@@ -2535,16 +2535,16 @@

 static struct audio_driver gus_audio_driver =
 {
-	owner:		THIS_MODULE,
-	open:		gus_audio_open,
-	close:		gus_audio_close,
-	output_block:	gus_audio_output_block,
-	start_input:	gus_audio_start_input,
-	ioctl:		gus_audio_ioctl,
-	prepare_for_input:	gus_audio_prepare_for_input,
-	prepare_for_output:	gus_audio_prepare_for_output,
-	halt_io:	gus_audio_reset,
-	local_qlen:	gus_local_qlen,
+	.owner			= THIS_MODULE,
+	.open			= gus_audio_open,
+	.close			= gus_audio_close,
+	.output_block		= gus_audio_output_block,
+	.start_input		= gus_audio_start_input,
+	.ioctl			= gus_audio_ioctl,
+	.prepare_for_input	= gus_audio_prepare_for_input,
+	.prepare_for_output	= gus_audio_prepare_for_output,
+	.halt_io		= gus_audio_reset,
+	.local_qlen		= gus_local_qlen,
 };

 static void guswave_setup_voice(int dev, int voice, int chn)
@@ -2623,28 +2623,28 @@

 static struct synth_operations guswave_operations =
 {
-	owner:		THIS_MODULE,
-	id:		"GUS",
-	info:		&gus_info,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_SAMPLE,
-	synth_subtype:	SAMPLE_TYPE_GUS,
-	open:		guswave_open,
-	close:		guswave_close,
-	ioctl:		guswave_ioctl,
-	kill_note:	guswave_kill_note,
-	start_note:	guswave_start_note,
-	set_instr:	guswave_set_instr,
-	reset:		guswave_reset,
-	hw_control:	guswave_hw_control,
-	load_patch:	guswave_load_patch,
-	aftertouch:	guswave_aftertouch,
-	controller:	guswave_controller,
-	panning:	guswave_panning,
-	volume_method:	guswave_volume_method,
-	bender:		guswave_bender,
-	alloc_voice:	guswave_alloc,
-	setup_voice:	guswave_setup_voice
+	.owner		= THIS_MODULE,
+	.id		= "GUS",
+	.info		= &gus_info,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_SAMPLE,
+	.synth_subtype	= SAMPLE_TYPE_GUS,
+	.open		= guswave_open,
+	.close		= guswave_close,
+	.ioctl		= guswave_ioctl,
+	.kill_note	= guswave_kill_note,
+	.start_note	= guswave_start_note,
+	.set_instr	= guswave_set_instr,
+	.reset		= guswave_reset,
+	.hw_control	= guswave_hw_control,
+	.load_patch	= guswave_load_patch,
+	.aftertouch	= guswave_aftertouch,
+	.controller	= guswave_controller,
+	.panning	= guswave_panning,
+	.volume_method	= guswave_volume_method,
+	.bender		= guswave_bender,
+	.alloc_voice	= guswave_alloc,
+	.setup_voice	= guswave_setup_voice
 };

 static void set_input_volumes(void)
@@ -2815,10 +2815,10 @@

 static struct mixer_operations gus_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"GUS",
-	name:	"Gravis Ultrasound",
-	ioctl:	gus_default_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "GUS",
+	.name	= "Gravis Ultrasound",
+	.ioctl	= gus_default_mixer_ioctl
 };

 static int __init gus_default_mixer_init(void)
diff -Nru linux-2.5.64.orig/sound/oss/i810_audio.c linux-2.5.64/sound/oss/i810_audio.c
--- linux-2.5.64.orig/sound/oss/i810_audio.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/i810_audio.c	2003-04-02 17:35:34.000000000 +0200
@@ -2554,15 +2554,15 @@
 }

 static /*const*/ struct file_operations i810_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		i810_read,
-	write:		i810_write,
-	poll:		i810_poll,
-	ioctl:		i810_ioctl,
-	mmap:		i810_mmap,
-	open:		i810_open,
-	release:	i810_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= i810_read,
+	.write		= i810_write,
+	.poll		= i810_poll,
+	.ioctl		= i810_ioctl,
+	.mmap		= i810_mmap,
+	.open		= i810_open,
+	.release	= i810_release,
 };

 /* Write AC97 codec registers */
@@ -2690,10 +2690,10 @@
 }

 static /*const*/ struct file_operations i810_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		i810_ioctl_mixdev,
-	open:		i810_open_mixdev,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= i810_ioctl_mixdev,
+	.open		= i810_open_mixdev,
 };

 /* AC97 codec initialisation.  These small functions exist so we don't
@@ -3430,13 +3430,13 @@
 #define I810_MODULE_NAME "intel810_audio"

 static struct pci_driver i810_pci_driver = {
-	name:		I810_MODULE_NAME,
-	id_table:	i810_pci_tbl,
-	probe:		i810_probe,
-	remove:		__devexit_p(i810_remove),
+	.name		= I810_MODULE_NAME,
+	.id_table	= i810_pci_tbl,
+	.probe		= i810_probe,
+	.remove		= __devexit_p(i810_remove),
 #ifdef CONFIG_PM
-	suspend:	i810_pm_suspend,
-	resume:		i810_pm_resume,
+	.suspend	= i810_pm_suspend,
+	.resume		= i810_pm_resume,
 #endif /* CONFIG_PM */
 };

diff -Nru linux-2.5.64.orig/sound/oss/ics2101.c linux-2.5.64/sound/oss/ics2101.c
--- linux-2.5.64.orig/sound/oss/ics2101.c	2003-03-05 04:29:00.000000000 +0100
+++ linux-2.5.64/sound/oss/ics2101.c	2003-04-02 18:12:38.000000000 +0200
@@ -209,10 +209,10 @@

 static struct mixer_operations ics2101_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"ICS2101",
-	name:	"ICS2101 Multimedia Mixer",
-	ioctl:	ics2101_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "ICS2101",
+	.name	= "ICS2101 Multimedia Mixer",
+	.ioctl	= ics2101_mixer_ioctl
 };

 int __init ics2101_mixer_init(void)
diff -Nru linux-2.5.64.orig/sound/oss/ite8172.c linux-2.5.64/sound/oss/ite8172.c
--- linux-2.5.64.orig/sound/oss/ite8172.c	2003-03-05 04:29:02.000000000 +0100
+++ linux-2.5.64/sound/oss/ite8172.c	2003-04-02 18:13:13.000000000 +0200
@@ -863,11 +863,11 @@
 }

 static /*const*/ struct file_operations it8172_mixer_fops = {
-    owner:	THIS_MODULE,
-    llseek:	no_llseek,
-    ioctl:	it8172_ioctl_mixdev,
-    open:	it8172_open_mixdev,
-    release:	it8172_release_mixdev,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .ioctl	= it8172_ioctl_mixdev,
+    .open	= it8172_open_mixdev,
+    .release	= it8172_release_mixdev,
 };

 /* --------------------------------------------------------------------- */
@@ -1630,15 +1630,15 @@
 }

 static /*const*/ struct file_operations it8172_audio_fops = {
-    owner:	THIS_MODULE,
-    llseek:	no_llseek,
-    read:	it8172_read,
-    write:	it8172_write,
-    poll:	it8172_poll,
-    ioctl:	it8172_ioctl,
-    mmap:	it8172_mmap,
-    open:	it8172_open,
-    release:	it8172_release,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .read	= it8172_read,
+    .write	= it8172_write,
+    .poll	= it8172_poll,
+    .ioctl	= it8172_ioctl,
+    .mmap	= it8172_mmap,
+    .open	= it8172_open,
+    .release	= it8172_release,
 };


diff -Nru linux-2.5.64.orig/sound/oss/maestro.c linux-2.5.64/sound/oss/maestro.c
--- linux-2.5.64.orig/sound/oss/maestro.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/maestro.c	2003-04-02 18:15:26.000000000 +0200
@@ -2170,11 +2170,11 @@
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
@@ -3106,15 +3106,15 @@
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
diff -Nru linux-2.5.64.orig/sound/oss/midi_synth.h linux-2.5.64/sound/oss/midi_synth.h
--- linux-2.5.64.orig/sound/oss/midi_synth.h	2003-03-05 04:29:02.000000000 +0100
+++ linux-2.5.64/sound/oss/midi_synth.h	2003-04-02 18:17:39.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/mpu401.c linux-2.5.64/sound/oss/mpu401.c
--- linux-2.5.64.orig/sound/oss/mpu401.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/mpu401.c	2003-04-02 18:19:20.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/msnd_pinnacle.c linux-2.5.64/sound/oss/msnd_pinnacle.c
--- linux-2.5.64.orig/sound/oss/msnd_pinnacle.c	2003-03-05 04:29:24.000000000 +0100
+++ linux-2.5.64/sound/oss/msnd_pinnacle.c	2003-04-02 18:21:01.000000000 +0200
@@ -1081,12 +1081,12 @@
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
diff -Nru linux-2.5.64.orig/sound/oss/nec_vrc5477.c linux-2.5.64/sound/oss/nec_vrc5477.c
--- linux-2.5.64.orig/sound/oss/nec_vrc5477.c	2003-03-05 04:29:32.000000000 +0100
+++ linux-2.5.64/sound/oss/nec_vrc5477.c	2003-04-02 18:22:15.000000000 +0200
@@ -896,11 +896,11 @@
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
@@ -1658,15 +1658,15 @@
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


diff -Nru linux-2.5.64.orig/sound/oss/nm256_audio.c linux-2.5.64/sound/oss/nm256_audio.c
--- linux-2.5.64.orig/sound/oss/nm256_audio.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/nm256_audio.c	2003-04-02 18:23:27.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/opl3.c linux-2.5.64/sound/oss/opl3.c
--- linux-2.5.64.orig/sound/oss/opl3.c	2003-03-05 04:29:21.000000000 +0100
+++ linux-2.5.64/sound/oss/opl3.c	2003-04-02 18:29:47.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/opl3sa2.c linux-2.5.64/sound/oss/opl3sa2.c
--- linux-2.5.64.orig/sound/oss/opl3sa2.c	2003-04-02 19:12:25.000000000 +0200
+++ linux-2.5.64/sound/oss/opl3sa2.c	2003-04-02 18:30:26.000000000 +0200
@@ -557,18 +557,18 @@

 static struct mixer_operations opl3sa2_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"OPL3-SA2",
-	name:	"Yamaha OPL3-SA2",
-	ioctl:	opl3sa2_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "OPL3-SA2",
+	.name	= "Yamaha OPL3-SA2",
+	.ioctl	= opl3sa2_mixer_ioctl
 };

 static struct mixer_operations opl3sa3_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"OPL3-SA3",
-	name:	"Yamaha OPL3-SA3",
-	ioctl:	opl3sa3_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "OPL3-SA3",
+	.name	= "Yamaha OPL3-SA3",
+	.ioctl	= opl3sa3_mixer_ioctl
 };

 /* End of mixer-related stuff */
diff -Nru linux-2.5.64.orig/sound/oss/pas2_midi.c linux-2.5.64/sound/oss/pas2_midi.c
--- linux-2.5.64.orig/sound/oss/pas2_midi.c	2003-03-05 04:29:31.000000000 +0100
+++ linux-2.5.64/sound/oss/pas2_midi.c	2003-04-02 18:46:19.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/pas2_mixer.c linux-2.5.64/sound/oss/pas2_mixer.c
--- linux-2.5.64.orig/sound/oss/pas2_mixer.c	2003-03-05 04:29:16.000000000 +0100
+++ linux-2.5.64/sound/oss/pas2_mixer.c	2003-04-02 18:47:13.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/pas2_pcm.c linux-2.5.64/sound/oss/pas2_pcm.c
--- linux-2.5.64.orig/sound/oss/pas2_pcm.c	2003-03-05 04:29:03.000000000 +0100
+++ linux-2.5.64/sound/oss/pas2_pcm.c	2003-04-02 18:48:02.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/pss.c linux-2.5.64/sound/oss/pss.c
--- linux-2.5.64.orig/sound/oss/pss.c	2003-03-05 04:29:56.000000000 +0100
+++ linux-2.5.64/sound/oss/pss.c	2003-04-02 18:44:36.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sb_audio.c linux-2.5.64/sound/oss/sb_audio.c
--- linux-2.5.64.orig/sound/oss/sb_audio.c	2003-03-05 04:29:33.000000000 +0100
+++ linux-2.5.64/sound/oss/sb_audio.c	2003-04-02 18:50:56.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sb_ess.c linux-2.5.64/sound/oss/sb_ess.c
--- linux-2.5.64.orig/sound/oss/sb_ess.c	2003-03-05 04:29:16.000000000 +0100
+++ linux-2.5.64/sound/oss/sb_ess.c	2003-04-02 18:52:29.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sb_midi.c linux-2.5.64/sound/oss/sb_midi.c
--- linux-2.5.64.orig/sound/oss/sb_midi.c	2003-03-05 04:28:53.000000000 +0100
+++ linux-2.5.64/sound/oss/sb_midi.c	2003-04-02 18:52:59.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sb_mixer.c linux-2.5.64/sound/oss/sb_mixer.c
--- linux-2.5.64.orig/sound/oss/sb_mixer.c	2003-03-05 04:29:01.000000000 +0100
+++ linux-2.5.64/sound/oss/sb_mixer.c	2003-04-02 18:53:37.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sonicvibes.c linux-2.5.64/sound/oss/sonicvibes.c
--- linux-2.5.64.orig/sound/oss/sonicvibes.c	2003-03-05 04:29:17.000000000 +0100
+++ linux-2.5.64/sound/oss/sonicvibes.c	2003-04-02 18:54:27.000000000 +0200
@@ -1267,11 +1267,11 @@
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
@@ -1978,15 +1978,15 @@
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
@@ -2260,13 +2260,13 @@
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
@@ -2435,11 +2435,11 @@
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
diff -Nru linux-2.5.64.orig/sound/oss/soundcard.c linux-2.5.64/sound/oss/soundcard.c
--- linux-2.5.64.orig/sound/oss/soundcard.c	2003-03-05 04:29:18.000000000 +0100
+++ linux-2.5.64/sound/oss/soundcard.c	2003-04-02 18:55:09.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/sys_timer.c linux-2.5.64/sound/oss/sys_timer.c
--- linux-2.5.64.orig/sound/oss/sys_timer.c	2003-03-05 04:29:18.000000000 +0100
+++ linux-2.5.64/sound/oss/sys_timer.c	2003-04-02 18:28:29.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/trident.c linux-2.5.64/sound/oss/trident.c
--- linux-2.5.64.orig/sound/oss/trident.c	2003-04-02 19:11:57.000000000 +0200
+++ linux-2.5.64/sound/oss/trident.c	2003-04-02 18:56:46.000000000 +0200
@@ -2772,15 +2772,15 @@
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
@@ -3894,10 +3894,10 @@
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
@@ -4376,12 +4376,12 @@
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
diff -Nru linux-2.5.64.orig/sound/oss/uart401.c linux-2.5.64/sound/oss/uart401.c
--- linux-2.5.64.orig/sound/oss/uart401.c	2003-03-05 04:29:34.000000000 +0100
+++ linux-2.5.64/sound/oss/uart401.c	2003-04-02 18:57:29.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/uart6850.c linux-2.5.64/sound/oss/uart6850.c
--- linux-2.5.64.orig/sound/oss/uart6850.c	2003-03-05 04:29:24.000000000 +0100
+++ linux-2.5.64/sound/oss/uart6850.c	2003-04-02 18:58:20.000000000 +0200
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


diff -Nru linux-2.5.64.orig/sound/oss/v_midi.c linux-2.5.64/sound/oss/v_midi.c
--- linux-2.5.64.orig/sound/oss/v_midi.c	2003-03-05 04:29:02.000000000 +0100
+++ linux-2.5.64/sound/oss/v_midi.c	2003-04-02 18:59:04.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/via82cxxx_audio.c linux-2.5.64/sound/oss/via82cxxx_audio.c
--- linux-2.5.64.orig/sound/oss/via82cxxx_audio.c	2003-03-05 04:29:04.000000000 +0100
+++ linux-2.5.64/sound/oss/via82cxxx_audio.c	2003-04-02 19:00:06.000000000 +0200
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
+	.llseek: 	no_llseek,
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

diff -Nru linux-2.5.64.orig/sound/oss/vidc.c linux-2.5.64/sound/oss/vidc.c
--- linux-2.5.64.orig/sound/oss/vidc.c	2003-03-05 04:28:58.000000000 +0100
+++ linux-2.5.64/sound/oss/vidc.c	2003-04-02 19:01:13.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/waveartist.c linux-2.5.64/sound/oss/waveartist.c
--- linux-2.5.64.orig/sound/oss/waveartist.c	2003-03-05 04:29:15.000000000 +0100
+++ linux-2.5.64/sound/oss/waveartist.c	2003-04-02 19:03:01.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/wavfront.c linux-2.5.64/sound/oss/wavfront.c
--- linux-2.5.64.orig/sound/oss/wavfront.c	2003-03-05 04:29:22.000000000 +0100
+++ linux-2.5.64/sound/oss/wavfront.c	2003-04-02 18:27:24.000000000 +0200
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

diff -Nru linux-2.5.64.orig/sound/oss/wf_midi.c linux-2.5.64/sound/oss/wf_midi.c
--- linux-2.5.64.orig/sound/oss/wf_midi.c	2003-03-05 04:28:58.000000000 +0100
+++ linux-2.5.64/sound/oss/wf_midi.c	2003-04-02 18:26:21.000000000 +0200
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
diff -Nru linux-2.5.64.orig/sound/oss/ymfpci.c linux-2.5.64/sound/oss/ymfpci.c
--- linux-2.5.64.orig/sound/oss/ymfpci.c	2003-03-05 04:29:24.000000000 +0100
+++ linux-2.5.64/sound/oss/ymfpci.c	2003-04-02 18:24:56.000000000 +0200
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
