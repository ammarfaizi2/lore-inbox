Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267939AbTBRRzr>; Tue, 18 Feb 2003 12:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBRRzq>; Tue, 18 Feb 2003 12:55:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21257 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267939AbTBRRyd>; Tue, 18 Feb 2003 12:54:33 -0500
Subject: PATCH: remove ide_ioreg_t
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:04:55 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC6x-00067n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-pnp.c linux-2.5.61-ac2/drivers/ide/ide-pnp.c
--- linux-2.5.61/drivers/ide/ide-pnp.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-pnp.c	2003-02-18 18:06:17.000000000 +0000
@@ -58,9 +58,9 @@
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
 		return 1;
 
-	ide_setup_ports(&hw, (ide_ioreg_t) pnp_port_start(dev, 0),
+	ide_setup_ports(&hw, (unsigned long) pnp_port_start(dev, 0),
 			generic_ide_offsets,
-			(ide_ioreg_t) pnp_port_start(dev, 1),
+			(unsigned long) pnp_port_start(dev, 1),
 			0, NULL,
 //			generic_pnp_ide_iops,
 			pnp_irq(dev, 0));
