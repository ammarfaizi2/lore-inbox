Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWHHDvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWHHDvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWHHDvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:51:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5516 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932477AbWHHDvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:51:11 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch 2.6.18-rc4] Fix compile problem when sata debugging is on
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 13:51:02 +1000
Message-ID: <8004.1155009062@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a sata debug print statement that still uses an old variable name.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

---
 drivers/scsi/ata_piix.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -567,8 +567,8 @@ static int piix_sata_prereset(struct ata
 			present = 1;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
-		ap->id, pcs, present_mask);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
+		ap->id, pcs, present);
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");

