Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFJT4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTFJTzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:55:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:11653 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263983AbTFJShZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270969511@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709682208@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1367, 2003/06/09 16:10:13-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/tmscsim.c


 drivers/scsi/tmscsim.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/scsi/tmscsim.c b/drivers/scsi/tmscsim.c
--- a/drivers/scsi/tmscsim.c	Tue Jun 10 11:18:24 2003
+++ b/drivers/scsi/tmscsim.c	Tue Jun 10 11:18:24 2003
@@ -394,7 +394,7 @@
 # define PCI_WRITE_CONFIG_WORD(pd, rv, bv) pci_write_config_word (pd, rv, bv)
 # define PCI_READ_CONFIG_WORD(pd, rv, bv) pci_read_config_word (pd, rv, bv)
 # define PCI_BUS_DEV pdev->bus->number, pdev->devfn
-# define PCI_PRESENT pci_present ()
+# define PCI_PRESENT (1)
 # define PCI_SET_MASTER pci_set_master (pdev)
 # define PCI_FIND_DEVICE(vend, id) (pdev = pci_find_device (vend, id, pdev))
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,10)

