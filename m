Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRLBL7h>; Sun, 2 Dec 2001 06:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282844AbRLBL72>; Sun, 2 Dec 2001 06:59:28 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:4843 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282843AbRLBL7J>; Sun, 2 Dec 2001 06:59:09 -0500
Date: Sun, 2 Dec 2001 14:03:38 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <bsdlite5@hotmail.com>
Subject: [PATCH] floppy.c #defines
Message-ID: <Pine.LNX.4.33.0112021351000.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was more but, all in all floppy.c is a strange place...

Regards,
	Zwane

diffed against 2.5.1-pre5

diff -urN linux-2.5.1-pre5/drivers/block/floppy.c linux-2.5.1-pre5-test/drivers/block/floppy.c
--- linux-2.5.1-pre5/drivers/block/floppy.c	Sun Dec  2 12:57:38 2001
+++ linux-2.5.1-pre5-test/drivers/block/floppy.c	Sun Dec  2 12:58:44 2001
@@ -496,7 +496,7 @@

 #define NO_SIGNAL (!interruptible || !signal_pending(current))
 #define CALL(x) if ((x) == -EINTR) return -EINTR
-#define ECALL(x) if ((ret = (x))) return ret;
+#define ECALL(x) if ((ret = (x))) return ret
 #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
 #define WAIT(x) _WAIT((x),interruptible)
 #define IWAIT(x) _WAIT((x),1)
@@ -670,7 +670,7 @@
 	else
 		return b;
 }
-#define INFBOUND(a,b) (a)=maximum((a),(b));
+#define INFBOUND(a,b) (a)=maximum((a),(b))

 static int minimum(int a, int b)
 {
@@ -679,7 +679,7 @@
 	else
 		return b;
 }
-#define SUPBOUND(a,b) (a)=minimum((a),(b));
+#define SUPBOUND(a,b) (a)=minimum((a),(b))


 /*
@@ -899,7 +899,7 @@
 #define lock_fdc(drive,interruptible) _lock_fdc(drive,interruptible, __LINE__)

 #define LOCK_FDC(drive,interruptible) \
-if (lock_fdc(drive,interruptible)) return -EINTR;
+if (lock_fdc(drive,interruptible)) return -EINTR


 /* unlocks the driver */
@@ -3506,7 +3506,7 @@
 	/* copyin */
 	CLEARSTRUCT(&inparam);
 	if (_IOC_DIR(cmd) & _IOC_WRITE)
-		ECALL(fd_copyin((void *)param, &inparam, size))
+		ECALL(fd_copyin((void *)param, &inparam, size));

 	switch (cmd) {
 		case FDEJECT:

