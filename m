Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTFJVPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTFJVCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:02:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4271 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262530AbTFJShN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:13 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270966633@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270966860@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1336, 2003/06/09 15:40:32-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/acenic.c


 drivers/net/acenic.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/net/acenic.c b/drivers/net/acenic.c
--- a/drivers/net/acenic.c	Tue Jun 10 11:21:08 2003
+++ b/drivers/net/acenic.c	Tue Jun 10 11:21:08 2003
@@ -618,9 +618,6 @@
 		return -ENODEV;
 	probed++;
 
-	if (!pci_present())		/* is PCI support present? */
-		return -ENODEV;
-
 	version_disp = 0;
 
 	while ((pdev = pci_find_class(PCI_CLASS_NETWORK_ETHERNET<<8, pdev))) {

