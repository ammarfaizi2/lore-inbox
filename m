Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271858AbRIMQra>; Thu, 13 Sep 2001 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271861AbRIMQrS>; Thu, 13 Sep 2001 12:47:18 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:18437 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271863AbRIMQqx>; Thu, 13 Sep 2001 12:46:53 -0400
Date: Thu, 13 Sep 2001 18:42:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 9/11] MD (raid) needs pid_t
Message-ID: <20010913184255.A2633@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On some architectures (including x86-64) pid_t isn't exactly 'long'. So
it matters to have it correct.

diff -urN linux-x86_64/drivers/md/md.c linux/drivers/md/md.c
--- linux-x86_64/drivers/md/md.c	Thu Aug 23 18:14:46 2001
+++ linux/drivers/md/md.c	Wed Sep 12 22:36:09 2001
@@ -47,7 +47,7 @@
 #include <asm/unaligned.h>
 
 extern asmlinkage int sys_sched_yield(void);
-extern asmlinkage long sys_setsid(void);
+extern asmlinkage pid_t sys_setsid(void);
 
 #define MAJOR_NR MD_MAJOR
 #define MD_DRIVER

-- 
Vojtech Pavlik
SuSE Labs
