Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVIITbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVIITbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVIITbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:31:53 -0400
Received: from magic.adaptec.com ([216.52.22.17]:46276 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030324AbVIITbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:31:52 -0400
Message-ID: <4321E322.2020609@adaptec.com>
Date: Fri, 09 Sep 2005 15:31:46 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 0/20] aic94xx: Kconfig
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:31:51.0119 (UTC) FILETIME=[208315F0:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/Kconfig linux-2.6.13/drivers/scsi/aic94xx/Kconfig
--- linux-2.6.13-orig/drivers/scsi/aic94xx/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/Kconfig	2005-09-09 11:55:32.000000000 -0400
@@ -0,0 +1,41 @@
+#
+# Kernel configuration file for aic94xx SAS/SATA driver.
+#
+# Copyright (c) 2005 Adaptec, Inc.  All rights reserved.
+# Copyright (c) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+#
+# This file is licensed under GPLv2.
+# 
+# This file is part of the aic94xx driver.
+#
+# The aic94xx driver is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; version 2 of the
+# License.
+#
+# The aic94xx driver is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with Aic94xx Driver; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# $Id: //depot/aic94xx/Kconfig#6 $
+#
+
+config SCSI_AIC94XX
+	tristate "Adaptec AIC94xx SAS/SATA support"
+	depends on PCI && SAS_CLASS
+	help
+		This driver supports Adaptec's SAS/SATA 3Gb/s 64 bit PCI-X
+		AIC94xx chip based host adapters.
+
+config AIC94XX_DEBUG
+	bool "Compile in debug mode"
+	default y
+	depends on SCSI_AIC94XX
+	help
+		Compiles the aic94xx driver in debug mode.  In debug mode,
+		the driver prints some messages to the console.

