Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268988AbTCASoI>; Sat, 1 Mar 2003 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268989AbTCASoI>; Sat, 1 Mar 2003 13:44:08 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:9489 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268988AbTCASn7>; Sat, 1 Mar 2003 13:43:59 -0500
Date: Sat, 1 Mar 2003 12:52:05 -0600
From: Art Haas <ahaas@airmail.net>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for sound/isa
Message-ID: <20030301185205.GB1532@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are a set of patches for files in sound/isa that convert the files
to use C99 initializers. The patches are against the current BK.

Art Haas

===== sound/isa/als100.c 1.7 vs edited =====
--- 1.7/sound/isa/als100.c	Tue Oct 22 08:04:00 2002
+++ edited/sound/isa/als100.c	Wed Feb 26 18:33:39 2003
@@ -112,9 +112,9 @@
 #define ISAPNP_ALS100(_va, _vb, _vc, _device, _audio, _mpu401, _opl) \
         { \
                 ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-                devs : { ISAPNP_DEVICE_ID('@', '@', '@', _audio), \
-                         ISAPNP_DEVICE_ID('@', 'X', '@', _mpu401), \
-			 ISAPNP_DEVICE_ID('@', 'H', '@', _opl) } \
+                .devs = { ISAPNP_DEVICE_ID('@', '@', '@', _audio), \
+                          ISAPNP_DEVICE_ID('@', 'X', '@', _mpu401), \
+		 	  ISAPNP_DEVICE_ID('@', 'H', '@', _opl) } \
         }
 
 static struct isapnp_card_id snd_als100_pnpids[] __devinitdata = {
===== sound/isa/azt2320.c 1.7 vs edited =====
--- 1.7/sound/isa/azt2320.c	Tue Oct 22 08:04:00 2002
+++ edited/sound/isa/azt2320.c	Wed Feb 26 18:33:40 2003
@@ -125,8 +125,8 @@
 #define ISAPNP_AZT2320(_va, _vb, _vc, _device, _audio, _mpu401) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _mpu401), } \
+		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
+			  ISAPNP_DEVICE_ID(_va, _vb, _vc, _mpu401), } \
 	}
 
 static struct isapnp_card_id snd_azt2320_pnpids[] __devinitdata = {
===== sound/isa/cmi8330.c 1.12 vs edited =====
--- 1.12/sound/isa/cmi8330.c	Sat Feb  8 14:10:50 2003
+++ edited/sound/isa/cmi8330.c	Wed Feb 26 18:33:40 2003
@@ -182,8 +182,8 @@
 #define ISAPNP_CMI8330(_va, _vb, _vc, _device, _audio1, _audio2) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID('@', '@', '@', _audio1), \
-			 ISAPNP_DEVICE_ID('@', 'X', '@', _audio2), } \
+		.devs = { ISAPNP_DEVICE_ID('@', '@', '@', _audio1), \
+			  ISAPNP_DEVICE_ID('@', 'X', '@', _audio2), } \
 	}
 
 static struct isapnp_card_id snd_cmi8330_pnpids[] __devinitdata =
