Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUFGMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUFGMXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUFGMWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:22:21 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15489 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264610AbUFGL4T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:19 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093543712@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093542892@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 32/39] input: Do not call synaptics_init unless we are ready to do full mouse setup
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.12, 2004-05-10 01:37:47-05:00, dtor_core@ameritech.net
  Input: do not call synaptics_init unless we are ready to do full
         mouse setup


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:10:55 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:10:55 +02:00
@@ -427,7 +427,7 @@
 		}
 
 		if (max_proto > PSMOUSE_IMEX) {
-			if (synaptics_init(psmouse) == 0)
+			if (!set_properties || synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).

