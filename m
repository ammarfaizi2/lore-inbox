Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422886AbWJVAyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422886AbWJVAyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWJVAyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:54:50 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:53662 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1422886AbWJVAyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:54:49 -0400
Message-id: <173491782393713775@wsc.cz>
Subject: [PATCH 3/3] Char: isicom, remove cvs stuff
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 22 Oct 2006 02:54:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, remove cvs stuff

We don't need RCS_ID & co. Extract them from the code and define only one
macro -- SX_VERSION.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d8e4a1a052b460b07936030bc99d8d9fe2b4bbf9
tree 0dd0319eb9b5e9d2380bbd605ed66fc755aa391b
parent e545b8cddd984bff6abbc1286baa042290b43032
author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 00:26:29 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 00:26:29 +0200

 drivers/char/sx.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index e9bc147..cf08be7 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -32,7 +32,6 @@
  *      USA.
  *
  * Revision history:
- * $Log: sx.c,v $
  * Revision 1.33  2000/03/09 10:00:00  pvdl,wolff
  * - Fixed module and port counting
  * - Fixed signal handling
@@ -199,9 +198,7 @@
  *
  * */
 
-
-#define RCS_ID "$Id: sx.c,v 1.33 2000/03/08 10:01:02 wolff, pvdl Exp $"
-#define RCS_REV "$Revision: 1.33 $"
+#define SX_VERSION	1.33
 
 #include <linux/module.h>
 #include <linux/kdev_t.h>
@@ -2052,7 +2049,7 @@ static void printheader(void)
 	if (!header_printed) {
 		printk (KERN_INFO "Specialix SX driver "
 		        "(C) 1998/1999 R.E.Wolff@BitWizard.nl \n");
-		printk (KERN_INFO "sx: version %s\n", RCS_ID);
+		printk (KERN_INFO "sx: version " __stringify(SX_VERSION) "\n");
 		header_printed = 1;
 	}
 }
