Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUG3JdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUG3JdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 05:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267665AbUG3JdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 05:33:24 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:39595 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267661AbUG3JdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 05:33:22 -0400
Message-ID: <410A15CC.4070607@bull.net>
Date: Fri, 30 Jul 2004 11:33:00 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] watchdog: fix warning "defined but not used"
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/07/2004 11:36:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/07/2004 11:38:02,
	Serialize complete at 30/07/2004 11:38:02
Content-Type: multipart/mixed;
 boundary="------------070304000303040907060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304000303040907060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

  Function wdtpci_init_one() in file wdt_pci.c generates a warning when 
compiling the watchdog driver. Here is a trivial patch for 2.6.8-rc2 to 
remove this warning.

HTH
Guillaume

--------------070304000303040907060303
Content-Type: text/plain;
 name="patch-wdt_pci"
Content-Disposition: inline;
 filename="patch-wdt_pci"
Content-Transfer-Encoding: 7bit

--- wdt_pci.c.orig	2004-07-30 09:00:13.435106288 +0200
+++ wdt_pci.c	2004-07-30 09:00:31.465365272 +0200
@@ -682,8 +682,8 @@ out:
 out_misc:
 #ifdef CONFIG_WDT_501_PCI
 	misc_deregister(&temp_miscdev);
-#endif /* CONFIG_WDT_501_PCI */
 out_rbt:
+#endif /* CONFIG_WDT_501_PCI */
 	unregister_reboot_notifier(&wdtpci_notifier);
 out_irq:
 	free_irq(irq, &wdtpci_miscdev);


--------------070304000303040907060303--
