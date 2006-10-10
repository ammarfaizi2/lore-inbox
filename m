Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWJJVB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWJJVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWJJVBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:01:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30894 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030373AbWJJVBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:01:54 -0400
Date: Tue, 10 Oct 2006 16:01:51 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 6/21]: powerpc/cell spidernet add missing netdev watchdog
Message-ID: <20061010210151.GC4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set the netdev watchdog timer.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:43:51.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:49:56.000000000 -0500
@@ -686,6 +686,7 @@ spider_net_prepare_tx_descr(struct spide
 
 	descr->prev->next_descr_addr = descr->bus_addr;
 
+	card->netdev->trans_start = jiffies; /* set netdev watchdog timer */
 	return 0;
 }
 
