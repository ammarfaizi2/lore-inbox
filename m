Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUIWVsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUIWVsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIWVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:12:09 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37009 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267397AbUIWVJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:09:05 -0400
Subject: [patch 17/20]  dvb/av7110_v4l: replace 	schedule_timeout() with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:09:06 +0200
Message-ID: <E1CAapu-00043j-Hl@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replace dvb_delay() with msleep() to guarantee the
task delays the desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110_v4l.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/media/dvb/ttpci/av7110_v4l.c~msleep-drivers_media_dvb_ttpci_av7110_v4l drivers/media/dvb/ttpci/av7110_v4l.c
--- linux-2.6.9-rc2-bk7/drivers/media/dvb/ttpci/av7110_v4l.c~msleep-drivers_media_dvb_ttpci_av7110_v4l	2004-09-21 20:50:25.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/dvb/ttpci/av7110_v4l.c	2004-09-21 20:50:25.000000000 +0200
@@ -517,7 +517,7 @@ int av7110_init_analog_module(struct av7
 	printk("av7110(%d): DVB-C analog module detected, initializing MSP3400\n",
 		av7110->dvb_adapter->num);
 	av7110->adac_type = DVB_ADAC_MSP;
-	dvb_delay(100); // the probing above resets the msp...
+	msleep(100);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
 	msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
 	printk("av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
_
