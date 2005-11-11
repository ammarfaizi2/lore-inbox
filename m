Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVKKBeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVKKBeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVKKBeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:34:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:61889 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751233AbVKKBeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:34:14 -0500
Date: Thu, 10 Nov 2005 20:34:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: [PATCH] lpfc build fix
Message-ID: <20051111013412.GA28149@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current upstream 'allmodconfig' build is broken.  This is the obvious
patch...

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c907238..0749811 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1704,7 +1704,6 @@ MODULE_DEVICE_TABLE(pci, lpfc_id_table);
 
 static struct pci_driver lpfc_driver = {
 	.name		= LPFC_DRIVER_NAME,
-	.owner		= THIS_MODULE,
 	.id_table	= lpfc_id_table,
 	.probe		= lpfc_pci_probe_one,
 	.remove		= __devexit_p(lpfc_pci_remove_one),
