Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTJVLaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJVLaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:30:24 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:59151 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263541AbTJVLaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:30:13 -0400
Date: Wed, 22 Oct 2003 21:30:00 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: zwane@commfireservices.com
Subject: Re: scx200_wdt: Include linux/fs.h for struct file
Message-ID: <20031022113000.GA28019@gondor.apana.org.au>
References: <20031022112035.GA25439@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20031022112035.GA25439@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2003 at 09:20:35PM +1000, herbert wrote:
> 
> This patch adds an explicit inclusion of linux/fs.h as it needs to
> dereference struct file *.  This is needed for it to compile on
> non-i386 architectures.

The same change is needed on a number of other watchdog drivers.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/char/watchdog/alim1535_wdt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/alim1535_wdt.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 alim1535_wdt.c
--- kernel-source-2.5/drivers/char/watchdog/alim1535_wdt.c	28 Sep 2003 04:44:12 -0000	1.1.1.2
+++ kernel-source-2.5/drivers/char/watchdog/alim1535_wdt.c	22 Oct 2003 11:26:00 -0000
@@ -17,6 +17,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
Index: kernel-source-2.5/drivers/char/watchdog/alim7101_wdt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/alim7101_wdt.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 alim7101_wdt.c
--- kernel-source-2.5/drivers/char/watchdog/alim7101_wdt.c	22 Aug 2003 23:58:10 -0000	1.1.1.5
+++ kernel-source-2.5/drivers/char/watchdog/alim7101_wdt.c	22 Oct 2003 11:24:43 -0000
@@ -25,6 +25,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
Index: kernel-source-2.5/drivers/char/watchdog/amd7xx_tco.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/amd7xx_tco.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 amd7xx_tco.c
--- kernel-source-2.5/drivers/char/watchdog/amd7xx_tco.c	8 Oct 2003 19:24:02 -0000	1.1.1.5
+++ kernel-source-2.5/drivers/char/watchdog/amd7xx_tco.c	22 Oct 2003 11:28:27 -0000
@@ -31,6 +31,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 
 #define AMDTCO_MODULE_VER	"build 20021116"
 #define AMDTCO_MODULE_NAME	"amd7xx_tco"
Index: kernel-source-2.5/drivers/char/watchdog/i810-tco.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/i810-tco.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 i810-tco.c
--- kernel-source-2.5/drivers/char/watchdog/i810-tco.c	28 Sep 2003 04:44:12 -0000	1.1.1.7
+++ kernel-source-2.5/drivers/char/watchdog/i810-tco.c	22 Oct 2003 11:22:44 -0000
@@ -56,6 +56,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include "i810-tco.h"
Index: kernel-source-2.5/drivers/char/watchdog/sc1200wdt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/sc1200wdt.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 sc1200wdt.c
--- kernel-source-2.5/drivers/char/watchdog/sc1200wdt.c	24 Feb 2003 19:05:11 -0000	1.1.1.3
+++ kernel-source-2.5/drivers/char/watchdog/sc1200wdt.c	22 Oct 2003 11:26:50 -0000
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/pnp.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 
 #include <asm/semaphore.h>
 #include <asm/io.h>
Index: kernel-source-2.5/drivers/char/watchdog/wdt_pci.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/wdt_pci.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 wdt_pci.c
--- kernel-source-2.5/drivers/char/watchdog/wdt_pci.c	28 Sep 2003 04:44:12 -0000	1.1.1.10
+++ kernel-source-2.5/drivers/char/watchdog/wdt_pci.c	22 Oct 2003 11:21:15 -0000
@@ -47,6 +47,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>

--WIyZ46R2i8wDzkSu--
