Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSKSL1K>; Tue, 19 Nov 2002 06:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSKSL1K>; Tue, 19 Nov 2002 06:27:10 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:25040 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265228AbSKSL1D>; Tue, 19 Nov 2002 06:27:03 -0500
Message-Id: <4.3.2.7.2.20021119122403.00b50d70@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 19 Nov 2002 12:34:24 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.4.19 patch for Suse compatibility
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Below is a patch to include an ioctl that Suse kernels use
	at bootup. (Against vanilla 2.4.19)
	Comments ? Can it be included in 2.4.20(-rc*) ?

	Margit

diff -ur /tmp/linux-2.4.19/include/asm-alpha/ioctls.h 
/usr/src/linux/include/asm-alpha/ioctls.h
--- /tmp/linux-2.4.19/include/asm-alpha/ioctls.h        2001-04-14 
05:26:07.000000000 +0200
+++ /usr/src/linux/include/asm-alpha/ioctls.h   2002-11-14 
10:06:16.000000000 +0100
@@ -91,6 +92,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  0x5453
  #define TIOCSERGWILD   0x5454
diff -ur /tmp/linux-2.4.19/include/asm-arm/ioctls.h 
/usr/src/linux/include/asm-arm/ioctls.h
--- /tmp/linux-2.4.19/include/asm-arm/ioctls.h  2001-02-09 
01:32:44.000000000 +0100
+++ /usr/src/linux/include/asm-arm/ioctls.h     2002-11-14 
10:06:16.000000000 +0100
@@ -49,6 +49,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-i386/ioctls.h 
/usr/src/linux/include/asm-i386/ioctls.h
--- /tmp/linux-2.4.19/include/asm-i386/ioctls.h 2002-08-03 
02:39:45.000000000 +0200
+++ /usr/src/linux/include/asm-i386/ioctls.h    2002-11-14 
10:06:16.000000000 +0100
@@ -49,6 +49,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-ia64/ioctls.h 
/usr/src/linux/include/asm-ia64/ioctls.h
--- /tmp/linux-2.4.19/include/asm-ia64/ioctls.h 2000-02-07 
03:42:40.000000000 +0100
+++ /usr/src/linux/include/asm-ia64/ioctls.h    2002-11-14 
10:06:16.000000000 +0100
@@ -54,6 +54,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-m68k/ioctls.h 
/usr/src/linux/include/asm-m68k/ioctls.h
--- /tmp/linux-2.4.19/include/asm-m68k/ioctls.h 1998-02-13 
01:25:04.000000000 +0100
+++ /usr/src/linux/include/asm-m68k/ioctls.h    2002-11-14 
10:06:16.000000000 +0100
@@ -49,6 +49,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-mips/ioctls.h 
/usr/src/linux/include/asm-mips/ioctls.h
--- /tmp/linux-2.4.19/include/asm-mips/ioctls.h 2001-09-09 
19:43:01.000000000 +0200
+++ /usr/src/linux/include/asm-mips/ioctls.h    2002-11-14 
10:06:16.000000000 +0100
@@ -89,6 +89,7 @@
  #define TIOCGSID       0x7416  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  0x5488
  #define TIOCSERGWILD   0x5489
diff -ur /tmp/linux-2.4.19/include/asm-mips64/ioctls.h 
/usr/src/linux/include/asm-mips64/ioctls.h
--- /tmp/linux-2.4.19/include/asm-mips64/ioctls.h       2001-09-09 
19:43:02.000000000 +0200
+++ /usr/src/linux/include/asm-mips64/ioctls.h  2002-11-14 
10:06:16.000000000 +0100
@@ -89,6 +89,7 @@
  #define TIOCGSID       0x7416  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  0x5488
  #define TIOCSERGWILD   0x5489
diff -ur /tmp/linux-2.4.19/include/asm-ppc/ioctls.h 
/usr/src/linux/include/asm-ppc/ioctls.h
--- /tmp/linux-2.4.19/include/asm-ppc/ioctls.h  2001-05-22 
00:02:06.000000000 +0200
+++ /usr/src/linux/include/asm-ppc/ioctls.h     2002-11-14 
10:06:16.000000000 +0100
@@ -92,6 +92,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  0x5453
  #define TIOCSERGWILD   0x5454
