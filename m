Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSK1Q0P>; Thu, 28 Nov 2002 11:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSK1Q0P>; Thu, 28 Nov 2002 11:26:15 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:3087 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S265578AbSK1Q0M>; Thu, 28 Nov 2002 11:26:12 -0500
Date: Fri, 29 Nov 2002 03:32:17 +1100
From: john slee <indigoid@higherplane.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix various mutations of "definite" and "the"
Message-ID: <20021128163217.GA11504@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

relative to current 2.5 bk tree.

diff -Nru a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
--- a/arch/m68k/mac/iop.c	Fri Nov 29 03:34:51 2002
+++ b/arch/m68k/mac/iop.c	Fri Nov 29 03:34:51 2002
@@ -28,7 +28,7 @@
  *		  globally-visible functions take an IOP number instead of an
  *		  an actual base address.
  * 990610 (jmt) - Finished the message passing framework and it seems to work.
- *		  Sending _definately_ works; my adb-bus.c mods can send
+ *		  Sending _definitely_ works; my adb-bus.c mods can send
  *		  messages and receive the MSG_COMPLETED status back from the
  *		  IOP. The trick now is figuring out the message formats.
  * 990611 (jmt) - More cleanups. Fixed problem where unclaimed messages on a
diff -Nru a/drivers/scsi/NCR53C9x.c b/drivers/scsi/NCR53C9x.c
--- a/drivers/scsi/NCR53C9x.c	Fri Nov 29 03:34:51 2002
+++ b/drivers/scsi/NCR53C9x.c	Fri Nov 29 03:34:51 2002
@@ -1180,7 +1180,7 @@
 		 *           ID bit on the data bus even though the ESP is
 		 *           at ID 7 and is the obvious winner for any
 		 *           arbitration.  The ESP is a poor sport and refuses
-		 *           to lose arbitration, it will continue indefinately
+		 *           to lose arbitration, it will continue indefinitely
 		 *           trying to arbitrate for the bus and can only be
 		 *           stopped via a chip reset or SCSI bus reset.
 		 *           Therefore _no_ disconnects for SCSI1 targets
diff -Nru a/drivers/scsi/esp.c b/drivers/scsi/esp.c
--- a/drivers/scsi/esp.c	Fri Nov 29 03:34:51 2002
+++ b/drivers/scsi/esp.c	Fri Nov 29 03:34:51 2002
@@ -1720,7 +1720,7 @@
 		 *           ID bit on the data bus even though the ESP is
 		 *           at ID 7 and is the obvious winner for any
 		 *           arbitration.  The ESP is a poor sport and refuses
-		 *           to lose arbitration, it will continue indefinately
+		 *           to lose arbitration, it will continue indefinitely
 		 *           trying to arbitrate for the bus and can only be
 		 *           stopped via a chip reset or SCSI bus reset.
 		 *           Therefore _no_ disconnects for SCSI1 targets
diff -Nru a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
--- a/fs/jfs/jfs_txnmgr.c	Fri Nov 29 03:34:51 2002
+++ b/fs/jfs/jfs_txnmgr.c	Fri Nov 29 03:34:51 2002
@@ -2829,7 +2829,7 @@
 			txLazyCommit(tblk);
 
 			/*
-			 * We can be running indefinately if other processors
+			 * We can be running indefinitely if other processors
 			 * are adding transactions to this list
 			 */
 			cond_resched();
diff -Nru a/include/asm-ia64/sn/sv.h b/include/asm-ia64/sn/sv.h
--- a/include/asm-ia64/sn/sv.h	Fri Nov 29 03:34:51 2002
+++ b/include/asm-ia64/sn/sv.h	Fri Nov 29 03:34:51 2002
@@ -99,7 +99,7 @@
  * Set SV_WAIT_SIG in sv_wait_flags to let the sv_wait be interrupted by signals.
  *
  * timeout is how long to wait before giving up, or 0 to wait
- * indefinately.  It is given in jiffies, and is relative.
+ * indefinitely.  It is given in jiffies, and is relative.
  *
  * The associated lock must be locked on entry.  It is unlocked on return.
  *
diff -Nru a/include/asm-m68k/mac_psc.h b/include/asm-m68k/mac_psc.h
--- a/include/asm-m68k/mac_psc.h	Fri Nov 29 03:34:51 2002
+++ b/include/asm-m68k/mac_psc.h	Fri Nov 29 03:34:51 2002
@@ -158,7 +158,7 @@
 				 *                  0x3 = CD Audio
 				 *                  0x4 = External Audio
 				 *
-				 * The volume is definately not the general
+				 * The volume is definitely not the general
 				 * output volume as it doesn't affect the
 				 * alert sound volume.
 				 */
