Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbREOQkp>; Tue, 15 May 2001 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbREOQkg>; Tue, 15 May 2001 12:40:36 -0400
Received: from intranet.resilience.com ([209.245.157.33]:22005 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S261942AbREOQkV>; Tue, 15 May 2001 12:40:21 -0400
Message-ID: <3B015D19.E5581AAD@resilience.com>
Date: Tue, 15 May 2001 09:45:13 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove silly beep macro from pgtable.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Found this bit of unused code in the i386 and sh architectures.  As it's not being used, let's get rid of it.  Also, pgtable.h seems to be an odd place for this.

-Jeff

diff -u -r linux-2.4.4.pure/include/asm-i386/pgtable.h linux-2.4.4/include/asm-i386/pgtable.h
--- linux-2.4.4.pure/include/asm-i386/pgtable.h Fri Apr 27 15:48:21 2001
+++ linux-2.4.4/include/asm-i386/pgtable.h      Tue May 15 09:12:24 2001
@@ -110,8 +110,6 @@
 #endif
 #endif

-#define __beep() asm("movb $0x3,%al; outb %al,$0x61")
-
 #define PMD_SIZE       (1UL << PMD_SHIFT)
 #define PMD_MASK       (~(PMD_SIZE-1))
 #define PGDIR_SIZE     (1UL << PGDIR_SHIFT)
diff -u -r linux-2.4.4.pure/include/asm-sh/pgtable.h linux-2.4.4/include/asm-sh/pgtable.h
--- linux-2.4.4.pure/include/asm-sh/pgtable.h   Wed Apr 11 21:24:52 2001
+++ linux-2.4.4/include/asm-sh/pgtable.h        Tue May 15 09:35:29 2001
@@ -72,8 +72,6 @@

 #include <asm/pgtable-2level.h>

-#define __beep() asm("")
-
 #define PMD_SIZE       (1UL << PMD_SHIFT)
 #define PMD_MASK       (~(PMD_SIZE-1))
 #define PGDIR_SIZE     (1UL << PGDIR_SHIFT)

-- 
Jeff Golds
jgolds@resilience.com
