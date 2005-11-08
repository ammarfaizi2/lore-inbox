Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbVKHGoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbVKHGoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbVKHGoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:44:15 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:15251 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965273AbVKHGoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:44:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Input: fix 'uniq' reporting in hotplug handler
Date: Tue, 8 Nov 2005 01:44:09 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.de>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511080144.11095.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: fix 'uniq' reporting in hotplug handler

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -669,7 +669,7 @@ static int input_dev_hotplug(struct clas
 		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);
 	if (dev->phys)
 		INPUT_ADD_HOTPLUG_VAR("PHYS=\"%s\"", dev->phys);
-	if (dev->phys)
+	if (dev->uniq)
 		INPUT_ADD_HOTPLUG_VAR("UNIQ=\"%s\"", dev->uniq);
 
 	INPUT_ADD_HOTPLUG_BM_VAR("EV=", dev->evbit, EV_MAX);
