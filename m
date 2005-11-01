Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVKAIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVKAIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVKAIN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:58 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:28110 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964971AbVKAINk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:40 -0500
Message-ID: <4367238F.8010803@m1k.net>
Date: Tue, 01 Nov 2005 03:13:03 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 07/37] dvb: pluto2: Removed unavoidable error message and
 related code
Content-Type: multipart/mixed;
 boundary="------------080300080301010701030403"
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
--------------080300080301010701030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------080300080301010701030403
Content-Type: text/x-patch;
 name="2370.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2370.patch"

From: Andreas Oberritter <obi@linuxtv.org>

Removed unavoidable error message and related code.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/pluto2/pluto2.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/pluto2/pluto2.c
+++ linux-2.6.14-git3/drivers/media/dvb/pluto2/pluto2.c
@@ -286,15 +286,10 @@
 	 *     although one packet has been transfered.
 	 */
 	if ((nbpackets == 0) || (nbpackets > TS_DMA_PACKETS)) {
-		unsigned int i = 0, valid;
+		unsigned int i = 0;
 		while (pluto->dma_buf[i] == 0x47)
 			i += 188;
-		valid = i / 188;
-		if (nbpackets != valid) {
-			dev_err(&pluto->pdev->dev, "nbpackets=%u valid=%u\n",
-					nbpackets, valid);
-			nbpackets = valid;
-		}
+		nbpackets = i / 188;
 	}
 
 	dvb_dmx_swfilter_packets(&pluto->demux, pluto->dma_buf, nbpackets);



--------------080300080301010701030403--
