Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUDUGVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUDUGVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUDUGIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:00 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:37036 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264985AbUDUGFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/15] New set of input patches: lkkbd simplify checks
Date: Wed, 21 Apr 2004 00:53:07 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210053.09166.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1906, 2004-04-20 22:26:58-05:00, dtor_core@ameritech.net
  Input: simplify checks for supported serio port in lkkbd


 lkkbd.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:01:41 2004
+++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:01:41 2004
@@ -527,9 +527,7 @@
 
 	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
 		return;
-	if (!(serio->type & SERIO_PROTO))
-		return;
-	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_LKKBD)
+	if ((serio->type & SERIO_PROTO) != SERIO_LKKBD)
 		return;
 
 	if (!(lk = kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
