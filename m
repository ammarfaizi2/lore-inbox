Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVIDXmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVIDXmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVIDXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:51 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:26241 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932106AbVIDXaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:02 -0400
Message-Id: <20050904232318.572368000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:06 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-remove-descramble-mac-and-section-callbacks.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 07/54] core: dvb_demux: remove unsused descramble callbacks
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Removed unused descramble_mac_address and descramble_section_payload callbacks.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/demux.h     |   11 -----------
 drivers/media/dvb/dvb-core/dvb_demux.c |    3 ---
 2 files changed, 14 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:55.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:56.000000000 +0200
@@ -260,17 +260,6 @@ struct dmx_demux {
 				      dmx_section_cb callback);
         int (*release_section_feed) (struct dmx_demux* demux,
 				     struct dmx_section_feed* feed);
-        int (*descramble_mac_address) (struct dmx_demux* demux,
-				       u8* buffer1,
-				       size_t buffer1_length,
-				       u8* buffer2,
-				       size_t buffer2_length,
-				       u16 pid);
-        int (*descramble_section_payload) (struct dmx_demux* demux,
-					   u8* buffer1,
-					   size_t buffer1_length,
-					   u8* buffer2, size_t buffer2_length,
-					   u16 pid);
         int (*add_frontend) (struct dmx_demux* demux,
 			     struct dmx_frontend* frontend);
         int (*remove_frontend) (struct dmx_demux* demux,
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:55.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:56.000000000 +0200
@@ -1232,9 +1232,6 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 	dmx->allocate_section_feed = dvbdmx_allocate_section_feed;
 	dmx->release_section_feed = dvbdmx_release_section_feed;
 
-	dmx->descramble_mac_address = NULL;
-	dmx->descramble_section_payload = NULL;
-
 	dmx->add_frontend = dvbdmx_add_frontend;
 	dmx->remove_frontend = dvbdmx_remove_frontend;
 	dmx->get_frontends = dvbdmx_get_frontends;

--

