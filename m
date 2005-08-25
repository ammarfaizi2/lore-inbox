Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVHYG5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVHYG5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbVHYG5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:57:16 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:211 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S1751548AbVHYG5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:57:15 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: libata-dev queue updated
Date: Thu, 25 Aug 2005 15:56:23 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF001617907@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Thread-Topic: libata-dev queue updated
Thread-Index: AcWoeP47hU0VTa3rT/uhuG/37gARFAAxf5tQ
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: "Jeff Garzik" <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

2.6.13- rc7-libata1.patch.bz2 was used. 
A combined mode of ata_piix seems not to work. 
Is the following patches correct?

diff -urN linux-2.6.13-rc7.orig/drivers/scsi/Kconfig linux-2.6.13-rc7/drivers/scsi/Kconfig
--- linux-2.6.13-rc7.orig/drivers/scsi/Kconfig	2005-08-25 13:44:33.000000000 +0900
+++ linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-08-25 14:33:38.000000000 +0900
@@ -424,7 +424,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	tristate "Serial ATA (SATA) support"
+	bool "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers

--
Haruo
