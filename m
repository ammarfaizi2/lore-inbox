Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVF0MpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVF0MpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVF0MmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:42:21 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:4325 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261160AbVF0MQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:16 -0400
Message-Id: <20050627121415.447846000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-firmware-error-handling-fixes4.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 30/51] ttpci: cleanup indentation + whitespace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation and add some whitepsace between operators.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c    |   12 ++++++------
 drivers/media/dvb/ttpci/av7110_av.c |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:23.000000000 +0200
@@ -122,11 +122,11 @@ static void init_av7110_av(struct av7110
 	/* set internal volume control to maximum */
 	av7110->adac_type = DVB_ADAC_TI;
 	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
-	if (ret<0)
+	if (ret < 0)
 		printk("dvb-ttpci:cannot set internal volume to maximum:%d\n",ret);
 
 	ret = av7710_set_video_mode(av7110, vidmode);
-	if (ret<0)
+	if (ret < 0)
 		printk("dvb-ttpci:cannot set video mode:%d\n",ret);
 
 	/* handle different card types */
@@ -162,10 +162,10 @@ static void init_av7110_av(struct av7110
 	if (av7110->adac_type == DVB_ADAC_NONE || av7110->adac_type == DVB_ADAC_MSP) {
 		// switch DVB SCART on
 		ret = av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
-		if (ret<0)
+		if (ret < 0)
 			printk("dvb-ttpci:cannot switch on SCART(Main):%d\n",ret);
 		ret = av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
-		if (ret<0)
+		if (ret < 0)
 			printk("dvb-ttpci:cannot switch on SCART(AD):%d\n",ret);
 		if (rgb_on &&
 		    (av7110->dev->pci->subsystem_vendor == 0x110a) && (av7110->dev->pci->subsystem_device == 0x0000)) {
@@ -175,10 +175,10 @@ static void init_av7110_av(struct av7110
 	}
 
 	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
-	if (ret<0)
+	if (ret < 0)
 		printk("dvb-ttpci:cannot set volume :%d\n",ret);
 	ret = av7110_setup_irc_config(av7110, 0);
-	if (ret<0)
+	if (ret < 0)
 		printk("dvb-ttpci:cannot setup irc config :%d\n",ret);
 }
 
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-06-27 13:24:21.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c	2005-06-27 13:24:23.000000000 +0200
@@ -1126,7 +1126,7 @@ static int dvb_video_ioctl(struct inode 
 		//note: arg is ignored by firmware
 		if (av7110->playing & RP_VIDEO)
 			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
-				      __Scan_I, 2, AV_PES, 0);
+					    __Scan_I, 2, AV_PES, 0);
 		else
 			ret = vidcom(av7110, VIDEO_CMD_FFWD, arg);
 		if (!ret) {
@@ -1164,15 +1164,15 @@ static int dvb_video_ioctl(struct inode 
 
 		if (av7110->playing == RP_AV) {
 			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
-				      __Play, 2, AV_PES, 0);
+					    __Play, 2, AV_PES, 0);
 			if (ret)
 				break;
 			if (av7110->trickmode == TRICK_FAST)
 				ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
-					      __Scan_I, 2, AV_PES, 0);
+						    __Scan_I, 2, AV_PES, 0);
 			if (av7110->trickmode == TRICK_SLOW) {
 				ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
-					      __Slow, 2, 0, 0);
+						    __Slow, 2, 0, 0);
 				if (!ret)
 					ret = vidcom(av7110, VIDEO_CMD_SLOW, arg);
 			}
@@ -1303,7 +1303,7 @@ static int dvb_audio_ioctl(struct inode 
 		av7110_ipack_reset(&av7110->ipack[0]);
 		if (av7110->playing == RP_AV)
 			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
-			       __Play, 2, AV_PES, 0);
+					    __Play, 2, AV_PES, 0);
 		break;
 	case AUDIO_SET_ID:
 

--

