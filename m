Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTFJUZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFJUZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:25:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:11397 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263973AbTFJShY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:24 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709651213@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651938@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1328, 2003/06/09 15:36:15-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/stallion.c


 drivers/char/stallion.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Tue Jun 10 11:21:45 2003
+++ b/drivers/char/stallion.c	Tue Jun 10 11:21:45 2003
@@ -2804,9 +2804,6 @@
 	printk("stl_findpcibrds()\n");
 #endif
 
-	if (! pci_present())
-		return(0);
-
 	for (i = 0; (i < stl_nrpcibrds); i++)
 		while ((dev = pci_find_device(stl_pcibrds[i].vendid,
 		    stl_pcibrds[i].devid, dev))) {

