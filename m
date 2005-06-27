Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVF0Nhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVF0Nhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVF0Nda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:33:30 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:26341 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262077AbVF0MQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:53 -0400
Message-Id: <20050627121412.104909000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:13 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-l64781-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 13/51] frontend: l64781: improve tuning
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable zig-zag and set min_delay_ms = 4000 as suggested
by Allan Guild to improve tuning with weak signal.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/l64781.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/l64781.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/l64781.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/l64781.c	2005-06-27 13:23:07.000000000 +0200
@@ -474,11 +474,12 @@ static int l64781_init(struct dvb_fronte
 	return 0;
 }
 
-static int l64781_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
+static int l64781_get_tune_settings(struct dvb_frontend* fe,
+				    struct dvb_frontend_tune_settings* fesettings)
 {
-        fesettings->min_delay_ms = 200;
-        fesettings->step_size = 166667;
-        fesettings->max_drift = 166667*2;
+        fesettings->min_delay_ms = 4000;
+        fesettings->step_size = 0;
+        fesettings->max_drift = 0;
         return 0;
 }
 

--

