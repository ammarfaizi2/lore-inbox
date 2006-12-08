Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425299AbWLHJqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425299AbWLHJqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425296AbWLHJqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:46:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54975 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425299AbWLHJqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:46:34 -0500
Date: Fri, 8 Dec 2006 09:46:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing includes in hilkbd
Message-ID: <20061208094633.GQ4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's built on m68k too...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/input/keyboard/hilkbd.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index 54bc569..35461ea 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -23,7 +23,12 @@ #include <linux/input.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/hil.h>
+#include <linux/io.h>
 #include <linux/spinlock.h>
+#include <asm/irq.h>
+#ifdef CONFIG_HP300
+#include <asm/hwtest.h>
+#endif
 
 
 MODULE_AUTHOR("Philip Blundell, Matthew Wilcox, Helge Deller");
-- 
1.4.2.GIT

