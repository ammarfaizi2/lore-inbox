Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbULHBTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbULHBTK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbULHBRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:17:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61578 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261988AbULHBPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:15:52 -0500
Date: Wed, 8 Dec 2004 02:14:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] DVB av7110_hw.c: remove unused functions (fwd)
Message-ID: <20041208011419.GD5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:16:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DVB av7110_hw.c: remove unused functions

The patch below removes three unused functions from 
drivers/media/dvb/ttpci/av7110_hw.c


diffstat output:
 drivers/media/dvb/ttpci/av7110_hw.c |   15 ---------------
 1 files changed, 15 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/media/dvb/ttpci/av7110_hw.c.old	2004-10-28 23:04:59.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/dvb/ttpci/av7110_hw.c	2004-10-28 23:05:26.000000000 +0200
@@ -577,21 +577,11 @@
 
 #ifdef CONFIG_DVB_AV7110_OSD
 
-static inline int ResetBlend(struct av7110 *av7110, u8 windownr)
-{
-	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetNonBlend, 1, windownr);
-}
-
 static inline int SetColorBlend(struct av7110 *av7110, u8 windownr)
 {
 	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetCBlend, 1, windownr);
 }
 
-static inline int SetWindowBlend(struct av7110 *av7110, u8 windownr, u8 blending)
-{
-	return av7110_fw_cmd(av7110, COMTYPE_OSD, SetWBlend, 2, windownr, blending);
-}
-
 static inline int SetBlend_(struct av7110 *av7110, u8 windownr,
 		     enum av7110_osd_palette_type colordepth, u16 index, u8 blending)
 {
@@ -606,11 +596,6 @@
 			     windownr, colordepth, index, colorhi, colorlo);
 }
 
-static inline int BringToTop(struct av7110 *av7110, u8 windownr)
-{
-	return av7110_fw_cmd(av7110, COMTYPE_OSD, WTop, 1, windownr);
-}
-
 static inline int SetFont(struct av7110 *av7110, u8 windownr, u8 fontsize,
 			  u16 colorfg, u16 colorbg)
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

