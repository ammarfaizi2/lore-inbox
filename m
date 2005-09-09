Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVIITdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVIITdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbVIITdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:33:39 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1733 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030336AbVIITdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:33:18 -0400
Message-ID: <4321E378.9060006@adaptec.com>
Date: Fri, 09 Sep 2005 15:33:12 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 6/20] aic94xx: aic94xx_dump.h Dumping utility header
 file
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:33:17.0371 (UTC) FILETIME=[53EC18B0:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx_dump.h linux-2.6.13/drivers/scsi/aic94xx/aic94xx_dump.h
--- linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx_dump.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/aic94xx_dump.h	2005-09-09 11:21:23.000000000 -0400
@@ -0,0 +1,53 @@
+/*
+ * Aic94xx SAS/SATA driver dump header file.
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This file is part of the aic94xx driver.
+ *
+ * The aic94xx driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ * The aic94xx driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the aic94xx driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/aic94xx/aic94xx_dump.h#9 $
+ */
+
+#ifndef _AIC94XX_DUMP_H_
+#define _AIC94XX_DUMP_H_
+
+#ifdef ASD_DEBUG
+
+void asd_dump_ddb_0(struct asd_ha_struct *asd_ha);
+void asd_dump_target_ddb(struct asd_ha_struct *asd_ha, u16 site_no);
+void asd_dump_scb_sites(struct asd_ha_struct *asd_ha);
+void asd_dump_seq_state(struct asd_ha_struct *asd_ha, u8 lseq_mask);
+void asd_dump_frame_rcvd(struct asd_phy *phy,
+			 struct done_list_struct *dl);
+void asd_dump_scb_list(struct asd_ascb *ascb, int num);
+#else /* ASD_DEBUG */
+
+static inline void asd_dump_ddb_0(struct asd_ha_struct *asd_ha) { }
+static inline void asd_dump_target_ddb(struct asd_ha_struct *asd_ha,
+				     u16 site_no) { }
+static inline void asd_dump_scb_sites(struct asd_ha_struct *asd_ha) { }
+static inline void asd_dump_seq_state(struct asd_ha_struct *asd_ha,
+				      u8 lseq_mask) { }
+static inline void asd_dump_frame_rcvd(struct asd_phy *phy,
+				       struct done_list_struct *dl) { }
+static inline void asd_dump_scb_list(struct asd_ascb *ascb, int num) { }
+#endif /* ASD_DEBUG */
+
+#endif /* _AIC94XX_DUMP_H_ */

