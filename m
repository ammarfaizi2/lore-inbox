Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVADE6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVADE6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVADE5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:57:52 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:33480 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262047AbVADEp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:45:27 -0500
Date: Tue, 4 Jan 2005 15:40:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] PPC64: move the lppaca defining header file
Message-Id: <20050104154025.63a1b9fb.sfr@canb.auug.org.au>
In-Reply-To: <20050104153740.56622b4f.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
	<20050104153445.3777e689.sfr@canb.auug.org.au>
	<20050104153740.56622b4f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_40_25_+1100_jC0Odqm3HrrplwOF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_40_25_+1100_jC0Odqm3HrrplwOF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just renames asm/iSeries/ItLpPaca.h to asm/lppaca.h as the
lppaca structure is no longer just legacy iSeries specific.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.9/arch/ppc64/kernel/LparData.c linus-bk-naca.10/arch/ppc64/kernel/LparData.c
--- linus-bk-naca.9/arch/ppc64/kernel/LparData.c	2004-12-11 02:49:48.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/LparData.c	2004-12-13 15:01:55.000000000 +1100
@@ -16,7 +16,7 @@
 #include <asm/naca.h>
 #include <asm/abs_addr.h>
 #include <asm/iSeries/ItLpNaca.h>
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 #include <asm/iSeries/ItLpRegSave.h>
 #include <asm/paca.h>
 #include <asm/iSeries/HvReleaseData.h>
diff -ruN linus-bk-naca.9/arch/ppc64/kernel/asm-offsets.c linus-bk-naca.10/arch/ppc64/kernel/asm-offsets.c
--- linus-bk-naca.9/arch/ppc64/kernel/asm-offsets.c	2004-12-10 17:27:14.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/asm-offsets.c	2004-12-13 15:02:03.000000000 +1100
@@ -29,7 +29,7 @@
 #include <asm/processor.h>
 
 #include <asm/paca.h>
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/rtas.h>
diff -ruN linus-bk-naca.9/arch/ppc64/kernel/iSeries_proc.c linus-bk-naca.10/arch/ppc64/kernel/iSeries_proc.c
--- linus-bk-naca.9/arch/ppc64/kernel/iSeries_proc.c	2004-12-10 16:26:54.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/iSeries_proc.c	2004-12-13 15:02:14.000000000 +1100
@@ -24,7 +24,7 @@
 #include <asm/paca.h>
 #include <asm/processor.h>
 #include <asm/time.h>
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvCallXm.h>
 #include <asm/iSeries/IoHriMainStore.h>
diff -ruN linus-bk-naca.9/arch/ppc64/kernel/lparcfg.c linus-bk-naca.10/arch/ppc64/kernel/lparcfg.c
--- linus-bk-naca.9/arch/ppc64/kernel/lparcfg.c	2004-11-20 12:05:26.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/lparcfg.c	2004-12-13 15:02:29.000000000 +1100
@@ -27,7 +27,7 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <asm/iSeries/HvLpConfig.h>
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 #include <asm/iSeries/LparData.h>
 #include <asm/hvcall.h>
 #include <asm/cputable.h>
diff -ruN linus-bk-naca.9/arch/ppc64/kernel/pacaData.c linus-bk-naca.10/arch/ppc64/kernel/pacaData.c
--- linus-bk-naca.9/arch/ppc64/kernel/pacaData.c	2004-12-11 02:50:23.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/pacaData.c	2004-12-13 15:02:07.000000000 +1100
@@ -16,7 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/paca.h>
 
diff -ruN linus-bk-naca.9/arch/ppc64/kernel/sysfs.c linus-bk-naca.10/arch/ppc64/kernel/sysfs.c
--- linus-bk-naca.9/arch/ppc64/kernel/sysfs.c	2004-12-13 14:49:37.000000000 +1100
+++ linus-bk-naca.10/arch/ppc64/kernel/sysfs.c	2004-12-13 15:01:19.000000000 +1100
@@ -15,7 +15,7 @@
 #include <asm/prom.h>
 #include <asm/systemcfg.h>
 #include <asm/paca.h>
