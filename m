Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266111AbTFWTHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbTFWTHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266111AbTFWTHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:07:47 -0400
Date: Mon, 23 Jun 2003 20:21:54 +0100
From: Matthew Wilcox <willy@debian.org>
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [willy@debian.org: [PATCH] Missing Kconfig dependencies]
Message-ID: <20030623192154.GB25982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DavidM wants these to go via you, Russell.

----- Forwarded message from Matthew Wilcox <willy@debian.org> -----

Date:	Mon, 23 Jun 2003 20:11:47 +0100
From:	Matthew Wilcox <willy@debian.org>
To:	linux-ia64@vger.kernel.org
Subject: [PATCH] Missing Kconfig dependencies
User-Agent: Mutt/1.4.1i
Precedence: bulk
X-Mailing-List:	linux-ia64@vger.kernel.org


If one turns off SERIAL_8250, these items shouldn't be selectable.
Also gets the indentation right in `make oldconfig'.

Index: drivers/serial/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/serial/Kconfig,v
retrieving revision 1.13
diff -u -p -r1.13 Kconfig
--- a/drivers/serial/Kconfig	23 Jun 2003 03:30:31 -0000	1.13
+++ b/drivers/serial/Kconfig	23 Jun 2003 19:01:59 -0000
@@ -80,14 +80,14 @@ config SERIAL_8250_CS
 config SERIAL_8250_ACPI
 	bool "8250/16550 device discovery via ACPI namespace"
 	default y if IA64
-	depends on ACPI_BUS
+	depends on ACPI_BUS && SERIAL_8250
 	---help---
 	  If you wish to enable serial port discovery via the ACPI
 	  namespace, say Y here.  If unsure, say N.
 
 config SERIAL_8250_HCDP
 	bool "8250/16550 device discovery support via EFI HCDP table"
-	depends on IA64
+	depends on IA64 && SERIAL_8250
 	---help---
 	  If you wish to make the serial console port described by the EFI
 	  HCDP table available for use as serial console or general

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



----- End forwarded message -----

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
