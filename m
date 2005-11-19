Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVKSVkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVKSVkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVKSVkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:40:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51084 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750853AbVKSVj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:39:59 -0500
Subject: PATCH: Fix enable bits for triflex
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 22:12:14 +0000
Message-Id: <1132438334.19692.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same again but for triflex

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.14-mm2/drivers/scsi/pata_triflex.c linux-2.6.14-mm2/drivers/scsi/pata_triflex.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_triflex.c	2005-11-19 17:28:03.000000000 +0000
+++ linux-2.6.14-mm2/drivers/scsi/pata_triflex.c	2005-11-19 17:34:45.000000000 +0000
@@ -49,8 +49,8 @@
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	static struct pci_bits triflex_enable_bits[] = {
-		{ 0x80, 0x01, 0x01 },
-		{ 0x80, 0x02, 0x02 }
+		{ 0x80, 1, 0x01, 0x01 },
+		{ 0x80, 1, 0x02, 0x02 }
 	};
 
 	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->hard_port_no])) {

