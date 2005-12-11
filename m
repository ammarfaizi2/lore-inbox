Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVLKS3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVLKS3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVLKS3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:29:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23308 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750788AbVLKS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:29:02 -0500
Date: Sun, 11 Dec 2005 19:29:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>, Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] ACX should select, not depend on FW_LOADER
Message-ID: <20051211182901.GP23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a driver needs FW_LOADER, it should select this option, not depend on 
it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/drivers/net/wireless/tiacx/Kconfig.old	2005-12-11 19:04:49.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/net/wireless/tiacx/Kconfig	2005-12-11 19:05:08.000000000 +0100
@@ -1,6 +1,7 @@
 config ACX
 	tristate "TI acx100/acx111 802.11b/g wireless chipsets"
-	depends on NET_RADIO && EXPERIMENTAL && FW_LOADER && (USB || PCI)
+	depends on NET_RADIO && EXPERIMENTAL && (USB || PCI)
+	select FW_LOADER
 	---help---
 	A driver for 802.11b/g wireless cards based on
 	Texas Instruments acx100 and acx111 chipsets.