-#include <asm/iSeries/ItLpPaca.h>
+#include <asm/lppaca.h>
 
 
 /* SMT stuff */
diff -ruN linus-bk-naca.9/include/asm-ppc64/iSeries/ItLpPaca.h linus-bk-naca.10/include/asm-ppc64/iSeries/ItLpPaca.h
--- linus-bk-naca.9/include/asm-ppc64/iSeries/ItLpPaca.h	2004-01-20 08:20:26.000000000 +1100
+++ linus-bk-naca.10/include/asm-ppc64/iSeries/ItLpPaca.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,134 +0,0 @@
-/*
- * ItLpPaca.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _ITLPPACA_H
-#define _ITLPPACA_H
-
-//=============================================================================
-//                                   
-//	This control block contains the data that is shared between the 
-//	hypervisor (PLIC) and the OS.
-//    
-//
-//----------------------------------------------------------------------------
-#include <asm/types.h>
-
-struct ItLpPaca
-{
-//=============================================================================
-// CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
-// NOTE: The xDynXyz fields are fields that will be dynamically changed by 
-// PLIC when preparing to bring a processor online or when dispatching a 
-// virtual processor!
-//=============================================================================
-	u32	xDesc;			// Eye catcher 0xD397D781	x00-x03
-	u16	xSize;			// Size of this struct		x04-x05
-	u16	xRsvd1_0;		// Reserved			x06-x07
-	u16	xRsvd1_1:14;		// Reserved			x08-x09
-	u8	xSharedProc:1;		// Shared processor indicator	...
-	u8	xSecondaryThread:1;	// Secondary thread indicator	...
-	volatile u8 xDynProcStatus:8;	// Dynamic Status of this proc	x0A-x0A
-	u8	xSecondaryThreadCnt;	// Secondary thread count	x0B-x0B
-	volatile u16 xDynHvPhysicalProcIndex;// Dynamic HV Physical Proc Index0C-x0D
-	volatile u16 xDynHvLogicalProcIndex;// Dynamic HV Logical Proc Indexx0E-x0F
-	u32	xDecrVal;   		// Value for Decr programming 	x10-x13
-	u32	xPMCVal;       		// Value for PMC regs         	x14-x17
-	volatile u32 xDynHwNodeId;	// Dynamic Hardware Node id	x18-x1B
-	volatile u32 xDynHwProcId;	// Dynamic Hardware Proc Id	x1C-x1F
-	volatile u32 xDynPIR;		// Dynamic ProcIdReg value	x20-x23
-	u32	xDseiData;           	// DSEI data                  	x24-x27
-	u64	xSPRG3;               	// SPRG3 value                	x28-x2F
-	u8	xRsvd1_3[80];		// Reserved			x30-x7F
-   
-//=============================================================================
-// CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
-//=============================================================================
-	// This Dword contains a byte for each type of interrupt that can occur.  
-	// The IPI is a count while the others are just a binary 1 or 0.
-	union {
-		u64	xAnyInt;
-		struct {
-			u16	xRsvd;		// Reserved - cleared by #mpasmbl
-			u8	xXirrInt;	// Indicates xXirrValue is valid or Immed IO
-			u8	xIpiCnt;	// IPI Count
-			u8	xDecrInt;	// DECR interrupt occurred
-			u8	xPdcInt;	// PDC interrupt occurred
-			u8	xQuantumInt;	// Interrupt quantum reached
-			u8	xOldPlicDeferredExtInt;	// Old PLIC has a deferred XIRR pending
-		} xFields;
-	} xIntDword;
-
-	// Whenever any fields in this Dword are set then PLIC will defer the 
-	// processing of external interrupts.  Note that PLIC will store the 
-	// XIRR directly into the xXirrValue field so that another XIRR will 
-	// not be presented until this one clears.  The layout of the low 
-	// 4-bytes of this Dword is upto SLIC - PLIC just checks whether the 
-	// entire Dword is zero or not.  A non-zero value in the low order 
-	// 2-bytes will result in SLIC being granted the highest thread 
-	// priority upon return.  A 0 will return to SLIC as medium priority.
-	u64	xPlicDeferIntsArea;	// Entire Dword
-
-	// Used to pass the real SRR0/1 from PLIC to SLIC as well as to 
-	// pass the target SRR0/1 from SLIC to PLIC on a SetAsrAndRfid.
-	u64     xSavedSrr0;             // Saved SRR0                   x10-x17
-	u64     xSavedSrr1;             // Saved SRR1                   x18-x1F
-
-	// Used to pass parms from the OS to PLIC for SetAsrAndRfid
-	u64     xSavedGpr3;             // Saved GPR3                   x20-x27
-	u64     xSavedGpr4;             // Saved GPR4                   x28-x2F
-	u64     xSavedGpr5;             // Saved GPR5                   x30-x37
-
-	u8	xRsvd2_1;		// Reserved			x38-x38
-	u8      xCpuCtlsTaskAttributes; // Task attributes for cpuctls  x39-x39
-	u8      xFPRegsInUse;           // FP regs in use               x3A-x3A
-	u8      xPMCRegsInUse;          // PMC regs in use              x3B-x3B
-	volatile u32  xSavedDecr;	// Saved Decr Value             x3C-x3F
-	volatile u64  xEmulatedTimeBase;// Emulated TB for this thread  x40-x47
-	volatile u64  xCurPLICLatency;	// Unaccounted PLIC latency     x48-x4F
-	u64     xTotPLICLatency;        // Accumulated PLIC latency     x50-x57   
-	u64     xWaitStateCycles;       // Wait cycles for this proc    x58-x5F
-	u64     xEndOfQuantum;          // TB at end of quantum         x60-x67
-	u64     xPDCSavedSPRG1;         // Saved SPRG1 for PMC int      x68-x6F
-	u64     xPDCSavedSRR0;          // Saved SRR0 for PMC int       x70-x77
-	volatile u32 xVirtualDecr;	// Virtual DECR for shared procsx78-x7B
-	u16     xSLBCount;              // # of SLBs to maintain        x7C-x7D
-	u8      xIdle;                  // Indicate OS is idle          x7E
-	u8      xRsvd2_2;               // Reserved                     x7F
-
-
-//=============================================================================
-// CACHE_LINE_3 0x0100 - 0x007F: This line is shared with other processors
-//=============================================================================
-	// This is the xYieldCount.  An "odd" value (low bit on) means that 
-	// the processor is yielded (either because of an OS yield or a PLIC 
-	// preempt).  An even value implies that the processor is currently 
-	// executing.
-	// NOTE: This value will ALWAYS be zero for dedicated processors and 
-	// will NEVER be zero for shared processors (ie, initialized to a 1).
-	volatile u32 xYieldCount;	// PLIC increments each dispatchx00-x03
-	u8	xRsvd3_0[124];		// Reserved                     x04-x7F         
-
-//=============================================================================
-// CACHE_LINE_4-5 0x0100 - 0x01FF Contains PMC interrupt data
-//=============================================================================
-	u8      xPmcSaveArea[256];	// PMC interrupt Area           x00-xFF
-
-
-};
-
-#endif /* _ITLPPACA_H */
diff -ruN linus-bk-naca.9/include/asm-ppc64/iSeries/LparData.h linus-bk-naca.10/include/asm-ppc64/iSeries/LparData.h
--- linus-bk-naca.9/include/asm-ppc64/iSeries/LparData.h	2004-12-10 16:26:54.000000000 +1100
+++ linus-bk-naca.10/include/asm-ppc64/iSeries/LparData.h	2004-12-13 15:03:03.000000000 +1100
@@ -25,7 +25,6 @@
 #include <asm/abs_addr.h>
 
 #include <asm/iSeries/ItLpNaca.h>
