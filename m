Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTB0Vbu>; Thu, 27 Feb 2003 16:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTB0Vbu>; Thu, 27 Feb 2003 16:31:50 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:47622 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267013AbTB0Vbs>; Thu, 27 Feb 2003 16:31:48 -0500
Date: Thu, 27 Feb 2003 15:35:53 -0600
From: Art Haas <ahaas@airmail.net>
To: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for sound/pci/ac97/ac97_codec.c
Message-ID: <20030227213553.GA8116@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers.

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
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
