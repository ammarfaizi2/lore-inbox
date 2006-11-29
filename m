Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933429AbWK2FMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbWK2FMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933709AbWK2FMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:12:08 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:63619 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933429AbWK2FMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:12:06 -0500
Date: Tue, 28 Nov 2006 21:08:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dwmw2@infradead.org
Subject: [PATCH -mm] MTD: ESB2ROM uses PCI
Message-Id: <20061128210824.39eb2996.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

ESB2ROM uses PCI interface functions.

With CONFIG_PCI=n:
drivers/mtd/maps/esb2rom.c: In function 'esb2rom_init_one':
drivers/mtd/maps/esb2rom.c:167: warning: implicit declaration of function 'pci_dev_get'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/mtd/maps/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2.orig/drivers/mtd/maps/Kconfig
+++ linux-2.6.19-rc6-mm2/drivers/mtd/maps/Kconfig
@@ -186,7 +186,7 @@ config MTD_ICHXROM
 
 config MTD_ESB2ROM
         tristate "BIOS flash chip on Intel ESB Controller Hub 2"
-        depends on X86 && MTD_JEDECPROBE
+        depends on X86 && MTD_JEDECPROBE && PCI
         help
           Support for treating the BIOS flash chip on ESB2 motherboards
           as an MTD device - with this you can reprogram your BIOS.


---
