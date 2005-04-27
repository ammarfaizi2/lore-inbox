Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVD0Krn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVD0Krn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVD0Krn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:47:43 -0400
Received: from styx.suse.cz ([82.119.242.94]:53214 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261393AbVD0Kre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:47:34 -0400
Date: Wed, 27 Apr 2005 12:48:56 +0200
From: Jiri Benc <jbenc@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: [PATCH] Typo in tulip driver
Message-Id: <20050427124856.3abe369f@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in tulip driver in 2.6.12-rc3.


--- linux-2.6.12-rc3/drivers/net/tulip/tulip_core.c
+++ linux-2.6.12-rc3-patched/drivers/net/tulip/tulip_core.c
@@ -1104,7 +1109,7 @@ static void set_rx_mode(struct net_devic
 			if (entry != 0) {
 				/* Avoid a chip errata by prefixing a dummy entry. Don't do
 				   this on the ULI526X as it triggers a different problem */
-				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
+				if (!(tp->chip_id == ULI526X && (tp->revision == 0x40 || tp->revision == 0x50))) {
 					tp->tx_buffers[entry].skb = NULL;
 					tp->tx_buffers[entry].mapping = 0;
 					tp->tx_ring[entry].length =


--
Jiri Benc
SUSE Labs
