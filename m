Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272740AbTG1Iyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272743AbTG1Iyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:54:44 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:46309
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S272740AbTG1Iyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:54:38 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16164.59438.761414.665378@wombat.chubb.wattle.id.au>
Date: Mon, 28 Jul 2003 19:09:02 +1000
To: trivial@rustcorp.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix loose->lose typos in 2.6.0-test2
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I cringe every time I see `loose' used where `lose' is intended.
Here's a fix for the few that escaped the attentions of the spelling mafia...

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1595  -> 1.1596 
#	include/linux/securebits.h	1.2     -> 1.3    
#	drivers/scsi/arm/fas216.c	1.23    -> 1.24   
#	   drivers/char/sx.c	1.37    -> 1.38   
#	drivers/char/serial167.c	1.29    -> 1.30   
#	arch/alpha/kernel/time.c	1.20    -> 1.21   
#	drivers/scsi/sym53c8xx_comm.h	1.12    -> 1.13   
#	arch/mips/ddb5xxx/ddb5476/setup.c	1.3     -> 1.4    
#	drivers/scsi/sym53c8xx.c	1.39    -> 1.40   
#	drivers/net/irda/irport.c	1.20    -> 1.21   
#	arch/i386/kernel/timers/timer_tsc.c	1.22    -> 1.23   
#	drivers/block/elevator.c	1.49    -> 1.50   
#	drivers/usb/serial/ftdi_sio.c	1.45    -> 1.46   
#	      net/irda/qos.c	1.12    -> 1.13   
#	drivers/net/bonding/bond_main.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/28	peterc@gelato.unsw.edu.au	1.1596
# Spelling fix: Loose->Lose (remember: loose -> free; lose -> can't find, or come last)
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c	Mon Jul 28 14:18:43 2003
+++ b/arch/alpha/kernel/time.c	Mon Jul 28 14:18:43 2003
@@ -375,8 +375,8 @@
         wall_to_monotonic.tv_nsec = 0;
 
 	if (HZ > (1<<16)) {
-		extern void __you_loose (void);
-		__you_loose();
+		extern void __you_lose (void);
+		__you_lose();
 	}
 
 	state.last_time = cc1;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jul 28 14:18:43 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jul 28 14:18:43 2003
