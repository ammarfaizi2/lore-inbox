Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272992AbTHKSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273111AbTHKSQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:16:22 -0400
Received: from mailrelay3.lanl.gov ([128.165.4.104]:49107 "EHLO
	mailrelay3.lanl.gov") by vger.kernel.org with ESMTP id S273028AbTHKSOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:14:35 -0400
Subject: Re: Kconfig -- kill "if you want to read about modules, see" crap?
From: Steven Cole <elenstev@mesatop.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <200308111400.h7BE01NL000208@81-2-122-30.bradfords.org.uk>
References: <200308111400.h7BE01NL000208@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1060625643.1736.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Aug 2003 12:14:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 08:00, John Bradford wrote:
> > Each and every input driver (and other drivers are not better)
> > contains this
> >
> > 	  This driver is also available as a module ( = code which can be
> > 	  inserted in and removed from the running kernel whenever you want).
> > 	  The module will be called input. If you want to compile it as a
> > 	  module, say M here and read <file:Documentation/modules.txt>.
> >
> > text. Perhaps having 1000 copies of same help test is bad idea?
> 
> I totally agree.  The only part that's useful is 'The module will be
> called...'.  We could change the whole wording to just, 'If compiled
> as a module, it will be called...'.
> 
> John.

Here is a little patch to implement this for
drivers/input/keyboard/Kconfig for a start.  The patch also fixes some
module names which were wrong (cut and paste errors).

Adding James Simmons to cc:list for patch review.  If this is the right
thing to do, please send Linuswards.

Steven

--- 2.5-bk-current/drivers/input/keyboard/Kconfig	Mon Aug 11 10:28:03 2003
+++ 2.5-linux/drivers/input/keyboard/Kconfig	Mon Aug 11 11:38:12 2003
@@ -23,10 +23,7 @@
 
 	  If unsure, say Y.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called atkbd. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called atkbd.
 
 config KEYBOARD_SUNKBD
 	tristate "Sun Type 4 and Type 5 keyboard support"
@@ -36,10 +33,7 @@
 	  connected either to the Sun keyboard connector or to an serial
 	  (RS-232) port via a simple adapter.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called sunkbd. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called sunkbd.
 
 config KEYBOARD_XTKBD
 	tristate "XT Keyboard support"
@@ -50,10 +44,7 @@
 	  parallel port keyboard adapter, you cannot connect it to the
 	  keyboard port on a PC that runs Linux. 
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called xtkbd. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called xtkbd.
 
 config KEYBOARD_NEWTON
 	tristate "Newton keyboard"
@@ -61,10 +52,7 @@
 	help
 	  Say Y here if you have a Newton keyboard on a serial port.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called maple_keyb. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called newtonkbd.
 
 config KEYBOARD_MAPLE
 	tristate "Maple bus keyboard support"
@@ -73,10 +61,7 @@
 	  Say Y here if you have a DreamCast console running Linux and have
 	  a keyboard attached to its Maple bus.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called maple_keyb. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called maple_keyb.
 
 config KEYBOARD_AMIGA
 	tristate "Amiga keyboard"
@@ -85,10 +70,7 @@
 	  Say Y here if you are running Linux on any AMIGA and have a keyboard
 	  attached.	
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called amikbd. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called amikbd.
 
 config KEYBOARD_98KBD
 	tristate "NEC PC-9800 Keyboard support"
@@ -97,8 +79,5 @@
 	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
 	  compatible) on your system. 
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called xtkbd.o. If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
+	  If compiled as a module, it will be called 98kbd.
 



