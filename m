Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVKMWYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVKMWYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKMWYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:24:49 -0500
Received: from mail.gondor.com ([212.117.64.182]:50189 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750764AbVKMWYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:24:49 -0500
Date: Sun, 13 Nov 2005 23:24:56 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org, James Ketrenos <jketreno@linux.intel.com>
Subject: [PATCH 2.6.14-rc1 1/1] IPW2100/2200: Question on menuconfig
Message-ID: <20051113222455.GA23910@knautsch.gondor.com>
References: <434B2AE2.1070709@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434B2AE2.1070709@linuxwireless.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the IPW2100 and IPW2200 options available in
the configuration menu even if IEEE80211 has not been selected before.
This behaviour is more intuitive for people which are not familiar with
the driver internals.
The suggestion for this change was made by Alejandro Bonilla Beeche.

Signed-off-by: Jan Niehusmann <jan@gondor.com>

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
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
-	depends on IEEE80211 && PCI
+	depends on PCI
 	select FW_LOADER
+	select IEEE80211
 	---help---
           A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
 	  Connection adapters. 
 
