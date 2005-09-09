Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVIITjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVIITjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIITjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:39:10 -0400
Received: from magic.adaptec.com ([216.52.22.17]:37830 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030375AbVIITjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:39:00 -0400
Message-ID: <4321E4CE.3050505@adaptec.com>
Date: Fri, 09 Sep 2005 15:38:54 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 1/14] sas-class: Makefile
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:38:59.0599 (UTC) FILETIME=[1FE7F1F0:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/Makefile linux-2.6.13/drivers/scsi/sas-class/Makefile
--- linux-2.6.13-orig/drivers/scsi/sas-class/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/Makefile	2005-09-09 11:23:50.000000000 -0400
@@ -0,0 +1,44 @@
+#
+# Kernel Makefile for the SAS Class
+#
+# Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+# Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+#
+# This file is licensed under GPLv2.
+# 
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; version 2 of the
+# License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+# USA
+#
+# $Id: //depot/sas-class/Makefile#18 $
+#
+
+CHECK = sparse -Wbitwise
+
+ifeq ($(CONFIG_SAS_DEBUG),y)
+	EXTRA_CFLAGS += -DSAS_DEBUG -g
+endif
+
+clean-files += *~ expander_conf
+
+obj-$(CONFIG_SAS_CLASS) += sas_class.o
+sas_class-y +=  sas_init.o     \
+		sas_common.o   \
+		sas_phy.o      \
+		sas_port.o     \
+		sas_event.o    \
+		sas_dump.o     \
+		sas_discover.o \
+		sas_expander.o \
+		sas_scsi_host.o


