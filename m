Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313025AbSDYKGA>; Thu, 25 Apr 2002 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSDYKF7>; Thu, 25 Apr 2002 06:05:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:59279 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313025AbSDYKFz>;
	Thu, 25 Apr 2002 06:05:55 -0400
Date: Thu, 25 Apr 2002 12:04:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Warn about trap for programmer in mm.h
Message-ID: <20020425100440.GA5061@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As suggested by A.Morton:
									Pavel

--- clean/include/linux/mm.h	Thu Apr 18 22:46:17 2002
+++ linux/include/linux/mm.h	Thu Apr 25 12:01:19 2002
@@ -291,8 +291,8 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
-
 #define PG_private		16	/* Has something at ->private */
+/* Top 8 bits are used for page's zone in 2.4-ac and 2.5, don't use them */
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
