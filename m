Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTBTCBf>; Wed, 19 Feb 2003 21:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBTCBC>; Wed, 19 Feb 2003 21:01:02 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:60933 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265094AbTBTB7g>; Wed, 19 Feb 2003 20:59:36 -0500
Subject: [PATCH] Spelling fixes for relevent -> relevant in 15 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Feb 2003 19:00:57 -0700
Message-Id: <1045706458.5965.500.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides spelling fixes for the following:

relevent    -> relevant
irrelevent  -> irrelevant

 arch/arm/kernel/entry-armo.S   |    2 +-
 arch/arm/kernel/entry-armv.S   |    8 ++++----
 arch/arm/mm/proc-arm6_7.S      |    2 +-
 arch/v850/kernel/ma.c          |    2 +-
 arch/v850/kernel/rte_ma1_cb.c  |    2 +-
 drivers/acpi/hardware/hwregs.c |    2 +-
 drivers/char/rio/list.h        |    2 +-
 drivers/char/rio/rioparam.c    |    2 +-
 drivers/char/rio/rioroute.c    |    2 +-
 drivers/i2c/i2c-algo-ibm_ocp.c |    2 +-
 drivers/isdn/hisax/rawhdlc.c   |    2 +-
 drivers/serial/sa1100.c        |    2 +-
 fs/adfs/dir_f.c                |    2 +-
 fs/afs/vnode.c                 |    2 +-
 kernel/futex.c                 |    2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff -ur linux-2.5-current/arch/arm/kernel/entry-armo.S linux/arch/arm/kernel/entry-armo.S
--- linux-2.5-current/arch/arm/kernel/entry-armo.S	Wed Feb 19 07:34:50 2003
+++ linux/arch/arm/kernel/entry-armo.S	Wed Feb 19 14:03:22 2003
@@ -426,7 +426,7 @@
 		mov	r2, #0
 		tst	r4, #1 << 20		@ Check to see if it is a write instruction
 		orreq	r2, r2, #FAULT_CODE_WRITE @ Indicate write instruction
-		mov	r1, r4, lsr #22		@ Now branch to the relevent processing routine
+		mov	r1, r4, lsr #22		@ Now branch to the relevant processing routine
 		and	r1, r1, #15 << 2
 		add	pc, pc, r1
 		movs	pc, lr
