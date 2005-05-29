Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVE2FBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVE2FBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVE2FBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:01:12 -0400
Received: from smtp831.mail.sc5.yahoo.com ([66.163.171.18]:53351 "HELO
	smtp831.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261234AbVE2FBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:08 -0400
Message-Id: <20050529045846.670822000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 01/13] Fix a warning in psmouse-base.c
Content-Disposition: inline; filename=psmouse-warning-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Input: Fix a warning in psmouse-base.c

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -972,7 +972,7 @@ static int psmouse_set_maxproto(const ch
 		return -EINVAL;
 
 	if (!strncmp(val, "any", 3)) {
-		*((unsigned int *)kp->arg) = -1UL;
+		*((unsigned int *)kp->arg) = -1U;
 		return 0;
 	}
 

