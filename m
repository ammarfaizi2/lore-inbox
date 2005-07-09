Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVGIHXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVGIHXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVGIHXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:23:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30340 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261567AbVGIHXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:23:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-Id: <200507090722.j697Mcrv015292@einhorn.in-berlin.de>
Date: Sat, 9 Jul 2005 09:22:38 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's
 for removal
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: scjody@modernduck.com, bunk@stusta.de
In-Reply-To: <20050709030734.GD28243@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
X-Spam-Score: (-0.679) AWL,BAYES_00,MSGID_FROM_MTA_ID
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Jul, Adrian Bunk wrote:
> On Thu, Jul 07, 2005 at 09:30:21PM +0200, Stefan Richter wrote:
>> Now that we are at it, the following EXPORT_SYMBOLs should be removed too...
>> 	_csr1212_read_keyval
> used in sbp2.c
>> 	_csr1212_destroy_keyval
> used in raw1394.c

You are right.


<--  snip  -->



This patch schedules unused EXPORT_SYMBOL's for removal.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

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
+When:	August 2005
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


