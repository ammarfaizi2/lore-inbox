Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJBKw0>; Wed, 2 Oct 2002 06:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbSJBKw0>; Wed, 2 Oct 2002 06:52:26 -0400
Received: from [212.3.242.3] ([212.3.242.3]:43255 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S263039AbSJBKwU>;
	Wed, 2 Oct 2002 06:52:20 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.50 - 8250_cs does NOT work
Date: Wed, 2 Oct 2002 12:57:42 +0200
User-Agent: KMail/1.4.1
Cc: Russell King <rmk@arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210021257.43121.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm trying to get my pcmcia modem to work, it's a 
 product info: "Psion Dacom", "Gold Card Global 56K+Fax", "56K+Fax", "V8.25"
  manfid: 0x016c, 0x0005
  function: 2 (serial)

If i load the 8250_cs module, I get _nothing_ at all. No text in system logs, 
nothing. Modem doesn't respond under the old /dev/ttyS1, I've tried all other 
/dev/ttySx's to see if it hasn't been remapped. Unfortunately, no.

Is there anything else I can try? I really need my modem back...

It seems that the Config.help entry is wrong aswell.

diff -Nru drivers/serial/Config.help.old drivers/serial/Config.help
--- drivers/serial/Config.help.old      Wed Oct  2 12:54:32 2002
+++ drivers/serial/Config.help  Wed Oct  2 12:54:55 2002
@@ -56,7 +56,7 @@
 
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
-  The module will be called serial_cs.o.  If you want to compile it as
+  The module will be called 8250_cs.o.  If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
   If unsure, say N.

DK

-- 
"There is hopeful symbolism in the fact that flags do not wave in a
vacuum."
		-- Arthur C. Clarke

