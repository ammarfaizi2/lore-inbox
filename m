Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTFJUpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFJUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:45:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15488 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263944AbTFJShS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:18 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709662135@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709661346@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1334, 2003/06/09 15:39:26-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/media/radio/radio-maestro.c


 drivers/media/radio/radio-maestro.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c	Tue Jun 10 11:21:17 2003
+++ b/drivers/media/radio/radio-maestro.c	Tue Jun 10 11:21:17 2003
@@ -285,8 +285,6 @@
 {
 	register __u16 found=0;
 	struct pci_dev *pcidev = NULL;
-	if(!pci_present())
-		return -ENODEV;
 	while(!found && (pcidev = pci_find_device(PCI_VENDOR_ESS, 
 						  PCI_DEVICE_ID_ESS_ESS1968,
 						  pcidev)))

