Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTFJUx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTFJUrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:47:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12672 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263930AbTFJShR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:17 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709671561@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709673434@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1350, 2003/06/09 16:01:11-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/3w-xxxx.c


 drivers/scsi/3w-xxxx.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
--- a/drivers/scsi/3w-xxxx.c	Tue Jun 10 11:19:52 2003
+++ b/drivers/scsi/3w-xxxx.c	Tue Jun 10 11:19:52 2003
@@ -2379,12 +2379,6 @@
 
 	printk(KERN_WARNING "3ware Storage Controller device driver for Linux v%s.\n", tw_driver_version);
 
-	/* Check if the kernel has PCI interface compiled in */
-	if (!pci_present()) {
-		printk(KERN_WARNING "3w-xxxx: tw_scsi_detect(): No pci interface present.\n");
-		return 0;
-	}
-
 	ret = tw_findcards(tw_host);
 
 	return ret;

