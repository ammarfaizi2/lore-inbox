Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbTFNUWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265721AbTFNUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:22:50 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41961 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265716AbTFNUWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:22:43 -0400
Date: Sat, 14 Jun 2003 22:36:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Fix sunkbd keybit bitfield filling [2/13]
Message-ID: <20030614223629.A25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614223513.A25948@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:35:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.19, 2003-06-09 13:48:38+02:00, vojtech@suse.cz
  input: fix sunkbd to properly set its bitfields up to key #127.


 sunkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Sat Jun 14 22:21:43 2003
+++ b/drivers/input/keyboard/sunkbd.c	Sat Jun 14 22:21:43 2003
@@ -271,7 +271,7 @@
 	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
 
 	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
-	for (i = 0; i < 127; i++)
+	for (i = 0; i < 128; i++)
 		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
 	clear_bit(0, sunkbd->dev.keybit);
 
