Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVEHTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVEHTWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVEHTWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:22:10 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:61590 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262884AbVEHTJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:51 -0400
Message-Id: <20050508184347.787119000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:49 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-tda1004x-nobitfields.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 20/37] tda1004x: dont use bitfields
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use simple u8 instead of bitfields (Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/tda1004x.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda1004x.h	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.h	2005-05-08 16:28:52.000000000 +0200
@@ -32,10 +32,10 @@ struct tda1004x_config
 	u8 demod_address;
 
 	/* does the "inversion" need inverted? */
-	u8 invert:1;
+	u8 invert;
 
 	/* Does the OCLK signal need inverted? */
-	u8 invert_oclk:1;
+	u8 invert_oclk;
 
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);

--

