Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRCCPN1>; Sat, 3 Mar 2001 10:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCCPNR>; Sat, 3 Mar 2001 10:13:17 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:15574 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129583AbRCCPNG>; Sat, 3 Mar 2001 10:13:06 -0500
Message-ID: <3AA10A1B.890D3D99@uow.edu.au>
Date: Sun, 04 Mar 2001 02:13:31 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] pci_release_region and pci_request_region
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.3-pre1 has been uploaded.  The following drivers will
not work as modules:

./drivers/net/via-rhine.c
./drivers/net/yellowfin.c
./drivers/net/epic100.c
./drivers/net/8139too.c
./drivers/net/rcpci45.c
./drivers/net/sundance.c

Two new functions need to be exported:

--- linux-2.4.3-pre1/drivers/pci/pci.c	Sat Mar  3 20:52:24 2001
+++ linux-akpm/drivers/pci/pci.c	Sun Mar  4 02:01:07 2001
@@ -1367,6 +1367,8 @@
 EXPORT_SYMBOL(pci_root_buses);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_find_capability);
+EXPORT_SYMBOL(pci_release_regions);
+EXPORT_SYMBOL(pci_request_regions);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_slot);
