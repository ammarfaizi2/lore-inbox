Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbREWUq3>; Wed, 23 May 2001 16:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbREWUqJ>; Wed, 23 May 2001 16:46:09 -0400
Received: from 136-CORU-X12.libre.retevision.es ([62.83.49.136]:14994 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S263251AbREWUqA>;
	Wed, 23 May 2001 16:46:00 -0400
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] hga depmod fix
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 23 May 2001 22:44:38 +0200
Message-ID: <m2ofsju761.fsf@trasno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        if you compile hga as a module, you get unresolved symbols,
        you need the following patch for it.
        The patch is trivial.  Apply, please.

Later, Juan.

--- linux/drivers/video/hgafb.c.~1~	Mon May 21 08:56:08 2001
+++ linux/drivers/video/hgafb.c	Mon May 21 09:04:00 2001
@@ -712,7 +712,7 @@
 
 	hga_gfx_mode();
 	hga_clear_screen();
-#ifdef MODULE
+#ifndef MODULE
 	if (!nologo) hga_show_logo();
 #endif /* MODULE */
 


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
