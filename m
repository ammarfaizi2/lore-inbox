Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVKAIRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVKAIRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVKAIQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:35 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:19941 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965069AbVKAIQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:15 -0500
Message-ID: <43672420.90700@m1k.net>
Date: Tue, 01 Nov 2005 03:15:28 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 27/37] dvb: Nebula nxt6000 requires fe reset
Content-Type: multipart/mixed;
 boundary="------------020507000306010702010504"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507000306010702010504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------020507000306010702010504
Content-Type: text/x-patch;
 name="2402.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2402.patch"

From: Stuart Auchterlonie <stuarta@squashedfrog.net>

Nebula nxt6000 requires fe reset.

Signed-off-by: Stuart Auchterlonie <stuarta@squashedfrog.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -523,9 +523,7 @@
 	/*
 	 * Reset the frontend, must be called before trying
 	 * to initialise the MT352 or mt352_attach
-	 * will fail.
-	 *
-	 * Presumably not required for the NXT6000 frontend.
+	 * will fail. Same goes for the nxt6000 frontend.
 	 *
 	 */
 
@@ -632,6 +630,7 @@
 		 */
 
 		/* Old Nebula (marked (c)2003 on high profile pci card) has nxt6000 demod */
+		digitv_alps_tded4_reset(card);
 		card->fe = nxt6000_attach(&vp3021_alps_tded4_config, card->i2c_adapter);
 		if (card->fe != NULL) {
 			dprintk ("dvb_bt8xx: an nxt6000 was detected on your digitv card\n");


--------------020507000306010702010504--
