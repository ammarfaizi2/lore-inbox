Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbTCOU3V>; Sat, 15 Mar 2003 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbTCOU3V>; Sat, 15 Mar 2003 15:29:21 -0500
Received: from pasky.ji.cz ([62.44.12.54]:35577 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261535AbTCOU3U>;
	Sat, 15 Mar 2003 15:29:20 -0500
Date: Sat, 15 Mar 2003 21:40:09 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][kconfig][i386] Fix help entry for processor type choice
Message-ID: <20030315204009.GB31875@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.64) moves the generic help of the "Processor family"
choice from the CONFIG_M386 option, adding some specific information about i386
processors to it instead.

  Please consider applying.

 arch/i386/Kconfig |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

  Kind regards,
				Petr Baudis

--- linux+pasky/arch/i386/Kconfig	Thu Mar  6 20:38:49 2003
+++ linux/arch/i386/Kconfig	Sat Mar 15 21:34:16 2003
@@ -110,10 +110,7 @@
 choice
 	prompt "Processor family"
 	default M686
-
-config M386
-	bool "386"
-	---help---
+	help
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
 	  all x86 CPU types (albeit not optimally fast), you can specify
@@ -148,10 +145,20 @@
 
 	  If you don't know what to do, choose "386".
 
+config M386
+	bool "386"
+	help
+	  Select this for an x386 processor, that is AMD/Cyrix/Intel
+	  386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2, UMC 486SX-S and NexGen
+	  Nx586. Kernel compiled for this processor will also run on any newer
+	  processor of this architecture, although not optimally fast.
+
+	  If you don't know what processor to choose, choose this one.
+
 config M486
 	bool "486"
 	help
-	  Select this for a x486 processor, ether Intel or one of the
+	  Select this for an x486 processor, either Intel or one of the
 	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
 	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
 	  U5S.
