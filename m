Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263178AbVGIKeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbVGIKeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVGIKeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:34:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:64406 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S263181AbVGIKeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:34:04 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200507091033.j69AXhrv027477@einhorn.in-berlin.de>
Date: Sat, 9 Jul 2005 12:33:43 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: alternative [PATCH] 2/2) drivers/ieee1394/: schedule unused
 EXPORT_SYMBOL's for removal
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
cc: scjody@modernduck.com, bunk@stusta.de, bcollins@debian.org
In-Reply-To: <20050709075035.GA20151@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (-0.677) AWL,BAYES_00,MSGID_FROM_MTA_ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IEEE 1394 subsystem: Unused EXPORT_SYMBOLs will be disabled as of August.
Based on a proposal by Adrian Bunk <bunk@stusta.de>.
May affect external FireWire driver projects.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>


diff -ru linux-2.6.13-rc2.old/Documentation/feature-removal-schedule.txt linux-2.6.13-rc2/Documentation/feature-removal-schedule.txt
--- linux-2.6.13-rc2.old/Documentation/feature-removal-schedule.txt	2005-07-06 05:46:33.000000000 +0200
+++ linux-2.6.13-rc2/Documentation/feature-removal-schedule.txt	2005-07-09 11:32:43.000000000 +0200
@@ -102,6 +102,22 @@
 
 ---------------------------
 
+What:	Make IEEE1394_EXPORT_FULL_API=n the default. Will disable the
+	following EXPORT_SYMBOLs in drivers/ieee1394/ieee1394_core.c:
+	hpsb_send_phy_config,     hpsb_send_packet_and_wait,
+	highlevel_add_host,       highlevel_remove_host,
+	nodemgr_for_each_host,    csr1212_create_csr,
+	csr1212_init_local_csr,   csr1212_new_immediate,
+	csr1212_associate_keyval, csr1212_new_string_descriptor_leaf,
+	csr1212_destroy_csr,      csr1212_generate_csr_image,
+	csr1212_parse_csr
+When:	August 2005
+Files:	drivers/ieee1394/Kconfig
+Why:	No modular usage in the kernel.
+Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
+
+---------------------------
+
 What:	register_serial/unregister_serial
 When:	December 2005
 Why:	This interface does not allow serial ports to be registered against

