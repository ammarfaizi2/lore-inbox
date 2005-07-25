Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVGYGTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVGYGTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVGYF5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:17 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:56445 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261715AbVGYFzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:51 -0400
Message-Id: <20050725054531.981131000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 10/24] serio_raw: link misc device and serio port
Content-Disposition: inline; filename=serio-raw-link-to-device.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: serio_raw - link serio_raw misc device to corresponding
       serio port in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/serio_raw.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/serio/serio_raw.c
===================================================================
--- work.orig/drivers/input/serio/serio_raw.c
+++ work/drivers/input/serio/serio_raw.c
@@ -299,6 +299,7 @@ static int serio_raw_connect(struct seri
 
 	serio_raw->dev.minor = PSMOUSE_MINOR;
 	serio_raw->dev.name = serio_raw->name;
+	serio_raw->dev.dev = &serio->dev;
 	serio_raw->dev.fops = &serio_raw_fops;
 
 	err = misc_register(&serio_raw->dev);

