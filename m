Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFJS7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFJSnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34223 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264035AbTFJShb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270970872@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270970236@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1382, 2003/06/09 16:22:20-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/skeleton.c


 sound/oss/skeleton.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/sound/oss/skeleton.c b/sound/oss/skeleton.c
--- a/sound/oss/skeleton.c	Tue Jun 10 11:16:46 2003
+++ b/sound/oss/skeleton.c	Tue Jun 10 11:16:46 2003
@@ -159,10 +159,6 @@
 	struct pci_dev *pcidev=NULL;
 	int count=0;
 		
-	if(!pci_present())
-		return -ENODEV;
-	
-		
 	while((pcidev = pci_find_device(PCI_VENDOR_MYIDENT, PCI_DEVICE_ID_MYIDENT_MYCARD1, pcidev))!=NULL)
 	{
 		if (pci_enable_device(pcidev))

