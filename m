Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbRL3U4o>; Sun, 30 Dec 2001 15:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284945AbRL3U4e>; Sun, 30 Dec 2001 15:56:34 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:20368 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S284970AbRL3U4Y>; Sun, 30 Dec 2001 15:56:24 -0500
Date: Sun, 30 Dec 2001 20:58:46 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, rmk@arm.linux.org.uk
Subject: PF_NOIO missing.
Message-ID: <20011230205846.A14713@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, rmk@arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, we didn't resync this bit quick enough..
Fixes build failure in loop.

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2-pre3/include/linux/sched.h linux-2.5/include/linux/sched.h
--- linux-2.5.2-pre3/include/linux/sched.h	Fri Dec 28 23:25:39 2001
+++ linux-2.5/include/linux/sched.h	Sat Dec 29 11:11:32 2001
@@ -433,6 +433,7 @@
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
+#define PF_NOIO		0x00004000	/* avoid generating further I/O */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