diff -ur /tmp/linux-2.4.19/include/asm-ppc64/ioctls.h 
/usr/src/linux/include/asm-ppc64/ioctls.h
--- /tmp/linux-2.4.19/include/asm-ppc64/ioctls.h        2002-08-03 
02:39:45.000000000 +0200
+++ /usr/src/linux/include/asm-ppc64/ioctls.h   2002-11-14 
10:06:16.000000000 +0100
@@ -96,6 +96,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  0x5453
  #define TIOCSERGWILD   0x5454
diff -ur /tmp/linux-2.4.19/include/asm-s390/ioctls.h 
/usr/src/linux/include/asm-s390/ioctls.h
--- /tmp/linux-2.4.19/include/asm-s390/ioctls.h 2001-02-13 
23:13:44.000000000 +0100
+++ /usr/src/linux/include/asm-s390/ioctls.h    2002-11-14 
10:06:16.000000000 +0100
@@ -57,6 +57,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-s390x/ioctls.h 
/usr/src/linux/include/asm-s390x/ioctls.h
--- /tmp/linux-2.4.19/include/asm-s390x/ioctls.h        2001-02-13 
23:13:44.000000000 +0100
+++ /usr/src/linux/include/asm-s390x/ioctls.h   2002-11-14 
10:06:16.000000000 +0100
@@ -57,6 +57,7 @@
  #define TIOCGSID       0x5429  /* Return the session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define FIONCLEX       0x5450  /* these numbers need to be adjusted. */
  #define FIOCLEX                0x5451
diff -ur /tmp/linux-2.4.19/include/asm-sh/ioctls.h 
/usr/src/linux/include/asm-sh/ioctls.h
--- /tmp/linux-2.4.19/include/asm-sh/ioctls.h   1999-11-06 
19:40:31.000000000 +0100
+++ /usr/src/linux/include/asm-sh/ioctls.h      2002-11-14 
10:06:16.000000000 +0100
@@ -80,6 +81,7 @@
  #define TIOCGSID       _IOR('T', 41, pid_t) /* 0x5429 */ /* Return the 
session ID of FD */
  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of 
pty-mux device) */
  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */

  #define TIOCSERCONFIG  _IO('T', 83) /* 0x5453 */
  #define TIOCSERGWILD   _IOR('T', 84,  int) /* 0x5454 */
diff -ur /tmp/linux-2.4.19/include/asm-sparc/ioctls.h 
/usr/src/linux/include/asm-sparc/ioctls.h
--- /tmp/linux-2.4.19/include/asm-sparc/ioctls.h        2002-08-03 
02:39:45.000000000 +0200
+++ /usr/src/linux/include/asm-sparc/ioctls.h   2002-11-14 
10:06:16.000000000 +0100
@@ -99,6 +100,7 @@
  #define TIOCSSERIAL    0x541F
  #define TCSBRKP                0x5425
  #define TIOCTTYGSTRUCT 0x5426
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */
  #define TIOCSERCONFIG  0x5453
  #define TIOCSERGWILD   0x5454
  #define TIOCSERSWILD   0x5455
diff -ur /tmp/linux-2.4.19/include/asm-sparc64/ioctls.h 
/usr/src/linux/include/asm-sparc64/ioctls.h
--- /tmp/linux-2.4.19/include/asm-sparc64/ioctls.h      2002-08-03 
02:39:45.000000000 +0200
+++ /usr/src/linux/include/asm-sparc64/ioctls.h 2002-11-14 
10:06:16.000000000 +0100
@@ -100,6 +101,7 @@
  #define TIOCSSERIAL    0x541F
  #define TCSBRKP                0x5425
  #define TIOCTTYGSTRUCT 0x5426
+#define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get real dev no 
below /dev/console */
  #define TIOCSERCONFIG  0x5453
  #define TIOCSERGWILD   0x5454
  #define TIOCSERSWILD   0x5455
diff -u /tmp/linux-2.4.19/drivers/char/tty_io.c 
/usr/src/linux/drivers/char/tty_io.c
--- /tmp/linux-2.4.19/drivers/char/tty_io.c     2002-08-03 
02:39:43.000000000 +0200
+++ /usr/src/linux/drivers/char/tty_io.c        2002-11-14 
10:06:34.000000000 +0100
@@ -1765,7 +1806,8 @@
  #endif
                 case TIOCTTYGSTRUCT:
                         return tiocttygstruct(tty, (struct tty_struct *) arg);
-
+               case TIOCGDEV:
+                       return put_user (kdev_t_to_nr (real_tty->device), 
(unsigned int*) arg);
                 /*
                  * Break handling
                  */

