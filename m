Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133057AbRDLHG7>; Thu, 12 Apr 2001 03:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133058AbRDLHGz>; Thu, 12 Apr 2001 03:06:55 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61345 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S133057AbRDLHG2>;
	Thu, 12 Apr 2001 03:06:28 -0400
Message-ID: <3AD553EF.9C585755@mandrakesoft.com>
Date: Thu, 12 Apr 2001 03:06:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.4-pre2: fix build...
Content-Type: multipart/mixed;
 boundary="------------79BD2878E97D91C34A68538A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------79BD2878E97D91C34A68538A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some uniprocessor configurations require the following patch in order to
build 2.4.4-pre2 at all...
-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
--------------79BD2878E97D91C34A68538A
Content-Type: text/plain; charset=us-ascii;
 name="rwsem-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem-fix.patch"

Index: include/asm-i386/rwsem.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/asm-i386/rwsem.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rwsem.h
--- include/asm-i386/rwsem.h	2001/04/12 03:17:29	1.1.1.1
+++ include/asm-i386/rwsem.h	2001/04/12 06:49:36
@@ -15,10 +15,10 @@
 
 #ifdef __KERNEL__
 
+#include <linux/wait.h>
+#include <linux/spinlock.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/spinlock.h>
-#include <linux/wait.h>
 
 #if RWSEM_DEBUG
 #define rwsemdebug(FMT,...) do { if (sem->debug) printk(FMT,__VA_ARGS__); } while(0)

--------------79BD2878E97D91C34A68538A--

