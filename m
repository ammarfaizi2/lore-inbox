Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318311AbSGRSzu>; Thu, 18 Jul 2002 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSGRSzu>; Thu, 18 Jul 2002 14:55:50 -0400
Received: from gherkin.frus.com ([192.158.254.49]:56704 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318311AbSGRSzq>;
	Thu, 18 Jul 2002 14:55:46 -0400
Message-Id: <m17VGU9-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] 2.5.26: linux/drivers/ide/device.c
To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2002 13:58:45 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM728348290-2536-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM728348290-2536-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Attached is a minor patch against 2.5.26 that exports two symbols needed
for modular IDE support.  Example: pure SCSI machine with PCMCIA/cardbus
and/or USB IDE devices.  This problem has existed since at least 2.5.24.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM728348290-2536-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch26_ide

--- linux/drivers/ide/device.c.orig	Wed Jul 17 09:44:32 2002
+++ linux/drivers/ide/device.c	Wed Jul 17 11:44:23 2002
@@ -79,6 +79,8 @@
 		ch->maskproc(drive);
 }
 
+EXPORT_SYMBOL(ata_mask);
+
 /*
  * Check the state of the status register.
  */
@@ -209,6 +211,8 @@
 	OUT_BYTE(rf->low_cylinder, ch->io_ports[IDE_LCYL_OFFSET]);
 	OUT_BYTE(rf->high_cylinder, ch->io_ports[IDE_HCYL_OFFSET]);
 }
+
+EXPORT_SYMBOL(ata_out_regfile);
 
 /*
  * Input a complete register file.

--ELM728348290-2536-0_--
