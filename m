Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbWFVNNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbWFVNNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030634AbWFVNNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:13:18 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:4747 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030632AbWFVNNR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:13:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 4/13] Equinox SST driver: new Kconfig/Makefile
Date: Thu, 22 Jun 2006 09:13:16 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71105@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 4/13] Equinox SST driver: new Kconfig/Makefile
Thread-Index: AcaV/Z9zmRu3/na5QX+6jPzVbtckLQ==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 4: new Kconfig and Makefile in drivers/char/eqnx directory.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 Kconfig  |   11 +++++++++++
 Makefile |    6 ++++++
 2 files changed, 17 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/Kconfig
linux-2.6.17.eqnx/drivers/char/eqnx/Kconfig
--- linux-2.6.17/drivers/char/eqnx/Kconfig	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/Kconfig	2006-06-20
09:50:01.000000000 -0400
@@ -0,0 +1,11 @@
+config EQNX
+	tristate "Equinox / Avocent SST (multi-port serial) support"
+	---help---
+	  This driver supports the PCI models of the Equinox / Avocent
+	  SST multi-port serial boards.  The boards supported are:
+	  SSP-4P, SSP-8P, SSP-16P, SSP-64P and SSP-128P.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called eqnx.
+
+	  If unsure, say N.
diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/Makefile
linux-2.6.17.eqnx/drivers/char/eqnx/Makefile
--- linux-2.6.17/drivers/char/eqnx/Makefile	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/Makefile	2006-06-20
09:50:01.000000000 -0400
@@ -0,0 +1,6 @@
+#
+# Makefile for Equinox / Avocent SST (multi-port serial) driver
+#
+
+obj-$(CONFIG_EQNX) += eqnx.o
+eqnx-objs := sst.o sst_tty.o sst_ioctl.o sst_poll.o sst_sysfs.o
sst_misc.o
