Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272909AbTG3OId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272904AbTG3OI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:08:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:32441 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272905AbTG3OIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:08:04 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 30 Jul 2003 16:08:00 +0200 (MEST)
Message-Id: <UTC200307301408.h6UE80K25902.aeb@smtp.cwi.nl>
To: bunk@fs.tum.de, clemens@endorphin.org, hvr@gnu.org
Subject: Re: [2.6 patch] let BLK_DEV_CRYPTOLOOP depend on EXPERIMENTAL
Cc: Andries.Brouwer@cwi.nl, akpm@cwi.nl, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest to let BLK_DEV_CRYPTOLOOP depend on EXPERIMENTAL

I have no objections.
Maybe you can also make INPUT depend on EXPERIMENTAL.

On the other hand, a few days ago I needed a serial line and
couldnt find the option in menuconfig. Turned out that
SERIAL_8250 depends on EXPERIMENTAL. I suppose that dependence
should be removed.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	Mon Jul 28 05:39:32 2003
+++ b/drivers/serial/Kconfig	Mon Jul 28 05:40:13 2003
@@ -9,8 +9,7 @@
 #
 # The new 8250/16550 serial drivers
 config SERIAL_8250
-	tristate "8250/16550 and compatible serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	tristate "8250/16550 and compatible serial support"
 	---help---
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
@@ -40,7 +39,7 @@
 	  modems and similar devices connecting to the standard serial ports.
 
 config SERIAL_8250_CONSOLE
-	bool "Console on 8250/16550 and compatible serial port (EXPERIMENTAL)"
+	bool "Console on 8250/16550 and compatible serial port"
 	depends on SERIAL_8250=y
 	---help---
 	  If you say Y here, it will be possible to use a serial port as the
@@ -53,8 +52,8 @@
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttyS1". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
+	  your boot loader (grub or lilo or loadlin) about how to pass options
+	  to the kernel at boot time.)
 
 	  If you don't have a VGA card installed and you say Y here, the
 	  kernel will automatically use the first serial line, /dev/ttyS0, as
