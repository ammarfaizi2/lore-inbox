Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSKCW0P>; Sun, 3 Nov 2002 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSKCW0P>; Sun, 3 Nov 2002 17:26:15 -0500
Received: from pasky.ji.cz ([62.44.12.54]:27896 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S263977AbSKCW0N>;
	Sun, 3 Nov 2002 17:26:13 -0500
Date: Sun, 3 Nov 2002 23:32:45 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Sane defaults for the input layer configuration
Message-ID: <20021103223245.GD20338@pasky.ji.cz>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>,
	linux-kernel@vger.kernel.org
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz> <20021103193734.GC2516@pasky.ji.cz> <20021103211308.B8636@ucw.cz> <20021103222054.GC20338@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103222054.GC20338@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.45) introduces sane defaults for the input layer
configuration. The most common options default to yes now, so that with simply
accepting defaults provided by make oldconfig, the 2.4 configuration can be
converted to 2.5 configuration while preserving the basic keyboard, mouse and
serial port support. This should prevent most users confusion when configuring
their first 2.5 kernel. Please apply.

 drivers/input/Kconfig          |    2 ++
 drivers/input/keyboard/Kconfig |    2 ++
 drivers/input/mouse/Kconfig    |    2 ++
 drivers/input/serio/Kconfig    |    3 +++
 4 files changed, 9 insertions(+)

  Kind regards,
				Petr Baudis

diff -ru linux/drivers/input/Kconfig linux+pasky/drivers/input/Kconfig
--- linux/drivers/input/Kconfig	Fri Nov  1 22:21:33 2002
+++ linux+pasky/drivers/input/Kconfig	Sun Nov  3 23:21:35 2002
@@ -28,6 +28,7 @@
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface"
+	default y
 	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
@@ -45,6 +46,7 @@
 
 config INPUT_MOUSEDEV_PSAUX
 	bool "Provide legacy /dev/psaux device"
+	default y
 	depends on INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_SCREEN_X
diff -ru linux/drivers/input/keyboard/Kconfig linux+pasky/drivers/input/keyboard/Kconfig
--- linux/drivers/input/keyboard/Kconfig	Fri Nov  1 22:21:34 2002
+++ linux+pasky/drivers/input/keyboard/Kconfig	Sun Nov  3 23:24:40 2002
@@ -3,6 +3,7 @@
 #
 config INPUT_KEYBOARD
 	bool "Keyboards"
+	default y
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported keyboards will be displayed.
@@ -12,6 +13,7 @@
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard support"
+	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	---help---
 	  Say Y here if you want to use the standard AT keyboard. Usually
diff -ru linux/drivers/input/mouse/Kconfig linux+pasky/drivers/input/mouse/Kconfig
--- linux/drivers/input/mouse/Kconfig	Fri Nov  1 22:21:34 2002
+++ linux+pasky/drivers/input/mouse/Kconfig	Sun Nov  3 23:22:27 2002
@@ -3,6 +3,7 @@
 #
 config INPUT_MOUSE
 	bool "Mice"
+	default y
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported mice will be displayed.
@@ -12,6 +13,7 @@
 
 config MOUSE_PS2
 	tristate "PS/2 mouse"
+	default y
 	depends on INPUT && INPUT_MOUSE && SERIO
 	---help---
 	  Say Y here if you have a PS/2 mouse connected to your system. This
diff -ru linux/drivers/input/serio/Kconfig linux+pasky/drivers/input/serio/Kconfig
--- linux/drivers/input/serio/Kconfig	Fri Nov  1 22:21:34 2002
+++ linux+pasky/drivers/input/serio/Kconfig	Sun Nov  3 23:22:58 2002
@@ -3,6 +3,7 @@
 #
 config SERIO
 	tristate "Serial i/o support"
+	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
 	  communicate with the system. This includes the 
@@ -19,6 +20,7 @@
 
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller"
+	default y
 	depends on SERIO
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
@@ -34,6 +36,7 @@
 
 config SERIO_SERPORT
 	tristate "Serial port line discipline"
+	default y
 	depends on SERIO
 	---help---
 	  Say Y here if you plan to use an input device (mouse, joystick,
