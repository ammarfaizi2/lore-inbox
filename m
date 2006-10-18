Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWJRR1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWJRR1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJRR1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:27:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22507 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422730AbWJRR1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:27:04 -0400
Subject: [PATCH] irq updates: make eata_pio compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:29:39 +0100
Message-Id: <1161192579.9363.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/scsi/eata_pio.c linux-2.6.19-rc2-mm1/drivers/scsi/eata_pio.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/scsi/eata_pio.c	2006-10-18 13:50:22.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/scsi/eata_pio.c	2006-10-18 15:25:45.000000000 +0100
@@ -203,7 +203,7 @@
 	irqreturn_t ret;
 
 	spin_lock_irqsave(dev->host_lock, flags);
-	ret = eata_pio_int_handler(irq, dev_id, regs);
+	ret = eata_pio_int_handler(irq, dev_id);
 	spin_unlock_irqrestore(dev->host_lock, flags);
 	return ret;
 }

