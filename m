Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTFJUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTFJUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:45:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13952 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263938AbTFJShR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:17 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709682643@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709683543@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1357, 2003/06/09 16:04:35-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/scsi/gdth.c


 drivers/scsi/gdth.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
--- a/drivers/scsi/gdth.c	Tue Jun 10 11:19:14 2003
+++ b/drivers/scsi/gdth.c	Tue Jun 10 11:19:14 2003
@@ -4460,9 +4460,7 @@
     }
 
     /* scanning for PCI controllers */
-#if LINUX_VERSION_CODE >= 0x2015C
-    if (pci_present())
-#else
+#if LINUX_VERSION_CODE < 0x2015C
     if (pcibios_present())
 #endif
     {

