Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTFECB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTFECB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:01:59 -0400
Received: from granite.he.net ([216.218.226.66]:53766 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264379AbTFECBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:01:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787462276@kroah.com>
Subject: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <20030605013147.GA9804@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1229.25.1, 2003/05/28 15:54:26-05:00, Matt_Domsch@dell.com

dynids: use list_add_tail

instead of list_add, such that later entries come later in the scanned list.


 drivers/pci/pci-driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Jun  4 18:12:29 2003
+++ b/drivers/pci/pci-driver.c	Wed Jun  4 18:12:29 2003
@@ -235,7 +235,7 @@
 		driver_data : 0UL;
 
 	spin_lock(&pdrv->dynids.lock);
-	list_add(&pdrv->dynids.list, &dynid->node);
+	list_add_tail(&pdrv->dynids.list, &dynid->node);
 	spin_unlock(&pdrv->dynids.lock);
 
 	bus = get_bus(pdrv->driver.bus);