===== sound/isa/dt019x.c 1.9 vs edited =====
--- 1.9/sound/isa/dt019x.c	Tue Oct 22 08:04:00 2002
+++ edited/sound/isa/dt019x.c	Wed Feb 26 18:33:41 2003
@@ -111,7 +111,7 @@
 	/* DT0196 / ALS-007 */
 	{
 		ISAPNP_CARD_ID('A','L','S',0x0007),
-		devs: { ISAPNP_DEVICE_ID('@','@','@',0x0001),
+		.devs = { ISAPNP_DEVICE_ID('@','@','@',0x0001),
 			ISAPNP_DEVICE_ID('@','X','@',0x0001),
 			ISAPNP_DEVICE_ID('@','H','@',0x0001) }
 	},
===== sound/isa/es18xx.c 1.13 vs edited =====
--- 1.13/sound/isa/es18xx.c	Sat Feb  8 14:10:50 2003
+++ edited/sound/isa/es18xx.c	Wed Feb 26 18:33:39 2003
@@ -1950,8 +1950,8 @@
 #define ISAPNP_ES18XX(_va, _vb, _vc, _device, _audio, _control) \
         { \
                 ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-                devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-                         ISAPNP_DEVICE_ID(_va, _vb, _vc, _control) } \
+                .devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
+                          ISAPNP_DEVICE_ID(_va, _vb, _vc, _control) } \
         }
 
 static struct isapnp_card_id snd_audiodrive_pnpids[] __devinitdata = {
===== sound/isa/opl3sa2.c 1.14 vs edited =====
--- 1.14/sound/isa/opl3sa2.c	Sat Dec  7 10:11:30 2002
+++ edited/sound/isa/opl3sa2.c	Thu Feb 27 14:04:55 2003
@@ -166,13 +166,13 @@
 
 static struct pnp_card_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
-	{.id = "YMH0020", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0020", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
-	{.id = "YMH0030", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0030", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA2 */
-	{.id = "YMH0800", .driver_data = 0, devs : { {.id="YMH0021"}, } },
+	{.id = "YMH0800", .driver_data = 0, .devs = { {.id="YMH0021"}, } },
 	/* NeoMagic MagicWave 3DX */
-	{.id = "NMX2200", .driver_data = 0, devs : { {.id="NMX2210"}, } },
+	{.id = "NMX2200", .driver_data = 0, .devs = { {.id="NMX2210"}, } },
 	/* --- */
 	{.id = "", } /* end */
 };
===== sound/isa/ad1816a/ad1816a.c 1.6 vs edited =====
--- 1.6/sound/isa/ad1816a/ad1816a.c	Tue Oct 22 08:04:00 2002
+++ edited/sound/isa/ad1816a/ad1816a.c	Wed Feb 26 18:33:37 2003
@@ -109,8 +109,8 @@
 #define ISAPNP_AD1816A(_va, _vb, _vc, _device, _fa, _fb, _fc, _audio, _mpu401) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_fa, _fb, _fc, _audio), \
-			 ISAPNP_DEVICE_ID(_fa, _fb, _fc, _mpu401), } \
+		.devs = { ISAPNP_DEVICE_ID(_fa, _fb, _fc, _audio), \
+			  ISAPNP_DEVICE_ID(_fa, _fb, _fc, _mpu401), } \
 	}
 
 static struct isapnp_card_id snd_ad1816a_pnpids[] __devinitdata = {
===== sound/isa/gus/gus_pcm.c 1.7 vs edited =====
--- 1.7/sound/isa/gus/gus_pcm.c	Sat Feb  8 14:10:51 2003
+++ edited/sound/isa/gus/gus_pcm.c	Wed Feb 26 18:33:37 2003
@@ -620,7 +620,7 @@
 static snd_pcm_hardware_t snd_gf1_pcm_playback =
 {
 	.info =			SNDRV_PCM_INFO_NONINTERLEAVED,
-	formats:		(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |
+	.formats		= (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |
 				 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_U16_LE),
 	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min =		5510,
===== sound/isa/gus/interwave.c 1.10 vs edited =====
--- 1.10/sound/isa/gus/interwave.c	Sun Feb 16 07:47:42 2003
+++ edited/sound/isa/gus/interwave.c	Thu Feb 27 14:06:03 2003
@@ -148,12 +148,12 @@
 #define ISAPNP_INTERWAVE(_va, _vb, _vc, _device, _audio) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
+		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
 	}
 #define ISAPNP_INTERWAVE_STB(_va, _vb, _vc, _device, _audio, _tone) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
+		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
 			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _tone), } \
 	}
 
===== sound/isa/sb/sb16.c 1.12 vs edited =====
--- 1.12/sound/isa/sb/sb16.c	Mon Jan 27 13:00:12 2003
+++ edited/sound/isa/sb/sb16.c	Thu Feb 27 14:06:54 2003
@@ -168,12 +168,12 @@
 #define ISAPNP_SB16(_va, _vb, _vc, _device, _audio) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
+		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
 	}
 #define ISAPNP_SBAWE(_va, _vb, _vc, _device, _audio, _awe) \
 	{ \
 		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		devs : { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
+		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
 			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _awe), } \
 	}
 
===== sound/isa/sb/sb8_main.c 1.4 vs edited =====
--- 1.4/sound/isa/sb/sb8_main.c	Sat Feb  8 14:10:51 2003
+++ edited/sound/isa/sb/sb8_main.c	Wed Feb 26 18:33:36 2003
@@ -97,7 +97,7 @@
 {
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (r->min > SB8_RATE(22050) || r->max <= SB8_RATE(11025)) {
-		snd_interval_t t = { min: 1, max: 1 };
+		snd_interval_t t = { .min = 1, .max = 1 };
 		return snd_interval_refine(hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS), &t);
 	}
 	return 0;
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
