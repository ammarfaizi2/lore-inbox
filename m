Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbTDWOpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTDWOpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:45:18 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:44172 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S264068AbTDWOow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:44:52 -0400
Subject: Re: How did the Spelling Police miss this one?
From: Steven Cole <elenstev@mesatop.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200304230936_MC3-1-35AA-864B@compuserve.com>
References: <200304230936_MC3-1-35AA-864B@compuserve.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051109635.29423.20.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 23 Apr 2003 08:53:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 07:33, Chuck Ebbert wrote:
> [me@qq linux-2.5.68-ref]$ grep -R cannonicalize * | wc -l
>      65
> 
> 
> 
>   Avast there ye swabs, prepare to fire a broadside!

Almost all of the spelling fixes from the Spelling Police were in
comments, not code.  This mistaken spelling of canonicalize is mostly in
various parts of the non-comment code. 

[steven@spc5 linux]$ grep -R cannonicalize * | wc -l
     64
[steven@spc5 linux]$ fix.canon
[steven@spc5 linux]$ grep -R cannonicalize * | wc -l
      0

The fix.canon script used was this:

#!/bin/sh
find . -name "*" | xargs grep -l cannonicalize | awk '{print "ex - ",$1," -c \"%s/cannonicalize/canonicalize/g|x\""}' | sh

Yes, I know that you can do that in fewer characters with perl.
But that script should have fixed canonicalize everywhere.  BTW, I did
it on a tree made with bk export -tplain ../linux.  The repository had
been recently updated with bk pull.

I prepared a patch in case anyone cares enough about this.  I tested on
i386 by building and booting.  It works for me.  

Steven

 arch/mips/au1000/common/serial.c     |    4 ++--
 arch/parisc/kernel/irq.c             |   12 ++++++------
 arch/ppc/platforms/4xx/oak_setup.c   |    2 +-
 arch/ppc/platforms/adir_setup.c      |    2 +-
 arch/ppc/platforms/chrp_setup.c      |    4 ++--
 arch/ppc/platforms/ev64260_setup.c   |    2 +-
 arch/ppc/platforms/gemini_setup.c    |    2 +-
 arch/ppc/platforms/lopec_setup.c     |    4 ++--
 arch/ppc/platforms/mcpn765_setup.c   |    4 ++--
 arch/ppc/platforms/pmac_setup.c      |    2 +-
 arch/ppc/platforms/pplus_setup.c     |    4 ++--
 arch/ppc/platforms/prep_setup.c      |    4 ++--
 arch/ppc/platforms/sandpoint_setup.c |    4 ++--
 arch/ppc/platforms/zx4500_setup.c    |    2 +-
 arch/ppc/syslib/m8260_setup.c        |    2 +-
 arch/ppc/syslib/m8xx_setup.c         |    2 +-
 drivers/char/synclink.c              |    2 +-
 drivers/net/ac3200.c                 |    2 +-
 drivers/serial/8250.c                |    2 +-
 drivers/serial/core.c                |    2 +-
 include/asm-alpha/irq.h              |    2 +-
 include/asm-arm/arch-arc/irqs.h      |    2 +-
 include/asm-arm/arch-ebsa285/irqs.h  |    2 +-
 include/asm-arm/arch-nexuspci/irqs.h |    2 +-
 include/asm-arm/arch-tbox/irqs.h     |    2 +-
 include/asm-arm/irq.h                |    4 ++--
 include/asm-h8300/irq.h              |    2 +-
 include/asm-i386/irq.h               |    2 +-
 include/asm-ia64/irq.h               |    4 ++--
 include/asm-m68k/irq.h               |    2 +-
 include/asm-mips/irq.h               |    4 ++--
 include/asm-mips64/irq.h             |    4 ++--
 include/asm-parisc/irq.h             |    2 +-
 include/asm-ppc/irq.h                |   12 ++++++------
 include/asm-ppc/machdep.h            |    2 +-
 include/asm-ppc64/irq.h              |    2 +-
 include/asm-sh/serial-bigsur.h       |    2 +-
 include/asm-sh/serial-ec3104.h       |    2 +-
 include/asm-sh/serial.h              |    2 +-
 include/asm-sparc/irq.h              |    2 +-
 include/asm-sparc64/irq.h            |    2 +-
 include/asm-v850/irq.h               |    2 +-
 include/asm-x86_64/irq.h             |    2 +-
 43 files changed, 64 insertions(+), 64 deletions(-)

diff -ur bk-current/arch/mips/au1000/common/serial.c linux/arch/mips/au1000/common/serial.c
--- bk-current/arch/mips/au1000/common/serial.c	Wed Apr 23 07:44:03 2003
+++ linux/arch/mips/au1000/common/serial.c	Wed Apr 23 07:49:34 2003
@@ -1451,7 +1451,7 @@
 		goto check_and_exit;
 	}
 
