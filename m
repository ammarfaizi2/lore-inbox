Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTE2EqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTE2EqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 00:46:23 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:40584
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S261872AbTE2EqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 00:46:22 -0400
Date: Thu, 29 May 2003 00:59:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH rc6] fix olympic driver build
Message-ID: <20030529045939.GA25707@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply un-splits a quoted string that is split across two lines,
most likely by an editor's word wrapping.

Breaks kernel build w/ gcc 3.3.

	Jeff




# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1231  -> 1.1232 
#	drivers/net/tokenring/olympic.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	jgarzik@redhat.com	1.1232
# [netdrvr olympic] fix build with gcc 3.3
# --------------------------------------------
#
diff -Nru a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
--- a/drivers/net/tokenring/olympic.c	Thu May 29 00:56:47 2003
+++ b/drivers/net/tokenring/olympic.c	Thu May 29 00:56:47 2003
@@ -655,8 +655,7 @@
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr = %08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
