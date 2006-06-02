Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWFBUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWFBUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWFBUYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:24:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56530 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932104AbWFBUYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:24:07 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:22:31 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 14/18] sbp2: sbp2 remove ohci1394 specific
 constant
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
Message-ID: <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.036) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Requires patches
"ieee1394: extend lowlevel API for address range properties" and
"ohci1394: set address range properties"

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:44.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:46.000000000 +0200
@@ -847,7 +847,7 @@ static struct scsi_id_instance_data *sbp
 	scsi_id->status_fifo_addr = hpsb_allocate_and_register_addrspace(
 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
-			0x010000000000ULL, CSR1212_ALL_SPACE_END);
+			ud->ne->host->low_addr_space, CSR1212_ALL_SPACE_END);
 	if (!scsi_id->status_fifo_addr) {
 		SBP2_ERR("failed to allocate status FIFO address range");
 		goto failed_alloc;


