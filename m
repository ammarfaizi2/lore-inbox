Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbULTByo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbULTByo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULTByn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:54:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261383AbULTBx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:53:27 -0500
Date: Mon, 20 Dec 2004 02:53:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bcollins@debian.org
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220015320.GO21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes 41 unneeded EXPORT_SYMBOL's.


diffstat output:
 drivers/ieee1394/ieee1394_core.c |   41 -------------------------------
 1 files changed, 41 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/ieee1394/ieee1394_core.c.old	2004-12-20 01:24:23.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/ieee1394/ieee1394_core.c	2004-12-20 02:31:01.000000000 +0100
@@ -1194,9 +1194,7 @@
 EXPORT_SYMBOL(hpsb_set_packet_complete_task);
 EXPORT_SYMBOL(hpsb_alloc_packet);
 EXPORT_SYMBOL(hpsb_free_packet);
-EXPORT_SYMBOL(hpsb_send_phy_config);
 EXPORT_SYMBOL(hpsb_send_packet);
-EXPORT_SYMBOL(hpsb_send_packet_and_wait);
 EXPORT_SYMBOL(hpsb_reset_bus);
 EXPORT_SYMBOL(hpsb_bus_reset);
 EXPORT_SYMBOL(hpsb_selfid_received);
@@ -1214,11 +1212,6 @@
 EXPORT_SYMBOL(hpsb_make_lock64packet);
 EXPORT_SYMBOL(hpsb_make_phypacket);
 EXPORT_SYMBOL(hpsb_make_isopacket);
-EXPORT_SYMBOL(hpsb_read);
-EXPORT_SYMBOL(hpsb_write);
-EXPORT_SYMBOL(hpsb_lock);
-EXPORT_SYMBOL(hpsb_lock64);
-EXPORT_SYMBOL(hpsb_send_gasp);
 EXPORT_SYMBOL(hpsb_packet_success);
 
 /** highlevel.c **/
@@ -1230,32 +1223,19 @@
 EXPORT_SYMBOL(hpsb_listen_channel);
 EXPORT_SYMBOL(hpsb_unlisten_channel);
 EXPORT_SYMBOL(hpsb_get_hostinfo);
-EXPORT_SYMBOL(hpsb_get_host_bykey);
 EXPORT_SYMBOL(hpsb_create_hostinfo);
 EXPORT_SYMBOL(hpsb_destroy_hostinfo);
 EXPORT_SYMBOL(hpsb_set_hostinfo_key);
-EXPORT_SYMBOL(hpsb_get_hostinfo_key);
 EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
 EXPORT_SYMBOL(hpsb_set_hostinfo);
-EXPORT_SYMBOL(highlevel_read);
-EXPORT_SYMBOL(highlevel_write);
-EXPORT_SYMBOL(highlevel_lock);
-EXPORT_SYMBOL(highlevel_lock64);
-EXPORT_SYMBOL(highlevel_add_host);
-EXPORT_SYMBOL(highlevel_remove_host);
 EXPORT_SYMBOL(highlevel_host_reset);
 
 /** nodemgr.c **/
-EXPORT_SYMBOL(hpsb_guid_get_entry);
-EXPORT_SYMBOL(hpsb_nodeid_get_entry);
 EXPORT_SYMBOL(hpsb_node_fill_packet);
-EXPORT_SYMBOL(hpsb_node_read);
 EXPORT_SYMBOL(hpsb_node_write);
-EXPORT_SYMBOL(hpsb_node_lock);
 EXPORT_SYMBOL(hpsb_register_protocol);
 EXPORT_SYMBOL(hpsb_unregister_protocol);
 EXPORT_SYMBOL(ieee1394_bus_type);
-EXPORT_SYMBOL(nodemgr_for_each_host);
 
 /** csr.c **/
 EXPORT_SYMBOL(hpsb_update_config_rom);
@@ -1292,32 +1272,11 @@
 EXPORT_SYMBOL(hpsb_iso_recv_flush);
 
 /** csr1212.c **/
-EXPORT_SYMBOL(csr1212_create_csr);
-EXPORT_SYMBOL(csr1212_init_local_csr);
-EXPORT_SYMBOL(csr1212_new_immediate);
-EXPORT_SYMBOL(csr1212_new_leaf);
-EXPORT_SYMBOL(csr1212_new_csr_offset);
 EXPORT_SYMBOL(csr1212_new_directory);
-EXPORT_SYMBOL(csr1212_associate_keyval);
 EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
-EXPORT_SYMBOL(csr1212_new_extended_immediate);
-EXPORT_SYMBOL(csr1212_new_extended_leaf);
-EXPORT_SYMBOL(csr1212_new_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_textual_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_icon_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_modifiable_descriptor_leaf);
-EXPORT_SYMBOL(csr1212_new_keyword_leaf);
 EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
-EXPORT_SYMBOL(csr1212_disassociate_keyval);
 EXPORT_SYMBOL(csr1212_release_keyval);
-EXPORT_SYMBOL(csr1212_destroy_csr);
 EXPORT_SYMBOL(csr1212_read);
-EXPORT_SYMBOL(csr1212_generate_positions);
-EXPORT_SYMBOL(csr1212_generate_layout_order);
-EXPORT_SYMBOL(csr1212_fill_cache);
-EXPORT_SYMBOL(csr1212_generate_csr_image);
 EXPORT_SYMBOL(csr1212_parse_keyval);
-EXPORT_SYMBOL(csr1212_parse_csr);
 EXPORT_SYMBOL(_csr1212_read_keyval);
 EXPORT_SYMBOL(_csr1212_destroy_keyval);
