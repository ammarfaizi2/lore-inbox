Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVF2AmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVF2AmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVF2AlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:41:01 -0400
Received: from holomorphy.com ([66.93.40.71]:9127 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262325AbVF2AcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:32:08 -0400
Date: Tue, 28 Jun 2005 17:31:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sparc32] Kconfig fixups (was Re: 2.6.12-mm2)
Message-ID: <20050629003155.GS3334@holomorphy.com>
References: <20050626040329.3849cf68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/

Something reverted most of the arch/sparc/Kconfig changes, leaving
arch/sparc/ unconfigurable. This patch re-removes the parts made
redundant by drivers/Kconfig in addition to a mysterious, spurious
second instance of source "mm/Kconfig". cvs strikes again?

Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm2-2.6.12/arch/sparc/Kconfig
===================================================================
--- mm2-2.6.12.orig/arch/sparc/Kconfig	2005-06-28 17:06:54.655102470 -0700
+++ mm2-2.6.12/arch/sparc/Kconfig	2005-06-28 17:16:52.135271678 -0700
@@ -270,66 +270,10 @@
 
 source "drivers/Kconfig"
 
-config PRINTER
-	tristate "Parallel printer support"
-	depends on PARPORT
-	---help---
-	  If you intend to attach a printer to the parallel port of your Linux
-	  box (as opposed to using a serial printer; if the connector at the
-	  printer has 9 or 25 holes ["female"], then it's serial), say Y.
-	  Also read the Printing-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  It is possible to share one parallel port among several devices
-	  (e.g. printer and ZIP drive) and it is safe to compile the
-	  corresponding drivers into the kernel.  If you want to compile this
-	  driver as a module however, choose M here and read
-	  <file:Documentation/parport.txt>.  The module will be called lp.
-
-	  If you have several parallel ports, you can specify which ports to
-	  use with the "lp" kernel command line option.  (Try "man bootparam"
-	  or see the documentation of your boot loader (silo) about how to pass
-	  options to the kernel at boot time.)  The syntax of the "lp" command
-	  line option can be found in <file:drivers/char/lp.c>.
-
-	  If you have more than 8 printers, you need to increase the LP_NO
-	  macro in lp.c and the PARPORT_MAX macro in parport.h.
-
-source "mm/Kconfig"
-
-endmenu
-
-source "drivers/base/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/serial/Kconfig"
-
 if !SUN4
 source "drivers/sbus/char/Kconfig"
 endif
 
-source "drivers/block/Kconfig"
-
-# Don't frighten a common SBus user
-if PCI
-
-source "drivers/ide/Kconfig"
-
-endif
-
-source "drivers/isdn/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/fc4/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "net/Kconfig"
-
 # This one must be before the filesystem configs. -DaveM
 
 menu "Unix98 PTY support"
