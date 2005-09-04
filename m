Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVIDXjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVIDXjr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVIDXay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:54 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:27265 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932108AbVIDXaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:03 -0400
Message-Id: <20050904232319.346856000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:08 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-use-INIT_LIST_HEAD.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 09/54] core: dvb_demux: use INIT_LIST_HEAD
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Use INIT_LIST_HEAD for frontend_list.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_demux.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:57.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:58.000000000 +0200
@@ -1188,9 +1188,9 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 		dvbdemux->feed[i].state = DMX_STATE_FREE;
 		dvbdemux->feed[i].index = i;
 	}
-	dvbdemux->frontend_list.next=
-	  dvbdemux->frontend_list.prev=
-	    &dvbdemux->frontend_list;
+
+	INIT_LIST_HEAD(&dvbdemux->frontend_list);
+
 	for (i=0; i<DMX_TS_PES_OTHER; i++) {
 		dvbdemux->pesfilter[i] = NULL;
 		dvbdemux->pids[i] = 0xffff;

--

