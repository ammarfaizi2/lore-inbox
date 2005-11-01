Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVKAITa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVKAITa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVKAIRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:17:10 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:45536 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965063AbVKAIQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:45 -0500
Message-ID: <4367244B.60700@m1k.net>
Date: Tue, 01 Nov 2005 03:16:11 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 32/37] dvb: nxt200x: remove null check before kfree()
Content-Type: multipart/mixed;
 boundary="------------020503020908080807020603"
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
--------------020503020908080807020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------020503020908080807020603
Content-Type: text/x-patch;
 name="2409.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2409.patch"

Removed unnecessary null check before kfree()
...inspired by the big patch from Jesper Juhl.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/nxt200x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/nxt200x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/nxt200x.c
@@ -1159,8 +1159,7 @@
 	return &state->frontend;
 
 error:
-	if (state)
-		kfree(state);
+	kfree(state);
 	printk("Unknown/Unsupported NXT chip: %02X %02X %02X %02X %02X\n",
 		buf[0], buf[1], buf[2], buf[3], buf[4]);
 	return NULL;


--------------020503020908080807020603--
