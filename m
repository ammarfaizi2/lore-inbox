Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWAZL4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWAZL4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWAZL4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:56:12 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:33887 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbWAZL4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:56:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uYghzFQ1cbp0+k4cZlQ1aUnoyeNQN+8lNxyAfAkBPVeKj+caprEIe7wJd2wiKdY5FgICbSEW2gFYt7IV56KRadxdsEPId6bYTapxjBlFLlVTgHNhm8I2c7EU8uUT6zBINHw4qXyO1C40V5nw3rDNYF+zSsO77XDts979WDITyvY=
Date: Thu, 26 Jan 2006 15:13:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Domen Puncer <domen@coderock.org>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove CONFIG_PARPORT_ARC, drivers/parport/parport_arc.c
Message-ID: <20060126121354.GB9288@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

It's wasn't referenced in Makefile since at least 2.2.8, unbuildable
due to trivial typos and things like DATA_LATCH and arc_write_control()
which doesn't exist.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm/configs/badge4_defconfig     |    1
 arch/arm/configs/bast_defconfig       |    1
 arch/arm/configs/clps7500_defconfig   |    1
 arch/arm/configs/ebsa110_defconfig    |    1
 arch/arm/configs/footbridge_defconfig |    1
 arch/arm/configs/netwinder_defconfig  |    1
 arch/arm/configs/rpc_defconfig        |    1
 arch/arm/configs/s3c2410_defconfig    |    1
 arch/arm/configs/shark_defconfig      |    1
 drivers/parport/Kconfig               |    5 -
 drivers/parport/parport_arc.c         |  139 ----------------------------------
 11 files changed, 153 deletions(-)

--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -287,7 +287,6 @@ CONFIG_MTD_SA1100=y
 CONFIG_PARPORT=m
 # CONFIG_PARPORT_PC is not set
 CONFIG_PARPORT_NOT_PC=y
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 # CONFIG_PARPORT_1284 is not set
 
--- a/arch/arm/configs/bast_defconfig
+++ b/arch/arm/configs/bast_defconfig
@@ -283,7 +283,6 @@ CONFIG_MTD_NAND_S3C2410=y
 #
 CONFIG_PARPORT=y
 # CONFIG_PARPORT_PC is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 CONFIG_PARPORT_1284=y
 
--- a/arch/arm/configs/clps7500_defconfig
+++ b/arch/arm/configs/clps7500_defconfig
@@ -217,7 +217,6 @@ CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 CONFIG_PARPORT_1284=y
 
--- a/arch/arm/configs/ebsa110_defconfig
+++ b/arch/arm/configs/ebsa110_defconfig
@@ -174,7 +174,6 @@ CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
 # CONFIG_PARPORT_PC_SUPERIO is not set
 # CONFIG_PARPORT_PC_PCMCIA is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 CONFIG_PARPORT_1284=y
 
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -186,7 +186,6 @@ CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 CONFIG_PARPORT_1284=y
 
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -182,7 +182,6 @@ CONFIG_PARPORT_PC=y
 # CONFIG_PARPORT_SERIAL is not set
 # CONFIG_PARPORT_PC_FIFO is not set
 CONFIG_PARPORT_PC_SUPERIO=y
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 # CONFIG_PARPORT_1284 is not set
 
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -181,7 +181,6 @@ CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_CML1=y
 CONFIG_PARPORT_PC_FIFO=y
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_OTHER is not set
 # CONFIG_PARPORT_1284 is not set
 
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -401,7 +401,6 @@ CONFIG_MTD_NAND_S3C2410=y
 #
 CONFIG_PARPORT=y
 # CONFIG_PARPORT_PC is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 CONFIG_PARPORT_1284=y
 
--- a/arch/arm/configs/shark_defconfig
+++ b/arch/arm/configs/shark_defconfig
@@ -184,7 +184,6 @@ CONFIG_PARPORT_PC=m
 # CONFIG_PARPORT_SERIAL is not set
 # CONFIG_PARPORT_PC_FIFO is not set
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_ARC is not set
 # CONFIG_PARPORT_GSC is not set
 # CONFIG_PARPORT_1284 is not set
 
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -85,11 +85,6 @@ config PARPORT_PC_PCMCIA
 config PARPORT_NOT_PC
 	bool
 
-config PARPORT_ARC
-	tristate "Archimedes hardware"
-	depends on ARM && PARPORT
-	select PARPORT_NOT_PC
-
 config PARPORT_AMIGA
 	tristate "Amiga builtin port"
 	depends on AMIGA && PARPORT
