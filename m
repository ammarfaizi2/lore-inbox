Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVIDXcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVIDXcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIDXbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:12 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:38273 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932124AbVIDXa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:28 -0400
Message-Id: <20050904232328.781670000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:32 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-endian-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 33/54] bt8xx: endianness fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Endianness fix for risc DMA start address setting.
(reported by Stefan Haubenthal/Peter Hettkamp)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/bt878.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/bt878.c	2005-09-04 22:27:47.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/bt878.c	2005-09-04 22:28:27.000000000 +0200
@@ -219,7 +219,7 @@ void bt878_start(struct bt878 *bt, u32 c
 	controlreg &= ~0x1f;
 	controlreg |= 0x1b;
 
-	btwrite(cpu_to_le32(bt->risc_dma), BT878_ARISC_START);
+	btwrite(bt->risc_dma, BT878_ARISC_START);
 
 	/* original int mask had :
 	 *    6    2    8    4    0

--

