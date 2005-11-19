Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVKSVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVKSVpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVKSVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:45:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38273 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750879AbVKSVpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:45:15 -0500
Subject: PATCH: VIA alternative patch set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 22:17:30 +0000
Message-Id: <1132438650.19692.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set applies if you want to fix the pata_via enablebits but don't
want to rely on the private_data patch or push that into the main tree
yet.

Alan

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.14-mm2/drivers/scsi/pata_via.c linux-2.6.14-mm2/drivers/scsi/pata_via.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_via.c	2005-11-19 17:28:03.000000000 +0000
+++ linux-2.6.14-mm2/drivers/scsi/pata_via.c	2005-11-19 17:34:41.000000000 +0000
@@ -151,8 +151,8 @@
 
 	/* Note: When we add VIA 6410 remember it doesn't have enable bits */
 	static struct pci_bits via_enable_bits[] = {
-		{ 0x40, 0x02, 0x02 },
-		{ 0x40, 0x01, 0x01 }
+		{ 0x40, 1, 0x02, 0x02 },
+		{ 0x40, 1, 0x01, 0x01 }
 	};
 
 	if (!pci_test_config_bits(pdev, &via_enable_bits[ap->hard_port_no])) {