-	new_serial.irq = irq_cannonicalize(new_serial.irq);
+	new_serial.irq = irq_canonicalize(new_serial.irq);
 
 	if ((new_serial.irq >= NR_IRQS) || (new_serial.irq < 0) || 
 	    (new_serial.baud_base < 9600)|| (new_serial.type < PORT_UNKNOWN) ||
@@ -2662,7 +2662,7 @@
 		state->icount.rx = state->icount.tx = 0;
 		state->icount.frame = state->icount.parity = 0;
 		state->icount.overrun = state->icount.brk = 0;
-		state->irq = irq_cannonicalize(state->irq);
+		state->irq = irq_canonicalize(state->irq);
 		if (state->hub6)
 			state->io_type = SERIAL_IO_HUB6;
 		if (state->port && check_region(state->port,8)) {
diff -ur bk-current/arch/parisc/kernel/irq.c linux/arch/parisc/kernel/irq.c
--- bk-current/arch/parisc/kernel/irq.c	Wed Apr 23 07:44:17 2003
+++ linux/arch/parisc/kernel/irq.c	Wed Apr 23 07:49:34 2003
@@ -161,7 +161,7 @@
 
 	DBG_IRQ(irq, ("mask_irq(%d) %d+%d eiem 0x%lx\n", irq,
 				IRQ_REGION(irq), IRQ_OFFSET(irq), cpu_eiem));
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	region = irq_region[IRQ_REGION(irq)];
 	if (region->ops.mask_irq)
 		region->ops.mask_irq(region->data.dev, IRQ_OFFSET(irq));
@@ -173,7 +173,7 @@
 
 	DBG_IRQ(irq, ("unmask_irq(%d) %d+%d eiem 0x%lx\n", irq,
 				IRQ_REGION(irq), IRQ_OFFSET(irq), cpu_eiem));
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	region = irq_region[IRQ_REGION(irq)];
 	if (region->ops.unmask_irq)
 		region->ops.unmask_irq(region->data.dev, IRQ_OFFSET(irq));
@@ -185,7 +185,7 @@
 
 	DBG_IRQ(irq, ("disable_irq(%d) %d+%d eiem 0x%lx\n", irq,
 				IRQ_REGION(irq), IRQ_OFFSET(irq), cpu_eiem));
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	region = irq_region[IRQ_REGION(irq)];
 	if (region->ops.disable_irq)
 		region->ops.disable_irq(region->data.dev, IRQ_OFFSET(irq));
@@ -199,7 +199,7 @@
 
 	DBG_IRQ(irq, ("enable_irq(%d) %d+%d eiem 0x%lx\n", irq,
 				IRQ_REGION(irq), IRQ_OFFSET(irq), cpu_eiem));
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	region = irq_region[IRQ_REGION(irq)];
 
 	if (region->ops.enable_irq)
@@ -594,7 +594,7 @@
 	printk(KERN_INFO "request_irq(%d, %p, 0x%lx, %s, %p)\n",irq, handler, irqflags, devname, dev_id);
 #endif
 
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	/* request_irq()/free_irq() may not be called from interrupt context. */
 	if (in_interrupt())
 		BUG();
@@ -654,7 +654,7 @@
 	struct irqaction *action, **p;
 
 	/* See comments in request_irq() about interrupt context */
-	irq = irq_cannonicalize(irq);
+	irq = irq_canonicalize(irq);
 	
 	if (in_interrupt()) BUG();
 
diff -ur bk-current/arch/ppc/platforms/4xx/oak_setup.c linux/arch/ppc/platforms/4xx/oak_setup.c
--- bk-current/arch/ppc/platforms/4xx/oak_setup.c	Wed Apr 23 07:45:07 2003
+++ linux/arch/ppc/platforms/4xx/oak_setup.c	Wed Apr 23 07:49:34 2003
@@ -101,7 +101,7 @@
 
 	ppc_md.setup_arch	 	= oak_setup_arch;
 	ppc_md.show_percpuinfo	 	= oak_show_percpuinfo;
-	ppc_md.irq_cannonicalize 	= NULL;
+	ppc_md.irq_canonicalize 	= NULL;
 	ppc_md.init_IRQ		 	= oak_init_IRQ;
 	ppc_md.get_irq		 	= oak_get_irq;
 	ppc_md.init		 	= NULL;
diff -ur bk-current/arch/ppc/platforms/adir_setup.c linux/arch/ppc/platforms/adir_setup.c
--- bk-current/arch/ppc/platforms/adir_setup.c	Wed Apr 23 07:44:07 2003
+++ linux/arch/ppc/platforms/adir_setup.c	Wed Apr 23 07:49:34 2003
@@ -189,7 +189,7 @@
 
 	ppc_md.setup_arch = adir_setup_arch;
 	ppc_md.show_cpuinfo = adir_show_cpuinfo;
-	ppc_md.irq_cannonicalize = NULL;
+	ppc_md.irq_canonicalize = NULL;
 	ppc_md.init_IRQ = adir_init_IRQ;
 	ppc_md.get_irq = adir_get_irq;
 	ppc_md.init = NULL;
diff -ur bk-current/arch/ppc/platforms/chrp_setup.c linux/arch/ppc/platforms/chrp_setup.c
--- bk-current/arch/ppc/platforms/chrp_setup.c	Wed Apr 23 07:45:10 2003
+++ linux/arch/ppc/platforms/chrp_setup.c	Wed Apr 23 07:49:34 2003
@@ -306,7 +306,7 @@
 }
 
 u_int __chrp
-chrp_irq_cannonicalize(u_int irq)
+chrp_irq_canonicalize(u_int irq)
 {
 	if (irq == 2)
 		return 9;
@@ -456,7 +456,7 @@
 	ppc_md.setup_arch     = chrp_setup_arch;
 	ppc_md.show_percpuinfo = of_show_percpuinfo;
 	ppc_md.show_cpuinfo   = chrp_show_cpuinfo;
-	ppc_md.irq_cannonicalize = chrp_irq_cannonicalize;
+	ppc_md.irq_canonicalize = chrp_irq_canonicalize;
 	ppc_md.init_IRQ       = chrp_init_IRQ;
 	ppc_md.get_irq        = openpic_get_irq;
 
diff -ur bk-current/arch/ppc/platforms/ev64260_setup.c linux/arch/ppc/platforms/ev64260_setup.c
--- bk-current/arch/ppc/platforms/ev64260_setup.c	Wed Apr 23 07:43:57 2003
+++ linux/arch/ppc/platforms/ev64260_setup.c	Wed Apr 23 07:49:34 2003
@@ -437,7 +437,7 @@
 
 	ppc_md.setup_arch = ev64260_setup_arch;
 	ppc_md.show_cpuinfo = ev64260_show_cpuinfo;
-	ppc_md.irq_cannonicalize = NULL;
+	ppc_md.irq_canonicalize = NULL;
 	ppc_md.init_IRQ = ev64260_init_irq;
 	ppc_md.get_irq = gt64260_get_irq;
 	ppc_md.init = NULL;
diff -ur bk-current/arch/ppc/platforms/gemini_setup.c linux/arch/ppc/platforms/gemini_setup.c
--- bk-current/arch/ppc/platforms/gemini_setup.c	Wed Apr 23 07:44:31 2003
+++ linux/arch/ppc/platforms/gemini_setup.c	Wed Apr 23 07:49:34 2003
@@ -559,7 +559,7 @@
 
 	ppc_md.setup_arch = gemini_setup_arch;
 	ppc_md.show_cpuinfo = gemini_show_cpuinfo;
-	ppc_md.irq_cannonicalize = NULL;
+	ppc_md.irq_canonicalize = NULL;
 	ppc_md.init_IRQ = gemini_init_IRQ;
 	ppc_md.get_irq = openpic_get_irq;
 	ppc_md.init = NULL;
diff -ur bk-current/arch/ppc/platforms/lopec_setup.c linux/arch/ppc/platforms/lopec_setup.c
--- bk-current/arch/ppc/platforms/lopec_setup.c	Wed Apr 23 07:44:37 2003
+++ linux/arch/ppc/platforms/lopec_setup.c	Wed Apr 23 07:49:34 2003
@@ -67,7 +67,7 @@
 }
 
 static u32
-lopec_irq_cannonicalize(u32 irq)
+lopec_irq_canonicalize(u32 irq)
 {
 	if (irq == 2)
 		return 9;
@@ -360,7 +360,7 @@
 
 	ppc_md.setup_arch = lopec_setup_arch;
 	ppc_md.show_cpuinfo = lopec_show_cpuinfo;
-	ppc_md.irq_cannonicalize = lopec_irq_cannonicalize;
+	ppc_md.irq_canonicalize = lopec_irq_canonicalize;
 	ppc_md.init_IRQ = lopec_init_IRQ;
 	ppc_md.get_irq = openpic_get_irq;
 
diff -ur bk-current/arch/ppc/platforms/mcpn765_setup.c linux/arch/ppc/platforms/mcpn765_setup.c
--- bk-current/arch/ppc/platforms/mcpn765_setup.c	Wed Apr 23 07:44:56 2003
+++ linux/arch/ppc/platforms/mcpn765_setup.c	Wed Apr 23 07:49:34 2003
@@ -201,7 +201,7 @@
 }
 
 static u32
-mcpn765_irq_cannonicalize(u32 irq)
+mcpn765_irq_canonicalize(u32 irq)
 {
 	if (irq == 2)
 		return 9;
@@ -434,7 +434,7 @@
 
 	ppc_md.setup_arch = mcpn765_setup_arch;
 	ppc_md.show_cpuinfo = mcpn765_show_cpuinfo;
-	ppc_md.irq_cannonicalize = mcpn765_irq_cannonicalize;
+	ppc_md.irq_canonicalize = mcpn765_irq_canonicalize;
 	ppc_md.init_IRQ = mcpn765_init_IRQ;
 	ppc_md.get_irq = openpic_get_irq;
 	ppc_md.init = mcpn765_init2;
diff -ur bk-current/arch/ppc/platforms/pmac_setup.c linux/arch/ppc/platforms/pmac_setup.c
--- bk-current/arch/ppc/platforms/pmac_setup.c	Wed Apr 23 07:44:54 2003
+++ linux/arch/ppc/platforms/pmac_setup.c	Wed Apr 23 07:49:34 2003
@@ -619,7 +619,7 @@
 	ppc_md.setup_arch     = pmac_setup_arch;
 	ppc_md.show_cpuinfo   = pmac_show_cpuinfo;
 	ppc_md.show_percpuinfo = pmac_show_percpuinfo;
-	ppc_md.irq_cannonicalize = NULL;
+	ppc_md.irq_canonicalize = NULL;
 	ppc_md.init_IRQ       = pmac_pic_init;
 	ppc_md.get_irq        = pmac_get_irq; /* Changed later on ... */
 	
diff -ur bk-current/arch/ppc/platforms/pplus_setup.c linux/arch/ppc/platforms/pplus_setup.c
--- bk-current/arch/ppc/platforms/pplus_setup.c	Wed Apr 23 07:45:29 2003
+++ linux/arch/ppc/platforms/pplus_setup.c	Wed Apr 23 07:49:34 2003
@@ -206,7 +206,7 @@
 }
 
 static unsigned int
-pplus_irq_cannonicalize(u_int irq)
+pplus_irq_canonicalize(u_int irq)
 {
 	if (irq == 2)
 	{
@@ -469,7 +469,7 @@
 	ppc_md.setup_arch     = pplus_setup_arch;
 	ppc_md.show_percpuinfo = NULL;
 	ppc_md.show_cpuinfo    = pplus_show_cpuinfo;
-	ppc_md.irq_cannonicalize = pplus_irq_cannonicalize;
+	ppc_md.irq_canonicalize = pplus_irq_canonicalize;
 	ppc_md.init_IRQ       = pplus_init_IRQ;
 	/* this gets changed later on if we have an OpenPIC -- Cort */
 	ppc_md.get_irq        = i8259_irq;
diff -ur bk-current/arch/ppc/platforms/prep_setup.c linux/arch/ppc/platforms/prep_setup.c
--- bk-current/arch/ppc/platforms/prep_setup.c	Wed Apr 23 07:45:14 2003
+++ linux/arch/ppc/platforms/prep_setup.c	Wed Apr 23 07:49:34 2003
@@ -976,7 +976,7 @@
 }
 
 static unsigned int __prep
-prep_irq_cannonicalize(u_int irq)
+prep_irq_canonicalize(u_int irq)
 {
 	if (irq == 2)
 	{
@@ -1150,7 +1150,7 @@
 	ppc_md.setup_arch     = prep_setup_arch;
 	ppc_md.show_percpuinfo = prep_show_percpuinfo;
 	ppc_md.show_cpuinfo   = NULL; /* set in prep_setup_arch() */
-	ppc_md.irq_cannonicalize = prep_irq_cannonicalize;
+	ppc_md.irq_canonicalize = prep_irq_canonicalize;
 	ppc_md.init_IRQ       = prep_init_IRQ;
 	/* this gets changed later on if we have an OpenPIC -- Cort */
 	ppc_md.get_irq        = i8259_irq;
diff -ur bk-current/arch/ppc/platforms/sandpoint_setup.c linux/arch/ppc/platforms/sandpoint_setup.c
--- bk-current/arch/ppc/platforms/sandpoint_setup.c	Wed Apr 23 07:45:38 2003
+++ linux/arch/ppc/platforms/sandpoint_setup.c	Wed Apr 23 07:49:34 2003
@@ -349,7 +349,7 @@
 }
 
 static u32
-sandpoint_irq_cannonicalize(u32 irq)
+sandpoint_irq_canonicalize(u32 irq)
 {
 	if (irq == 2)
 	{
@@ -602,7 +602,7 @@
 
 	ppc_md.setup_arch = sandpoint_setup_arch;
 	ppc_md.show_cpuinfo = sandpoint_show_cpuinfo;
-	ppc_md.irq_cannonicalize = sandpoint_irq_cannonicalize;
+	ppc_md.irq_canonicalize = sandpoint_irq_canonicalize;
 	ppc_md.init_IRQ = sandpoint_init_IRQ;
 	ppc_md.get_irq = sandpoint_get_irq;
 	ppc_md.init = sandpoint_init2;
diff -ur bk-current/arch/ppc/platforms/zx4500_setup.c linux/arch/ppc/platforms/zx4500_setup.c
--- bk-current/arch/ppc/platforms/zx4500_setup.c	Wed Apr 23 07:43:31 2003
+++ linux/arch/ppc/platforms/zx4500_setup.c	Wed Apr 23 07:49:34 2003
@@ -331,7 +331,7 @@
 
 	ppc_md.setup_arch = zx4500_setup_arch;
 	ppc_md.show_cpuinfo = zx4500_show_cpuinfo;
-	ppc_md.irq_cannonicalize = NULL;
+	ppc_md.irq_canonicalize = NULL;
 	ppc_md.init_IRQ = zx4500_init_IRQ;
 	ppc_md.get_irq = openpic_get_irq;
 	ppc_md.init = NULL;
diff -ur bk-current/arch/ppc/syslib/m8260_setup.c linux/arch/ppc/syslib/m8260_setup.c
--- bk-current/arch/ppc/syslib/m8260_setup.c	Wed Apr 23 07:44:30 2003
+++ linux/arch/ppc/syslib/m8260_setup.c	Wed Apr 23 07:49:34 2003
@@ -243,7 +243,7 @@
 
 	ppc_md.setup_arch		= m8260_setup_arch;
 	ppc_md.show_percpuinfo		= m8260_show_percpuinfo;
-	ppc_md.irq_cannonicalize	= NULL;
+	ppc_md.irq_canonicalize	= NULL;
 	ppc_md.init_IRQ			= m8260_init_IRQ;
 	ppc_md.get_irq			= m8260_get_irq;
 	ppc_md.init			= NULL;
diff -ur bk-current/arch/ppc/syslib/m8xx_setup.c linux/arch/ppc/syslib/m8xx_setup.c
--- bk-current/arch/ppc/syslib/m8xx_setup.c	Wed Apr 23 07:44:20 2003
+++ linux/arch/ppc/syslib/m8xx_setup.c	Wed Apr 23 07:49:34 2003
@@ -377,7 +377,7 @@
 
 	ppc_md.setup_arch		= m8xx_setup_arch;
 	ppc_md.show_percpuinfo		= m8xx_show_percpuinfo;
-	ppc_md.irq_cannonicalize	= NULL;
+	ppc_md.irq_canonicalize	= NULL;
 	ppc_md.init_IRQ			= m8xx_init_IRQ;
 	ppc_md.get_irq			= m8xx_get_irq;
 	ppc_md.init			= NULL;
diff -ur bk-current/drivers/char/synclink.c linux/drivers/char/synclink.c
--- bk-current/drivers/char/synclink.c	Wed Apr 23 07:44:14 2003
+++ linux/drivers/char/synclink.c	Wed Apr 23 07:49:34 2003
@@ -4608,7 +4608,7 @@
 		/* Copy user configuration info to device instance data */
 		info->io_base = (unsigned int)io[i];
 		info->irq_level = (unsigned int)irq[i];
-		info->irq_level = irq_cannonicalize(info->irq_level);
+		info->irq_level = irq_canonicalize(info->irq_level);
 		info->dma_level = (unsigned int)dma[i];
 		info->bus_type = MGSL_BUS_TYPE_ISA;
 		info->io_addr_size = 16;
diff -ur bk-current/drivers/net/ac3200.c linux/drivers/net/ac3200.c
--- bk-current/drivers/net/ac3200.c	Wed Apr 23 07:44:54 2003
+++ linux/drivers/net/ac3200.c	Wed Apr 23 07:49:34 2003
@@ -167,7 +167,7 @@
 		dev->irq = config2irq(inb(ioaddr + AC_CONFIG));
 		printk(", using");
 	} else {
-		dev->irq = irq_cannonicalize(dev->irq);
+		dev->irq = irq_canonicalize(dev->irq);
 		printk(", assigning");
 	}
 
diff -ur bk-current/drivers/serial/8250.c linux/drivers/serial/8250.c
--- bk-current/drivers/serial/8250.c	Wed Apr 23 07:43:42 2003
+++ linux/drivers/serial/8250.c	Wed Apr 23 07:49:34 2003
@@ -1830,7 +1830,7 @@
 	for (i = 0, up = serial8250_ports; i < ARRAY_SIZE(old_serial_port);
 	     i++, up++) {
 		up->port.iobase   = old_serial_port[i].port;
-		up->port.irq      = irq_cannonicalize(old_serial_port[i].irq);
+		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
 		up->port.uartclk  = old_serial_port[i].baud_base * 16;
 		up->port.flags    = old_serial_port[i].flags |
 				    UPF_RESOURCES;
diff -ur bk-current/drivers/serial/core.c linux/drivers/serial/core.c
--- bk-current/drivers/serial/core.c	Wed Apr 23 07:43:54 2003
+++ linux/drivers/serial/core.c	Wed Apr 23 07:49:34 2003
@@ -683,7 +683,7 @@
 	if (HIGH_BITS_OFFSET)
 		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
 
-	new_serial.irq = irq_cannonicalize(new_serial.irq);
+	new_serial.irq = irq_canonicalize(new_serial.irq);
 
 	/*
 	 * This semaphore protects state->count.  It is also
diff -ur bk-current/include/asm-alpha/irq.h linux/include/asm-alpha/irq.h
--- bk-current/include/asm-alpha/irq.h	Wed Apr 23 07:45:36 2003
+++ linux/include/asm-alpha/irq.h	Wed Apr 23 07:49:34 2003
@@ -64,7 +64,7 @@
 # define NR_IRQS	16
 #endif
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	/*
 	 * XXX is this true for all Alpha's?  The old serial driver
diff -ur bk-current/include/asm-arm/arch-arc/irqs.h linux/include/asm-arm/arch-arc/irqs.h
--- bk-current/include/asm-arm/arch-arc/irqs.h	Wed Apr 23 07:44:29 2003
+++ linux/include/asm-arm/arch-arc/irqs.h	Wed Apr 23 07:49:34 2003
@@ -57,4 +57,4 @@
  */
 #define FIQ_START		64
 
-#define irq_cannonicalize(i)	(i)
+#define irq_canonicalize(i)	(i)
diff -ur bk-current/include/asm-arm/arch-ebsa285/irqs.h linux/include/asm-arm/arch-ebsa285/irqs.h
--- bk-current/include/asm-arm/arch-ebsa285/irqs.h	Wed Apr 23 07:43:58 2003
+++ linux/include/asm-arm/arch-ebsa285/irqs.h	Wed Apr 23 07:49:34 2003
@@ -95,4 +95,4 @@
 #define AUX_IRQ		(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
 #define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
 
-#define irq_cannonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
+#define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
diff -ur bk-current/include/asm-arm/arch-nexuspci/irqs.h linux/include/asm-arm/arch-nexuspci/irqs.h
--- bk-current/include/asm-arm/arch-nexuspci/irqs.h	Wed Apr 23 07:44:02 2003
+++ linux/include/asm-arm/arch-nexuspci/irqs.h	Wed Apr 23 07:49:34 2003
@@ -31,4 +31,4 @@
 /* timer is part of the DUART */
 #define IRQ_TIMER		IRQ_DUART
 
-#define irq_cannonicalize(i)	(i)
+#define irq_canonicalize(i)	(i)
diff -ur bk-current/include/asm-arm/arch-tbox/irqs.h linux/include/asm-arm/arch-tbox/irqs.h
--- bk-current/include/asm-arm/arch-tbox/irqs.h	Wed Apr 23 07:45:34 2003
+++ linux/include/asm-arm/arch-tbox/irqs.h	Wed Apr 23 07:49:34 2003
@@ -26,4 +26,4 @@
 #define IRQ_EXPMODCS0		12
 #define IRQ_EXPMODCS1		13
 
-#define irq_cannonicalize(i)	(i)
+#define irq_canonicalize(i)	(i)
diff -ur bk-current/include/asm-arm/irq.h linux/include/asm-arm/irq.h
--- bk-current/include/asm-arm/irq.h	Wed Apr 23 07:45:41 2003
+++ linux/include/asm-arm/irq.h	Wed Apr 23 07:49:34 2003
@@ -3,8 +3,8 @@
 
 #include <asm/arch/irqs.h>
 
-#ifndef irq_cannonicalize
-#define irq_cannonicalize(i)	(i)
+#ifndef irq_canonicalize
+#define irq_canonicalize(i)	(i)
 #endif
 
 #ifndef NR_IRQS
diff -ur bk-current/include/asm-h8300/irq.h linux/include/asm-h8300/irq.h
--- bk-current/include/asm-h8300/irq.h	Wed Apr 23 07:43:50 2003
+++ linux/include/asm-h8300/irq.h	Wed Apr 23 07:49:34 2003
@@ -13,7 +13,7 @@
 
 #define IRQ_SCHED_TIMER	(40)    /* interrupt source for scheduling timer */
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
 }
diff -ur bk-current/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- bk-current/include/asm-i386/irq.h	Wed Apr 23 07:44:54 2003
+++ linux/include/asm-i386/irq.h	Wed Apr 23 07:49:34 2003
@@ -15,7 +15,7 @@
 /* include comes from machine specific directory */
 #include "irq_vectors.h"
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
 }
diff -ur bk-current/include/asm-ia64/irq.h linux/include/asm-ia64/irq.h
--- bk-current/include/asm-ia64/irq.h	Wed Apr 23 07:45:34 2003
+++ linux/include/asm-ia64/irq.h	Wed Apr 23 07:49:34 2003
@@ -6,7 +6,7 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *	Stephane Eranian <eranian@hpl.hp.com>
  *
- * 11/24/98	S.Eranian 	updated TIMER_IRQ and irq_cannonicalize
+ * 11/24/98	S.Eranian 	updated TIMER_IRQ and irq_canonicalize
  * 01/20/99	S.Eranian	added keyboard interrupt
  * 02/29/00     D.Mosberger	moved most things into hw_irq.h
  */
@@ -14,7 +14,7 @@
 #define NR_IRQS		256
 
 static __inline__ int
-irq_cannonicalize (int irq)
+irq_canonicalize (int irq)
 {
 	/*
 	 * We do the legacy thing here of pretending that irqs < 16
diff -ur bk-current/include/asm-m68k/irq.h linux/include/asm-m68k/irq.h
--- bk-current/include/asm-m68k/irq.h	Wed Apr 23 07:44:57 2003
+++ linux/include/asm-m68k/irq.h	Wed Apr 23 07:49:34 2003
@@ -45,7 +45,7 @@
 
 #define IRQ_SCHED_TIMER	(8)    /* interrupt source for scheduling timer */
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
 }
diff -ur bk-current/include/asm-mips/irq.h linux/include/asm-mips/irq.h
--- bk-current/include/asm-mips/irq.h	Wed Apr 23 07:43:47 2003
+++ linux/include/asm-mips/irq.h	Wed Apr 23 07:49:34 2003
@@ -16,12 +16,12 @@
 #define TIMER_IRQ 0
 
 #ifdef CONFIG_I8259
-static inline int irq_cannonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
 }
 #else
-#define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
+#define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
 struct irqaction;
diff -ur bk-current/include/asm-mips64/irq.h linux/include/asm-mips64/irq.h
--- bk-current/include/asm-mips64/irq.h	Wed Apr 23 07:44:13 2003
+++ linux/include/asm-mips64/irq.h	Wed Apr 23 07:49:34 2003
@@ -34,12 +34,12 @@
 			(node_level_to_irq[CPUID_TO_COMPACT_NODEID(c)][(l)])
 
 #ifdef CONFIG_I8259
-static inline int irq_cannonicalize(int irq)
+static inline int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
 }
 #else
-#define irq_cannonicalize(irq) (irq)	/* Sane hardware, sane code ... */
+#define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
 
diff -ur bk-current/include/asm-parisc/irq.h linux/include/asm-parisc/irq.h
--- bk-current/include/asm-parisc/irq.h	Wed Apr 23 07:44:13 2003
+++ linux/include/asm-parisc/irq.h	Wed Apr 23 07:49:34 2003
@@ -66,7 +66,7 @@
 
 extern struct irq_region *irq_region[NR_IRQ_REGS];
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 #ifdef CONFIG_EISA
 	return (irq == (IRQ_FROM_REGION(EISA_IRQ_REGION)+2) 
diff -ur bk-current/include/asm-ppc/irq.h linux/include/asm-ppc/irq.h
--- bk-current/include/asm-ppc/irq.h	Wed Apr 23 07:43:46 2003
+++ linux/include/asm-ppc/irq.h	Wed Apr 23 07:49:34 2003
@@ -66,7 +66,7 @@
 #define NR_IRQS		((NR_UIC_IRQS * NR_UICS) + NR_BOARD_IRQS)
 #endif
 static __inline__ int
-irq_cannonicalize(int irq)
+irq_canonicalize(int irq)
 {
 	return (irq);
 }
@@ -78,7 +78,7 @@
 #define	NR_IRQS		(NR_UIC_IRQS + NR_BOARD_IRQS)
 
 static __inline__ int
-irq_cannonicalize(int irq)
+irq_canonicalize(int irq)
 {
 	return (irq);
 }
@@ -148,7 +148,7 @@
 #define	mk_int_int_mask(IL) (1 << (7 - (IL/2)))
 
 /* always the same on 8xx -- Cort */
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
 }
@@ -196,10 +196,10 @@
  * powermacs as well as prep/chrp boxes.
  * Prep and chrp both have cascaded 8259 PICs.
  */
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
-	if (ppc_md.irq_cannonicalize)
-		return ppc_md.irq_cannonicalize(irq);
+	if (ppc_md.irq_canonicalize)
+		return ppc_md.irq_canonicalize(irq);
 	return irq;
 }
 
