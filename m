Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVGCXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVGCXYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVGCXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 19:24:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22533 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261570AbVGCXYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 19:24:08 -0400
Date: Mon, 4 Jul 2005 01:24:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal (fwd)
Message-ID: <20050703232405.GR5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch I sent on 13 May 2005 is still not in Linus' tree, and now 
it's July.

What shall I do?
- resend this patch with the removal date set to August or
- send a patch to remove these symbols

cu
Adrian

<--  snip  -->


This patch schedules unused EXPORT_SYMBOL's for removal.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |   21 ++++++++++++++
 drivers/ieee1394/ieee1394_core.c           |   31 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

--- linux-2.6.12-rc4-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-05-13 15:19:54.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/Documentation/feature-removal-schedule.txt	2005-05-13 15:29:24.000000000 +0200
@@ -93,0 +94,21 @@
+
+---------------------------
+
+What:	remove the following ieee1394 EXPORT_SYMBOL's:
+	- hpsb_send_phy_config
+	- hpsb_send_packet_and_wait
+	- highlevel_add_host
+	- highlevel_remove_host
+	- nodemgr_for_each_host
+	- csr1212_create_csr
+	- csr1212_init_local_csr
+	- csr1212_new_immediate
+	- csr1212_associate_keyval
+	- csr1212_new_string_descriptor_leaf
+	- csr1212_destroy_csr
+	- csr1212_generate_csr_image
+	- csr1212_parse_csr
+When:	July 2005
+Files:	drivers/ieee1394/ieee1394_core.c
+Why:	No modular usage in the kernel.
+Who:	Adrian Bunk <bunk@stusta.de>
--- linux-2.6.12-rc4-mm1-full/drivers/ieee1394/ieee1394_core.c.old	2005-05-13 15:19:34.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/drivers/ieee1394/ieee1394_core.c	2005-05-13 15:28:17.000000000 +0200
@@ -1226,7 +1226,13 @@
 EXPORT_SYMBOL(hpsb_alloc_packet);
 EXPORT_SYMBOL(hpsb_free_packet);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(hpsb_send_phy_config);
+
 EXPORT_SYMBOL(hpsb_send_packet);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(hpsb_send_packet_and_wait);
+
 EXPORT_SYMBOL(hpsb_reset_bus);
 EXPORT_SYMBOL(hpsb_bus_reset);
@@ -1265,6 +1271,11 @@
 EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
 EXPORT_SYMBOL(hpsb_set_hostinfo);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(highlevel_add_host);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(highlevel_remove_host);
+
 EXPORT_SYMBOL(highlevel_host_reset);
 
@@ -1275,4 +1286,6 @@
 EXPORT_SYMBOL(hpsb_unregister_protocol);
 EXPORT_SYMBOL(ieee1394_bus_type);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(nodemgr_for_each_host);
 
@@ -1312,18 +1325,36 @@
 
 /** csr1212.c **/
+
+/* EXPORT_SYMBOLs scheduled for removal */
 EXPORT_SYMBOL(csr1212_create_csr);
 EXPORT_SYMBOL(csr1212_init_local_csr);
 EXPORT_SYMBOL(csr1212_new_immediate);
+
 EXPORT_SYMBOL(csr1212_new_directory);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(csr1212_associate_keyval);
+
 EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
+
 EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
 EXPORT_SYMBOL(csr1212_release_keyval);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(csr1212_destroy_csr);
+
 EXPORT_SYMBOL(csr1212_read);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(csr1212_generate_csr_image);
+
 EXPORT_SYMBOL(csr1212_parse_keyval);
+
+/* EXPORT_SYMBOL scheduled for removal */
 EXPORT_SYMBOL(csr1212_parse_csr);
+
 EXPORT_SYMBOL(_csr1212_read_keyval);
 EXPORT_SYMBOL(_csr1212_destroy_keyval);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

