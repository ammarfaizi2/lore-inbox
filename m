Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272970AbRIHGm6>; Sat, 8 Sep 2001 02:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272971AbRIHGms>; Sat, 8 Sep 2001 02:42:48 -0400
Received: from [144.137.83.84] ([144.137.83.84]:44538 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S272970AbRIHGmo>;
	Sat, 8 Sep 2001 02:42:44 -0400
Message-ID: <3B99BB98.797ADBD3@eyal.emu.id.au>
Date: Sat, 08 Sep 2001 16:32:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5: drivers/net/wan compile fixes
In-Reply-To: <Pine.LNX.4.33.0109072117580.1259-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------9F3FD0778ACAA955116E80B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F3FD0778ACAA955116E80B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A number of modules fail to include <linux/module.h> but use the new
MODULE_LICENSE macro.
--------------9F3FD0778ACAA955116E80B9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre5-wan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre5-wan.patch"

diff -u -r linux/drivers/net/wan-orig/sdla_chdlc.c linux/drivers/net/wan/sdla_chdlc.c
--- linux/drivers/net/wan-orig/sdla_chdlc.c	Sat Sep  8 16:22:28 2001
+++ linux/drivers/net/wan/sdla_chdlc.c	Sat Sep  8 16:17:52 2001
@@ -48,6 +48,7 @@
 * Aug 07, 1998	David Fong	Initial version.
 *****************************************************************************/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */
diff -u -r linux/drivers/net/wan-orig/sdla_fr.c linux/drivers/net/wan/sdla_fr.c
--- linux/drivers/net/wan-orig/sdla_fr.c	Sat Sep  8 16:23:04 2001
+++ linux/drivers/net/wan/sdla_fr.c	Sat Sep  8 16:23:17 2001
@@ -138,6 +138,7 @@
 * Jan 02, 1997	Gene Kozin	Initial version.
 *****************************************************************************/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */
diff -u -r linux/drivers/net/wan-orig/sdla_ft1.c linux/drivers/net/wan/sdla_ft1.c
--- linux/drivers/net/wan-orig/sdla_ft1.c	Sat Sep  8 16:13:18 2001
+++ linux/drivers/net/wan/sdla_ft1.c	Sat Sep  8 16:13:34 2001
@@ -20,6 +20,7 @@
 * Aug 07, 1998	David Fong	Initial version.
 *****************************************************************************/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */
diff -u -r linux/drivers/net/wan-orig/sdla_ppp.c linux/drivers/net/wan/sdla_ppp.c
--- linux/drivers/net/wan-orig/sdla_ppp.c	Sat Sep  8 16:22:13 2001
+++ linux/drivers/net/wan/sdla_ppp.c	Sat Sep  8 16:18:50 2001
@@ -90,6 +90,7 @@
 * Jan 06, 1997	Gene Kozin	Initial version.
 *****************************************************************************/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */
diff -u -r linux/drivers/net/wan-orig/sdla_x25.c linux/drivers/net/wan/sdla_x25.c
--- linux/drivers/net/wan-orig/sdla_x25.c	Sat Sep  8 16:15:33 2001
+++ linux/drivers/net/wan/sdla_x25.c	Sat Sep  8 16:15:12 2001
@@ -81,6 +81,7 @@
  * 	Includes 
  *=====================================================*/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */
diff -u -r linux/drivers/net/wan-orig/wanpipe_multppp.c linux/drivers/net/wan/wanpipe_multppp.c
--- linux/drivers/net/wan-orig/wanpipe_multppp.c	Sat Sep  8 16:24:02 2001
+++ linux/drivers/net/wan/wanpipe_multppp.c	Sat Sep  8 16:19:59 2001
@@ -17,6 +17,7 @@
 *  		module.
 *****************************************************************************/
 
+#include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>	/* printk(), and other useful stuff */
 #include <linux/stddef.h>	/* offsetof(), etc. */

--------------9F3FD0778ACAA955116E80B9--

