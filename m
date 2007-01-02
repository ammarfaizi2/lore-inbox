Return-Path: <linux-kernel-owner+w=401wt.eu-S1754950AbXABV5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbXABV5J (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXABV5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:57:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2711 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754971AbXABV4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:56:54 -0500
Date: Tue, 2 Jan 2007 22:56:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled IEEE1394_EXPORT_FULL_API removal
Message-ID: <20070102215657.GB20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled IEEE1394_EXPORT_FULL_API removal.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    8 -------
 drivers/ieee1394/Kconfig                   |    7 ------
 drivers/ieee1394/ieee1394_core.c           |   22 ---------------------
 3 files changed, 37 deletions(-)

--- linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt.old	2007-01-02 21:09:52.000000000 +0100
+++ linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt	2007-01-02 21:10:00.000000000 +0100
@@ -61,8 +60,0 @@
-What:	ieee1394's *_oui sysfs attributes (CONFIG_IEEE1394_OUI_DB)
-When:	January 2007
-Files:	drivers/ieee1394/: oui.db, oui2c.sh
-Why:	big size, little value
-Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
-
----------------------------
-
--- linux-2.6.20-rc2-mm1/drivers/ieee1394/Kconfig.old	2007-01-02 21:19:15.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/ieee1394/Kconfig	2007-01-02 21:19:29.000000000 +0100
@@ -52,13 +52,6 @@
 	  with MacOSX and WinXP IP-over-1394), enable this option and the
 	  eth1394 option below.
 
-config IEEE1394_EXPORT_FULL_API
-	bool "Export all symbols of ieee1394's API (deprecated)"
-	depends on IEEE1394
-	default n
-	help
-	  This option will be removed soon.  Don't worry, say N.
-
 comment "Device Drivers"
 	depends on IEEE1394
 
--- linux-2.6.20-rc2-mm1/drivers/ieee1394/ieee1394_core.c.old	2007-01-02 21:18:39.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/ieee1394/ieee1394_core.c	2007-01-02 21:22:01.000000000 +0100
@@ -1195,10 +1195,6 @@
 EXPORT_SYMBOL(hpsb_packet_sent);
 EXPORT_SYMBOL(hpsb_packet_received);
 EXPORT_SYMBOL_GPL(hpsb_disable_irm);
-#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
-EXPORT_SYMBOL(hpsb_send_phy_config);
-EXPORT_SYMBOL(hpsb_send_packet_and_wait);
-#endif
 
 /** ieee1394_transactions.c **/
 EXPORT_SYMBOL(hpsb_get_tlabel);
@@ -1229,20 +1225,12 @@
 EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
 EXPORT_SYMBOL(hpsb_set_hostinfo);
 EXPORT_SYMBOL(highlevel_host_reset);
-#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
-EXPORT_SYMBOL(highlevel_add_host);
-EXPORT_SYMBOL(highlevel_remove_host);
-#endif
 
 /** nodemgr.c **/
 EXPORT_SYMBOL(hpsb_node_fill_packet);
 EXPORT_SYMBOL(hpsb_node_write);
 EXPORT_SYMBOL(__hpsb_register_protocol);
 EXPORT_SYMBOL(hpsb_unregister_protocol);
-#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
-EXPORT_SYMBOL(ieee1394_bus_type);
-EXPORT_SYMBOL(nodemgr_for_each_host);
-#endif
 
 /** csr.c **/
 EXPORT_SYMBOL(hpsb_update_config_rom);
@@ -1287,13 +1275,3 @@
 EXPORT_SYMBOL(csr1212_parse_keyval);
 EXPORT_SYMBOL(_csr1212_read_keyval);
 EXPORT_SYMBOL(_csr1212_destroy_keyval);
-#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
-EXPORT_SYMBOL(csr1212_create_csr);
-EXPORT_SYMBOL(csr1212_init_local_csr);
-EXPORT_SYMBOL(csr1212_new_immediate);
-EXPORT_SYMBOL(csr1212_associate_keyval);
-EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_destroy_csr);
-EXPORT_SYMBOL(csr1212_generate_csr_image);
-EXPORT_SYMBOL(csr1212_parse_csr);
-#endif