diff -ur bk-current/include/asm-ppc/machdep.h linux/include/asm-ppc/machdep.h
--- bk-current/include/asm-ppc/machdep.h	Wed Apr 23 07:44:01 2003
+++ linux/include/asm-ppc/machdep.h	Wed Apr 23 07:49:34 2003
@@ -25,7 +25,7 @@
 	int		(*show_cpuinfo)(struct seq_file *m);
 	int		(*show_percpuinfo)(struct seq_file *m, int i);
 	/* Optional, may be NULL. */
-	unsigned int	(*irq_cannonicalize)(unsigned int irq);
+	unsigned int	(*irq_canonicalize)(unsigned int irq);
 	void		(*init_IRQ)(void);
 	int		(*get_irq)(struct pt_regs *);
 	
diff -ur bk-current/include/asm-ppc64/irq.h linux/include/asm-ppc64/irq.h
--- bk-current/include/asm-ppc64/irq.h	Wed Apr 23 07:45:38 2003
+++ linux/include/asm-ppc64/irq.h	Wed Apr 23 07:49:34 2003
@@ -46,7 +46,7 @@
  * powermacs as well as prep/chrp boxes.
  * Prep and chrp both have cascaded 8259 PICs.
  */
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
 }
diff -ur bk-current/include/asm-sh/serial-bigsur.h linux/include/asm-sh/serial-bigsur.h
--- bk-current/include/asm-sh/serial-bigsur.h	Wed Apr 23 07:44:57 2003
+++ linux/include/asm-sh/serial-bigsur.h	Wed Apr 23 07:49:34 2003
@@ -25,6 +25,6 @@
 #define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
 
 /* XXX: This should be moved ino irq.h */
