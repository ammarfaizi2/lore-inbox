Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263832AbTCUS5c>; Fri, 21 Mar 2003 13:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263826AbTCUS4W>; Fri, 21 Mar 2003 13:56:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36228
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263827AbTCUSz2>; Fri, 21 Mar 2003 13:55:28 -0500
Date: Fri, 21 Mar 2003 20:10:43 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212010.h2LKAhvk026310@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: C99 for ac97 codec ALSA style
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/pci/ac97/ac97_codec.c linux-2.5.65-ac2/sound/pci/ac97/ac97_codec.c
--- linux-2.5.65/sound/pci/ac97/ac97_codec.c	2003-03-18 16:46:53.000000000 +0000
+++ linux-2.5.65-ac2/sound/pci/ac97/ac97_codec.c	2003-03-18 17:14:02.000000000 +0000
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
@p