diff -Nru a/include/asm-mips/ng1hw.h b/include/asm-mips/ng1hw.h
--- a/include/asm-mips/ng1hw.h	Fri Nov 29 03:34:51 2002
+++ b/include/asm-mips/ng1hw.h	Fri Nov 29 03:34:51 2002
@@ -1,6 +1,6 @@
 /* $Id: ng1hw.h,v 1.4 1999/08/04 06:01:51 ulfc Exp $
  * 
- * ng1hw.h: Tweaks the newport.h structures and definations to be compatible
+ * ng1hw.h: Tweaks the newport.h structures and definitions to be compatible
  * 	    with IRIX.  Quite ugly, but it works.
  *
  * Copyright (C) 1999 Ulf Carlsson (ulfc@thepuffingroup.com)
diff -Nru a/include/linux/ixjuser.h b/include/linux/ixjuser.h
--- a/include/linux/ixjuser.h	Fri Nov 29 03:34:51 2002
+++ b/include/linux/ixjuser.h	Fri Nov 29 03:34:51 2002
@@ -312,8 +312,8 @@
 * must be set to the number of IXJ_CADENCE_ELEMENTS in the array.  The
 * termination variable defines what to do at the end of a cadence, the
 * options are to play the cadence once and stop, to repeat the last
-* element of the cadence indefinatly, or to repeat the entire cadence
-* indefinatly.  The ce variable is a pointer to the array of IXJ_TONE
+* element of the cadence indefinitely, or to repeat the entire cadence
+* indefinitely.  The ce variable is a pointer to the array of IXJ_TONE
 * structures.  If the freq0 variable is non-zero, the tone table contents
 * for the tone_index are updated to the frequencies and gains defined.  It
 * should be noted that DTMF tones cannot be reassigned, so if DTMF tone
diff -Nru a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Fri Nov 29 03:34:51 2002
+++ b/sound/pci/ali5451/ali5451.c	Fri Nov 29 03:34:51 2002
@@ -67,7 +67,7 @@
 MODULE_PARM_SYNTAX(pcm_channels, SNDRV_ENABLED ",default:32,allows:{{1,32}}");
 
 /*
- *  Debug part definations
+ *  Debug part definitions
  */
 
 //#define ALI_DEBUG
diff -Nru a/arch/ia64/sn/io/io.c b/arch/ia64/sn/io/io.c
--- a/arch/ia64/sn/io/io.c	Fri Nov 29 03:35:03 2002
+++ b/arch/ia64/sn/io/io.c	Fri Nov 29 03:35:03 2002
@@ -622,7 +622,7 @@
 }
 
 /*
- * Check that an address is in teh real small window widget 0 space
+ * Check that an address is in the real small window widget 0 space
  * or else in the big window we're using to emulate small window 0
  * in the kernel.
  */
@@ -699,7 +699,7 @@
 /*
  * hub_setup_prb(nasid, prbnum, credits, conveyor)
  *
- * 	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otehrwise,
+ * 	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otherwise,
  * 	put it into conveyor belt mode with the specified number of credits.
  */
 void
diff -Nru a/drivers/char/rio/rioctrl.c b/drivers/char/rio/rioctrl.c
--- a/drivers/char/rio/rioctrl.c	Fri Nov 29 03:35:03 2002
+++ b/drivers/char/rio/rioctrl.c	Fri Nov 29 03:35:03 2002
@@ -203,7 +203,7 @@
 	
 	func_enter ();
 	
-	/* Confuse teh compiler to think that we've initialized these */
+	/* Confuse the compiler to think that we've initialized these */
 	Host=0;
 	PortP = NULL;
 
diff -Nru a/include/asm-ia64/sn/router.h b/include/asm-ia64/sn/router.h
--- a/include/asm-ia64/sn/router.h	Fri Nov 29 03:35:02 2002
+++ b/include/asm-ia64/sn/router.h	Fri Nov 29 03:35:02 2002
@@ -500,7 +500,7 @@
 
 	/*
 	 * Everything below here is for kernel use only and may change at	
-	 * at any time with or without a change in teh revision number
+	 * at any time with or without a change in the revision number
 	 *
 	 * Any pointers or things that come and go with DEBUG must go at
  	 * the bottom of the structure, below the user stuff.
diff -Nru a/include/asm-ppc/iSeries/iSeries_FlightRecorder.h b/include/asm-ppc/iSeries/iSeries_FlightRecorder.h
--- a/include/asm-ppc/iSeries/iSeries_FlightRecorder.h	Fri Nov 29 03:35:03 2002
+++ b/include/asm-ppc/iSeries/iSeries_FlightRecorder.h	Fri Nov 29 03:35:03 2002
@@ -56,7 +56,7 @@
 /************************************************************************/
 /* Generic Flight Recorder Structure                                    */
 /************************************************************************/
-struct iSeries_FlightRecorder {         /* Structure Defination         */
+struct iSeries_FlightRecorder {         /* Structure Definition         */
     char  Signature[16];                /* Eye Catcher                  */
     char* StartingPointer;              /* Buffer Starting Address      */
     char* CurrentPointer;               /* Next Entry Address           */
diff -Nru a/Documentation/rpc-cache.txt b/Documentation/rpc-cache.txt
--- a/Documentation/rpc-cache.txt	Fri Nov 29 03:35:16 2002
+++ b/Documentation/rpc-cache.txt	Fri Nov 29 03:35:16 2002
@@ -148,7 +148,7 @@
 added to the channel but instead all looks that do not find a valid
 entry will fail.  This is partly for backward compatability: The
 previous nfs exports table was deemed to be authoritative and a
-failed lookup meant a definate 'no'.
+failed lookup meant a definite 'no'.
 
 request/response format
 -----------------------
diff -Nru a/Documentation/video4linux/bttv/Cards b/Documentation/video4linux/bttv/Cards
--- a/Documentation/video4linux/bttv/Cards	Fri Nov 29 03:35:16 2002
+++ b/Documentation/video4linux/bttv/Cards	Fri Nov 29 03:35:16 2002
@@ -607,7 +607,7 @@
 Hauppauge
 ---------
    many many WinTV models ...
-   WinTV DVBs = Tehcnotrend Premium
+   WinTV DVBs = Technotrend Premium
    WinTV NOVA = Technotrend Budget
    WinTV NOVA-CI
    WinTV-Nexus-s
