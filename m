Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270611AbTGNMdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270589AbTGNMba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45956
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270587AbTGNMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:12:13 -0400
Date: Mon, 14 Jul 2003 13:26:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141226.h6ECQ9HG030923@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix i810 and cs46xx crashes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/sound/cs46xx.c linux.22-pre5-ac1/drivers/sound/cs46xx.c
--- linux.22-pre5/drivers/sound/cs46xx.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/sound/cs46xx.c	2003-07-07 16:08:18.000000000 +0100
@@ -4257,7 +4257,6 @@
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
 		if ((codec = ac97_alloc_codec()) == NULL)
 			return -ENOMEM;
-		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/sound/i810_audio.c linux.22-pre5-ac1/drivers/sound/i810_audio.c
--- linux.22-pre5/drivers/sound/i810_audio.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/sound/i810_audio.c	2003-07-07 16:08:18.000000000 +0100
@@ -2875,7 +2875,6 @@
 		
 		if ((codec = ac97_alloc_codec()) == NULL)
 			return -ENOMEM;
-		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
