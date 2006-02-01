Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWBAFJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWBAFJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWBAFJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:20 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:19371 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030307AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201050733.622200000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 03/18] iforce: do not return ENOMEM upon successful allocation
Content-Disposition: inline; filename=iforce-enomem-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

Input: iforce - do not return ENOMEM upon successful allocation

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/iforce/iforce-main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- work.orig/drivers/input/joystick/iforce/iforce-main.c
+++ work/drivers/input/joystick/iforce/iforce-main.c
@@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
 	int i;
 
 	input_dev = input_allocate_device();
-	if (input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&iforce->wait);

