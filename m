Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUGTBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUGTBEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 21:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUGTBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 21:04:42 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:14089 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S264936AbUGTBEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 21:04:41 -0400
Content-class: urn:content-classes:message
Subject: [PATCH 2.6.8-rc2] include/linux/ata.h
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 19 Jul 2004 18:04:38 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF05A1844D@mail-sc-6-bk.nvidia.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] include/linux/ata.h
Thread-Index: AcRt9YnCznqKyKMXSd297QflIAIhzQ==
From: "Andrew Chew" <achew@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Cc: <B.Zolnierkiewicz@elka.pw.edu.pl>, <jgarzik@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The macros ata_id_has_lba() and ata_id_has_dma() seem to have their bits
reversed.  LBA support is bit 9 of word 49 in the identify page, whereas
DMA support is bit 8 of word 49 in the identify page.


--- ata.original.h	2004-07-19 17:49:26.000000000 -0700
+++ ata.h	2004-07-19 17:49:05.000000000 -0700
@@ -209,8 +209,8 @@
 #define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
-#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
-#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
+#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
+#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
 #define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
 #define ata_id_u32(dev,n)	\
 	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