@@ -182,9 +182,9 @@
 	if (lost >= 2) {
 		jiffies += lost-1;
 
-		/* sanity check to ensure we're not always loosing ticks */
+		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
-			printk(KERN_WARNING "Loosing too many ticks!\n");
+			printk(KERN_WARNING "Losing too many ticks!\n");
 			printk(KERN_WARNING "TSC cannot be used as a timesource."
 					" (Are you running with SpeedStep?)\n");
 			printk(KERN_WARNING "Falling back to a sane timesource.\n");
diff -Nru a/arch/mips/ddb5xxx/ddb5476/setup.c b/arch/mips/ddb5xxx/ddb5476/setup.c
--- a/arch/mips/ddb5xxx/ddb5476/setup.c	Mon Jul 28 14:18:43 2003
+++ b/arch/mips/ddb5xxx/ddb5476/setup.c	Mon Jul 28 14:18:43 2003
@@ -232,7 +232,7 @@
 	ddb_set_pmr(DDB_PCIINIT1, DDB_PCICMD_MEM, DDB_PCI_MEM_BASE, DDB_PCI_ACCESS_32);
 
 	/* ----------- setup PDARs ------------ */
-	/* this is problematic - it will reset Aladin which cause we loose
+	/* this is problematic - it will reset Aladin which cause we lose
 	 * serial port, and we don't know how to set up Aladin chip again.
 	 */
 	// ddb_pci_reset_bus();
diff -Nru a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/block/elevator.c	Mon Jul 28 14:18:43 2003
@@ -20,7 +20,7 @@
  *
  * Jens:
  * - Rework again to work with bio instead of buffer_heads
- * - loose bi_dev comparisons, partition handling is right now
+ * - lose bi_dev comparisons, partition handling is right now
  * - completely modularize elevator setup and teardown
  *
  */
diff -Nru a/drivers/char/serial167.c b/drivers/char/serial167.c
--- a/drivers/char/serial167.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/char/serial167.c	Mon Jul 28 14:18:43 2003
@@ -451,7 +451,7 @@
 		    *tty->flip.char_buf_ptr++ = 0;
 		    /*
 		       If the flip buffer itself is
-		       overflowing, we still loose
+		       overflowing, we still lose
 		       the next incoming character.
 		     */
 		    if(tty->flip.count < TTY_FLIPBUF_SIZE){
diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/char/sx.c	Mon Jul 28 14:18:43 2003
@@ -166,7 +166,7 @@
  * cleanup. Not good.
  *
  * Revision 0.10  1999/03/28 08:09:43  wolff
- * Fixed loosing characters on close.
+ * Fixed losing characters on close.
  *
  * Revision 0.9  1999/03/21 22:52:01  wolff
  * Ported back to 2.2.... (minor things)
diff -Nru a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/net/bonding/bond_main.c	Mon Jul 28 14:18:43 2003
@@ -362,7 +362,7 @@
  *	  so specific modes can take actions when the primary adapter is
  *	  changed.
  *	- Take the updelay parameter into consideration during bond_enslave
- *	  since some adapters loose their link during setting the device.
+ *	  since some adapters lose their link during setting the device.
  *	- Renamed bond_3ad_link_status_changed() to
  *	  bond_3ad_handle_link_change() for compatibility with TLB.
  *	  new version - 2.1.0
diff -Nru a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
--- a/drivers/net/irda/irport.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/net/irda/irport.c	Mon Jul 28 14:18:43 2003
@@ -724,7 +724,7 @@
  *
  * Called only from irport_interrupt()
  * Make sure this function is *not* called while we are receiving,
- * otherwise we will reset fifo and loose data :-(
+ * otherwise we will reset fifo and lose data :-(
  */
 static inline void irport_write_wakeup(struct irport_cb *self)
 {
diff -Nru a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
--- a/drivers/scsi/arm/fas216.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/scsi/arm/fas216.c	Mon Jul 28 14:18:43 2003
@@ -2132,7 +2132,7 @@
 	 * executed, unless a target connects to us.
 	 */
 	if (info->reqSCpnt)
-		printk(KERN_WARNING "scsi%d.%c: loosing request command\n",
+		printk(KERN_WARNING "scsi%d.%c: losing request command\n",
 			info->host->host_no, '0' + SCpnt->device->id);
 	info->reqSCpnt = SCpnt;
 }
diff -Nru a/drivers/scsi/sym53c8xx.c b/drivers/scsi/sym53c8xx.c
--- a/drivers/scsi/sym53c8xx.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/scsi/sym53c8xx.c	Mon Jul 28 14:18:43 2003
@@ -619,7 +619,7 @@
 **	use several SCSI adapters, we are using one lock per controller 
 **	instead of some global one. For the moment (linux-2.1.95), driver's 
 **	entry points are called with the 'io_request_lock' lock held, so:
-**	- We are uselessly loosing a couple of micro-seconds to lock the 
+**	- We are uselessly losing a couple of micro-seconds to lock the 
 **	  controller data structure.
 **	- But the driver is not broken by design for SMP and so can be 
 **	  more resistant to bugs or bad changes in the IO sub-system code.
diff -Nru a/drivers/scsi/sym53c8xx_comm.h b/drivers/scsi/sym53c8xx_comm.h
--- a/drivers/scsi/sym53c8xx_comm.h	Mon Jul 28 14:18:43 2003
+++ b/drivers/scsi/sym53c8xx_comm.h	Mon Jul 28 14:18:43 2003
@@ -417,7 +417,7 @@
 **	one. For the moment (linux-2.1.95), driver's entry 
 **	points are called with the 'io_request_lock' lock 
 **	held, so:
-**	- We are uselessly loosing a couple of micro-seconds 
+**	- We are uselessly losing a couple of micro-seconds 
 **	  to lock the controller data structure.
 **	- But the driver is not broken by design for SMP and 
 **	  so can be more resistant to bugs or bad changes in 
diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Mon Jul 28 14:18:43 2003
+++ b/drivers/usb/serial/ftdi_sio.c	Mon Jul 28 14:18:43 2003
@@ -1152,7 +1152,7 @@
 			0, buf, 0, WDR_TIMEOUT);
 
 	/* Termios defaults are set by usb_serial_init. We don't change
-	   port->tty->termios - this would loose speed settings, etc.
+	   port->tty->termios - this would lose speed settings, etc.
 	   This is same behaviour as serial.c/rs_open() - Kuba */
 
 	/* ftdi_set_termios  will send usb control messages */
diff -Nru a/include/linux/securebits.h b/include/linux/securebits.h
--- a/include/linux/securebits.h	Mon Jul 28 14:18:43 2003
+++ b/include/linux/securebits.h	Mon Jul 28 14:18:43 2003
@@ -14,7 +14,7 @@
 #define SECURE_NOROOT            0
 
 /* When set, setuid to/from uid 0 does not trigger capability-"fixes"
-   to be compatible with old programs relying on set*uid to loose
+   to be compatible with old programs relying on set*uid to lose
    privileges. When unset, setuid doesn't change privileges. */
 #define SECURE_NO_SETUID_FIXUP   2
 
diff -Nru a/net/irda/qos.c b/net/irda/qos.c
--- a/net/irda/qos.c	Mon Jul 28 14:18:43 2003
+++ b/net/irda/qos.c	Mon Jul 28 14:18:43 2003
@@ -417,7 +417,7 @@
 	 * Fix tx data size according to user limits - Jean II
 	 */
 	if (qos->data_size.value > sysctl_max_tx_data_size)
-		/* Allow non discrete adjustement to avoid loosing capacity */
+		/* Allow non discrete adjustement to avoid losing capacity */
 		qos->data_size.value = sysctl_max_tx_data_size;
 	/*
 	 * Override Tx window if user request it. - Jean II
