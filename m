Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUGPUvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUGPUvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUGPUvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:51:32 -0400
Received: from havoc.gtf.org ([216.162.42.101]:29404 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266595AbUGPUv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:51:28 -0400
Date: Fri, 16 Jul 2004 16:51:25 -0400
From: David Eger <eger@havoc.gtf.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] restore ppc defconfig's
Message-ID: <20040716205125.GA18186@havoc.gtf.org>
References: <200407141709.i6EH9EYW029131@hera.kernel.org> <1089833270.11816.55.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089833270.11816.55.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard said in a fit of pique:
> Hi, could we not disable AT keyboards (used by CHRP and PReP machines)
> and PowerMac serial ports (used by PowerMacs) in the defconfig please?

Apologies.  The AT Keyboard driver does behave well, I'm just really
used to just having ADB.  Also, the zilog isn't oopsing now, hooray.

-dte

diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
--- a/arch/ppc/defconfig	2004-07-16 16:49:53 -04:00
+++ b/arch/ppc/defconfig	2004-07-16 16:49:53 -04:00
@@ -689,7 +689,7 @@
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
@@ -724,8 +724,8 @@
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_CORE is not set
-# CONFIG_SERIAL_PMACZILOG is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_PMACZILOG=y
 # CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
