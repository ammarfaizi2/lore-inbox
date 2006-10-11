Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWJKVbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWJKVbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161394AbWJKVaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:30:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:34206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161383AbWJKVFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:14 -0400
Date: Wed, 11 Oct 2006 14:04:58 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/67] mv643xx_eth: fix obvious typo, which caused build breakage
Message-ID: <20061011210458.GT16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mv643xx_eth-fix-obvious-typo-which-caused-build-breakage.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Garzik <jeff@garzik.org>

The last minute fix submitted by the author fixed a bug, but
broke the driver build.

Noticed by Al Viro, since I can't build on said platform.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/net/mv643xx_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.18/drivers/net/mv643xx_eth.c
@@ -385,7 +385,7 @@ static int mv643xx_eth_receive_queue(str
 	struct pkt_info pkt_info;
 
 	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
-		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
+		dma_unmap_single(NULL, pkt_info.buf_ptr, ETH_RX_SKB_SIZE,
 							DMA_FROM_DEVICE);
 		mp->rx_desc_count--;
 		received_packets++;

--
