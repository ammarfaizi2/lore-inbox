Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWI3XYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWI3XYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 19:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWI3XYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 19:24:00 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:54480 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751705AbWI3XYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 19:24:00 -0400
Message-id: <345345345435@wsc.cz>
Subject: [PATCH] Char: serial167, remove useless tty check
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <cyclades@netcom.com>
Cc: <bentson@grieg.seaslug.org>
Date: Sun,  1 Oct 2006 01:23:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serial167, remove useless tty check

tty is dereferenced before it is checked to be nonNULL. Remove such check.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 00bed6b2fb10dd07cdde1f6ebe8066058b748ce1
tree b69d8cc230471d1e5dfa09d273960997deb42eba
parent 810378cbe277c73f99219e343f54e782459b6b61
author Jiri Slaby <jirislaby@gmail.com> Sun, 01 Oct 2006 01:12:34 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sun, 01 Oct 2006 01:12:34 +0200

 drivers/char/serial167.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
index 48dae5d..f4809c8 100644
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -1121,7 +1121,7 @@ #endif
     if (serial_paranoia_check(info, tty->name, "cy_put_char"))
 	return;
 
-    if (!tty || !info->xmit_buf)
+    if (!info->xmit_buf)
 	return;
 
     local_irq_save(flags);
@@ -1187,7 +1187,7 @@ #endif
 	return 0;
     }
 	
-    if (!tty || !info->xmit_buf){
+    if (!info->xmit_buf){
         return 0;
     }
 
