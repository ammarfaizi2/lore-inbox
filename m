Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbTFRVhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbTFRVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:37:23 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:43258 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265548AbTFRVhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:37:18 -0400
Message-ID: <16112.57021.420450.341367@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 17:50:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: "John Stoffel" <stoffel@lucent.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH CYCLADES 2/2] update drivers/char/Kconfig cyclades entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I've cleaned up the Kconfig entry for the cyclades serial boards, this
makes it more obvious what the entry refers to in my mind.  

I'd also ask you to remove drivers/char/README.cyclomY since it's
*way* out of date and refers to an ancient version of the driver and
MAKEDEV scripts.

Thanks,
John
john@stoffel.org

diff -ur l-2.5.72/drivers/char/Kconfig l-2.5.72-cyclades/drivers/char/Kconfig
--- l-2.5.72/drivers/char/Kconfig	Wed Jun 18 10:26:21 2003
+++ l-2.5.72-cyclades/drivers/char/Kconfig	Wed Jun 18 17:37:42 2003
@@ -110,17 +110,19 @@
           you don't have a Comtrol RocketPort/RocketModem card installed, say N.
 
 config CYCLADES
-	tristate "Cyclades async mux support"
+	tristate "Cyclades Multiport Serial Board support"
 	depends on SERIAL_NONSTANDARD
 	---help---
 	  This is a driver for a card that gives you many serial ports. You
 	  would need something like this to connect more than two modems to
 	  your Linux box, for instance in order to become a dial-in server.
-	  For information about the Cyclades-Z card, read
-	  <file:drivers/char/README.cycladesZ>.
+          This driver supports the following boards:
+
+             Cyclom-Y (ISA or PCI)
+             Cyclades-Z (PCI)
 
-	  As of 1.3.9x kernels, this driver's minor numbers start at 0 instead
-	  of 32.
+          For information about the Cyclades-Z card, read
+	  <file:drivers/char/README.cycladesZ>.
 
 	  If you want to compile this as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
