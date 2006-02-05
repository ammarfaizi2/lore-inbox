Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWBEPNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWBEPNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBEPNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:13:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750870AbWBEPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:13:23 -0500
Date: Sun, 5 Feb 2006 16:13:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jan Niehusmann <jan@gondor.com>
Subject: [2.6 patch] let IPW2{1,2}00 select IEEE80211
Message-ID: <20060205151322.GE5271@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Niehusmann <jan@gondor.com>

This patch makes the IPW2100 and IPW2200 options available in
the configuration menu even if IEEE80211 has not been selected before.
This behaviour is more intuitive for people which are not familiar with
the driver internals.
The suggestion for this change was made by Alejandro Bonilla Beeche.

Signed-off-by: Jan Niehusmann <jan@gondor.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jan Niehusmann on:
- 13 Nov 2005

--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -139,8 +139,9 @@ comment "Wireless 802.11b ISA/PCI cards 
 
 config IPW2100
 	tristate "Intel PRO/Wireless 2100 Network Connection"
-	depends on NET_RADIO && PCI && IEEE80211
+	depends on NET_RADIO && PCI
 	select FW_LOADER
+	select IEEE80211
 	---help---
           A driver for the Intel PRO/Wireless 2100 Network 
 	  Connection 802.11b wireless network adapter.
@@ -192,8 +193,9 @@ config IPW_DEBUG
 
 config IPW2200
 	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
-	depends on NET_RADIO && IEEE80211 && PCI
+	depends on NET_RADIO && PCI
 	select FW_LOADER
+	select IEEE80211
 	---help---
           A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
 	  Connection adapters. 
 