-#define irq_cannonicalize(x) (x)
+#define irq_canonicalize(x) (x)
 
 #endif /* _ASM_SERIAL_BIGSUR_H */
diff -ur bk-current/include/asm-sh/serial-ec3104.h linux/include/asm-sh/serial-ec3104.h
--- bk-current/include/asm-sh/serial-ec3104.h	Wed Apr 23 07:44:28 2003
+++ linux/include/asm-sh/serial-ec3104.h	Wed Apr 23 07:49:34 2003
@@ -21,4 +21,4 @@
 #define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
 
 /* XXX: This should be moved ino irq.h */
-#define irq_cannonicalize(x) (x)
+#define irq_canonicalize(x) (x)
diff -ur bk-current/include/asm-sh/serial.h linux/include/asm-sh/serial.h
--- bk-current/include/asm-sh/serial.h	Wed Apr 23 07:44:40 2003
+++ linux/include/asm-sh/serial.h	Wed Apr 23 07:49:34 2003
@@ -49,7 +49,7 @@
 #define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
 
 /* XXX: This should be moved ino irq.h */
-#define irq_cannonicalize(x) (x)
+#define irq_canonicalize(x) (x)
 
 #endif
 #endif /* _ASM_SERIAL_H */
diff -ur bk-current/include/asm-sparc/irq.h linux/include/asm-sparc/irq.h
--- bk-current/include/asm-sparc/irq.h	Wed Apr 23 07:44:35 2003
+++ linux/include/asm-sparc/irq.h	Wed Apr 23 07:49:34 2003
@@ -22,7 +22,7 @@
 
 #define NR_IRQS    16
 
