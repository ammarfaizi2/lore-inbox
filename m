Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTDKM6Y (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTDKM6Y (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:58:24 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:47111 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264341AbTDKM6L (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 08:58:11 -0400
Date: Fri, 11 Apr 2003 08:09:49 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializer cleanup for sound/oss
Message-ID: <20030411130949.GA11887@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The latest Linus BK has added C99 initializers to many of the files in
sound/oss. A few files were missed or not completely converted. Here is
a small patchset that fixes the missed conversions I found.

Art Haas

===== sound/oss/es1370.c 1.20 vs edited =====
--- 1.20/sound/oss/es1370.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/es1370.c	Thu Apr 10 20:27:05 2003
@@ -2731,10 +2731,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver es1370_driver = {
-	name: "es1370",
-	id_table: id_table,
-	probe: es1370_probe,
-	remove: es1370_remove
+	.name		= "es1370",
+	.id_table	= id_table,
+	.probe		= es1370_probe,
+	.remove		= es1370_remove,
 };
 
 static int __init init_es1370(void)
===== sound/oss/aci.c 1.7 vs edited =====
--- 1.7/sound/oss/aci.c	Sun Feb 10 20:50:07 2002
+++ edited/sound/oss/aci.c	Thu Apr 10 20:22:33 2003
@@ -584,9 +584,9 @@
 
 static struct mixer_operations aci_mixer_operations =
 {
-	owner: THIS_MODULE,
-	id:    "ACI",
-	ioctl: aci_mixer_ioctl
+	.owner = THIS_MODULE,
+	.id    = "ACI",
+	.ioctl = aci_mixer_ioctl
 };
 
 /*
===== sound/oss/nec_vrc5477.c 1.10 vs edited =====
--- 1.10/sound/oss/nec_vrc5477.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/nec_vrc5477.c	Thu Apr 10 20:35:16 2003
@@ -1994,10 +1994,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver vrc5477_ac97_driver = {
-	name: VRC5477_AC97_MODULE_NAME,
-	id_table: id_table,
-	probe: vrc5477_ac97_probe,
-	remove: vrc5477_ac97_remove
+	.name		= VRC5477_AC97_MODULE_NAME,
+	.id_table	= id_table,
+	.probe		= vrc5477_ac97_probe,
+	.remove		= vrc5477_ac97_remove,
 };
 
 static int __init init_vrc5477_ac97(void)
===== sound/oss/ite8172.c 1.11 vs edited =====
--- 1.11/sound/oss/ite8172.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/ite8172.c	Thu Apr 10 20:32:47 2003
@@ -1930,10 +1930,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver it8172_driver = {
-    name: IT8172_MODULE_NAME,
-    id_table: id_table,
-    probe: it8172_probe,
-    remove: it8172_remove
+	.name		= IT8172_MODULE_NAME,
+	.id_table	= id_table,
+	.probe		= it8172_probe,
+	.remove		= it8172_remove,
 };
 
 static int __init init_it8172(void)
===== sound/oss/esssolo1.c 1.22 vs edited =====
--- 1.22/sound/oss/esssolo1.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/esssolo1.c	Thu Apr 10 20:29:29 2003
@@ -2448,12 +2448,12 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver solo1_driver = {
-	name: "ESS Solo1",
-	id_table: id_table,
-	probe: solo1_probe,
-	remove: solo1_remove,
-	suspend: solo1_suspend,
-	resume: solo1_resume
+	.name		= "ESS Solo1",
+	.id_table	= id_table,
+	.probe		= solo1_probe,
+	.remove		= solo1_remove,
+	.suspend	= solo1_suspend,
+	.resume		= solo1_resume,
 };
 
 
===== sound/oss/es1371.c 1.22 vs edited =====
--- 1.22/sound/oss/es1371.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/es1371.c	Thu Apr 10 20:28:08 2003
@@ -3035,10 +3035,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver es1371_driver = {
-	name: "es1371",
-	id_table: id_table,
-	probe: es1371_probe,
-	remove: es1371_remove
+	.name		= "es1371",
+	.id_table	= id_table,
+	.probe		= es1371_probe,
+	.remove		= es1371_remove,
 };
 
 static int __init init_es1371(void)
===== sound/oss/sound_timer.c 1.3 vs edited =====
--- 1.3/sound/oss/sound_timer.c	Thu Aug 15 09:20:44 2002
+++ edited/sound/oss/sound_timer.c	Thu Apr 10 20:42:40 2003
@@ -264,16 +264,16 @@
 
 static struct sound_timer_operations sound_timer =
 {
-	owner:		THIS_MODULE,
-	info:		{"Sound Timer", 0},
-	priority:	1,	/* Priority */
-	devlink:	0,	/* Local device link */
-	open:		timer_open,
-	close:		timer_close,
-	event:		timer_event,
-	get_time:	timer_get_time,
-	ioctl:		timer_ioctl,
-	arm_timer:	timer_arm
+	.owner		= THIS_MODULE,
+	.info		= {"Sound Timer", 0},
+	.priority	= 1,	/* Priority */
+	.devlink	= 0,	/* Local device link */
+	.open		= timer_open,
+	.close		= timer_close,
+	.event		= timer_event,
+	.get_time	= timer_get_time,
+	.ioctl		= timer_ioctl,
+	.arm_timer	= timer_arm
 };
 
 void sound_timer_interrupt(void)
===== sound/oss/sonicvibes.c 1.17 vs edited =====
--- 1.17/sound/oss/sonicvibes.c	Thu Apr  3 16:52:57 2003
+++ edited/sound/oss/sonicvibes.c	Thu Apr 10 20:42:09 2003
@@ -2715,10 +2715,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver sv_driver = {
-       name: "sonicvibes",
-       id_table: id_table,
-       probe: sv_probe,
-       remove: sv_remove
+       .name		= "sonicvibes",
+       .id_table	= id_table,
+       .probe		= sv_probe,
+       .remove		= sv_remove,
 };
  
 static int __init init_sonicvibes(void)
===== sound/oss/sb_card.h 1.3 vs edited =====
--- 1.3/sound/oss/sb_card.h	Tue Mar 25 11:31:32 2003
+++ edited/sound/oss/sb_card.h	Thu Apr 10 20:40:33 2003
@@ -25,121 +25,121 @@
 /* Card PnP ID Table */
 static struct pnp_card_device_id sb_pnp_card_table[] = {
 	/* Sound Blaster 16 */
-	{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0024", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0025", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0025", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0026", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0026", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0027", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0027", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0028", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0028", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0029", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0029", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL002a", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL002a", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL002b", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL002b", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL002c", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL002c", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL00ed", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	{.id = "CTL00ed", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 	/* Sound Blaster 16 */
-	{.id = "CTL0086", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	{.id = "CTL0086", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 	/* Sound Blaster Vibra16S */
-	{.id = "CTL0051", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+	{.id = "CTL0051", .driver_data = 0, .devs = { {.id="CTL0001"}, } },
 	/* Sound Blaster Vibra16C */
-	{.id = "CTL0070", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+	{.id = "CTL0070", .driver_data = 0, .devs = { {.id="CTL0001"}, } },
 	/* Sound Blaster Vibra16CL */
-	{.id = "CTL0080", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	{.id = "CTL0080", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 	/* Sound Blaster Vibra16CL */
-	{.id = "CTL00F0", .driver_data = 0, devs : { {.id="CTL0043"}, } },
+	{.id = "CTL00F0", .driver_data = 0, .devs = { {.id="CTL0043"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0039", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0039", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0042", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0042", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0043", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0043", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0044", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0044", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0045", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0045", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0046", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0046", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0047", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0047", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0048", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0048", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL0054", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	{.id = "CTL0054", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 	/* Sound Blaster AWE 32 */
-	{.id = "CTL009C", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	{.id = "CTL009C", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 	/* Createive SB32 PnP */
-	{.id = "CTL009F", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	{.id = "CTL009F", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL009D", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+	{.id = "CTL009D", .driver_data = 0, .devs = { {.id="CTL0042"}, } },
 	/* Sound Blaster AWE 64 Gold */
-	{.id = "CTL009E", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+	{.id = "CTL009E", .driver_data = 0, .devs = { {.id="CTL0044"}, } },
 	/* Sound Blaster AWE 64 Gold */
-	{.id = "CTL00B2", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+	{.id = "CTL00B2", .driver_data = 0, .devs = { {.id="CTL0044"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00C1", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+	{.id = "CTL00C1", .driver_data = 0, .devs = { {.id="CTL0042"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00C3", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	{.id = "CTL00C3", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00C5", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	{.id = "CTL00C5", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00C7", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	{.id = "CTL00C7", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00E4", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	{.id = "CTL00E4", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 	/* Sound Blaster AWE 64 */
-	{.id = "CTL00E9", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	{.id = "CTL00E9", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 	/* ESS 1868 */
-	{.id = "ESS0968", .driver_data = 0, devs : { {.id="ESS0968"}, } },
+	{.id = "ESS0968", .driver_data = 0, .devs = { {.id="ESS0968"}, } },
 	/* ESS 1868 */
-	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS1868"}, } },
+	{.id = "ESS1868", .driver_data = 0, .devs = { {.id="ESS1868"}, } },
 	/* ESS 1868 */
-	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS8611"}, } },
+	{.id = "ESS1868", .driver_data = 0, .devs = { {.id="ESS8611"}, } },
 	/* ESS 1869 PnP AudioDrive */
-	{.id = "ESS0003", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+	{.id = "ESS0003", .driver_data = 0, .devs = { {.id="ESS1869"}, } },
 	/* ESS 1869 */
-	{.id = "ESS1869", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+	{.id = "ESS1869", .driver_data = 0, .devs = { {.id="ESS1869"}, } },
 	/* ESS 1878 */
-	{.id = "ESS1878", .driver_data = 0, devs : { {.id="ESS1878"}, } },
+	{.id = "ESS1878", .driver_data = 0, .devs = { {.id="ESS1878"}, } },
 	/* ESS 1879 */
-	{.id = "ESS1879", .driver_data = 0, devs : { {.id="ESS1879"}, } },
+	{.id = "ESS1879", .driver_data = 0, .devs = { {.id="ESS1879"}, } },
 	/* CMI 8330 SoundPRO */
-	{.id = "CMI0001", .driver_data = 0, devs : { {.id="@X@0001"},
-						     {.id="@H@0001"},
-						     {.id="@@@0001"}, } },
+	{.id = "CMI0001", .driver_data = 0, .devs = { {.id="@X@0001"},
+						      {.id="@H@0001"},
+						      {.id="@@@0001"}, } },
 	/* Diamond DT0197H */
-	{.id = "RWR1688", .driver_data = 0, devs : { {.id="@@@0001"},
-						     {.id="@X@0001"},
-						     {.id="@H@0001"}, } },
+	{.id = "RWR1688", .driver_data = 0, .devs = { {.id="@@@0001"},
+						      {.id="@X@0001"},
+						      {.id="@H@0001"}, } },
 	/* ALS007 */
-	{.id = "ALS0007", .driver_data = 0, devs : { {.id="@@@0001"},
-						     {.id="@X@0001"},
-						     {.id="@H@0001"}, } },
+	{.id = "ALS0007", .driver_data = 0, .devs = { {.id="@@@0001"},
+						      {.id="@X@0001"},
+						      {.id="@H@0001"}, } },
 	/* ALS100 */
-	{.id = "ALS0001", .driver_data = 0, devs : { {.id="@@@0001"},
-						     {.id="@X@0001"},
-						     {.id="@H@0001"}, } },
+	{.id = "ALS0001", .driver_data = 0, .devs = { {.id="@@@0001"},
+						      {.id="@X@0001"},
+						      {.id="@H@0001"}, } },
 	/* ALS110 */
-	{.id = "ALS0110", .driver_data = 0, devs : { {.id="@@@1001"},
-						     {.id="@X@1001"},
-						     {.id="@H@0001"}, } },
+	{.id = "ALS0110", .driver_data = 0, .devs = { {.id="@@@1001"},
+						      {.id="@X@1001"},
+						      {.id="@H@0001"}, } },
 	/* ALS120 */
-	{.id = "ALS0120", .driver_data = 0, devs : { {.id="@@@2001"},
-						     {.id="@X@2001"},
-						     {.id="@H@0001"}, } },
+	{.id = "ALS0120", .driver_data = 0, .devs = { {.id="@@@2001"},
+						      {.id="@X@2001"},
+						      {.id="@H@0001"}, } },
 	/* ALS200 */
-	{.id = "ALS0200", .driver_data = 0, devs : { {.id="@@@0020"},
-						     {.id="@X@0030"},
-						     {.id="@H@0001"}, } },
+	{.id = "ALS0200", .driver_data = 0, .devs = { {.id="@@@0020"},
+						      {.id="@X@0030"},
+						      {.id="@H@0001"}, } },
 	/* ALS200 */
-	{.id = "RTL3000", .driver_data = 0, devs : { {.id="@@@2001"},
-						     {.id="@X@2001"},
-						     {.id="@H@0001"}, } },
+	{.id = "RTL3000", .driver_data = 0, .devs = { {.id="@@@2001"},
+						      {.id="@X@2001"},
+						      {.id="@H@0001"}, } },
 	/* -end- */
 	{.id = "", }
 };
===== sound/oss/nm256_audio.c 1.10 vs edited =====
--- 1.10/sound/oss/nm256_audio.c	Thu Apr  3 16:35:48 2003
+++ edited/sound/oss/nm256_audio.c	Thu Apr 10 20:37:30 2003
@@ -925,10 +925,10 @@
 }
 
 static struct mixer_operations nm256_mixer_operations = {
-    .owner	= THIS_MODULE,
-    .id		= "NeoMagic",
-    .name	= "NM256AC97Mixer",
-    .ioctl	= nm256_default_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "NeoMagic",
+	.name	= "NM256AC97Mixer",
+	.ioctl	= nm256_default_mixer_ioctl
 };
 
 /*
@@ -1632,16 +1632,16 @@
 
 static struct audio_driver nm256_audio_driver =
 {
-    .owner		= THIS_MODULE,
-    .open		= nm256_audio_open,
-    .close		= nm256_audio_close,
-    .output_block	= nm256_audio_output_block,
-    .start_input	= nm256_audio_start_input,
-    .ioctl		= nm256_audio_ioctl,
-    .prepare_for_input	= nm256_audio_prepare_for_input,
-    .prepare_for_output	= nm256_audio_prepare_for_output,
-    .halt_io		= nm256_audio_reset,
-    .local_qlen		= nm256_audio_local_qlen,
+	.owner			= THIS_MODULE,
+	.open			= nm256_audio_open,
+	.close			= nm256_audio_close,
+	.output_block		= nm256_audio_output_block,
+	.start_input		= nm256_audio_start_input,
+	.ioctl			= nm256_audio_ioctl,
+	.prepare_for_input	= nm256_audio_prepare_for_input,
+	.prepare_for_output	= nm256_audio_prepare_for_output,
+	.halt_io		= nm256_audio_reset,
+	.local_qlen		= nm256_audio_local_qlen,
 };
 
 static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
@@ -1656,10 +1656,10 @@
 
 
 struct pci_driver nm256_pci_driver = {
-	name:"nm256_audio",
-	id_table:nm256_pci_tbl,
-	probe:nm256_probe,
-	remove:nm256_remove,
+	.name		= "nm256_audio",
+	.id_table	= nm256_pci_tbl,
+	.probe		= nm256_probe,
+	.remove		= nm256_remove,
 };
 
 MODULE_PARM (usecache, "i");
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
