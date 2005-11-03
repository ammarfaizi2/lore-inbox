Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVKCEbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVKCEbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKCEbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:31:36 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:16796 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030324AbVKCEbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:31:23 -0500
Message-Id: <20051103042818.616523000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 5/7] locomokbd: fix wrong bustype
Content-Disposition: inline; filename=locomo-fix-bustype.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>

Input: locomokbd - fix wrong bustype

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/locomokbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/keyboard/locomokbd.c
===================================================================
--- work.orig/drivers/input/keyboard/locomokbd.c
+++ work/drivers/input/keyboard/locomokbd.c
@@ -230,7 +230,7 @@ static int locomokbd_probe(struct locomo
 
 	input_dev->name = "LoCoMo keyboard";
 	input_dev->phys = locomokbd->phys;
-	input_dev->id.bustype = BUS_XTKBD;
+	input_dev->id.bustype = BUS_HOST;
 	input_dev->id.vendor = 0x0001;
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0100;

