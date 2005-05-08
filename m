Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVEHThy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVEHThy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVEHTOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:14:30 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:57494 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262836AbVEHTJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:39 -0400
Message-Id: <20050508184346.253750000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-vdispfmt.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 09/37] av7110: fix VIDEO_SET_DISPLAY_FORMAT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIDEO_SET_DISPLAY_FORMAT ioctl fixed:
set videostate.display_format, not videostate.video_format (Oliver Endriss)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110_av.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 16:05:18.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_av.c	2005-05-08 16:12:44.000000000 +0200
@@ -1075,7 +1075,7 @@ static int dvb_video_ioctl(struct inode 
 		}
 		if (ret < 0)
 			break;
-		av7110->videostate.video_format = format;
+		av7110->videostate.display_format = format;
 		ret = av7110_fw_cmd(av7110, COMTYPE_ENCODER, SetPanScanType,
 				    1, (u16) val);
 		break;

--

