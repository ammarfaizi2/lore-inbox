Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUEKG3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUEKG3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUEKG2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:28:53 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:32632 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262337AbUEKGZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/9] New set of input patches - 11-synaptics-reconnect.patch
Date: Tue, 11 May 2004 01:09:05 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net> <200405110105.58112.dtor_core@ameritech.net> <200405110106.32081.dtor_core@ameritech.net>
In-Reply-To: <200405110106.32081.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405110109.11506.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.12, 2004-05-10 01:37:47-05:00, dtor_core@ameritech.net
  Input: do not call synaptics_init unless we are ready to do full
         mouse setup


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue May 11 00:57:50 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue May 11 00:57:50 2004
@@ -427,7 +427,7 @@
 		}
 
 		if (max_proto > PSMOUSE_IMEX) {
-			if (synaptics_init(psmouse) == 0)
+			if (!set_properties || synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
