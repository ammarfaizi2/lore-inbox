Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSJ2ERX>; Mon, 28 Oct 2002 23:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJ2ERW>; Mon, 28 Oct 2002 23:17:22 -0500
Received: from web20005.mail.yahoo.com ([216.136.225.68]:9274 "HELO
	web20005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261540AbSJ2ERU>; Mon, 28 Oct 2002 23:17:20 -0500
Message-ID: <20021029042340.12726.qmail@web20005.mail.yahoo.com>
Date: Mon, 28 Oct 2002 20:23:40 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: [PATCH] <exception typos>, kernel 2.5.44
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-995607466-1035865420=:12532"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-995607466-1035865420=:12532
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, having read the FAQ...
Here is a simple patch for fixing common misspellings
of 'exception' found in the code.

-Kenny

__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
--0-995607466-1035865420=:12532
Content-Type: text/x-diff; name=exception_patch
Content-Description: exception_patch
Content-Disposition: inline; filename=exception_patch

diff -ruN linux-2.5.44/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.44/arch/i386/kernel/entry.S	Sat Oct 19 00:01:19 2002
+++ linux/arch/i386/kernel/entry.S	Sun Oct 27 01:42:17 2002
@@ -211,7 +211,7 @@
 	movl TI_FLAGS(%ebx), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ?
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
 	sti
diff -ruN linux-2.5.44/arch/m68k/lib/checksum.c linux/arch/m68k/lib/checksum.c
--- linux-2.5.44/arch/m68k/lib/checksum.c	Sat Oct 19 00:02:35 2002
+++ linux/arch/m68k/lib/checksum.c	Sun Oct 27 02:05:29 2002
@@ -243,7 +243,7 @@
 	     "8:\n"
 		".section .fixup,\"ax\"\n"
 		".even\n"
-		/* If any execption occurs zero out the rest.
+		/* If any exception occurs zero out the rest.
 		   Similarities with the code above are intentional :-) */
 	     "90:\t"
 		"clrw %3@+\n\t"
diff -ruN linux-2.5.44/arch/mips64/config.in linux/arch/mips64/config.in
--- linux-2.5.44/arch/mips64/config.in	Sat Oct 19 00:02:24 2002
+++ linux/arch/mips64/config.in	Sun Oct 27 02:05:47 2002
@@ -239,7 +239,7 @@
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
 if [ "$CONFIG_MODULES" = "y" ]; then
-   bool ' Build fp execption handler module' CONFIG_MIPS_FPE_MODULE
+   bool ' Build fp exception handler module' CONFIG_MIPS_FPE_MODULE
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
diff -ruN linux-2.5.44/arch/ppc/boot/simple/rw4/ppc_40x.h linux/arch/ppc/boot/simple/rw4/ppc_40x.h
--- linux-2.5.44/arch/ppc/boot/simple/rw4/ppc_40x.h	Sat Oct 19 00:01:16 2002
+++ linux/arch/ppc/boot/simple/rw4/ppc_40x.h	Sun Oct 27 02:08:44 2002
@@ -41,9 +41,9 @@
 #define dbsr            0x3f0               /* debug status register         */
 #define dccr            0x3fa               /* data cache control reg.       */
 #define dcwr            0x3ba               /* data cache write-thru reg     */
-#define dear            0x3d5               /* data exeption address reg     */
-#define esr             0x3d4               /* execption syndrome registe    */
-#define evpr            0x3d6               /* exeption vector prefix reg    */
+#define dear            0x3d5               /* data exception address reg    */
+#define esr             0x3d4               /* exception syndrome registe    */
+#define evpr            0x3d6               /* exception vector prefix reg   */
 #define iccr            0x3fb               /* instruction cache cntrl re    */
 #define icdbdr          0x3d3               /* instr cache dbug data reg     */
 #define lrreg           0x008               /* link register                 */
diff -ruN linux-2.5.44/drivers/acpi/namespace/nsxfobj.c linux/drivers/acpi/namespace/nsxfobj.c
--- linux-2.5.44/drivers/acpi/namespace/nsxfobj.c	Sat Oct 19 00:00:42 2002
+++ linux/drivers/acpi/namespace/nsxfobj.c	Sun Oct 27 02:10:38 2002
@@ -141,7 +141,7 @@
 	*ret_handle =
 		acpi_ns_convert_entry_to_handle (acpi_ns_get_parent_node (node));
 
-	/* Return exeption if parent is null */
+	/* Return exception if parent is null */
 
 	if (!acpi_ns_get_parent_node (node)) {
 		status = AE_NULL_ENTRY;
diff -ruN linux-2.5.44/drivers/isdn/hardware/eicon/mi_pc.h linux/drivers/isdn/hardware/eicon/mi_pc.h
--- linux-2.5.44/drivers/isdn/hardware/eicon/mi_pc.h	Sat Oct 19 00:01:55 2002
+++ linux/drivers/isdn/hardware/eicon/mi_pc.h	Sun Oct 27 02:10:57 2002
@@ -65,7 +65,7 @@
 #define _MP_LED1         0x04        /* 1 = on      */
 #define _MP_DSP_RESET    0x02        /* active lo   */
 #define _MP_RISC_RESET   0x81        /* active hi, bit 7 for compatibility with old boards */
-/* CPU exeption context structure in MP shared ram after trap */
+/* CPU exception context structure in MP shared ram after trap */
 typedef struct mp_xcptcontext_s MP_XCPTC;
 struct mp_xcptcontext_s {
     dword       sr;
diff -ruN linux-2.5.44/drivers/md/lvm-snap.c linux/drivers/md/lvm-snap.c
--- linux-2.5.44/drivers/md/lvm-snap.c	Sat Oct 19 00:02:27 2002
+++ linux/drivers/md/lvm-snap.c	Sun Oct 27 02:06:12 2002
@@ -387,7 +387,7 @@
 #endif
 
 	/* the original chunk is now stored on the snapshot volume
-	   so update the execption table */
+	   so update the exception table */
 	lv_snap->u.lv_block_exception[idx].rdev_org = org_phys_dev;
 	lv_snap->u.lv_block_exception[idx].rsector_org = org_start;
 
diff -ruN linux-2.5.44/drivers/net/sk98lin/h/skgehw.h linux/drivers/net/sk98lin/h/skgehw.h
--- linux-2.5.44/drivers/net/sk98lin/h/skgehw.h	Sat Oct 19 00:02:33 2002
+++ linux/drivers/net/sk98lin/h/skgehw.h	Sun Oct 27 02:07:17 2002
@@ -813,7 +813,7 @@
 									/* Bit 31..12:	reserved */
 #define	IS_IRQ_MST_ERR	(1L<<11)	/* Bit 11:	IRQ master error */
 									/*	PERR,RMABORT,RTABORT,DATAPERR */
-#define	IS_IRQ_STAT		(1L<<10)	/* Bit 10:	IRQ status execption */
+#define	IS_IRQ_STAT		(1L<<10)	/* Bit 10:	IRQ status exception */
 									/*	RMABORT, RTABORT, DATAPERR */
 #define IS_NO_STAT_M1	(1L<<9)		/* Bit	9:	No Rx Status from MAC1*/
 #define IS_NO_STAT_M2	(1L<<8)		/* Bit	8:	No Rx Status from MAC2*/
diff -ruN linux-2.5.44/drivers/net/skfp/h/skfbi.h linux/drivers/net/skfp/h/skfbi.h
--- linux-2.5.44/drivers/net/skfp/h/skfbi.h	Sat Oct 19 00:01:51 2002
+++ linux/drivers/net/skfp/h/skfbi.h	Sun Oct 27 02:06:50 2002
@@ -1308,7 +1308,7 @@
 #define IS_I2C_READY	(1L<<27)	/* Bit 27: (ML)	IRQ on end of I2C tx */
 #define IS_IRQ_SW	(1L<<26)	/* Bit 26: (ML)	SW forced IRQ	     */
 #define IS_EXT_REG	(1L<<25)	/* Bit 25: (ML) IRQ from external reg*/
-#define	IS_IRQ_STAT	(1L<<24)	/* Bit 24:	IRQ status execption */
+#define	IS_IRQ_STAT	(1L<<24)	/* Bit 24:	IRQ status exception */
 					/*   PERR, RMABORT, RTABORT DATAPERR */
 #define	IS_IRQ_MST_ERR	(1L<<23)	/* Bit 23:	IRQ master error     */
 					/*   RMABORT, RTABORT, DATAPERR	     */
@@ -1360,7 +1360,7 @@
 #define IRQ_I2C_READY	(1L<<27)	/* Bit 27: (ML)	IRQ on end of I2C tx */
 #define IRQ_SW		(1L<<26)	/* Bit 26: (ML)	SW forced IRQ	     */
 #define IRQ_EXT_REG	(1L<<25)	/* Bit 25: (ML) IRQ from external reg*/
-#define	IRQ_STAT	(1L<<24)	/* Bit 24:	IRQ status execption */
+#define	IRQ_STAT	(1L<<24)	/* Bit 24:	IRQ status exception */
 					/*   PERR, RMABORT, RTABORT DATAPERR */
 #define	IRQ_MST_ERR	(1L<<23)	/* Bit 23:	IRQ master error     */
 					/*   RMABORT, RTABORT, DATAPERR	     */
diff -ruN linux-2.5.44/drivers/sbus/char/bpp.c linux/drivers/sbus/char/bpp.c
--- linux-2.5.44/drivers/sbus/char/bpp.c	Sat Oct 19 00:01:08 2002
+++ linux/drivers/sbus/char/bpp.c	Sun Oct 27 02:11:19 2002
@@ -95,7 +95,7 @@
 /*
  * These are for data access.
  * Control lines accesses are hidden in set_bits() and get_bits().
- * The exeption is the probe procedure, which is system-dependent.
+ * The exception is the probe procedure, which is system-dependent.
  */
 #define bpp_outb_p(data, base)  outb_p((data), (base))
 #define bpp_inb(base)  inb(base)

--0-995607466-1035865420=:12532--
