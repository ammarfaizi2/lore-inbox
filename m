Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUI1N6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUI1N6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUI1N6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:58:17 -0400
Received: from owa.go-wlan.com ([192.114.175.10]:320 "EHLO owa.go-wlan.com")
	by vger.kernel.org with ESMTP id S267823AbUI1N4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:56:12 -0400
Subject: [PATCH] export __dma_sync under
	arch/ppc/linux/kernel/dma-mapping.c,2.6.8.1
From: Elad Ben-Israel <eladb@go-wlan.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096379760.4145.166.camel@dt-eladb-01.go80211.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 15:56:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__dma_sync() needs to be exported from dma-mapping.c under PPC.
we needed it in order to make MadWiFi (the Atheros 802.11 driver) work
with 2.6.8.1 under ppc.

Elad Ben-Israel
eladb@go-wlan.com

--- linux-2.6.8.1/arch/ppc/kernel/dma-mapping.c	2004-09-27 21:03:54.000000000 +0200
+++ linux/arch/ppc/kernel/dma-mapping.c	2004-09-27 20:58:01.000000000 +0200
@@ -381,6 +381,7 @@
 		break;
 	}
 }
+EXPORT_SYMBOL(__dma_sync);
 

 #ifdef CONFIG_HIGHMEM