--- a/drivers/parport/parport_arc.c
+++ b/drivers/parport/parport_arc.c
@@ -1,139 +0,0 @@
-/* Low-level parallel port routines for Archimedes onboard hardware
- *
- * Author: Phil Blundell <philb@gnu.org>
- */
-
-/* This driver is for the parallel port hardware found on Acorn's old
- * range of Archimedes machines.  The A5000 and newer systems have PC-style
- * I/O hardware and should use the parport_pc driver instead.
- *
- * The Acorn printer port hardware is very simple.  There is a single 8-bit
- * write-only latch for the data port and control/status bits are handled
- * with various auxilliary input and output lines.  The port is not
- * bidirectional, does not support any modes other than SPP, and has only
- * a subset of the standard printer control lines connected.
- */
-
-#include <linux/threads.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/parport.h>
-
-#include <asm/ptrace.h>
-#include <asm/io.h>
-#include <asm/arch/oldlatches.h>
-#include <asm/arch/irqs.h>
-
-#define DATA_ADDRESS    0x3350010
-
-/* This is equivalent to the above and only used for request_region. */
-#define PORT_BASE       0x80000000 | ((DATA_ADDRESS - IO_BASE) >> 2)
-
-/* The hardware can't read from the data latch, so we must use a soft
-   copy. */
-static unsigned char data_copy;
-
-/* These are pretty simple. We know the irq is never shared and the
-   kernel does all the magic that's required. */
-static void arc_enable_irq(struct parport *p)
-{
-	enable_irq(p->irq);
-}
-
-static void arc_disable_irq(struct parport *p)
-{
-	disable_irq(p->irq);
-}
-
-static void arc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	parport_generic_irq(irq, (struct parport *) dev_id, regs);
-}
-
-static void arc_write_data(struct parport *p, unsigned char data)
-{
-	data_copy = data;
-	outb_t(data, DATA_LATCH);
-}
-
-static unsigned char arc_read_data(struct parport *p)
-{
-	return data_copy;
-}
-
-static struct parport_operations parport_arc_ops = 
-{
-	.write_data	= arc_write_data,
-	.read_data	= arc_read_data,
-
-	.write_control	= arc_write_control,
-	.read_control	= arc_read_control,
-	.frob_control	= arc_frob_control,
-
-	.read_status	= arc_read_status,
-
-	.enable_irq	= arc_enable_irq,
-	.disable_irq	= arc_disable_irq,
-
-	.data_forward	= arc_data_forward,
-	.data_reverse	= arc_data_reverse,
-
-	.init_state	= arc_init_state,
-	.save_state	= arc_save_state,
-	.restore_state	= arc_restore_state,
-
-	.epp_write_data	= parport_ieee1284_epp_write_data,
-	.epp_read_data	= parport_ieee1284_epp_read_data,
-	.epp_write_addr	= parport_ieee1284_epp_write_addr,
-	.epp_read_addr	= parport_ieee1284_epp_read_addr,
-
-	.ecp_write_data	= parport_ieee1284_ecp_write_data,
-	.ecp_read_data	= parport_ieee1284_ecp_read_data,
-	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
-	
-	.compat_write_data	= parport_ieee1284_write_compat,
-	.nibble_read_data	= parport_ieee1284_read_nibble,
-	.byte_read_data		= parport_ieee1284_read_byte,
-
-	.owner		= THIS_MODULE,
-};
-
-/* --- Initialisation code -------------------------------- */
-
-static int parport_arc_init(void)
-{
-	/* Archimedes hardware provides only one port, at a fixed address */
-	struct parport *p;
-	struct resource res;
-	char *fake_name = "parport probe");
-
-	res = request_region(PORT_BASE, 1, fake_name);
-	if (res == NULL)
-		return 0;
-
-	p = parport_register_port (PORT_BASE, IRQ_PRINTERACK,
-				   PARPORT_DMA_NONE, &parport_arc_ops);
-
-	if (!p) {
-		release_region(PORT_BASE, 1);
-		return 0;
-	}
-
-	p->modes = PARPORT_MODE_ARCSPP;
-	p->size = 1;
-	rename_region(res, p->name);
-
-	printk(KERN_INFO "%s: Archimedes on-board port, using irq %d\n",
-	       p->irq);
-
-	/* Tell the high-level drivers about the port. */
-	parport_announce_port (p);
-
-	return 1;
-}
-
-module_init(parport_arc_init)

