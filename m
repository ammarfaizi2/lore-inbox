Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUBIX6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUBIX5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:57:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:60092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265420AbUBIXWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:36 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <1076368940145@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:20 -0800
Message-Id: <10763689403898@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.14, 2004/02/03 16:49:23-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: very small optimisations for ibmphp_pci.c


 drivers/pci/hotplug/ibmphp_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	Mon Feb  9 14:58:51 2004
+++ b/drivers/pci/hotplug/ibmphp_pci.c	Mon Feb  9 14:58:51 2004
@@ -49,7 +49,7 @@
  */
 static void assign_alt_irq (struct pci_func * cur_func, u8 class_code)
 {
-	int j = 0;
+	int j;
 	for (j = 0; j < 4; j++) {
 		if (cur_func->irq[j] == 0xff) {
 			switch (class_code) {

