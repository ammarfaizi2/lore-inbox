Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUAAUsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbUAAUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:03:52 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:22596 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264568AbUAAUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:52 -0500
Date: Thu, 1 Jan 2004 21:01:49 +0100
Message-Id: <200401012001.i01K1nNJ031709@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 344] M68k head white space
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove trailing white space (from Roman Zippel)

--- linux-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:56:19 -0000	1.13
+++ linux-m68k-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 23:03:00 -0000
@@ -23,7 +23,7 @@
 ** 98/04/25 Phil Blundell: added HP300 support
 ** 1998/08/30 David Kilzer: Added support for font_desc structures
 **            for linux-2.1.115
-** 9/02/11  Richard Zidlicky: added Q40 support (initial vesion 99/01/01) 
+** 9/02/11  Richard Zidlicky: added Q40 support (initial vesion 99/01/01)
 **
 ** This file is subject to the terms and conditions of the GNU General Public
 ** License. See the file README.legal in the main directory of this archive
@@ -100,14 +100,14 @@
  *
  *	While this essentially describes the function in the abstract, you'll
  * find more indepth description of other parameters at the implementation site.
- * 
+ *
  * mmu_get_root_table_entry
  * ------------------------
  * mmu_get_ptr_table_entry
  * -----------------------
  * mmu_get_page_table_entry
  * ------------------------
- * 
+ *
  *	These routines are used by other mmu routines to get a pointer into
  * a table, if necessary a new table is allocated. These routines are working
  * basically like pmd_alloc() and pte_alloc() in <asm/pgtable.h>. The root
@@ -311,8 +311,8 @@
 .globl mvme_bdid
 #endif
 #ifdef CONFIG_Q40
-.globl q40_mem_cptr	
-#endif		
+.globl q40_mem_cptr
+#endif
 #ifdef CONFIG_HP300
 .globl hp300_phys_ram_base
 #endif
@@ -423,7 +423,7 @@
 L(\name):
 	linkw	%a6,#-\stack
 	moveml	\saveregs,%sp@-
-.set	stackstart,-\stack	
+.set	stackstart,-\stack
 
 .macro	func_return_\name
 	moveml	%sp@+,\saveregs
@@ -593,7 +593,7 @@
 	.long	MACH_MVME16x, MVME16x_BOOTI_VERSION
 	.long	MACH_BVME6000, BVME6000_BOOTI_VERSION
 	.long	MACH_MAC, MAC_BOOTI_VERSION
-	.long	MACH_Q40, Q40_BOOTI_VERSION	
+	.long	MACH_Q40, Q40_BOOTI_VERSION
 	.long	0
 1:	jra	__start
 
@@ -611,8 +611,8 @@
    address (apparently 0xff002000 in practice) which is not good if we need
    to be able to map this to VA 0x1000.  We could do it with pagetables but
    a better solution seems to be to relocate the kernel in physical memory
-   before we start.  
-	
+   before we start.
+
    So, we copy the entire kernel image (code+data+bss) down to the 16MB
    boundary that marks the start of RAM.  This is slightly tricky because
    we must not overwrite the copying code itself. :-)  */
@@ -657,7 +657,7 @@
 	movel	%d6,%a0
 	addl	#Lstart1,%a0
 	jmp	%a0@
-Lcopyend:	
+Lcopyend:
 
 Lstart1:
 	moveb	#0x3f,%d7
@@ -1115,12 +1115,12 @@
 
 	mmu_map_tt	#0,#0xfe000000,#0x01000000,#_PAGE_CACHE040W
 	mmu_map_tt	#1,#0xff000000,#0x01000000,#_PAGE_NOCACHE_S
-	
+
 	jbra	L(mmu_init_done)
-	
-L(notq40):		
-#endif	
-	
+
+L(notq40):
+#endif
+
 #ifdef CONFIG_HP300
 	is_not_hp300(L(nothp300))
 
@@ -1137,18 +1137,18 @@
 
 #ifdef CONFIG_MVME147
 
-       is_not_mvme147(L(not147))
+	is_not_mvme147(L(not147))
 
-       /*
-	* On MVME147 we have already created kernel page tables for
-	* 4MB of RAM at address 0, so now need to do a transparent
-	* mapping of the top of memory space.  Make it 0.5GByte for now,
-	* so we can access on-board i/o areas.
-	*/
+	/*
+	 * On MVME147 we have already created kernel page tables for
+	 * 4MB of RAM at address 0, so now need to do a transparent
+	 * mapping of the top of memory space.  Make it 0.5GByte for now,
+	 * so we can access on-board i/o areas.
+	 */
 
-       mmu_map_tt      #1,#0xe0000000,#0x20000000,#_PAGE_NOCACHE030
+	mmu_map_tt	#1,#0xe0000000,#0x20000000,#_PAGE_NOCACHE030
 
-       jbra    L(mmu_init_done)
+	jbra	L(mmu_init_done)
 
 L(not147):
 #endif /* CONFIG_MVME147 */
@@ -1287,7 +1287,7 @@
 	andl	#PAGE_TABLE_SIZE-1, %d0
 	mmu_get_page_table_entry	%a0,%d0
 
-	/* this is where the prom page table lives */	
+	/* this is where the prom page table lives */
 	movel	0xfefe00d4, %a1
 	movel	%a1@, %a1
 
@@ -1298,11 +1298,11 @@
 	movel	%d3,%a0@+
 	addl	#0x1000,%d3
 	movel	%d3,%a0@+
-	
-	dbra	%d1,1b	
-		
+
+	dbra	%d1,1b
+
 	/* setup tt1 for I/O */
-	mmu_map_tt	#1,#0x40000000,#0x40000000,#_PAGE_NOCACHE_S 
+	mmu_map_tt	#1,#0x40000000,#0x40000000,#_PAGE_NOCACHE_S
 	jbra	L(mmu_init_done)
 
 L(notsun3x):
