Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVF0MpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVF0MpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVF0Mmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:42:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:4837 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261188AbVF0MQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:17 -0400
Message-Id: <20050627121414.668022000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:26 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Dr. Werner Fink" <werner@suse.de>
Content-Disposition: inline; filename=dvb-ttpci-av7110-audio-continue-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 26/51] ttpci: fix AUDUIO_CONTINUE ioctl
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. Werner Fink" <werner@suse.de>

Fixed typo in AUDUIO_CONTINUE ioctl:  AUDIO_CMD_MUTE -> AUDIO_CMD_UNMUTE

Signed-off-by: "Dr. Werner Fink" <werner@suse.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110_av.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c	2005-06-27 13:24:19.000000000 +0200
@@ -1200,7 +1200,7 @@ static int dvb_audio_ioctl(struct inode 
 	case AUDIO_CONTINUE:
 		if (av7110->audiostate.play_state == AUDIO_PAUSED) {
 			av7110->audiostate.play_state = AUDIO_PLAYING;
-			audcom(av7110, AUDIO_CMD_MUTE | AUDIO_CMD_PCM16);
+			audcom(av7110, AUDIO_CMD_UNMUTE | AUDIO_CMD_PCM16);
 		}
 		break;
 

--

