Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVAQWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVAQWVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVAQWV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:21:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:23199 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262930AbVAQWCI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:08 -0500
Cc: greg@kroah.com
Subject: PCI: move pcie build into the drivers/pci/ subdirectory
In-Reply-To: <11059993132086@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:53 -0800
Message-Id: <11059993131527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.9, 2005/01/17 10:06:44-08:00, greg@kroah.com

PCI: move pcie build into the drivers/pci/ subdirectory

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/Makefile     |    1 -
 drivers/pci/Makefile |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-01-17 13:55:21 -08:00
+++ b/drivers/Makefile	2005-01-17 13:55:21 -08:00
@@ -55,7 +55,6 @@
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
-obj-$(CONFIG_PCIEPORTBUS)	+= pci/pcie/
 obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2005-01-17 13:55:21 -08:00
+++ b/drivers/pci/Makefile	2005-01-17 13:55:21 -08:00
@@ -56,4 +56,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := devlist.h classlist.h
 
+# Build PCI Express stuff if needed
+obj-$(CONFIG_PCIEPORTBUS) += pcie/
 

