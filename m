Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316253AbSEZSdb>; Sun, 26 May 2002 14:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316254AbSEZSda>; Sun, 26 May 2002 14:33:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:63387 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316252AbSEZSd2>;
	Sun, 26 May 2002 14:33:28 -0400
Date: Sun, 26 May 2002 20:32:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: trivial: vmscan extra {}s
Message-ID: <20020526183200.GA11613@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Extra { } look ugly, too, they are not consistant with rest of code and I introduced them :-(

--- clean/mm/vmscan.c	Sun May 26 19:32:05 2002
+++ linux-swsusp/mm/vmscan.c	Sun May 26 19:55:34 2002
@@ -794,10 +794,8 @@
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep()) {
+		if (kswapd_can_sleep())
 			schedule();
-		}
-		
 
 		__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&kswapd_wait, &wait);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
