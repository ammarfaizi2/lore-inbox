Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCCERk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCCERk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVCCEPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:15:36 -0500
Received: from schokokeks.org ([193.201.54.11]:28032 "EHLO a.mx.schokokeks.org")
	by vger.kernel.org with ESMTP id S262505AbVCBWpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:45:38 -0500
From: Hanno =?utf-8?q?B=C3=B6ck?= <mail@hboeck.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH: Whitelist-Entry (FORCELUN) for SGS Thomson Microelectronics Cytronix 6in1 card reader in scsi_devinfo.c
Date: Wed, 2 Mar 2005 23:49:56 +0100
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022349.56262.mail@hboeck.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an usb-cardreader here that needs some FORCELUN-entries in scsi_devinfo.c.

lsusb says about the device:
Bus 001 Device 003: ID 0483:1307 SGS Thomson Microelectronics Cytronix 6in1 card reader

Patch see below. Please apply.




--- linux-2.6.11-buju/drivers/scsi/scsi_devinfo.c	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.11/drivers/scsi/scsi_devinfo.c	2005-03-02 23:42:56.961751736 +0100
@@ -148,6 +148,10 @@
 	{"Generic", "USB SD Reader", "1.00", BLIST_FORCELUN | BLIST_INQUIRY_36},
 	{"Generic", "USB Storage-SMC", "0180", BLIST_FORCELUN | BLIST_INQUIRY_36},
 	{"Generic", "USB Storage-SMC", "0207", BLIST_FORCELUN | BLIST_INQUIRY_36},
+	{"Generic", "USB Reader-SMC", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36},
+	{"Generic", "USB Reader-CF", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36},
+	{"Generic", "USB Reader-SD", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36},
+	{"Generic", "USB Reader-MS", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36},
 	{"HITACHI", "DF400", "*", BLIST_SPARSELUN},
 	{"HITACHI", "DF500", "*", BLIST_SPARSELUN},
 	{"HITACHI", "DF600", "*", BLIST_SPARSELUN},
