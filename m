Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSGYN2s>; Thu, 25 Jul 2002 09:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGYN2r>; Thu, 25 Jul 2002 09:28:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1277 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314381AbSGYN2m>; Thu, 25 Jul 2002 09:28:42 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251445.g6PEjs17010417@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) Q40 keyboard
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:45:54 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Q40 keyboard is only found on a Q40..

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/input/serio/Config.in linux-2.5.28-ac1/drivers/input/serio/Config.in
--- linux-2.5.28/drivers/input/serio/Config.in	Thu Jul 25 10:49:21 2002
+++ linux-2.5.28-ac1/drivers/input/serio/Config.in	Sun Jul 21 15:38:48 2002
@@ -12,7 +12,9 @@
 fi
 dep_tristate '  Serial port line discipline' CONFIG_SERIO_SERPORT $CONFIG_SERIO 
 dep_tristate '  ct82c710 Aux port controller' CONFIG_SERIO_CT82C710 $CONFIG_SERIO
-dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
+if [ "$CONFIG_Q40" = "y" ]; then
+   dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
+fi
 dep_tristate '  Parallel port keyboard adapter' CONFIG_SERIO_PARKBD $CONFIG_SERIO $CONFIG_PARPORT
 
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
