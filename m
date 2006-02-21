Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161295AbWBUDMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161295AbWBUDMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWBUDMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:12:55 -0500
Received: from dialup-4.240.33.204.Dial1.Phoenix1.Level3.net ([4.240.33.204]:9090
	"EHLO tesore.local") by vger.kernel.org with ESMTP id S1161295AbWBUDMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:12:54 -0500
Date: Mon, 20 Feb 2006 20:23:33 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] axnet_cs: support amb8110
Message-ID: <20060221032333.GA15768@tesore.frys.com>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Allen <the3dfxdude@gmail.com>

The axnet_cs driver can support the AMB8110 PC Card, so add the id for it.

Signed-off-by: Jesse Allen <the3dfxdude@gmail.com>
---

In the old pcmcia-cs config file, this card is listed with the comment
"not specific enough".  The last entry in the axnet_ids has the same
comment.  They are disabled, and for good reason as it was originally
identified by the MANFID, and that is shared with several cards that use
both the pcnet_cs driver and axnet_cs driver.  I tried my AMB8110 with
pcnet_cs, and found that it works fine, and I cannot find a reason for
either, except that the old config file recommended axnet_cs.


--- linux/drivers/net/pcmcia/axnet_cs.c	2006-01-21 11:10:23.000000000 -0700
+++ linux2/drivers/net/pcmcia/axnet_cs.c	2006-02-20 17:19:14.000000000 -0700
@@ -806,6 +806,7 @@ static struct pcmcia_device_id axnet_ids
 	PCMCIA_DEVICE_MANF_CARD(0x026f, 0x0309),
 	PCMCIA_DEVICE_MANF_CARD(0x0274, 0x1106),
 	PCMCIA_DEVICE_MANF_CARD(0x8a01, 0xc1ab),
+	PCMCIA_DEVICE_PROD_ID12("AmbiCom,Inc.", "Fast Ethernet PC Card(AMB8110)", 0x49b020a7, 0x119cc9fc),
 	PCMCIA_DEVICE_PROD_ID124("Fast Ethernet", "16-bit PC Card", "AX88190", 0xb4be14e3, 0x9a12eb6a, 0xab9be5ef),
 	PCMCIA_DEVICE_PROD_ID12("ASIX", "AX88190", 0x0959823b, 0xab9be5ef),
 	PCMCIA_DEVICE_PROD_ID12("Billionton", "LNA-100B", 0x552ab682, 0xbc3b87e1),
