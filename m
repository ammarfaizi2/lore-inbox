Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUBWQsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBWQpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:45:50 -0500
Received: from mailout.zma.compaq.com ([161.114.64.103]:5137 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261953AbUBWQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:45:13 -0500
Subject: [Fwd: [PATCH]2.6.3-rc2 MSI requirements in Kconfig
From: Martine Silbermann <Martine.Silbermann@hp.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Cc: Martine.Silbermann@hp.com
Content-Type: multipart/mixed; boundary="=-0lShsBK4ixJ5YLsLWSa9"
Organization: 
Message-Id: <1077554729.7740.16.camel@wcswing.americas.cpqcorp.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Feb 2004 11:45:30 -0500
X-OriginalArrivalTime: 23 Feb 2004 16:45:09.0058 (UTC) FILETIME=[65D6B220:01C3FA2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0lShsBK4ixJ5YLsLWSa9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Having spent a non trivial amount of time trying to pull in the 
code to enable MSI, I would suggest that a clear indication in 
Kconfig that MSI requires CONFIG_PCI_USE_VECTOR would be very helpful.
Also since the MSI code was integrated into 2.6.1 I've updated the 
comment that called for installing the MSI patch.
Martine

--=-0lShsBK4ixJ5YLsLWSa9
Content-Disposition: attachment; filename=patch-2.6.3-rc2-MSI-in-Kconfig
Content-Type: text/plain; name=patch-2.6.3-rc2-MSI-in-Kconfig; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2/arch/i386/Kconfig	2004-02-09 22:00:27.000000000 -0500
+++ linux-2.6.3-rc2_mine/arch/i386/Kconfig	2004-02-12 14:24:37.000000000 -0500
@@ -1056,7 +1056,7 @@
 	default y
 
 config PCI_USE_VECTOR
-	bool "Vector-based interrupt indexing"
+	bool "Vector-based interrupt indexing (MSI)"
 	depends on X86_LOCAL_APIC && X86_IO_APIC
 	default n
 	help
@@ -1066,11 +1066,11 @@
 	   1) Support MSI implementation.
 	   2) Support future IOxAPIC hotplug
 
-	   Note that this enables MSI, Message Signaled Interrupt, on all
-	   MSI capable device functions detected if users also install the
-	   MSI patch. Message Signal Interrupt enables an MSI-capable
-	   hardware device to send an inbound Memory Write on its PCI bus
-	   instead of asserting IRQ signal on device IRQ pin.
+	   Note that this allows the device drivers to enable MSI, Message 
+	   Signaled Interrupt, on all MSI capable device functions detected.
+	   Message Signal Interrupt enables an MSI-capable hardware device to
+	   send an inbound Memory Write on its PCI bus instead of asserting
+	   IRQ signal on device IRQ pin.
 
 	   If you don't know what to do here, say N.
 

--=-0lShsBK4ixJ5YLsLWSa9--

