Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbRBKUNl>; Sun, 11 Feb 2001 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRBKUNb>; Sun, 11 Feb 2001 15:13:31 -0500
Received: from tazenda.demon.co.uk ([158.152.220.239]:55302 "EHLO
	tazenda.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129853AbRBKUNQ>; Sun, 11 Feb 2001 15:13:16 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: linux-kernel@vger.kernel.org
Subject: small patch for unsigned char breakage in rtl8129 driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Feb 2001 20:12:54 +0000
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14S2rf-0003or-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/drivers/net/rtl8129.c	Sat Nov  4 16:42:22 2000
+++ linux/drivers/net/rtl8129.c	Sat Nov  4 16:48:21 2000
@@ -271,7 +271,7 @@ struct rtl8129_private {
 	unsigned char *tx_bufs;				/* Tx bounce buffer region. */
 	dma_addr_t rx_ring_dma;
 	dma_addr_t tx_bufs_dma;
-	char phys[4];						/* MII device addresses. */
+	signed char phys[4];				/* MII device addresses. */
 	char twistie, twist_cnt;			/* Twister tune state. */
 	unsigned int tx_full:1;				/* The Tx queue is full. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
