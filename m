Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULMUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULMUCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbULMUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:00:57 -0500
Received: from mail.dif.dk ([193.138.115.101]:59033 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261635AbULMTyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:54:52 -0500
Date: Mon, 13 Dec 2004 21:05:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matan Peled <chaosite@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Danny Beaudoin <beaudoin_danny@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Typo in kernel configuration (xconfig)
In-Reply-To: <41BDDB02.5020606@gmail.com>
Message-ID: <Pine.LNX.4.61.0412132059290.3382@dragon.hygekrogen.localhost>
References: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
 <Pine.LNX.4.61.0412130925510.2394@yvahk01.tjqt.qr> <41BDDB02.5020606@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Matan Peled wrote:

> Jan Engelhardt wrote:
> 
> > > Hi!
> > > If I'm not at the right place, please forward this to the right person.
> > > 
> > > In Device Drivers/Graphics Support/Support for frame buffer devices:
> > > "On several non-X86 architectures, the frame buffer device is the
> > > only way to use the graphics hardware."
> > > 
> > > This should be 'x86' instead, as in the rest of the description.
> > >    
> > 
> > What kind of typo is that?
> > 
> > 
> A nit picking one :)
> 

Well, in case anyone actually cares, here's a patch (at the end of the 
mail) to fix the nit. "x86" does seem to be in the majority compared to 
"X86" in the Kconfig help texts, I guess we might as well make it 
consistent..

> Besides, linux is case-sensitive, isn't it?
> 
Filesystems, yes. C source, yes. help text for kernel options, no.



Desc: [Documentation] Make Kconfig help texts use the term "x86" consistently.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -ur linux-2.6.10-rc3-bk7-orig/arch/ia64/Kconfig linux-2.6.10-rc3-bk7/arch/ia64/Kconfig
--- linux-2.6.10-rc3-bk7-orig/arch/ia64/Kconfig	2004-10-18 23:55:27.000000000 +0200
+++ linux-2.6.10-rc3-bk7/arch/ia64/Kconfig	2004-12-13 20:53:05.000000000 +0100
@@ -14,7 +14,7 @@
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
-	  the 32-bit X86 line.  The IA-64 Linux project has a home
+	  the 32-bit x86 line.  The IA-64 Linux project has a home
 	  page at <http://www.linuxia64.org/> and a mailing list at
 	  <linux-ia64@vger.kernel.org>.
 
@@ -269,7 +269,7 @@
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help
-	  IA-64 processors can execute IA-32 (X86) instructions.  By
+	  IA-64 processors can execute IA-32 (x86) instructions.  By
 	  saying Y here, the kernel will include IA-32 system call
 	  emulation support which makes it possible to transparently
 	  run IA-32 Linux binaries on an IA-64 Linux system.
diff -ur linux-2.6.10-rc3-bk7-orig/arch/mips/Kconfig linux-2.6.10-rc3-bk7/arch/mips/Kconfig
--- linux-2.6.10-rc3-bk7-orig/arch/mips/Kconfig	2004-12-06 22:24:17.000000000 +0100
+++ linux-2.6.10-rc3-bk7/arch/mips/Kconfig	2004-12-13 20:53:25.000000000 +0100
@@ -1040,7 +1040,7 @@
 	  architectures supported by Linux and make the implementation of
 	  application programs easier and more portable; at this point, an X
 	  server exists which uses the frame buffer device exclusively.
-	  On several non-X86 architectures, the frame buffer device is the
+	  On several non-x86 architectures, the frame buffer device is the
 	  only way to use the graphics hardware.
 
 	  The device is accessed through special device nodes, usually located
diff -ur linux-2.6.10-rc3-bk7-orig/drivers/video/Kconfig linux-2.6.10-rc3-bk7/drivers/video/Kconfig
--- linux-2.6.10-rc3-bk7-orig/drivers/video/Kconfig	2004-12-06 22:24:43.000000000 +0100
+++ linux-2.6.10-rc3-bk7/drivers/video/Kconfig	2004-12-13 20:51:11.000000000 +0100
@@ -17,7 +17,7 @@
 	  architectures supported by Linux and make the implementation of
 	  application programs easier and more portable; at this point, an X
 	  server exists which uses the frame buffer device exclusively.
-	  On several non-X86 architectures, the frame buffer device is the
+	  On several non-x86 architectures, the frame buffer device is the
 	  only way to use the graphics hardware.
 
 	  The device is accessed through special device nodes, usually located



