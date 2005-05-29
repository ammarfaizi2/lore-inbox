Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVE2FDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVE2FDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVE2FC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:28 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:31120 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261245AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045847.271815000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:19 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 06/13] i8042: tone down warning when PNP insists that KBC is missing
Content-Disposition: inline; filename=i8042-tone-down-warnings.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: Tone down the severity of a printk() in i386/ia64 arch code
       for i386, it's printed on many machines and usually is not
       a cause for worry.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
---

 drivers/input/serio/i8042-x86ia64io.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -241,7 +241,7 @@ static int i8042_pnp_init(void)
 #if defined(__ia64__)
 		return -ENODEV;
 #else
-		printk(KERN_WARNING "PNP: No PS/2 controller found. Probing ports directly.\n");
+		printk(KERN_INFO "PNP: No PS/2 controller found. Probing ports directly.\n");
 		return 0;
 #endif
 	}

