Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTFJUbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFJShT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3228 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbTFJSgw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:52 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270969809@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709691672@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1369, 2003/06/09 16:12:47-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/video/pm2fb.c


 drivers/video/pm2fb.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	Tue Jun 10 11:18:15 2003
+++ b/drivers/video/pm2fb.c	Tue Jun 10 11:18:15 2003
@@ -1186,10 +1186,6 @@
 #endif
 
 	memset(pci, 0, sizeof(struct pm2pci_par));
-	if (!pci_present()) {
-		DPRINTK("no PCI bus found.\n");
-		return 0;
-	}
 	DPRINTK("scanning PCI bus for known chipsets...\n");
 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {

