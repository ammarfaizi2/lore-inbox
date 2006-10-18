Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWJRH1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWJRH1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJRH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:27:42 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:29130 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP
	id S1751182AbWJRH1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:27:41 -0400
Message-ID: <4535D76C.4080903@netbauds.net>
Date: Wed, 18 Oct 2006 08:27:40 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.0.7) Gecko/20060929 SeaMonkey/1.0.5
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH 2.6.18.1 drivers/net/sk98lin/sky2.c compile fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was necessary to make 2.6.18.1 build.

--- linux-2.6.18.1/drivers/net/sk98lin/sky2.c~  2006-10-17 00:27:02.000000000 +0100
+++ linux-2.6.18.1/drivers/net/sk98lin/sky2.c   2006-10-17 00:27:02.000000000 +0100
@@ -1007,7 +1007,7 @@
                        SK_DBG_MSG(pAC, SK_DBGMOD_DRV, SK_DBGCAT_DRV_TX_PROGRESS,
                                ("\tGet LE\n"));
 #ifdef NETIF_F_TSO
-                       Mss = skb_shinfo(pSkPacket->pMBuf)->tso_size;
+                       Mss = skb_shinfo(pSkPacket->pMBuf)->gso_size;
                        if (Mss) {
                                TcpOptLen = ((pSkPacket->pMBuf->h.th->doff - 5) * 4);
                                IpTcpLen  = ((pSkPacket->pMBuf->nh.iph->ihl * 4) +



-- 
Darryl L. Miles


