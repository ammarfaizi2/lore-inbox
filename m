Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVJSBgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVJSBgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVJSBgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:36:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:2052 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932443AbVJSBdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:41 -0400
Date: Tue, 18 Oct 2005 21:31:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [patch 2.6.14-rc3 3/3] sundance: expand reset mask
Message-ID: <10182005213102.12871@bilbo.tuxdriver.com>
In-Reply-To: <10182005213101.12810@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the mask used when reseting the chip to include the GlobalReset
bit.  This fix comes from ICPlus and seems to be required for some
cards.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/sundance.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -690,7 +690,7 @@ static int __devinit sundance_probe1 (st
 	/* Reset the chip to erase previous misconfiguration. */
 	if (netif_msg_hw(np))
 		printk("ASIC Control is %x.\n", ioread32(ioaddr + ASICCtrl));
-	iowrite16(0x007f, ioaddr + ASICCtrl + 2);
+	iowrite16(0x00ff, ioaddr + ASICCtrl + 2);
 	if (netif_msg_hw(np))
 		printk("ASIC Control is now %x.\n", ioread32(ioaddr + ASICCtrl));
 
