Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbTD1MjE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTD1MjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:39:04 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:62471 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263548AbTD1Mi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:38:57 -0400
Date: Mon, 28 Apr 2003 07:51:03 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for sound/
Message-ID: <20030428125103.GA14394@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are three patches converting files in sound/ to use C99
initializers. The patches are against the current BK.

Art Haas

===== sound/oss/cs46xx.c 1.28 vs edited =====
--- 1.28/sound/oss/cs46xx.c	Thu Apr 24 05:36:25 2003
+++ edited/sound/oss/cs46xx.c	Mon Apr 28 07:27:08 2003
@@ -1934,7 +1934,7 @@
  *   Midi file operations struct.
  */
 static /*const*/ struct file_operations cs_midi_fops = {
-	CS_OWNER	CS_THIS_MODULE
+	.owner		= THIS_MODULE
 	.llseek		= no_llseek,
 	.read		= cs_midi_read,
 	.write		= cs_midi_write,
@@ -3818,7 +3818,7 @@
 }
 
 static /*const*/ struct file_operations cs461x_fops = {
-	CS_OWNER	CS_THIS_MODULE
+	.owner		= THIS_MODULE
 	.llseek		= no_llseek,
 	.read		= cs_read,
 	.write		= cs_write,
@@ -4225,7 +4225,7 @@
 }
 
 static /*const*/ struct file_operations cs_mixer_fops = {
-	CS_OWNER	CS_THIS_MODULE
+	.owner		= THIS_MODULE
 	.llseek		= no_llseek,
 	.ioctl		= cs_ioctl_mixdev,
 	.open		= cs_open_mixdev,
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
===== sound/pci/rme9652/hdsp.c 1.17 vs edited =====
--- 1.17/sound/pci/rme9652/hdsp.c	Mon Apr 21 02:32:53 2003
+++ edited/sound/pci/rme9652/hdsp.c	Mon Apr 28 07:28:30 2003
@@ -3526,7 +3526,7 @@
 		snd_interval_t t = {
 			.min = hdsp->ds_channels,
 			.max = hdsp->ds_channels,
-			integer: 1,
+			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);
 	} else if (r->max < 64000) {
@@ -3550,7 +3550,7 @@
 		snd_interval_t t = {
 			.min = 32000,
 			.max = 48000,
-			integer: 1,
+			.integer = 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= hdsp->ds_channels) {
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
