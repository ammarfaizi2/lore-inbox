Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSASRYJ>; Sat, 19 Jan 2002 12:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSASRYA>; Sat, 19 Jan 2002 12:24:00 -0500
Received: from ns.suse.de ([213.95.15.193]:41990 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286207AbSASRXr>;
	Sat, 19 Jan 2002 12:23:47 -0500
Date: Sat, 19 Jan 2002 18:23:42 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18pre4 cleanup in asm-i386/system.h
Message-ID: <20020119182342.A5145@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the asm-i386/system.h includes <linux/init.h> without real need.
Some driver module authors do sometimes forget to include linux/init.h
in their code with the result that it can not compile on other archs.


--- linux-2.4.18pre4/include/asm-i386/system.h.old      Thu Nov 22 20:46:18 2001
+++ linux-2.4.18pre4/include/asm-i386/system.h  Sat Jan 19 17:40:51 2002
@@ -3,9 +3,8 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <asm/segment.h>
-#include <linux/bitops.h> /* for LOCK_PREFIX */
+#include <asm/bitops.h> /* for LOCK_PREFIX */
 
 #ifdef __KERNEL__
 


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
