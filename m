Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSFEPFy>; Wed, 5 Jun 2002 11:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFEPFx>; Wed, 5 Jun 2002 11:05:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315447AbSFEPFw>; Wed, 5 Jun 2002 11:05:52 -0400
Date: Wed, 5 Jun 2002 16:05:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow mpage.c to build
Message-ID: <20020605160547.C10293@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

When trying to build mpage.c for ARM, I get errors from bio.h since kdev_t
isn't defined.  The following fixes this.

(I fail to see how this can build for anyone as it currently stands; its
probably something x86 specific buried in the asm-i386 includes.)

--- orig/fs/mpage.c	Wed May 29 23:57:08 2002
+++ linux/fs/mpage.c	Thu May 30 00:34:44 2002
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/kdev_t.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
 #include <linux/buffer_head.h>

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

