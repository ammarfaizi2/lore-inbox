Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTISK2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTISK1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:03 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:19854 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261489AbTISK0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:53 -0400
Subject: [PATCH 9/11] input: Enlarge the timeout for PS/2 mouse full reset
In-Reply-To: <10639672013970@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:42 +0200
Message-Id: <10639672021535@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1347, 2003-09-19 01:23:29-07:00, vojtech@suse.cz
  psmouse-base.c:
    Enlarge the timeout for PS/2 mouse full reset.


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:15:54 2003
+++ b/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:15:54 2003
@@ -223,7 +223,7 @@
 	psmouse->cmdcnt = receive;
 
 	if (command == PSMOUSE_CMD_RESET_BAT)
-                timeout = 2000000; /* 2 sec */
+                timeout = 4000000; /* 4 sec */
 
 	if (command & 0xff)
 		if (psmouse_sendbyte(psmouse, command & 0xff))

