Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271813AbTHDPKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTHDPKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:10:07 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:20229 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S271813AbTHDPKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:10:02 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2-mm[34] 8042 config broken
Date: Mon, 4 Aug 2003 23:09:48 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308042308.11878.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think anyone has reported on whether 2.6.0-test2-mm2 fixes any
> PS/2 or synaptics problems.  You are all very bad.

2.6.x-mm1 and -mm2 did not break the keyboard and trackpoint for me ;)

I was so happy that 8042 could be removed and reinserted after S3 
restoring the mouse.

However -mm3 and -mm4 can't config 8042 anymore.

===== serio/Kconfig 1.8 vs edited =====
--- 1.8/drivers/input/serio/Kconfig     Mon Jun  9 20:01:42 2003
+++ edited/serio/Kconfig        Mon Aug  4 19:44:35 2003
@@ -19,7 +19,7 @@
          as a module, say M here and read <file:Documentation/modules.txt>.

 config SERIO_I8042
-       tristate "i8042 PC Keyboard controller"
+       tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
        default y
        depends on SERIO
        ---help---

Regards 
Michael

-- 
Powered by linux-2.6-test2-mm4. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

