Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271310AbRHORN5>; Wed, 15 Aug 2001 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271316AbRHORNr>; Wed, 15 Aug 2001 13:13:47 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18571
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S271310AbRHORNk>; Wed, 15 Aug 2001 13:13:40 -0400
Date: Wed, 15 Aug 2001 10:13:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add linux/spinlock.h to include/linux/mc146816rtc.h
Message-ID: <20010815101346.F15482@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  include/linux/mc146818rtc.h has the line:
'extern spinlock_t rtc_lock;' in it, but it relies on linux/spinlock.h being
included elsewhere.  The inlined fixes that.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

diff -Nru a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
--- a/include/linux/mc146818rtc.h	Wed Aug 15 09:59:45 2001
+++ b/include/linux/mc146818rtc.h	Wed Aug 15 09:59:45 2001
@@ -13,6 +13,7 @@
 
 #include <asm/io.h>
 #include <linux/rtc.h>			/* get the user-level API */
+#include <linux/spinlock.h>		/* spinlock_t */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
