Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbVCEFgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbVCEFgb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVCEF2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 00:28:35 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:15086 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261964AbVCEFQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:16:14 -0500
Date: Fri, 4 Mar 2005 23:15:07 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, jaka@activetools.si,
       linuxppc-embedded@ozlabs.org
Subject: [PATCH] initialize a spin lock in CPM2 uart driver
Message-ID: <Pine.LNX.4.61.0503042313040.23572@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static initialization of spin locks that are otherwise accessed prior to 
initialization.

Signed-off-by: Jaka Mocnik <jaka@activetools.si>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
   
---

diff -Nru a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-04 23:03:27 -06:00
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-04 23:03:27 -06:00
@@ -864,6 +864,7 @@
 			.irq		= SMC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -877,6 +878,7 @@
 			.irq		= SMC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -893,6 +895,7 @@
 			.irq		= SCC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -905,6 +908,7 @@
 			.irq		= SCC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -917,6 +921,7 @@
 			.irq		= SCC3_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -929,6 +934,7 @@
 			.irq		= SCC4_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