-#include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpRegSave.h>
 #include <asm/iSeries/HvReleaseData.h>
 #include <asm/iSeries/LparMap.h>
diff -ruN linus-bk-naca.9/include/asm-ppc64/lppaca.h linus-bk-naca.10/include/asm-ppc64/lppaca.h
--- linus-bk-naca.9/include/asm-ppc64/lppaca.h	1970-01-01 10:00:00.000000000 +1000
+++ linus-bk-naca.10/include/asm-ppc64/lppaca.h	2004-12-13 15:04:43.000000000 +1100
@@ -0,0 +1,134 @@
+/*
+ * lppaca.h
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ASM_LPPACA_H
+#define _ASM_LPPACA_H
+
+//=============================================================================
+//                                   
+//	This control block contains the data that is shared between the 
+//	hypervisor (PLIC) and the OS.
+//    
+//
+//----------------------------------------------------------------------------
+#include <asm/types.h>
+
+struct ItLpPaca
+{
+//=============================================================================
+// CACHE_LINE_1 0x0000 - 0x007F Contains read-only data
+// NOTE: The xDynXyz fields are fields that will be dynamically changed by 
+// PLIC when preparing to bring a processor online or when dispatching a 
+// virtual processor!
+//=============================================================================
+	u32	xDesc;			// Eye catcher 0xD397D781	x00-x03
+	u16	xSize;			// Size of this struct		x04-x05
+	u16	xRsvd1_0;		// Reserved			x06-x07
+	u16	xRsvd1_1:14;		// Reserved			x08-x09
+	u8	xSharedProc:1;		// Shared processor indicator	...
+	u8	xSecondaryThread:1;	// Secondary thread indicator	...
+	volatile u8 xDynProcStatus:8;	// Dynamic Status of this proc	x0A-x0A
+	u8	xSecondaryThreadCnt;	// Secondary thread count	x0B-x0B
+	volatile u16 xDynHvPhysicalProcIndex;// Dynamic HV Physical Proc Index0C-x0D
+	volatile u16 xDynHvLogicalProcIndex;// Dynamic HV Logical Proc Indexx0E-x0F
+	u32	xDecrVal;   		// Value for Decr programming 	x10-x13
+	u32	xPMCVal;       		// Value for PMC regs         	x14-x17
+	volatile u32 xDynHwNodeId;	// Dynamic Hardware Node id	x18-x1B
+	volatile u32 xDynHwProcId;	// Dynamic Hardware Proc Id	x1C-x1F
+	volatile u32 xDynPIR;		// Dynamic ProcIdReg value	x20-x23
+	u32	xDseiData;           	// DSEI data                  	x24-x27
+	u64	xSPRG3;               	// SPRG3 value                	x28-x2F
+	u8	xRsvd1_3[80];		// Reserved			x30-x7F
+   
+//=============================================================================
+// CACHE_LINE_2 0x0080 - 0x00FF Contains local read-write data
+//=============================================================================
+	// This Dword contains a byte for each type of interrupt that can occur.  
+	// The IPI is a count while the others are just a binary 1 or 0.
+	union {
+		u64	xAnyInt;
+		struct {
+			u16	xRsvd;		// Reserved - cleared by #mpasmbl
+			u8	xXirrInt;	// Indicates xXirrValue is valid or Immed IO
+			u8	xIpiCnt;	// IPI Count
+			u8	xDecrInt;	// DECR interrupt occurred
+			u8	xPdcInt;	// PDC interrupt occurred
+			u8	xQuantumInt;	// Interrupt quantum reached
+			u8	xOldPlicDeferredExtInt;	// Old PLIC has a deferred XIRR pending
+		} xFields;
+	} xIntDword;
+
+	// Whenever any fields in this Dword are set then PLIC will defer the 
+	// processing of external interrupts.  Note that PLIC will store the 
+	// XIRR directly into the xXirrValue field so that another XIRR will 
+	// not be presented until this one clears.  The layout of the low 
+	// 4-bytes of this Dword is upto SLIC - PLIC just checks whether the 
+	// entire Dword is zero or not.  A non-zero value in the low order 
+	// 2-bytes will result in SLIC being granted the highest thread 
+	// priority upon return.  A 0 will return to SLIC as medium priority.
+	u64	xPlicDeferIntsArea;	// Entire Dword
+
+	// Used to pass the real SRR0/1 from PLIC to SLIC as well as to 
+	// pass the target SRR0/1 from SLIC to PLIC on a SetAsrAndRfid.
+	u64     xSavedSrr0;             // Saved SRR0                   x10-x17
+	u64     xSavedSrr1;             // Saved SRR1                   x18-x1F
+
+	// Used to pass parms from the OS to PLIC for SetAsrAndRfid
+	u64     xSavedGpr3;             // Saved GPR3                   x20-x27
+	u64     xSavedGpr4;             // Saved GPR4                   x28-x2F
+	u64     xSavedGpr5;             // Saved GPR5                   x30-x37
+
+	u8	xRsvd2_1;		// Reserved			x38-x38
+	u8      xCpuCtlsTaskAttributes; // Task attributes for cpuctls  x39-x39
+	u8      xFPRegsInUse;           // FP regs in use               x3A-x3A
+	u8      xPMCRegsInUse;          // PMC regs in use              x3B-x3B
+	volatile u32  xSavedDecr;	// Saved Decr Value             x3C-x3F
+	volatile u64  xEmulatedTimeBase;// Emulated TB for this thread  x40-x47
+	volatile u64  xCurPLICLatency;	// Unaccounted PLIC latency     x48-x4F
+	u64     xTotPLICLatency;        // Accumulated PLIC latency     x50-x57   
+	u64     xWaitStateCycles;       // Wait cycles for this proc    x58-x5F
+	u64     xEndOfQuantum;          // TB at end of quantum         x60-x67
+	u64     xPDCSavedSPRG1;         // Saved SPRG1 for PMC int      x68-x6F
+	u64     xPDCSavedSRR0;          // Saved SRR0 for PMC int       x70-x77
+	volatile u32 xVirtualDecr;	// Virtual DECR for shared procsx78-x7B
+	u16     xSLBCount;              // # of SLBs to maintain        x7C-x7D
+	u8      xIdle;                  // Indicate OS is idle          x7E
+	u8      xRsvd2_2;               // Reserved                     x7F
+
+
+//=============================================================================
+// CACHE_LINE_3 0x0100 - 0x007F: This line is shared with other processors
+//=============================================================================
+	// This is the xYieldCount.  An "odd" value (low bit on) means that 
+	// the processor is yielded (either because of an OS yield or a PLIC 
+	// preempt).  An even value implies that the processor is currently 
+	// executing.
+	// NOTE: This value will ALWAYS be zero for dedicated processors and 
+	// will NEVER be zero for shared processors (ie, initialized to a 1).
+	volatile u32 xYieldCount;	// PLIC increments each dispatchx00-x03
+	u8	xRsvd3_0[124];		// Reserved                     x04-x7F         
+
+//=============================================================================
+// CACHE_LINE_4-5 0x0100 - 0x01FF Contains PMC interrupt data
+//=============================================================================
+	u8      xPmcSaveArea[256];	// PMC interrupt Area           x00-xFF
+
+
+};
+
+#endif /* _ASM_LPPACA_H */
diff -ruN linus-bk-naca.9/include/asm-ppc64/paca.h linus-bk-naca.10/include/asm-ppc64/paca.h
--- linus-bk-naca.9/include/asm-ppc64/paca.h	2004-12-13 18:05:08.000000000 +1100
+++ linus-bk-naca.10/include/asm-ppc64/paca.h	2004-12-31 15:48:57.000000000 +1100
@@ -18,7 +18,7 @@
 
 #include	<linux/config.h>
 #include	<asm/types.h>
-#include	<asm/iSeries/ItLpPaca.h>
+#include	<asm/lppaca.h>
 #include	<asm/iSeries/ItLpRegSave.h>
 #include	<asm/mmu.h>
 

--Signature=_Tue__4_Jan_2005_15_40_25_+1100_jC0Odqm3HrrplwOF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2h454CJfqux9a+8RAlaPAKCDaO4M94ii7qKFs+qLMTigO4H55wCgmMqo
qQ5sJqRYXjHDHo+yjfDAaSY=
=Axb1
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_40_25_+1100_jC0Odqm3HrrplwOF--
