Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284250AbRLEMHT>; Wed, 5 Dec 2001 07:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284290AbRLEMG7>; Wed, 5 Dec 2001 07:06:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48144 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284250AbRLEMGs>; Wed, 5 Dec 2001 07:06:48 -0500
Subject: PATCH: Fix 2.4.17pre breakages in ad1848
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Date: Wed, 5 Dec 2001 12:15:57 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Baxx-00067I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot one small but important detail:

--- drivers/sound/ad1848.c~	Sat Nov 17 20:47:59 2001
+++ drivers/sound/ad1848.c	Wed Dec  5 13:01:29 2001
@@ -134,7 +134,7 @@
 
 static int loaded;
 
-static int ad_format_mask[10 /*devc->model */ ] =
+static int ad_format_mask[13 /*devc->model */ ] =
 {
 	0,
 	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW,
@@ -145,7 +145,10 @@
 	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW | AFMT_S16_BE | AFMT_IMA_ADPCM,
 	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW | AFMT_S16_BE | AFMT_IMA_ADPCM,
 	AFMT_U8 | AFMT_S16_LE /* CS4235 */,
-	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW	/* Ensoniq Soundscape*/
+	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW	/* Ensoniq Soundscape*/,
+	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW | AFMT_S16_BE | AFMT_IMA_ADPCM,
+	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW | AFMT_S16_BE | AFMT_IMA_ADPCM,
+	AFMT_U8 | AFMT_S16_LE | AFMT_MU_LAW | AFMT_A_LAW | AFMT_S16_BE | AFMT_IMA_ADPCM	
 };
 
 static ad1848_info adev_info[MAX_AUDIO_DEV];
