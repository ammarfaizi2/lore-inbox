Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVLUB1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVLUB1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLUB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:27:33 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:32937 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932230AbVLUB1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:27:33 -0500
Message-ID: <43A8AF74.1080706@lwfinger.net>
Date: Tue, 20 Dec 2005 19:27:16 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15-rc6] alps: Add HP ze1115 support to alps driver
Content-Type: multipart/mixed;
 boundary="------------040803010200000708010807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040803010200000708010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the touchpad found on HP ze1115 notebooks. 
Patch file attached to preserve white space and line integrity.

PatchAuthor: Larry.Finger@lwfinger.net

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -40,6 +40,7 @@ static struct alps_model_info alps_model
         { { 0x33, 0x02, 0x0a }, 0x88, 0xf8, ALPS_OLDPROTO }, 
  /* UMAX-530T */
         { { 0x53, 0x02, 0x0a }, 0xf8, 0xf8, 0 },
         { { 0x53, 0x02, 0x14 }, 0xf8, 0xf8, 0 },
+       { { 0x60, 0x03, 0xc8 }, 0xf8, 0xf8, 0 }, 
/* HP ze1115 */
         { { 0x63, 0x02, 0x0a }, 0xf8, 0xf8, 0 },
         { { 0x63, 0x02, 0x14 }, 0xf8, 0xf8, 0 },
         { { 0x63, 0x02, 0x28 }, 0xf8, 0xf8, ALPS_FW_BK_2 }, 
  /* Fujitsu Siemens S6010 */

--------------040803010200000708010807
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -40,6 +40,7 @@ static struct alps_model_info alps_model
 	{ { 0x33, 0x02, 0x0a },	0x88, 0xf8, ALPS_OLDPROTO },		/* UMAX-530T */
 	{ { 0x53, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x53, 0x02, 0x14 },	0xf8, 0xf8, 0 },
+	{ { 0x60, 0x03, 0xc8 }, 0xf8, 0xf8, 0 },			/* HP ze1115 */
 	{ { 0x63, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x14 },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */

--------------040803010200000708010807--
