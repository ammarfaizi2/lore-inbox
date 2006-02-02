Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWBBWmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWBBWmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWBBWmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:42:17 -0500
Received: from sipsolutions.net ([66.160.135.76]:59909 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932390AbWBBWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:42:16 -0500
Subject: [RFC 3/4] firewire: unconditionally export
	hpsb_send_packet_and_wait
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138919238.3621.12.camel@localhost>
References: <1138919238.3621.12.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 23:41:17 +0100
Message-Id: <1138920077.3621.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mem1394 will need hpsb_send_packet_and_wait so it needs to be exported
unconditionally.

diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
index 17afc3b..5800534 100644
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -589,6 +589,7 @@ int hpsb_send_packet_and_wait(struct hps
 
 	return retval;
 }
+EXPORT_SYMBOL(hpsb_send_packet_and_wait);
 
 static void send_packet_nocare(struct hpsb_packet *packet)
 {
@@ -1269,7 +1270,6 @@ EXPORT_SYMBOL(hpsb_packet_received);
 EXPORT_SYMBOL_GPL(hpsb_disable_irm);
 #ifdef CONFIG_IEEE1394_EXPORT_FULL_API
 EXPORT_SYMBOL(hpsb_send_phy_config);
-EXPORT_SYMBOL(hpsb_send_packet_and_wait);
 #endif
 
 /** ieee1394_transactions.c **/


