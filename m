Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVIXHCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVIXHCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVIXHCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:02:38 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:60502 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751450AbVIXHCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:02:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] Input: check switch bitmap when matching handlers
Date: Sat, 24 Sep 2005 02:02:29 -0500
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509240202.29764.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: check switch bitmap when matching handlers

Switch bitmap was added to input_device_id structure so we should
check it when matching handlers and input devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -309,6 +309,7 @@ static struct input_device_id *input_mat
 		MATCH_BIT(ledbit, LED_MAX);
 		MATCH_BIT(sndbit, SND_MAX);
 		MATCH_BIT(ffbit,  FF_MAX);
+		MATCH_BIT(swbit,  SW_MAX);
 
 		return id;
 	}
