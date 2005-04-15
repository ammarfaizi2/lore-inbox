Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVDOPVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVDOPVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 11:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDOPVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 11:21:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35090 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261841AbVDOPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 11:10:54 -0400
Date: Fri, 15 Apr 2005 17:10:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, rmk+serial@arm.linux.org.uk,
       linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Message-ID: <20050415151053.GM5456@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning:

<--  snip  -->

...
  CC      drivers/serial/8250_acpi.o
drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
drivers/serial/8250_acpi.c:51: warning: implicit declaration of function 
`acpi_register_gsi'
...

<--  snip  -->

This patch was already ACK'ed by Bjorn Helgaas.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Apr 2005

--- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old	2005-04-05 15:58:59.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c	2005-04-05 16:01:47.000000000 +0200
@@ -9,6 +9,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/config.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>


