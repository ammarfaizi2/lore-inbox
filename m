Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWF1Q6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWF1Q6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWF1Qz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43524 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751456AbWF1QzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:15 -0400
Date: Wed, 28 Jun 2006 18:55:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes: occuring -> occurring
Message-ID: <20060628165514.GB13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-list-2.6.txt           |    2 +-
 Documentation/memory-barriers.txt            |    2 +-
 arch/i386/mm/fault.c                         |    2 +-
 arch/m32r/mm/fault.c                         |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |    2 +-
 arch/powerpc/platforms/pseries/eeh_driver.c  |    2 +-
 arch/x86_64/mm/fault.c                       |    2 +-
 drivers/infiniband/hw/ipath/ipath_intr.c     |    2 +-
 drivers/message/fusion/mptbase.c             |    2 +-
 drivers/net/wireless/ipw2100.c               |    2 +-
 drivers/serial/pxa.c                         |    2 +-
 include/asm-arm/thread_info.h                |    2 +-
 include/asm-ia64/sn/tioca_provider.h         |    2 +-
 kernel/cpuset.c                              |    2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

--- linux-2.6.17-mm3-full/Documentation/memory-barriers.txt.old	2006-06-27 20:47:07.000000000 +0200
+++ linux-2.6.17-mm3-full/Documentation/memory-barriers.txt	2006-06-27 20:47:19.000000000 +0200
@@ -602,7 +602,7 @@
 
 This sequence of events is committed to the memory coherence system in an order
 that the rest of the system might perceive as the unordered set of { STORE A,
-STORE B, STORE C } all occuring before the unordered set of { STORE D, STORE E
+STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 }:
 
 	+-------+       :      :
--- linux-2.6.17-mm3-full/Documentation/feature-list-2.6.txt.old	2006-06-27 20:47:29.000000000 +0200
+++ linux-2.6.17-mm3-full/Documentation/feature-list-2.6.txt	2006-06-27 20:47:32.000000000 +0200
@@ -963,7 +963,7 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 The machine check handler has been extended so that it regularly polls
 for any problems on AMD Athlon, and Intel Pentium 4 systems.
-This may result in machine check exceptions occuring more frequently
+This may result in machine check exceptions occurring more frequently
 than they did in 2.4 on out of spec systems (Overclocking/inadequate
 cooling/underated PSU etc..).
 
--- linux-2.6.17-mm3-full/arch/i386/mm/fault.c.old	2006-06-27 20:47:40.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/i386/mm/fault.c	2006-06-27 20:47:46.000000000 +0200
@@ -389,7 +389,7 @@
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
-	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * erroneous fault occurring in a code path which already holds mmap_sem
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
--- linux-2.6.17-mm3-full/arch/m32r/mm/fault.c.old	2006-06-27 20:47:53.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/m32r/mm/fault.c	2006-06-27 20:47:57.000000000 +0200
@@ -148,7 +148,7 @@
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
-	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * erroneous fault occurring in a code path which already holds mmap_sem
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
--- linux-2.6.17-mm3-full/arch/powerpc/platforms/powermac/cpufreq_32.c.old	2006-06-27 20:48:05.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/powerpc/platforms/powermac/cpufreq_32.c	2006-06-27 20:48:08.000000000 +0200
@@ -268,7 +268,7 @@
 
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	/* Make sure any pending DEC interrupt occuring while we did
+	/* Make sure any pending DEC interrupt occurring while we did
 	 * the above didn't re-enable the DEC */
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
--- linux-2.6.17-mm3-full/arch/powerpc/platforms/pseries/eeh_driver.c.old	2006-06-27 20:48:15.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/powerpc/platforms/pseries/eeh_driver.c	2006-06-27 20:48:18.000000000 +0200
@@ -175,7 +175,7 @@
  *
  * pSeries systems will isolate a PCI slot if the PCI-Host
  * bridge detects address or data parity errors, DMA's