diff -ur linux-2.5-current/arch/arm/kernel/entry-armv.S linux/arch/arm/kernel/entry-armv.S
--- linux-2.5-current/arch/arm/kernel/entry-armv.S	Wed Feb 19 07:34:51 2003
+++ linux/arch/arm/kernel/entry-armv.S	Wed Feb 19 14:03:22 2003
@@ -1026,7 +1026,7 @@
 		mrs	lr, spsr
 		str	lr, [r13, #4]			@ save spsr_IRQ
 		@
-		@ now branch to the relevent MODE handling routine
+		@ now branch to the relevant MODE handling routine
 		@
 		mov	r13, #PSR_I_BIT | MODE_SVC
 		msr	spsr_c, r13			@ switch to SVC_32 mode
@@ -1067,7 +1067,7 @@
 		mrs	lr, spsr
 		str	lr, [r13, #4]
 		@
-		@ now branch to the relevent MODE handling routine
+		@ now branch to the relevant MODE handling routine
 		@
 		mov	r13, #PSR_I_BIT | MODE_SVC
 		msr	spsr_c, r13			@ switch to SVC_32 mode
@@ -1109,7 +1109,7 @@
 		mrs	lr, spsr
 		str	lr, [r13, #4]			@ save spsr_ABT
 		@
-		@ now branch to the relevent MODE handling routine
+		@ now branch to the relevant MODE handling routine
 		@
 		mov	r13, #PSR_I_BIT | MODE_SVC
 		msr	spsr_c, r13			@ switch to SVC_32 mode
@@ -1150,7 +1150,7 @@
 		mrs	lr, spsr
 		str	lr, [r13, #4]			@ save spsr_UND
 		@
-		@ now branch to the relevent MODE handling routine
+		@ now branch to the relevant MODE handling routine
 		@
 		mov	r13, #PSR_I_BIT | MODE_SVC
 		msr	spsr_c, r13			@ switch to SVC_32 mode
diff -ur linux-2.5-current/arch/arm/mm/proc-arm6_7.S linux/arch/arm/mm/proc-arm6_7.S
--- linux-2.5-current/arch/arm/mm/proc-arm6_7.S	Wed Feb 19 07:35:08 2003
+++ linux/arch/arm/mm/proc-arm6_7.S	Wed Feb 19 14:03:22 2003
@@ -97,7 +97,7 @@
 		tst	r4, r4, lsr #21			@ C = bit 20
 		sbc	r1, r1, r1			@ r1 = C - 1
 		and	r2, r4, #15 << 24
-		add	pc, pc, r2, lsr #22		@ Now branch to the relevent processing routine
+		add	pc, pc, r2, lsr #22		@ Now branch to the relevant processing routine
 		movs	pc, lr
 
 		b	Ldata_unknown
diff -ur linux-2.5-current/arch/v850/kernel/ma.c linux/arch/v850/kernel/ma.c
--- linux-2.5-current/arch/v850/kernel/ma.c	Wed Feb 19 07:34:43 2003
+++ linux/arch/v850/kernel/ma.c	Wed Feb 19 14:03:22 2003
@@ -61,7 +61,7 @@
 	   specific chips may have more).  */
 	if (chan < 2) {
 		unsigned bits = 0x3 << (chan * 3);
-		/* Specify that the relevent pins on the chip should do
+		/* Specify that the relevant pins on the chip should do
 		   serial I/O, not direct I/O.  */
 		MA_PORT4_PMC |= bits;
 		/* Specify that we're using the UART, not the CSI device.  */
diff -ur linux-2.5-current/arch/v850/kernel/rte_ma1_cb.c linux/arch/v850/kernel/rte_ma1_cb.c
--- linux-2.5-current/arch/v850/kernel/rte_ma1_cb.c	Wed Feb 19 07:35:16 2003
+++ linux/arch/v850/kernel/rte_ma1_cb.c	Wed Feb 19 14:03:22 2003
@@ -93,7 +93,7 @@
 		/* Turn on the timer.  */
 		NB85E_TIMER_C_TMCC0 (tc) |= NB85E_TIMER_C_TMCC0_CAE;
 
-	/* Make sure the relevent port0/port1 pins are assigned
+	/* Make sure the relevant port0/port1 pins are assigned
 	   interrupt duty.  We used INTP001-INTP011 (don't screw with
 	   INTP000 because the monitor uses it).  */
 	MA_PORT0_PMC |= 0x4;	/* P02 (INTP001) in IRQ mode.  */
diff -ur linux-2.5-current/drivers/acpi/hardware/hwregs.c linux/drivers/acpi/hardware/hwregs.c
--- linux-2.5-current/drivers/acpi/hardware/hwregs.c	Wed Feb 19 07:35:16 2003
+++ linux/drivers/acpi/hardware/hwregs.c	Wed Feb 19 14:03:22 2003
@@ -370,7 +370,7 @@
 
 		/*
 		 * Status Registers are different from the rest.  Clear by
-		 * writing 1, writing 0 has no effect.  So, the only relevent
+		 * writing 1, writing 0 has no effect.  So, the only relevant
 		 * information is the single bit we're interested in, all others should
 		 * be written as 0 so they will be left unchanged
 		 */
diff -ur linux-2.5-current/drivers/char/rio/list.h linux/drivers/char/rio/list.h
--- linux-2.5-current/drivers/char/rio/list.h	Wed Feb 19 07:35:15 2003
+++ linux/drivers/char/rio/list.h	Wed Feb 19 14:03:22 2003
@@ -111,7 +111,7 @@
 /*
 ** can_remove_receive( PacketP, PortP ) returns non-zero if PKT_IN_USE is set
 ** for the next packet on the queue. It will also set PacketP to point to the
-** relevent packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
+** relevant packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
 ** then can_remove_receive() returns 0.
 */
 #if defined(MIPS) || defined(nx6000) || defined(drs6000) || defined(UWsparc)
diff -ur linux-2.5-current/drivers/char/rio/rioparam.c linux/drivers/char/rio/rioparam.c
--- linux-2.5-current/drivers/char/rio/rioparam.c	Wed Feb 19 07:35:24 2003
+++ linux/drivers/char/rio/rioparam.c	Wed Feb 19 14:03:22 2003
@@ -714,7 +714,7 @@
 /*
 ** can_remove_receive(PktP,P) returns non-zero if PKT_IN_USE is set
 ** for the next packet on the queue. It will also set PktP to point to the
-** relevent packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
+** relevant packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
 ** then can_remove_receive() returns 0.
 */
 int
diff -ur linux-2.5-current/drivers/char/rio/rioroute.c linux/drivers/char/rio/rioroute.c
--- linux-2.5-current/drivers/char/rio/rioroute.c	Wed Feb 19 07:35:01 2003
+++ linux/drivers/char/rio/rioroute.c	Wed Feb 19 14:03:22 2003
@@ -521,7 +521,7 @@
       /*
       ** If either of the modules on this unit is read-only or write-only
       ** or none-xprint, then we need to transfer that info over to the
-      ** relevent ports.
+      ** relevant ports.
       */
       if ( HostP->Mapping[ThisUnit].SysPort != NO_PORT )
       {
diff -ur linux-2.5-current/drivers/i2c/i2c-algo-ibm_ocp.c linux/drivers/i2c/i2c-algo-ibm_ocp.c
--- linux-2.5-current/drivers/i2c/i2c-algo-ibm_ocp.c	Wed Feb 19 07:35:05 2003
+++ linux/drivers/i2c/i2c-algo-ibm_ocp.c	Wed Feb 19 14:03:22 2003
@@ -758,7 +758,7 @@
         // Check to see if the bus is busy
         //
         ret = iic_inb(adap, iic->extsts);
-        // Mask off the irrelevent bits
+        // Mask off the irrelevant bits
         ret = ret & 0x70;
         // When the bus is free, the BCS bits in the EXTSTS register are 0b100
         if(ret != 0x40) return IIC_ERR_LOST_ARB;
diff -ur linux-2.5-current/drivers/isdn/hisax/rawhdlc.c linux/drivers/isdn/hisax/rawhdlc.c
--- linux-2.5-current/drivers/isdn/hisax/rawhdlc.c	Wed Feb 19 07:34:43 2003
+++ linux/drivers/isdn/hisax/rawhdlc.c	Wed Feb 19 14:03:22 2003
@@ -34,7 +34,7 @@
  * end-of-frame would occur), so the transmitter performs
  * "bit-stuffing" - inserting a zero bit after every five one bits,
  * irregardless of the original bit after the five ones.  Byte
- * ordering is irrelevent at this point - the data is treated as a
+ * ordering is irrelevant at this point - the data is treated as a
  * string of bits, not bytes.  Since no more than 5 ones may now occur
  * in a row, the flag sequence, with its 6 ones, is unique.
  *
diff -ur linux-2.5-current/drivers/serial/sa1100.c linux/drivers/serial/sa1100.c
--- linux-2.5-current/drivers/serial/sa1100.c	Wed Feb 19 07:34:42 2003
+++ linux/drivers/serial/sa1100.c	Wed Feb 19 14:03:22 2003
@@ -327,7 +327,7 @@
 			sa1100_rx_chars(sport, regs);
 		}
 
-		/* Clear the relevent break bits */
+		/* Clear the relevant break bits */
 		if (status & (UTSR0_RBB | UTSR0_REB))
 			UART_PUT_UTSR0(sport, status & (UTSR0_RBB | UTSR0_REB));
 
diff -ur linux-2.5-current/fs/adfs/dir_f.c linux/fs/adfs/dir_f.c
--- linux-2.5-current/fs/adfs/dir_f.c	Wed Feb 19 07:35:05 2003
+++ linux/fs/adfs/dir_f.c	Wed Feb 19 14:03:22 2003
@@ -259,7 +259,7 @@
 
 /*
  * get a directory entry.  Note that the caller is responsible
- * for holding the relevent locks.
+ * for holding the relevant locks.
  */
 int
 __adfs_dir_get(struct adfs_dir *dir, int pos, struct object_info *obj)
diff -ur linux-2.5-current/fs/afs/vnode.c linux/fs/afs/vnode.c
--- linux-2.5-current/fs/afs/vnode.c	Wed Feb 19 07:34:56 2003
+++ linux/fs/afs/vnode.c	Wed Feb 19 14:03:22 2003
@@ -272,7 +272,7 @@
 /*****************************************************************************/
 /*
  * break any outstanding callback on a vnode
- * - only relevent to server that issued it
+ * - only relevant to server that issued it
  */
 int afs_vnode_give_up_callback(afs_vnode_t *vnode)
 {
diff -ur linux-2.5-current/kernel/futex.c linux/kernel/futex.c
--- linux-2.5-current/kernel/futex.c	Wed Feb 19 07:34:50 2003
+++ linux/kernel/futex.c	Wed Feb 19 14:03:22 2003
@@ -39,7 +39,7 @@
 
 /*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
- * we can wake only the relevent ones (hashed queues may be shared):
+ * we can wake only the relevant ones (hashed queues may be shared):
  */
 struct futex_q {
 	struct list_head list;



