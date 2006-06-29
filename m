Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWF2EG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWF2EG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWF2EG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:06:57 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:63497 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751701AbWF2EG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:06:56 -0400
From: "Matt LaPlante" <laplam@rpi.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [Patch] Attack of "the the"s in /arch
Date: Thu, 29 Jun 2006 00:06:25 -0400
Message-ID: <000001c69b31$64186160$fe01a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcabMWPqbQBnIxNFSR6IZ3B+G8Ng3g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 00:06:37 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 00:06:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  This is my first attempt at submitting a patch, so I apologize if I've
broken any rules.  I started out looking for errors in KConfig text, and
after finding one instance of the popular repetition "the the" I decided to
grep for other occurrences.  To my surprise, I popped up quite a few of
them!  The patch below corrects these typos across several files, both in
source comments and KConfig files.  There is no actual code changed, only
text.  Note this only affects the /arch directory, and I believe I could
find many more elsewhere. :) I'm not submitting for inclusion yet, so I can
get feedback incase I need to change my format.

-
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

--

diff -ru a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c
--- a/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
23:20:26.000000000 -0400
+++ b/arch/arm/mach-lh7a40x/arch-lpd7a40x.c	2006-06-28
23:45:49.000000000 -0400
@@ -163,7 +163,7 @@
 	/* CPLD doesn't have ack capability, but some devices may */
 
 #if defined (CPLD_INTMASK_TOUCH)
-	/* The touch control *must* mask the the interrupt because the
+	/* The touch control *must* mask the interrupt because the
 	 * interrupt bit is read by the driver to determine if the pen
 	 * is still down. */
 	if (irq == IRQ_TOUCH)
diff -ru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2006-06-28 23:20:26.000000000 -0400
+++ b/arch/i386/Kconfig	2006-06-28 23:39:21.000000000 -0400
@@ -667,7 +667,7 @@
 	depends on ACPI
 	default n
 	---help---
-	This enables the the kernel to boot on EFI platforms using
+	This enables the kernel to boot on EFI platforms using
 	system configuration information passed to it from the firmware.
 	This also enables the kernel to use any EFI runtime services that
are
 	available (such as the EFI variable services).
diff -ru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/i386/pci/fixup.c	2006-06-28 23:39:21.000000000 -0400
@@ -393,7 +393,7 @@
  * We pretend to bring them out of full D3 state, and restore the proper
  * IRQ, PCI cache line size, and BARs, otherwise the device won't function
  * properly.  In some cases, the device will generate an interrupt on
- * the wrong IRQ line, causing any devices sharing the the line it's
+ * the wrong IRQ line, causing any devices sharing the line it's
  * *supposed* to use to be disabled by the kernel's IRQ debug code.
  */
 static u16 toshiba_line_size;
diff -ru a/arch/ia64/sn/kernel/xpnet.c b/arch/ia64/sn/kernel/xpnet.c
--- a/arch/ia64/sn/kernel/xpnet.c	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/ia64/sn/kernel/xpnet.c	2006-06-28 23:45:48.000000000 -0400
@@ -226,7 +226,7 @@
 	skb_put(skb, (msg->size - msg->leadin_ignore -
msg->tailout_ignore));
 
 	/*
-	 * Move the data over from the the other side.
+	 * Move the data over from the other side.
 	 */
 	if ((XPNET_VERSION_MINOR(msg->version) == 1) &&
 						(msg->embedded_bytes != 0))
{
diff -ru a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	2006-06-28 23:20:26.000000000 -0400
+++ b/arch/m68knommu/Kconfig	2006-06-28 23:39:21.000000000 -0400
@@ -495,7 +495,7 @@
 	hex "Address of the base of system vectors"
 	default "0"
 	help
-	  Define the address of the the system vectors. Commonly this is
+	  Define the address of the system vectors. Commonly this is
 	  put at the start of RAM, but it doesn't have to be. On ColdFire
 	  platforms this address is programmed into the VBR register, thus
 	  actually setting the address to use.
diff -ru a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
--- a/arch/mips/mm/tlbex.c	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/mips/mm/tlbex.c	2006-06-28 23:44:22.000000000 -0400
@@ -1214,7 +1214,7 @@
 	 * Overflow check: For the 64bit handler, we need at least one
 	 * free instruction slot for the wrap-around branch. In worst
 	 * case, if the intended insertion point is a delay slot, we
-	 * need three, with the the second nop'ed and the third being
+	 * need three, with the second nop'ed and the third being
 	 * unused.
 	 */
 #ifdef CONFIG_32BIT
diff -ru a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
--- a/arch/parisc/kernel/entry.S	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/parisc/kernel/entry.S	2006-06-28 23:44:22.000000000 -0400
@@ -942,8 +942,8 @@
 	 * to "proper" values now (otherwise we'll wind up restoring
 	 * whatever was last stored in the task structure, which might
 	 * be inconsistent if an interrupt occured while on the gateway
-	 * page) Note that we may be "trashing" values the user put in
-	 * them, but we don't support the the user changing them.
+	 * page). Note that we may be "trashing" values the user put in
+	 * them, but we don't support the user changing them.
 	 */
 
 	STREG   %r0,PT_SR2(%r16)
