Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVCVC0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVCVC0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVCVCZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:25:02 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:396 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262359AbVCVBgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:53 -0500
Message-Id: <20050322013456.744099000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:51 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-skystar2-mac.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 18/48] skystar2: fix MAC address reading
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed MAC address reading (eeprom address to read, was not correctly set,
respectively overwritten)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 skystar2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:14:55.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:16:14.000000000 +0100
@@ -231,8 +231,8 @@ static void fixchipaddr(u32 device, u32 
 {
 	if (device == 0x20000000)
 		*ret = bus | ((addr >> 8) & 3);
-
-	*ret = bus;
+	else
+		*ret = bus;
 }
 
 static u32 flex_i2c_read(struct adapter *adapter, u32 device, u32 bus, u32 addr, u8 *buf, u32 len)

--

