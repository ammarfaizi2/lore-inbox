Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTFJVgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTFJVg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:36:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32156 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263375AbTFJShE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:04 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709672299@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709671265@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1354, 2003/06/09 16:03:01-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/cpqfcTSinit.c


 drivers/scsi/cpqfcTSinit.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
--- a/drivers/scsi/cpqfcTSinit.c	Tue Jun 10 11:19:31 2003
+++ b/drivers/scsi/cpqfcTSinit.c	Tue Jun 10 11:19:31 2003
@@ -298,12 +298,6 @@
   ScsiHostTemplate->proc_name = "cpqfcTS";
 #endif
 
-  if( pci_present() == 0) // no PCI busses?
-  {
-    printk( "  no PCI bus?@#!\n");
-    return NumberOfAdapters;
-  }
-
   for( i=0; i < HBA_TYPES; i++)
   {
     // look for all HBAs of each type

