Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbUJ2ANM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUJ2ANM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUJ2AMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:12:36 -0400
Received: from smtp.knology.net ([24.214.63.101]:34472 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S263178AbUJ2AIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:08:48 -0400
Subject: Re: [2.6 patch] net/typhoon.c: remove an unused function
From: David Dillow <dave@thedillows.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041028230629.GY3207@stusta.de>
References: <20041028230629.GY3207@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Oct 2004 20:08:39 -0400
Message-Id: <1099008519.8952.26.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 01:06 +0200, Adrian Bunk wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The patch below removes an unused function from drivers/net/typhoon.c

NAK -- I'd prefer to make it be used, which was the reason it was there
in the first place... not sure why it wasn't...

===== drivers/net/typhoon.c 1.25 vs edited =====
--- 1.25/drivers/net/typhoon.c	2004-10-21 18:42:58 -04:00
+++ edited/drivers/net/typhoon.c	2004-10-28 20:06:45 -04:00
@@ -1687,8 +1687,7 @@
 		skb = rxb->skb;
 		dma_addr = rxb->dma_addr;
 
-		rxaddr += sizeof(struct rx_desc);
-		rxaddr %= RX_ENTRIES * sizeof(struct rx_desc);
+		typhoon_inc_rx_index(&rxaddr, 1);
 
 		if(rx->flags & TYPHOON_RX_ERROR) {
 			typhoon_recycle_rx_skb(tp, idx);

