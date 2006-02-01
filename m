Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWBAFOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWBAFOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWBAFJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:06 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:33679 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030324AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050734.429394000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 10/18] sidewinder: fix an oops
Content-Disposition: inline; filename=sidewinder-fix-oops.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zinx Verituse <zinx@bluecherry.net>

Input: sidewinder - fix an oops

Dynalloc conversion strikes again...

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/sidewinder.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/joystick/sidewinder.c
===================================================================
--- work.orig/drivers/input/joystick/sidewinder.c
+++ work/drivers/input/joystick/sidewinder.c
@@ -736,7 +736,7 @@ static int sw_connect(struct gameport *g
 		sprintf(sw->name, "Microsoft SideWinder %s", sw_name[sw->type]);
 		sprintf(sw->phys[i], "%s/input%d", gameport->phys, i);
 
-		input_dev = input_allocate_device();
+		sw->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			err = -ENOMEM;
 			goto fail3;

