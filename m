Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUBTP7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbUBTP7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:59:09 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:48646 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261301AbUBTP7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:59:00 -0500
Subject: [PATCH]2.6.3-rc2 MSI Documentation
From: Martine Silbermann <Martine.Silbermann@hp.com>
To: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com, greg@kroah.com
Cc: Martine.Silbermann@hp.com
Content-Type: multipart/mixed; boundary="=-noln6gqMiz2e5ZsPwOlH"
Organization: 
Message-Id: <1077292736.7739.6.camel@wcswing.americas.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Feb 2004 10:58:58 -0500
X-OriginalArrivalTime: 20 Feb 2004 15:58:56.0891 (UTC) FILETIME=[724254B0:01C3F7CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-noln6gqMiz2e5ZsPwOlH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After getting feedback from Tom,I made some changes to the patch
Attached is a revised version.
Martine


--=-noln6gqMiz2e5ZsPwOlH
Content-Disposition: attachment; filename=patch-2.6.3-rc2-MSI-doc-v2
Content-Type: text/plain; name=patch-2.6.3-rc2-MSI-doc-v2; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2/Documentation/MSI-HOWTO.txt	2004-02-09 22:00:01.000000000 -0500
+++ linux-2.6.3-rc2_mine/Documentation/MSI-HOWTO.txt	2004-02-20 10:44:41.758947320 -0500
@@ -1,6 +1,8 @@
 		The MSI Driver Guide HOWTO
 	Tom L Nguyen tom.l.nguyen@intel.com
 			10/03/2003
+	Revised Feb 12, 2004 by Martine Silbermann
+		email: Martine.Silbermann@hp.com
 
 1. About this guide
 
@@ -90,17 +92,14 @@
 5. Configuring a driver to use MSI/MSI-X
 
 By default, the kernel will not enable MSI/MSI-X on all devices that
-support this capability once the patch is installed. A kernel
-configuration option must be selected to enable MSI/MSI-X support.
+support this capability. The CONFIG_PCI_USE_VECTOR kernel option
+must be selected to enable MSI/MSI-X support.
 
 5.1 Including MSI support into the kernel
 
-To include MSI support into the kernel requires users to patch the
-VECTOR-base patch first and then the MSI patch because the MSI
-support needs VECTOR based scheme. Once these patches are installed,
-setting CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
-the option for MSI-capable device drivers to selectively enable MSI
-(using pci_enable_msi as desribed below).
+To allow MSI-Capable device drivers to selectively enable MSI (using
+pci_enable_msi as described below), the VECTOR based scheme needs to
+be enabled by setting CONFIG_PCI_USE_VECTOR.
 
 Since the target of the inbound message is the local APIC, providing
 CONFIG_PCI_USE_VECTOR is dependent on whether CONFIG_X86_LOCAL_APIC
@@ -130,7 +129,7 @@
 5.2 Configuring for MSI support
 
 Due to the non-contiguous fashion in vector assignment of the
-existing Linux kernel, this patch does not support multiple
+existing Linux kernel, this version does not support multiple
 messages regardless of the device function is capable of supporting
 more than one vector. The bus driver initializes only entry 0 of
 this capability if pci_enable_msi(...) is called successfully by
@@ -232,7 +231,7 @@
 CONFIG_X86_LOCAL_APIC. Once CONFIG_X86_LOCAL_APIC=y, setting
 CONFIG_PCI_USE_VECTOR enables the VECTOR based scheme and
 the option for MSI-capable device drivers to selectively enable
-MSI (using pci_enable_msi as desribed below).
+MSI (using pci_enable_msi as described below).
 
 Note that CONFIG_X86_IO_APIC setting is irrelevant because MSI
 vector is allocated new during runtime and MSI support does not

--=-noln6gqMiz2e5ZsPwOlH--

