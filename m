Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTFJSmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFJSlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:41:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:931 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264066AbTFJShe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709683543@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709682819@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1356, 2003/06/09 16:04:04-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/eata.c


 drivers/scsi/eata.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/eata.c b/drivers/scsi/eata.c
--- a/drivers/scsi/eata.c	Tue Jun 10 11:19:19 2003
+++ b/drivers/scsi/eata.c	Tue Jun 10 11:19:19 2003
@@ -959,8 +959,6 @@
    unsigned int addr;
    struct pci_dev *dev = NULL;
 
-   if (!pci_present()) return NULL;
-
    while((dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
       addr = pci_resource_start (dev, 0);
 
@@ -983,8 +981,6 @@
 
    struct pci_dev *dev = NULL;
 
-   if (!pci_present()) return;
-
    while((dev = pci_find_class(PCI_CLASS_STORAGE_SCSI << 8, dev))) {
 
 #if defined(DEBUG_PCI_DETECT)
@@ -1409,8 +1405,6 @@
    unsigned int addr, k;
 
    struct pci_dev *dev = NULL;
-
-   if (!pci_present()) return;
 
    for (k = 0; k < MAX_PCI; k++) {
 

