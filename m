Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262748AbTCUUsP>; Fri, 21 Mar 2003 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263812AbTCUUrG>; Fri, 21 Mar 2003 15:47:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32388
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263799AbTCUSxk>; Fri, 21 Mar 2003 13:53:40 -0500
Date: Fri, 21 Mar 2003 20:08:56 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212008.h2LK8uKf026278@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix i810 ifs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[There are a ton of updates to pull from 2.4, but not yet merged]
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/i810_audio.c linux-2.5.65-ac2/sound/oss/i810_audio.c
--- linux-2.5.65/sound/oss/i810_audio.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/i810_audio.c	2003-03-06 23:20:44.000000000 +0000
@@ -2406,9 +2406,9 @@
 				i810_set_dac_channels ( state, channels );
 
 				/* check that they really got turned on */
-				if ( !state->card->ac97_status & SURR_ON )
+				if (!(state->card->ac97_status & SURR_ON))
 					val &= ~DSP_BIND_SURR;
-				if ( !state->card->ac97_status & CENTER_LFE_ON )
+				if (!(state->card->ac97_status & CENTER_LFE_ON))
 					val &= ~DSP_BIND_CENTER_LFE;
 			}
 		}
