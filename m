Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWIZQdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWIZQdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWIZQdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:33:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64138 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932350AbWIZQdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:33:18 -0400
Subject: [PATCH] libata-sff: use our IRQ defines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 17:55:37 +0100
Message-Id: <1159289737.11049.261.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/libata-sff.c linux-2.6.18-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/libata-sff.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/libata-sff.c	2006-09-25 16:04:41.000000000 +0100
@@ -881,7 +881,7 @@
 	probe_ent->private_data = port[0]->private_data;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = 14;
+		probe_ent->irq = ATA_PRIMARY_IRQ;
 		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
 		probe_ent->port[0].altstatus_addr =
 		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
@@ -896,7 +896,7 @@
 
 	if (port_mask & ATA_PORT_SECONDARY) {
 		if (probe_ent->irq)
-			probe_ent->irq2 = 15;
+			probe_ent->irq2 = ATA_SECONDARY_IRQ;
 		else
 			probe_ent->irq = 15;
 		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;

