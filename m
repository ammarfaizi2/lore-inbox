Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTFUNjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTFUNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:39:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21154 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264067AbTFUNiE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:04 -0400
Subject: [PATCH 1/11] input: HID devices can have the same logical max and min
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <1056203517244@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1359, 2003-06-21 04:32:06-07:00, A.Wegele@tu-bs.de
  input: logical maximum and minimum can have the same value in HID.


 hid-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Sat Jun 21 15:24:52 2003
+++ b/drivers/usb/input/hid-core.c	Sat Jun 21 15:24:52 2003
@@ -215,7 +215,7 @@
 		return -1;
 	}
 
-	if (parser->global.logical_maximum <= parser->global.logical_minimum) {
+	if (parser->global.logical_maximum < parser->global.logical_minimum) {
 		dbg("logical range invalid %d %d", parser->global.logical_minimum, parser->global.logical_maximum);
 		return -1;
 	}