diff -ru a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	2006-06-28 23:20:27.000000000 -0400
+++ b/arch/powerpc/Kconfig	2006-06-28 23:39:21.000000000 -0400
@@ -958,7 +958,7 @@
 	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
 	help
 	  This option allows you to set the base virtual address
-	  of the the consistent memory pool.  This pool of virtual
+	  of the consistent memory pool.  This pool of virtual
 	  memory is used to make consistent memory allocations.
 
 config CONSISTENT_START
@@ -969,7 +969,7 @@
 	bool "Set custom consistent memory pool size"
 	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
 	help
-	  This option allows you to set the size of the the
+	  This option allows you to set the size of the
 	  consistent memory pool.  This pool of virtual memory
 	  is used to make consistent memory allocations.
 
diff -ru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2006-06-28 23:20:27.000000000 -0400
+++ b/arch/ppc/Kconfig	2006-06-28 23:39:21.000000000 -0400
@@ -1342,7 +1342,7 @@
 	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
 	help
 	  This option allows you to set the base virtual address
-	  of the the consistent memory pool.  This pool of virtual
+	  of the consistent memory pool.  This pool of virtual
 	  memory is used to make consistent memory allocations.
 
 config CONSISTENT_START
@@ -1353,7 +1353,7 @@
 	bool "Set custom consistent memory pool size"
 	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
 	help
-	  This option allows you to set the size of the the
+	  This option allows you to set the size of the
 	  consistent memory pool.  This pool of virtual memory
 	  is used to make consistent memory allocations.
 
diff -ru a/arch/um/drivers/line.c b/arch/um/drivers/line.c
--- a/arch/um/drivers/line.c	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/um/drivers/line.c	2006-06-28 23:44:21.000000000 -0400
@@ -498,7 +498,7 @@
 }
 
 /* Common setup code for both startup command line and mconsole
initialization.
- * @lines contains the the array (of size @num) to modify;
+ * @lines contains the array (of size @num) to modify;
  * @init is the setup string;
  */
 
diff -ru a/arch/um/include/sysdep-x86_64/ptrace_user.h
b/arch/um/include/sysdep-x86_64/ptrace_user.h
--- a/arch/um/include/sysdep-x86_64/ptrace_user.h	2006-06-20
05:31:55.000000000 -0400
+++ b/arch/um/include/sysdep-x86_64/ptrace_user.h	2006-06-28
23:47:48.000000000 -0400
@@ -55,7 +55,7 @@
 #define PTRACE_OLDSETOPTIONS 21
 #endif
 
-/* These are before the system call, so the the system call number is RAX
+/* These are before the system call, so the system call number is RAX
  * rather than ORIG_RAX, and arg4 is R10 rather than RCX
  */
 #define REGS_SYSCALL_NR PT_INDEX(RAX)
diff -ru a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/um/Makefile	2006-06-28 23:39:21.000000000 -0400
@@ -102,7 +102,7 @@
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for
backward'
   echo '		   compatibility only, this creates a hard link to
the'
-  echo '		   real kernel binary, the the "vmlinux" binary you'
+  echo '		   real kernel binary, the "vmlinux" binary you'
   echo '		   find in the kernel root.'
 endef
 
diff -ru a/arch/v850/kernel/entry.S b/arch/v850/kernel/entry.S
--- a/arch/v850/kernel/entry.S	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/v850/kernel/entry.S	2006-06-28 23:41:24.000000000 -0400
@@ -195,7 +195,7 @@
 	sst.w	lp, PTO+PT_GPR(GPR_LP)[ep];
\
 	type ## _STATE_SAVER
 /* Pop a register state pushed by PUSH_STATE, except for the stack pointer,
-   from the the stack.  */
+   from the stack.  */
 #define POP_STATE(type)
\
 	mov	sp, ep;
\
 	type ## _STATE_RESTORER;
\
diff -ru a/arch/xtensa/lib/usercopy.S b/arch/xtensa/lib/usercopy.S
--- a/arch/xtensa/lib/usercopy.S	2006-06-20 05:31:55.000000000 -0400
+++ b/arch/xtensa/lib/usercopy.S	2006-06-28 23:47:48.000000000 -0400
@@ -5,10 +5,10 @@
  *
  *  DO NOT COMBINE this function with <arch/xtensa/lib/hal/memcopy.S>.
  *  It needs to remain separate and distinct.  The hal files are part
- *  of the the Xtensa link-time HAL, and those files may differ per
+ *  of the Xtensa link-time HAL, and those files may differ per
  *  processor configuration.  Patching the kernel for another
  *  processor configuration includes replacing the hal files, and we
- *  could loose the special functionality for accessing user-space
+ *  could lose the special functionality for accessing user-space
  *  memory during such a patch.  We sacrifice a little code space here
  *  in favor to simplify code maintenance.
  *


