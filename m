Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbTAIObl>; Thu, 9 Jan 2003 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbTAIObk>; Thu, 9 Jan 2003 09:31:40 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30663 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266675AbTAIObj>; Thu, 9 Jan 2003 09:31:39 -0500
Date: Thu, 9 Jan 2003 15:40:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>, claus@momo.math.rwth-aachen.de,
       linux-tape@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove KERNEL_VER from ftape.h
Message-ID: <20030109144016.GV6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patch that removed kernel 2.0 conpatibility code from 
drivers/char/ftape/* included in 2.5.55 removed all usages of KERNEL_VER 
but it is still #define'd in ftape.h.

The patch below removes this no longer needed #define.

I've tested the compilation with 2.5.55.

cu
Adrian

--- linux-2.5.55/include/linux/ftape.h.old	2003-01-09 15:27:41.000000000 +0100
+++ linux-2.5.55/include/linux/ftape.h	2003-01-09 15:34:46.000000000 +0100
@@ -30,9 +30,6 @@
 
 #define FTAPE_VERSION "ftape v3.04d 25/11/97"
 
-/* this makes the Kernel version numbers readable */
-#define KERNEL_VER(major,minor,sublvl) (((major)<<16)+((minor)<<8)+(sublvl))
-
 #ifdef __KERNEL__
 #include <linux/interrupt.h>
 #include <linux/mm.h>
