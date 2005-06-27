Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVF0Nbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVF0Nbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVF0NYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:24:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:16357 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262061AbVF0MQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:37 -0400
Message-Id: <20050627121418.667336000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:45 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-digitv-memcpy-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 45/51] usb: digitv memcpy fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Fix memcpy copying into the wrong destination.
Thanks to Allan Third for reporting.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/digitv.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/digitv.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-06-27 13:26:13.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/digitv.c	2005-06-27 13:26:17.000000000 +0200
@@ -37,7 +37,7 @@ static int digitv_ctrl_msg(struct dvb_us
 		dvb_usb_generic_write(d,sndbuf,7);
 	} else {
 		dvb_usb_generic_rw(d,sndbuf,7,rcvbuf,7,10);
-		memcpy(&rbuf,&rcvbuf[3],rlen);
+		memcpy(rbuf,&rcvbuf[3],rlen);
 	}
 	return 0;
 }

--