@@ -1313,8 +1313,8 @@
 
 	putc	'P'
 	mmu_map         #0x80000000,#0,#0x02000000,#_PAGE_NOCACHE030
-	
-L(notapollo):	
+
+L(notapollo):
 	jbra	L(mmu_init_done)
 #endif
 
@@ -1345,7 +1345,7 @@
 #endif
 
 	/* first fix the page at the start of the kernel, that
-         * contains also kernel_pg_dir.
+	 * contains also kernel_pg_dir.
 	 */
 	movel	%pc@(L(phys_kernel_start)),%d0
 	subl	#PAGE_OFFSET,%d0
@@ -1473,7 +1473,7 @@
 #endif
 #ifdef MAC_SERIAL_DEBUG
 	orl	#0x50000000,L(mac_sccbase)
-#endif		
+#endif
 1:
 #endif
 
@@ -1495,20 +1495,20 @@
 	is_not_sun3x(1f)
 
 	/* enable copro */
-	oriw	#0x4000,0x61000000 
+	oriw	#0x4000,0x61000000
 1:
 #endif
 
 #ifdef CONFIG_APOLLO
 	is_not_apollo(1f)
 
-        /*
+	/*
 	 * Fix up the iobase before printing
-         */
-        movel   #0x80000000,L(iobase)
+	 */
+	movel	#0x80000000,L(iobase)
 1:
 #endif
-	
+
 	putc	'I'
 	leds	0x10
 
@@ -2990,7 +2990,7 @@
    - check for '%LX$' signature in SRAM   */
 	lea	%pc@(q40_mem_cptr),%a1
 	move.l	#0xff020010,%a1@  /* must be inited - also used by debug=mem */
-	move.l	#0xff020000,%a1   
+	move.l	#0xff020000,%a1
 	cmp.b	#'%',%a1@
 	bne	2f	/*nodbg*/
 	addq.w	#4,%a1
@@ -3005,10 +3005,10 @@
 	/* signature OK */
 	lea	%pc@(L(q40_do_debug)),%a1
 	tas	%a1@
-/*nodbg: q40_do_debug is 0 by default*/	
-2:		
-#endif	
-	
+/*nodbg: q40_do_debug is 0 by default*/
+2:
+#endif
+
 #ifdef CONFIG_APOLLO
 /* We count on the PROM initializing SIO1 */
 #endif
@@ -3176,15 +3176,15 @@
 #endif
 
 #ifdef CONFIG_SUN3X
-	is_not_sun3x(2f) 
+	is_not_sun3x(2f)
 	movel	%d0,-(%sp)
 	movel	0xFEFE0018,%a1
 	jbsr	(%a1)
 	addq	#4,%sp
 	jbra	L(serial_putc_done)
-2:	
+2:
 #endif
-	
+
 #ifdef CONFIG_Q40
 	is_not_q40(2f)
 	tst.l	%pc@(L(q40_do_debug))	/* only debug if requested */
@@ -3195,16 +3195,16 @@
 	addq.l	#4,%a0
 	move.l	%a0,%a1@
 	jbra    L(serial_putc_done)
-2:		
-#endif	
+2:
+#endif
 
 #ifdef CONFIG_APOLLO
 	is_not_apollo(2f)
 	movl    %pc@(L(iobase)),%a1
-        moveb   %d0,%a1@(LTHRB0)
+	moveb	%d0,%a1@(LTHRB0)
 1:      moveb   %a1@(LSRB0),%d0
-        andb    #0x4,%d0
-        beq     1b
+	andb	#0x4,%d0
+	beq	1b
 2:
 #endif
 
@@ -3221,7 +3221,7 @@
 1:
 #ifdef CONSOLE
 	console_putc	%d0
-#endif 
+#endif
 #ifdef SERIAL_DEBUG
 	serial_putc	%d0
 #endif
@@ -3250,7 +3250,7 @@
 2:
 #ifdef CONSOLE
 	console_putc	%d2
-#endif 
+#endif
 #ifdef SERIAL_DEBUG
 	serial_putc	%d2
 #endif
@@ -3299,7 +3299,7 @@
 	moveb	%d0,%a0@(0x1ffff)
 	jra	2f
 #endif
-1:	
+1:
 #ifdef CONFIG_APOLLO
 	movel   %pc@(L(iobase)),%a0
 	lsll    #8,%d0
@@ -3396,8 +3396,8 @@
 	movel	%d3,%d0				/* screen width in pixels */
 	divul	%a0@(FONT_DESC_WIDTH),%d0	/* d0 = max num chars per row */
 
-	movel	%d4,%d1				 /* screen height in pixels */
-	divul	%a0@(FONT_DESC_HEIGHT),%d1	 /* d1 = max num rows */
+	movel	%d4,%d1				/* screen height in pixels */
+	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3442,7 +3442,7 @@
 #ifdef MAC_SERIAL_DEBUG
 	putn	%pc@(L(mac_sccbase))
 	putc	'\n'
-#endif	
+#endif
 #  if defined(MMU_PRINT)
 	jbsr	mmu_print_machine_cpu_types
 #  endif /* MMU_PRINT */
@@ -3483,7 +3483,7 @@
 
 /* include penguin bitmap */
 L(that_penguin):
-#include "../mac/mac_penguin.S"	
+#include "../mac/mac_penguin.S"
 #endif
 
 	/*
@@ -3940,7 +3940,7 @@
 #endif
 #if defined(CONFIG_Q40)
 q40_mem_cptr:
-	.long 0
-L(q40_do_debug):	
-	.long 0	
+	.long	0
+L(q40_do_debug):
+	.long	0
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
