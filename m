Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVEHT3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVEHT3M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVEHTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:21:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:61078 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262883AbVEHTJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:51 -0400
Message-Id: <20050508184347.512159000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:47 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-ves1820-nosleep.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 18/37] ves1820: remove unnecessary msleep
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary msleep(10) in writereg (Tony Glader)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/ves1820.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1820.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/ves1820.c	2005-05-08 16:21:47.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/ves1820.c	2005-05-08 16:25:45.000000000 +0200
@@ -70,7 +70,6 @@ static int ves1820_writereg(struct ves18
 		printk("ves1820: %s(): writereg error (reg == 0x%02x,"
 			"val == 0x%02x, ret == %i)\n", __FUNCTION__, reg, data, ret);
 
-	msleep(10);
 	return (ret != 1) ? -EREMOTEIO : 0;
 }
 

--