-#define irq_cannonicalize(irq)	(irq)
+#define irq_canonicalize(irq)	(irq)
 
 /* Dave Redman (djhr@tadpole.co.uk)
  * changed these to function pointers.. it saves cycles and will allow
diff -ur bk-current/include/asm-sparc64/irq.h linux/include/asm-sparc64/irq.h
--- bk-current/include/asm-sparc64/irq.h	Wed Apr 23 07:44:34 2003
+++ linux/include/asm-sparc64/irq.h	Wed Apr 23 07:49:34 2003
@@ -114,7 +114,7 @@
 
 #define NR_IRQS    16
 
-#define irq_cannonicalize(irq)	(irq)
+#define irq_canonicalize(irq)	(irq)
 extern void disable_irq(unsigned int);
 #define disable_irq_nosync disable_irq
 extern void enable_irq(unsigned int);
diff -ur bk-current/include/asm-v850/irq.h linux/include/asm-v850/irq.h
--- bk-current/include/asm-v850/irq.h	Wed Apr 23 07:45:26 2003
+++ linux/include/asm-v850/irq.h	Wed Apr 23 07:49:34 2003
@@ -37,7 +37,7 @@
 struct hw_interrupt_type;
 struct irqaction;
 
-#define irq_cannonicalize(irq)	(irq)
+#define irq_canonicalize(irq)	(irq)
 
 /* Initialize irq handling for IRQs.
    BASE_IRQ, BASE_IRQ+INTERVAL, ..., BASE_IRQ+NUM*INTERVAL
diff -ur bk-current/include/asm-x86_64/irq.h linux/include/asm-x86_64/irq.h
--- bk-current/include/asm-x86_64/irq.h	Wed Apr 23 07:43:30 2003
+++ linux/include/asm-x86_64/irq.h	Wed Apr 23 07:49:34 2003
@@ -23,7 +23,7 @@
  */
 #define NR_IRQS 224
 
-static __inline__ int irq_cannonicalize(int irq)
+static __inline__ int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
 }





