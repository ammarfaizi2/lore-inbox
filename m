Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbWJZCWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbWJZCWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbWJZCVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:21:44 -0400
Received: from isilmar.linta.de ([213.239.214.66]:36575 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965285AbWJZCTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:10 -0400
Date: Wed, 25 Oct 2006 22:12:37 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hostap@shmoo.com,
       linville@tuxdriver.com, jkmaline@cc.hut.fi, proski@gnu.org
Subject: [RFC PATCH 2/11] pcmcia: add more IDs to hostap_cs.c
Message-ID: <20061026021237.GC20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	hostap@shmoo.com, linville@tuxdriver.com, jkmaline@cc.hut.fi,
	proski@gnu.org
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Sun, 2 Jul 2006 21:21:51 +0200
Subject: [PATCH] pcmcia: add more IDs to hostap_cs.c

As a replacement for the broad manufactor/card ID match we commented out
because of conflicts with pcnet_cs, add two product ID matches.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/net/wireless/hostap/hostap_cs.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/net/wireless/hostap/hostap_cs.c b/drivers/net/wireless/hostap/hostap_cs.c
index 686d895..f63909e 100644
--- a/drivers/net/wireless/hostap/hostap_cs.c
+++ b/drivers/net/wireless/hostap/hostap_cs.c
@@ -887,6 +887,13 @@ static struct pcmcia_device_id hostap_cs
 	PCMCIA_DEVICE_PROD_ID123(
 		"U.S. Robotics", "IEEE 802.11b PC-CARD", "Version 01.02",
 		0xc7b8df9d, 0x1700d087, 0x4b74baa0),
+	PCMCIA_DEVICE_PROD_ID123(
+		"Allied Telesyn", "AT-WCL452 Wireless PCMCIA Radio",
+		"Ver. 1.00",
+		0x5cd01705, 0x4271660f, 0x9d08ee12),
+	PCMCIA_DEVICE_PROD_ID123(
+		"corega", "WL PCCL-11", "ISL37300P",
+		0xa21501a, 0x59868926, 0xc9049a39),
 	PCMCIA_DEVICE_NULL
 };
 MODULE_DEVICE_TABLE(pcmcia, hostap_cs_ids);
-- 
1.4.3

