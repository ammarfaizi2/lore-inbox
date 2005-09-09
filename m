Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVIITcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVIITcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVIITcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:32:13 -0400
Received: from magic.adaptec.com ([216.52.22.17]:52932 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030328AbVIITcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:32:11 -0400
Message-ID: <4321E335.5010805@adaptec.com>
Date: Fri, 09 Sep 2005 15:32:05 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 1/20] aic94xx: Makefile
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:32:10.0354 (UTC) FILETIME=[2BFA1D20:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile linux-2.6.13/drivers/scsi/aic94xx/Makefile
--- linux-2.6.13-orig/drivers/scsi/aic94xx/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/Makefile	2005-09-09 11:23:01.000000000 -0400
@@ -0,0 +1,46 @@
+#
+# Makefile for Adaptec aic94xx SAS/SATA driver.
+#
+# Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+# Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+#
+# This file is licensed under GPLv2.
+# 
+# This file is part of the the aic94xx driver.
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
+# along with the aic94xx driver; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# $Id: //depot/aic94xx/Makefile#34 $
+#
+
+CHECK = sparse -Wbitwise
+
+ifeq ($(CONFIG_AIC94XX_DEBUG),y)
+	EXTRA_CFLAGS += -DASD_DEBUG -DASD_ENTER_EXIT -g
+endif
+
+clean-files += *~
+
+obj-$(CONFIG_SCSI_AIC94XX) += aic94xx.o
+aic94xx-y += aic94xx_init.o \
+	     aic94xx_hwi.o  \
+	     aic94xx_reg.o  \
+	     aic94xx_sds.o  \
+	     aic94xx_seq.o  \
+	     aic94xx_dump.o \
+	     aic94xx_scb.o  \
+	     aic94xx_dev.o  \
+	     aic94xx_tmf.o  \
+	     aic94xx_task.o

