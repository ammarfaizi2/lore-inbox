Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVIITlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVIITlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVIITlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:41:15 -0400
Received: from magic.adaptec.com ([216.52.22.17]:3271 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030389AbVIITku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:40:50 -0400
Message-ID: <4321E537.90505@adaptec.com>
Date: Fri, 09 Sep 2005 15:40:39 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 7/14] sas-class: sas_dump.h Dumping utility header
 file
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:40:44.0976 (UTC) FILETIME=[5EB73300:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/sas_dump.h linux-2.6.13/drivers/scsi/sas-class/sas_dump.h
--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_dump.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/sas_dump.h	2005-09-09 11:14:51.000000000 -0400
@@ -0,0 +1,43 @@
+/*
+ * Serial Attached SCSI (SAS) Dump/Debugging routines header file
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/sas-class/sas_dump.h#2 $
+ */
+
+#include "sas_internal.h"
+
+#ifdef SAS_DEBUG
+
+void sas_dprint_porte(int phyid, enum port_event pe);
+void sas_dprint_phye(int phyid, enum phy_event pe);
+void sas_dprint_hae(struct sas_ha_struct *sas_ha, enum ha_event he);
+void sas_dump_port(struct sas_port *port);
+
+#else /* SAS_DEBUG */
+
+static inline void sas_dprint_porte(int phyid, enum port_event pe) { }
+static inline void sas_dprint_phye(int phyid, enum phy_event pe) { }
+static inline void sas_dprint_hae(struct sas_ha_struct *sas_ha,
+				  enum ha_event he) { }
+static inline void sas_dump_port(struct sas_port *port) { }
+
+#endif /* SAS_DEBUG */


