Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWJPO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWJPO54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJPO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:57:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30694 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750736AbWJPO5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:57:55 -0400
Subject: PATCH: ahci - readability tweak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:21:40 +0100
Message-Id: <1161012100.24237.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/ata/ahci.c linux-2.6.19-rc1-mm1/drivers/ata/ahci.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/ata/ahci.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/ata/ahci.c	2006-10-13 17:14:40.000000000 +0100
@@ -1046,7 +1046,7 @@
 	/* hmmm... a spurious interupt */
 
 	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+	if (ap->sactive && (status & PORT_IRQ_D2H_REG_FIS))
 		return;
 
 	/* ignore interim PIO setup fis interrupts */

