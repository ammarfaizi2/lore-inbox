Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVCCLSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVCCLSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVCCLQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:16:50 -0500
Received: from router.activetools.si ([213.250.28.33]:50585 "EHLO vafel.at.lan")
	by vger.kernel.org with ESMTP id S261624AbVCCLOL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:14:11 -0500
Subject: [PATCH] initialize a spin lock in CPM2 uart driver
From: Jaka =?iso-8859-2?Q?Mo=E8nik?= <jaka@activetools.si>
To: kumar.gala@freescale.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Mar 2005 12:13:52 +0100
Message-Id: <1109848432.29455.31.camel@x.at.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static initialization of spin locks that are otherwise accessed prior to
initialization.

Signed-off-by: Jaka Močnik <jaka@activetools.si>

--- linux-2.6.11/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-03 12:07:17.482520924 +0100
+++ linux-2.6.11-sgn/drivers/serial/cpm_uart/cpm_uart_core.c	2005-03-03 10:08:02.000000000 +0100
@@ -864,6 +864,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SMC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -877,6 +878,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SMC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.flags = FLAG_SMC,
 		.tx_nrfifos = TX_NUM_FIFO,
@@ -893,6 +895,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SCC1_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -905,6 +908,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SCC2_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -917,6 +921,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SCC3_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,
@@ -929,6 +934,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 			.irq		= SCC4_IRQ,
 			.ops		= &cpm_uart_pops,
 			.iotype		= SERIAL_IO_MEM,
+			.lock		= SPIN_LOCK_UNLOCKED,
 		},
 		.tx_nrfifos = TX_NUM_FIFO,
 		.tx_fifosize = TX_BUF_SIZE,

