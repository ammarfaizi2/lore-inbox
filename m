Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbTFEUqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTFEUqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:46:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15780 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265118AbTFEUp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:45:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468772002@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468771865@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315, 2003/06/05 12:04:12-07:00, greg@kroah.com

[PATCH] PCI: remove usage of pci_for_each_dev_reverse() in


 drivers/ide/setup-pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	Thu Jun  5 13:52:52 2003
+++ b/drivers/ide/setup-pci.c	Thu Jun  5 13:52:52 2003
@@ -880,7 +880,7 @@
 			ide_scan_pcidev(dev);
 		}
 	} else {
-		pci_for_each_dev_reverse(dev) {
+		while ((dev = pci_find_device_reverse(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 			ide_scan_pcidev(dev);
 		}
 	}

