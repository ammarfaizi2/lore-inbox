Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCGH1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCGH1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCGHXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:23:31 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:64441 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261668AbVCGHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:15:51 -0500
Message-ID: <422BFF88.50205@yahoo.com>
Date: Sun, 06 Mar 2005 23:15:20 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 3/6] Open-iSCSI High-Performance Initiator for Linux
Content-Type: multipart/mixed;
 boundary="------------000906040700070605030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906040700070605030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

          drivers/scsi/Kconfig changes.

          Signed-off-by: Alex Aizman <itn780@yahoo.com>
          Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>









--------------000906040700070605030506
Content-Type: text/plain;
 name="open-iscsi-kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="open-iscsi-kconfig.patch"

diff -Nru --exclude 'iscsi*' --exclude Makefile linux-2.6.11.orig/drivers/scsi/Kconfig linux-2.6.11.dima/drivers/scsi/Kconfig
--- linux-2.6.11.orig/drivers/scsi/Kconfig	2005-03-01 23:38:25.000000000 -0800
+++ linux-2.6.11.dima/drivers/scsi/Kconfig	2005-03-04 17:50:11.141413333 -0800
@@ -185,6 +185,44 @@
 	  there should be no noticeable performance impact as long as you have
 	  logging turned off.
 
+config ISCSI_IF
+	tristate "iSCSI Open Transport Interface"
+	depends on SCSI && INET
+	---help---
+	To compile this driver as a module, choose M here: the
+	module will be called iscsi_if.
+
+	This driver manages multiple iSCSI transports. This module is required
+	for normal iscsid operation.
+
+	See more detailed information here:
+
+ 	http://www.open-iscsi.org
+
+config ISCSI_TCP
+	tristate "iSCSI Initiator over TCP/IP"
+	depends on ISCSI_IF
+	default y
+	select CRYPTO
+	select CRYPTO_MD5
+	select CRYPTO_CRC32C
+	---help---
+	To compile this driver as a module, choose M here: the
+	module will be called iscsi_tcp.
+
+ 	The iSCSI Driver provides a host with the ability to access storage
+	through an IP network. The driver uses the iSCSI protocol to transport
+	SCSI requests and responses over a TCP/IP network between the host
+	(the "initiator") and "targets".  Architecturally, the iSCSI driver
+	combines with the host's TCP/IP stack, network drivers, and Network
+	Interface Card (NIC) to provide the same functions as a SCSI or a
+	Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
+ 
+ 	The userspace component needed to initialize the driver, documentation,
+	and sample configuration files can be found here:
+ 
+ 	http://www.open-iscsi.org
+
 menu "SCSI Transport Attributes"
 	depends on SCSI
 










--------------000906040700070605030506--
