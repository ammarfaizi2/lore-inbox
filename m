Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFJUiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFJUcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:6533 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263964AbTFJShW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:22 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709663662@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709663992@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1338, 2003/06/09 15:49:08-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/fc/iph5526.c


 drivers/net/fc/iph5526.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)


diff -Nru a/drivers/net/fc/iph5526.c b/drivers/net/fc/iph5526.c
--- a/drivers/net/fc/iph5526.c	Tue Jun 10 11:20:59 2003
+++ b/drivers/net/fc/iph5526.c	Tue Jun 10 11:20:59 2003
@@ -232,7 +232,7 @@
 
 int __init iph5526_probe(struct net_device *dev)
 {
-	if (pci_present() && (iph5526_probe_pci(dev) == 0))
+	if (iph5526_probe_pci(dev) == 0)
 		return 0;
 	return -ENODEV;
 }
@@ -3720,10 +3720,6 @@
 	unsigned long timeout;
 
 	tmpt->proc_name = "iph5526";
-	if (pci_present() == 0) {
-		printk("iph5526: PCI not present\n");
-		return 0;
-	}
 
 	for (i = 0; i <= MAX_FC_CARDS; i++) 
 		fc[i] = NULL;

