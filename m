Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSBMRUw>; Wed, 13 Feb 2002 12:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSBMRUl>; Wed, 13 Feb 2002 12:20:41 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:29374 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S287882AbSBMRU1>; Wed, 13 Feb 2002 12:20:27 -0500
Message-Id: <200202131632.JAA02806@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dag Brattli <dag@brattli.net>
Subject: [PATCH] Add help texts to drivers/net/irda/Config.help
Date: Wed, 13 Feb 2002 10:19:11 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/net/irda/Config.in, there are two options which currently do
not have help texts in drivers/net/irda/Config.help.  Here are snippets
from the Config.in for these options:

if [ "$CONFIG_ARCH_EP7211" = "y" ]; then
    dep_tristate '  EP7211 I/R support' CONFIG_EP7211_IR $CONFIG_IRDA
fi

if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
   dep_tristate 'SA1100 Internal IR' CONFIG_SA1100_FIR $CONFIG_IRDA
fi

Here is a patch to drivers/net/irda/Config.help to add these help texts.

Steven

--- linux-2.5.4/drivers/net/irda/Config.help.orig       Wed Feb 13 09:29:49 2002
+++ linux-2.5.4/drivers/net/irda/Config.help    Wed Feb 13 09:38:40 2002
@@ -88,6 +88,18 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>. The module will be called vlsi_ir.o.

+CONFIG_EP7211_IR
+  Say Y here if you wish to use the infrared port on the EP7211. Note
+  that you can't use the first UART and the infrared port at the same
+  time, and that the EP7211 only supports SIR mode, at speeds up to
+  115.2 kbps. To use the I/R port, you will need to get the source to
+  irda-utils and apply the patch at
+  <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2001-June/003510.html>.
+
+CONFIG_SA1100_FIR
+  Say Y here to enable the on-board IRDA device on a Intel(R)
+  StrongARM(R) SA-1110 based microporocessor.
+
 CONFIG_DONGLE
   Say Y here if you have an infrared device that connects to your
   computer's serial port. These devices are called dongles. Then say Y
