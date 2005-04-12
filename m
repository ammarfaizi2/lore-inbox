Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVDLFTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVDLFTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDLFTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:19:04 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:16998 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262010AbVDLDYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:24:44 -0400
Message-ID: <425B3F68.5030506@yahoo.com>
Date: Mon, 11 Apr 2005 20:24:24 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 3/6] Linux-iSCSI High-Performance Initiator
Content-Type: multipart/mixed;
 boundary="------------000908080400010301090801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000908080400010301090801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

              drivers/scsi/Kconfig changes.

              Signed-off-by: Alex Aizman <itn780@yahoo.com>
              Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>













--------------000908080400010301090801
Content-Type: text/plain;
 name="linux-iscsi-kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-iscsi-kconfig.patch"

diff -Nru --exclude 'iscsi*' --exclude Makefile linux-2.6.12-rc2.orig/drivers/scsi/Kconfig linux-2.6.12-rc2.dima/drivers/scsi/Kconfig
--- linux-2.6.12-rc2.orig/drivers/scsi/Kconfig	2005-04-11 17:13:39.000000000 -0700
+++ linux-2.6.12-rc2.dima/drivers/scsi/Kconfig	2005-04-11 18:13:12.000000000 -0700
@@ -185,6 +185,45 @@
 	  there should be no noticeable performance impact as long as you have
 	  logging turned off.
 
+config ISCSI_IF
+	tristate "iSCSI Open Transport Interface"
+	depends on SCSI && INET
+	---help---
+	This driver manages multiple iSCSI transports. This module is required
+	for normal iscsid operation.
+
+	To compile this driver as a module, choose M here: the
+	module will be called iscsi_if.
+
+	See more detailed information here:
+
+	http://linux-iscsi.sf.net
+
+config ISCSI_TCP
+	tristate "iSCSI Initiator over TCP/IP"
+	depends on ISCSI_IF
+	default y
+	select CRYPTO
+	select CRYPTO_MD5
+	select CRYPTO_CRC32C
+	select SCSI_ISCSI_ATTRS
+	---help---
+ 	The iSCSI Driver provides a host with the ability to access storage
+	through an IP network. The driver uses the iSCSI protocol to transport
+	SCSI requests and responses over a TCP/IP network between the host
+	(the "initiator") and "targets".  Architecturally, the iSCSI driver
+	combines with the host's TCP/IP stack, network drivers, and Network
+	Interface Card (NIC) to provide the same functions as a SCSI or a
+	Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
+
+	To compile this driver as a module, choose M here: the
+	module will be called iscsi_tcp.
+ 
+ 	The userspace component needed to initialize the driver, documentation,
+	and sample configuration files can be found here:
+ 
+	http://linux-iscsi.sf.net
+
 menu "SCSI Transport Attributes"
 	depends on SCSI
 




--------------000908080400010301090801--
