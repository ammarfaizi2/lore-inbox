Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTASXiL>; Sun, 19 Jan 2003 18:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267722AbTASXiL>; Sun, 19 Jan 2003 18:38:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42964 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267721AbTASXiJ>; Sun, 19 Jan 2003 18:38:09 -0500
Date: Mon, 20 Jan 2003 00:47:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: intermezzo-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small intermezzo cleanup
Message-ID: <20030119234707.GE12601@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups in the intermezzo code:
- remove #include <stdarg.h>'s
- remove unused #define MIN/MAX/MKSTR

I've tested the compilation with 2.5.59.

Please apply
Adrian


--- linux-2.5.59-full/fs/intermezzo/dir.c.old	2003-01-20 00:40:01.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/dir.c	2003-01-20 00:40:29.000000000 +0100
@@ -22,8 +22,6 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <stdarg.h>
-
 #include <asm/bitops.h>
 #include <asm/ioctls.h>
 #include <asm/uaccess.h>
--- linux-2.5.59-full/fs/intermezzo/fileset.c.old	2003-01-20 00:40:30.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/fileset.c	2003-01-20 00:40:47.000000000 +0100
@@ -23,7 +23,6 @@
  */
 
 #define __NO_VERSION__
-#include <stdarg.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- linux-2.5.59-full/fs/intermezzo/cache.c.old	2003-01-20 00:40:48.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/cache.c	2003-01-20 00:40:55.000000000 +0100
@@ -22,7 +22,6 @@
 
 #define __NO_VERSION__
 #include <linux/module.h>
-#include <stdarg.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2.5.59-full/fs/intermezzo/replicator.c.old	2003-01-20 00:40:56.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/replicator.c	2003-01-20 00:41:03.000000000 +0100
@@ -25,7 +25,6 @@
 
 #define __NO_VERSION__
 #include <linux/module.h>
-#include <stdarg.h>
 #include <asm/uaccess.h>
 
 #include <linux/errno.h>
--- linux-2.5.59-full/fs/intermezzo/file.c.old	2003-01-20 00:41:04.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/file.c	2003-01-20 00:41:12.000000000 +0100
@@ -29,8 +29,6 @@
  * 
  */
 
-#include <stdarg.h>
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2.5.59-full/fs/intermezzo/methods.c.old	2003-01-20 00:41:13.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/methods.c	2003-01-20 00:41:21.000000000 +0100
@@ -25,8 +25,6 @@
  *
  */
 
-#include <stdarg.h>
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2.5.59-full/fs/intermezzo/super.c.old	2003-01-20 00:41:22.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/super.c	2003-01-20 00:41:31.000000000 +0100
@@ -26,8 +26,6 @@
 static char rcsid[] __attribute ((unused)) = "$Id: super.c,v 1.4 2002/10/12 02:16:19 rread Exp $";
 #define INTERMEZZO_VERSION "$Revision: 1.4 $"
 
-#include <stdarg.h>
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
--- linux-2.5.59-full/fs/intermezzo/intermezzo_lib.h.old	2003-01-20 00:41:45.000000000 +0100
+++ linux-2.5.59-full/fs/intermezzo/intermezzo_lib.h	2003-01-20 00:42:27.000000000 +0100
@@ -32,12 +32,6 @@
 # include <sys/types.h>
 #endif
 
-#undef MIN
-#define MIN(a,b) (((a)<(b)) ? (a): (b))
-#undef MAX
-#define MAX(a,b) (((a)>(b)) ? (a): (b))
-#define MKSTR(ptr) ((ptr))? (ptr) : ""
-
 static inline int size_round (int val)
 {
 	return (val + 3) & (~0x3);


