Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWJCVES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWJCVES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWJCVER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:04:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:25499 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030416AbWJCVEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:04:14 -0400
Date: Tue, 3 Oct 2006 16:04:08 -0500
To: akpm@osdl.org, jeff@garzik.org
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4]: Spidernet module parm permissions
Message-ID: <20061003210408.GI4381@austin.ibm.com>
References: <20061003205240.GE4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003205240.GE4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The module param permsissions should bw read-only, not writable.

Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-02 19:09:38.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-02 19:14:48.000000000 -0500
@@ -60,8 +60,8 @@ MODULE_VERSION(VERSION);
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
 
-module_param(rx_descriptors, int, 0644);
-module_param(tx_descriptors, int, 0644);
+module_param(rx_descriptors, int, 0444);
+module_param(tx_descriptors, int, 0444);
 
 MODULE_PARM_DESC(rx_descriptors, "number of descriptors used " \
 		 "in rx chains");
