Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDCWeA>; Wed, 3 Apr 2002 17:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDCWdu>; Wed, 3 Apr 2002 17:33:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10889 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312420AbSDCWdl>;
	Wed, 3 Apr 2002 17:33:41 -0500
Date: Thu, 4 Apr 2002 00:18:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Warn about ioctl collision
Message-ID: <20020403221815.GA1141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It is probably too late to fix it properly, but warning is better than
nothing. (It confused the hell out of me...)
									Pavel

--- clean.2.5/include/asm-i386/ioctls.h	Fri Jul 24 20:10:16 1998
+++ linux/include/asm-i386/ioctls.h	Thu Oct 25 13:24:35 2001
@@ -6,7 +6,7 @@
 /* 0x54 is just a magic number to make these relatively unique ('T') */
 
 #define TCGETS		0x5401
-#define TCSETS		0x5402
+#define TCSETS		0x5402 /* Clashes with SNDCTL_TMR_START sound ioctl */
 #define TCSETSW		0x5403
 #define TCSETSF		0x5404
 #define TCGETA		0x5405

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
