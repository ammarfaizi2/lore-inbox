Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUBTTH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUBTTHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:07:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:63717 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261265AbUBTTGW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:22 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039813376@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:21 -0800
Message-Id: <10773039813517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1580, 2004/02/20 09:20:38-08:00, Martine.Silbermann@hp.com

[PATCH] PCI: update MSI Documentation

After getting feedback from Tom,I made some changes to the patch
Attached is a revised version.


 Documentation/MSI-HOWTO.txt |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)


diff -Nru a/Documentation/MSI-HOWTO.txt b/Documentation/MSI-HOWTO.txt
--- a/Documentation/MSI-HOWTO.txt	Fri Feb 20 10:44:24 2004
+++ b/Documentation/MSI-HOWTO.txt	Fri Feb 20 10:44:24 2004
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

