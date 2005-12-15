Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVLOCrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVLOCrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLOCrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:47:08 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:15990 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030381AbVLOCrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:47:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Input: ALPS - correctly report button presses on Fujitsu Siemens S6010
Date: Wed, 14 Dec 2005 21:47:00 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512142147.01431.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Without this patch Forward and Backward buttons on the touchpad do not
generate any events.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -42,7 +42,7 @@ static struct alps_model_info alps_model
 	{ { 0x53, 0x02, 0x14 },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x14 },	0xf8, 0xf8, 0 },
-	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, 0 },
+	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */
 	{ { 0x63, 0x02, 0x3c },	0x8f, 0x8f, ALPS_WHEEL },		/* Toshiba Satellite S2400-103 */
 	{ { 0x63, 0x02, 0x50 },	0xef, 0xef, ALPS_FW_BK_1 },		/* NEC Versa L320 */
 	{ { 0x63, 0x02, 0x64 },	0xf8, 0xf8, 0 },
