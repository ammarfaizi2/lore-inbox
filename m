Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVI3TgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVI3TgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVI3TgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:36:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46747 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030377AbVI3TgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:36:21 -0400
Date: Fri, 30 Sep 2005 21:32:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Karall <dominik.karall@gmx.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [patch 2.6.14-rc2 1/1] r8169: tone down the r8169 driver
Message-ID: <20050930193250.GA24548@electric-eye.fr.zoreil.com>
References: <20050929143732.59d22569.akpm@osdl.org> <200509302049.45143.dominik.karall@gmx.net> <20050930120723.07d42517.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930120723.07d42517.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tone down the r8169 driver

As an alternative, people can use the boot time 'debug' option
and/or use 'ethtool -s ethX msglvl xyz'. The different messages
are listed at: http://www.zoreil.com/~romieu/r8169/doc/msglvl.txt

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/net/r8169.c~r8169-a00 drivers/net/r8169.c
--- linux-2.6.14-rc2-git/drivers/net/r8169.c~r8169-a00	2005-09-30 21:16:11.749368793 +0200
+++ linux-2.6.14-rc2-git/drivers/net/r8169.c	2005-09-30 21:16:46.687692546 +0200
@@ -92,8 +92,7 @@ VERSION 2.2LK	<2005/01/25>
 #endif /* RTL8169_DEBUG */
 
 #define R8169_MSG_DEFAULT \
-	(NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK | NETIF_MSG_IFUP | \
-	 NETIF_MSG_IFDOWN)
+	(NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | NETIF_MSG_IFDOWN)
 
 #define TX_BUFFS_AVAIL(tp) \
 	(tp->dirty_tx + NUM_TX_DESC - tp->cur_tx - 1)

_
