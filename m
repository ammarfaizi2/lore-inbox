Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTBLK77>; Wed, 12 Feb 2003 05:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBLK7p>; Wed, 12 Feb 2003 05:59:45 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:51337 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267098AbTBLK6U>;
	Wed, 12 Feb 2003 05:58:20 -0500
Date: Wed, 12 Feb 2003 12:07:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: sunkbd.c - fix reading beyond end of keycode array [14/14]
Message-ID: <20030212120757.M1563@ucw.cz>
References: <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz> <20030212120454.H1563@ucw.cz> <20030212120530.I1563@ucw.cz> <20030212120605.J1563@ucw.cz> <20030212120638.K1563@ucw.cz> <20030212120710.L1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120710.L1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:07:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1017, 2003-02-12 11:09:03+01:00, vojtech@suse.cz
  input: sunkbd.c - fix reading beyond end of keycode array.


 sunkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
+++ b/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
@@ -268,7 +268,7 @@
 	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
 
 	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
-	for (i = 0; i < 255; i++)
+	for (i = 0; i < 127; i++)
 		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
 	clear_bit(0, sunkbd->dev.keybit);
 