- * occuring to wild addresses (which usually happen due to
+ * occurring to wild addresses (which usually happen due to
  * bugs in device drivers or in PCI adapter firmware).
  * Slot isolations also occur if #SERR, #PERR or other misc
  * PCI-related errors are detected.
--- linux-2.6.17-mm3-full/arch/x86_64/mm/fault.c.old	2006-06-27 20:48:27.000000000 +0200
+++ linux-2.6.17-mm3-full/arch/x86_64/mm/fault.c	2006-06-27 20:48:42.000000000 +0200
@@ -418,7 +418,7 @@
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
-	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * erroneous fault occurring in a code path which already holds mmap_sem
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
--- linux-2.6.17-mm3-full/drivers/infiniband/hw/ipath/ipath_intr.c.old	2006-06-27 20:48:51.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/infiniband/hw/ipath/ipath_intr.c	2006-06-27 20:48:55.000000000 +0200
@@ -397,7 +397,7 @@
 		if ((dd->ipath_maskederrs & ~dd->ipath_ignorederrs) &
 		    ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL))
 			ipath_dev_err(dd, "Disabling error(s) %llx because "
-				      "occuring too frequently (%s)\n",
+				      "occurring too frequently (%s)\n",
 				      (unsigned long long)
 				      (dd->ipath_maskederrs &
 				       ~dd->ipath_ignorederrs), msg);
--- linux-2.6.17-mm3-full/drivers/message/fusion/mptbase.c.old	2006-06-27 20:49:02.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/message/fusion/mptbase.c	2006-06-27 20:49:06.000000000 +0200
@@ -5593,7 +5593,7 @@
 
 	/* The SCSI driver needs to adjust timeouts on all current
 	 * commands prior to the diagnostic reset being issued.
-	 * Prevents timeouts occuring during a diagnostic reset...very bad.
+	 * Prevents timeouts occurring during a diagnostic reset...very bad.
 	 * For all other protocol drivers, this is a no-op.
 	 */
 	{
--- linux-2.6.17-mm3-full/drivers/net/wireless/ipw2100.c.old	2006-06-27 20:49:14.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/net/wireless/ipw2100.c	2006-06-27 20:49:18.000000000 +0200
@@ -5358,7 +5358,7 @@
 		     idx, keylen, len);
 
 	/* NOTE: We don't check cached values in case the firmware was reset
-	 * or some other problem is occuring.  If the user is setting the key,
+	 * or some other problem is occurring.  If the user is setting the key,
 	 * then we push the change */
 
 	wep_key->idx = idx;
--- linux-2.6.17-mm3-full/drivers/serial/pxa.c.old	2006-06-27 20:49:25.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/serial/pxa.c	2006-06-27 20:49:28.000000000 +0200
@@ -390,7 +390,7 @@
 
 	/*
 	 * Finally, enable interrupts.  Note: Modem status interrupts
-	 * are set via set_termios(), which will be occuring imminently
+	 * are set via set_termios(), which will be occurring imminently
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI | UART_IER_RTOIE | UART_IER_UUE;
--- linux-2.6.17-mm3-full/include/asm-arm/thread_info.h.old	2006-06-27 20:49:35.000000000 +0200
+++ linux-2.6.17-mm3-full/include/asm-arm/thread_info.h	2006-06-27 20:49:38.000000000 +0200
@@ -110,7 +110,7 @@
 
 /*
  * We use bit 30 of the preempt_count to indicate that kernel
- * preemption is occuring.  See include/asm-arm/hardirq.h.
+ * preemption is occurring.  See include/asm-arm/hardirq.h.
  */
 #define PREEMPT_ACTIVE	0x40000000
 
--- linux-2.6.17-mm3-full/include/asm-ia64/sn/tioca_provider.h.old	2006-06-27 20:49:45.000000000 +0200
+++ linux-2.6.17-mm3-full/include/asm-ia64/sn/tioca_provider.h	2006-06-27 20:49:49.000000000 +0200
@@ -27,7 +27,7 @@
 #define PV908234 (1 << 1)
   /* CA:AGPDMA write request data mismatch with ABC1CL merge */
 #define PV895469 (1 << 1)
-  /* TIO:CA TLB invalidate of written GART entries possibly not occuring in CA*/
+  /* TIO:CA TLB invalidate of written GART entries possibly not occurring in CA*/
 #define PV910244 (1 << 1)
 
 struct tioca_dmamap{
--- linux-2.6.17-mm3-full/kernel/cpuset.c.old	2006-06-27 20:50:01.000000000 +0200
+++ linux-2.6.17-mm3-full/kernel/cpuset.c	2006-06-27 20:50:05.000000000 +0200
@@ -1064,7 +1064,7 @@
 }
 
 /*
- * Frequency meter - How fast is some event occuring?
+ * Frequency meter - How fast is some event occurring?
  *
  * These routines manage a digitally filtered, constant time based,
  * event frequency meter.  There are four routines:

