Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTEJMF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 08:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbTEJMF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 08:05:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57083 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264072AbTEJMFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 08:05:45 -0400
Date: Sat, 10 May 2003 14:18:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] Configure.help updates from -ac
Message-ID: <20030510121816.GC1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below includes some Configure.help entries for new options in 
2.4.21 that aren't in 2.4.21-rc2 from -ac.

It applies (with a few lines offset) against 2.4.21-rc2.

Please apply
Adrian


--- linux.21rc1/Documentation/Configure.help	2003-04-22 16:39:32.000000000 +0100
+++ linux.21rc1-ac4/Documentation/Configure.help	2003-05-03 19:08:44.000000000 +0100
@@ -23168,6 +23545,23 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called radio-sf16fmi.o.
 
+SF16FMR2 Radio
+CONFIG_RADIO_SF16FMR2
+  Choose Y here if you have one of these FM radio cards.  If you
+  compile the driver into the kernel and your card is not PnP one, you
+  have to add "sf16fmr2=<io>" to the kernel command line (I/O address is
+  0x284 or 0x384, default 0x384).
+
+  In order to control your radio card, you will need to use programs
+  that are compatible with the Video For Linux API.  Information on
+  this API and pointers to "v4l" programs may be found on the WWW at
+  <http://roadrunner.swansea.uk.linux.org/v4l.shtml>.
+
+  If you want to compile this driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>.  The module
+  will be called radio-sf16fmr2.o.
+
 Typhoon Radio (a.k.a. EcoRadio)
 CONFIG_RADIO_TYPHOON
   Choose Y here if you have one of these FM radio cards, and then fill
@@ -26523,6 +27038,90 @@
 
   If unsure, say N.
 
+NatSemi SCx200 support
+CONFIG_SCx200
+  This provides basic support for the National Semiconductor SCx200
+  processor.  Right now this is just a driver for the GPIO pins.
+
+  If you don't know what to do here, say N.
+
+  This support is also available as a module.  If compiled as a
+  module, it will be called scx200.o.
+
+NatSemi SCx200 Watchdog
+CONFIG_SCx200_WDT
+  Enable the built-in watchdog timer support on the National 
+  Semiconductor SCx200 processors.
+
+  If compiled as a module, it will be called scx200_watchdog.o.
+
+Flash device mapped with DOCCS on NatSemi SCx200
+CONFIG_MTD_SCx200_DOCFLASH
+  Enable support for a flash chip mapped using the DOCCS signal on a
+  National Semiconductor SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_docflash.o.
+
+NatSemi SCx200 I2C using GPIO pins
+CONFIG_SCx200_GPIO
+  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_i2c.o.
+
+GPIO pin used for SCL
+CONFIG_SCx200_I2C_SCL
+  Enter the GPIO pin number used for the SCL signal.  This value can
+  also be specified with a module parameter.
+
+GPIO pin used for SDA
+CONFIG_SCx200_I2C_SDA
+  Enter the GPIO pin number used for the SSA signal.  This value can
+  also be specified with a module parameter.
+
+NatSemi SCx200 ACCESS.bus
+CONFIG_SCx200_ACB
+  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_acb.o.
+
+IPMI top-level message handler
+CONFIG_IPMI_HANDLER
+  This enables the central IPMI message handler, required for IPMI
+  to work.  Note that you must have this enabled to do any other IPMI
+  things.
+
+  IPMI is a standard for managing sensors (temperature,
+  voltage, etc.) in a system.
+
+  See Documentation/IPMI.txt for more details on the driver.
+
+  If unsure, say N.
+
+Generate a panic event to all BMCs on a panic
+CONFIG_IPMI_PANIC_EVENT
+  When a panic occurs, this will cause the IPMI message handler to
+  generate an IPMI event describing the panic to each interface
+  registered with the message handler.
+
+Device interface for IPMI
+CONFIG_IPMI_DEVICE_INTERFACE
+  This provides an IOCTL interface to the IPMI message handler so
+  userland processes may use IPMI.  It supports poll() and select().
+
+IPMI KCS handler
+CONFIG_IPMI_KCS
+  Provides a driver for a KCS-style interface to a BMC.
+
+IPMI Watchdog Timer
+CONFIG_IPMI_WATCHDOG
+  This enables the IPMI watchdog timer.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
