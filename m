Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275282AbTHMRcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275284AbTHMRcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:32:04 -0400
Received: from mail.kroah.org ([65.200.24.183]:13471 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275282AbTHMRcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:32:00 -0400
Date: Wed, 13 Aug 2003 10:31:51 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, rddunlap@osdl.org, davej@redhat.com,
       willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813173150.GA3317@kroah.com>
References: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813031432.22b6a0d6.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:14:32AM -0700, David S. Miller wrote:
> 
> Hey guys, define a set of macros to make it more readable.
> This would keep the number of lines down and also make
> the C99 folks happy.

Heh, much like the USB people have had for years :)

How about this patch?  If you like it I'll add the pci.h change to the
tree and let you take the tg3.c part.

thanks,

greg k-h

# add PCI_DEVICE() macro to make pci_device_id tables easier to read.

diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
+++ b/drivers/net/tg3.c	Wed Aug 13 10:29:08 2003
@@ -128,36 +128,21 @@
 static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 
 static struct pci_device_id tg3_pci_tbl[] = {
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702FE,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702X,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703X,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704S,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702A3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703A3,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_SYSKONNECT, 0x4400,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1000,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1001,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702FE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702X) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703X) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704S) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702A3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703A3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x4400) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1000) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1001) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100) },
 	{ 0, }
 };
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Aug 13 10:29:08 2003
+++ b/include/linux/pci.h	Wed Aug 13 10:29:08 2003
@@ -524,6 +524,18 @@
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
 
+/**
+ * PCI_DEVICE - macro used to describe a specific pci device
+ * @vend: the 16 bit PCI Vendor ID
+ * @dev: the 16 bit PCI Device ID
+ *
+ * This macro is used to create a struct pci_device_id that matches a
+ * specific device.  The subvendor and subdevice fields will be set to
+ * PCI_ANY_ID.
+ */
+#define PCI_DEVICE(vend,dev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
