Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270109AbUJSXQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbUJSXQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270108AbUJSXMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:12:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:24714 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270178AbUJSWqq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:46 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225739230@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257391349@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.63, 2004/10/06 14:08:45-07:00, greg@kroah.com

[PATCH] PCI: remove pci_module_init() usage from drivers/usb/*

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/goku_udc.c |    2 +-
 drivers/usb/gadget/net2280.c  |    2 +-
 drivers/usb/host/ehci-hcd.c   |    2 +-
 drivers/usb/host/ohci-pci.c   |    2 +-
 drivers/usb/host/uhci-hcd.c   |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
--- a/drivers/usb/gadget/goku_udc.c	2004-10-19 15:21:42 -07:00
+++ b/drivers/usb/gadget/goku_udc.c	2004-10-19 15:21:42 -07:00
@@ -1976,7 +1976,7 @@
 
 static int __init init (void)
 {
-	return pci_module_init (&goku_pci_driver);
+	return pci_register_driver (&goku_pci_driver);
 }
 module_init (init);
 
diff -Nru a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
--- a/drivers/usb/gadget/net2280.c	2004-10-19 15:21:41 -07:00
+++ b/drivers/usb/gadget/net2280.c	2004-10-19 15:21:41 -07:00
@@ -2935,7 +2935,7 @@
 {
 	if (!use_dma)
 		use_dma_chaining = 0;
-	return pci_module_init (&net2280_pci_driver);
+	return pci_register_driver (&net2280_pci_driver);
 }
 module_init (init);
 
diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2004-10-19 15:21:42 -07:00
+++ b/drivers/usb/host/ehci-hcd.c	2004-10-19 15:21:42 -07:00
@@ -1092,7 +1092,7 @@
 		sizeof (struct ehci_qh), sizeof (struct ehci_qtd),
 		sizeof (struct ehci_itd), sizeof (struct ehci_sitd));
 
-	return pci_module_init (&ehci_pci_driver);
+	return pci_register_driver (&ehci_pci_driver);
 }
 module_init (init);
 
diff -Nru a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
--- a/drivers/usb/host/ohci-pci.c	2004-10-19 15:21:42 -07:00
+++ b/drivers/usb/host/ohci-pci.c	2004-10-19 15:21:42 -07:00
@@ -279,7 +279,7 @@
 
 	pr_debug ("%s: block sizes: ed %Zd td %Zd\n", hcd_name,
 		sizeof (struct ed), sizeof (struct td));
-	return pci_module_init (&ohci_pci_driver);
+	return pci_register_driver (&ohci_pci_driver);
 }
 module_init (ohci_hcd_pci_init);
 
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	2004-10-19 15:21:42 -07:00
+++ b/drivers/usb/host/uhci-hcd.c	2004-10-19 15:21:42 -07:00
@@ -2534,7 +2534,7 @@
 	if (!uhci_up_cachep)
 		goto up_failed;
 
-	retval = pci_module_init(&uhci_pci_driver);
+	retval = pci_register_driver(&uhci_pci_driver);
 	if (retval)
 		goto init_failed;
 

