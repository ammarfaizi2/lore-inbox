Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVEHUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVEHUYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVEHUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:22:55 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63638 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262822AbVEHTJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:59 -0400
Message-Id: <20050508184349.328727000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:00 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-dst-ca.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 31/37] DST: fix for descrambling failure
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix for descrambling failure (Dominique Dumont, Manu Abraham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:44.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:49.000000000 +0200
@@ -198,7 +198,7 @@ int dst_wait_dst_ready(struct dst_state 
 				dprintk("%s: dst wait ready after %d\n", __FUNCTION__, i);
 			return 1;
 		}
-		msleep(35);
+		msleep(10);
 	}
 	if (verbose > 1)
 		dprintk("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);

--

