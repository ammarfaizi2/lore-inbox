Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbSLLSN7>; Thu, 12 Dec 2002 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbSLLSMf>; Thu, 12 Dec 2002 13:12:35 -0500
Received: from 217-127-135-237.uc.nombres.ttd.es ([217.127.135.237]:52209 "EHLO
	pulp.ibd.es") by vger.kernel.org with ESMTP id <S267424AbSLLSLs>;
	Thu, 12 Dec 2002 13:11:48 -0500
Date: Thu, 12 Dec 2002 19:19:30 +0100 (CET)
From: =?ISO-8859-1?Q?Alfredo_Sanju=C3=A1n?= <alfre@ibd.es>
X-X-Sender: alfre@localhost.localdomain
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL] available spell fixes
Message-ID: <Pine.LNX.4.44.0212121912100.1528-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against vanilla 2.4.20, spell fixes for 'available'.

Regrads - alfredo

--
Alfredo Sanjuan
<alfre@ibd.es>

diff -ruN linux-2.4.20/drivers/atm/iphase.c linux-2.4.20spellfix/drivers/atm/iphase.c
--- linux-2.4.20/drivers/atm/iphase.c	Fri Nov 29 00:53:12 2002
+++ linux-2.4.20spellfix/drivers/atm/iphase.c	Thu Dec 12 17:40:33 2002
@@ -1884,7 +1884,7 @@
                     return -EINVAL; 
                 }
                 if (vcc->qos.txtp.max_pcr > iadev->LineRate) {
-                   IF_CBR(printk("PCR is not availble\n");)
+                   IF_CBR(printk("PCR is not available\n");)
                    return -1;
                 }
                 vc->type = CBR;
@@ -1894,7 +1894,7 @@
                 }
        } 
 	else  
-           printk("iadev:  Non UBR, ABR and CBR traffic not supportedn"); 
+           printk("iadev:  Non UBR, ABR and CBR traffic not supported\n"); 
         
         iadev->testTable[vcc->vci]->vc_status |= VC_ACTIVE;
 	IF_EVENT(printk("ia open_tx returning \n");)  
diff -ruN linux-2.4.20/drivers/ieee1394/dv1394.h linux-2.4.20spellfix/drivers/ieee1394/dv1394.h
--- linux-2.4.20/drivers/ieee1394/dv1394.h	Sat Aug  3 02:39:44 2002
+++ linux-2.4.20spellfix/drivers/ieee1394/dv1394.h	Thu Dec 12 17:41:03 2002
@@ -175,7 +175,7 @@
    where copy_DV_frame() reads or writes on the dv1394 file descriptor
    (read/write mode) or copies data to/from the mmap ringbuffer and
    then calls ioctl(DV1394_SUBMIT_FRAMES) to notify dv1394 that new
-   frames are availble (mmap mode).
+   frames are available (mmap mode).
 
    reset_dv1394() is called in the event of a buffer
    underflow/overflow or a halt in the DV stream (e.g. due to a 1394
diff -ruN linux-2.4.20/drivers/md/lvm.c linux-2.4.20spellfix/drivers/md/lvm.c
--- linux-2.4.20/drivers/md/lvm.c	Fri Nov 29 00:53:13 2002
+++ linux-2.4.20spellfix/drivers/md/lvm.c	Thu Dec 12 17:41:28 2002
@@ -2405,7 +2405,7 @@
 		}
 	}
 
-	/* save availiable i/o statistic data */
+	/* save available i/o statistic data */
 	if (old_lv->lv_stripes < 2) {	/* linear logical volume */
 		end = min(old_lv->lv_current_le, new_lv->lv_current_le);
 		for (l = 0; l < end; l++) {
diff -ruN linux-2.4.20/drivers/net/saa9730.c linux-2.4.20spellfix/drivers/net/saa9730.c
--- linux-2.4.20/drivers/net/saa9730.c	Wed Oct 17 06:56:29 2001
+++ linux-2.4.20spellfix/drivers/net/saa9730.c	Thu Dec 12 17:31:08 2002
@@ -265,7 +265,7 @@
 	lp->NextRcvPacketIndex = 0;
 	lp->NextRcvToUseIsA = 1;
 
-	/* Set current buffer index & next availble packet index */
+	/* Set current buffer index & next available packet index */
 	lp->NextTxmPacketIndex = 0;
 	lp->NextTxmBufferIndex = 0;
 	lp->PendingTxmPacketIndex = 0;
@@ -520,7 +520,7 @@
 	lp->NextRcvPacketIndex = 0;
 	lp->NextRcvToUseIsA = 1;
 
-	/* Set current buffer index & next availble packet index */
+	/* Set current buffer index & next available packet index */
 	lp->NextTxmPacketIndex = 0;
 	lp->NextTxmBufferIndex = 0;
 	lp->PendingTxmPacketIndex = 0;
diff -ruN linux-2.4.20/drivers/net/wan/comx-hw-munich.c linux-2.4.20spellfix/drivers/net/wan/comx-hw-munich.c
--- linux-2.4.20/drivers/net/wan/comx-hw-munich.c	Fri Nov 29 00:53:14 2002
+++ linux-2.4.20spellfix/drivers/net/wan/comx-hw-munich.c	Thu Dec 12 17:30:12 2002
@@ -269,7 +269,7 @@
 				   - Path Code Violations >1, but <320
 				   - not a Severely Errored Second
 				   - no AIS
-				   - not incremented during an Unavailabla Second                       */
+				   - not incremented during an Unavailable Second                       */
       severely_err_secs,	/* Severely Errored Second:
 				   - CRC4: >=832 Path COde Violations || >0 Out Of Frame defects
 				   - noCRC4: >=2048 Line Code Violations
diff -ruN linux-2.4.20/drivers/scsi/aic7xxx/aic7xxx.h linux-2.4.20spellfix/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.4.20/drivers/scsi/aic7xxx/aic7xxx.h	Sat Aug  3 02:39:44 2002
+++ linux-2.4.20spellfix/drivers/scsi/aic7xxx/aic7xxx.h	Thu Dec 12 17:38:17 2002
@@ -362,7 +362,7 @@
 
 /*
  * The driver keeps up to MAX_SCB scb structures per card in memory.  The SCB
- * consists of a "hardware SCB" mirroring the fields availible on the card
+ * consists of a "hardware SCB" mirroring the fields available on the card
  * and additional information the kernel stores for each transaction.
  *
  * To minimize space utilization, a portion of the hardware scb stores
diff -ruN linux-2.4.20/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.4.20spellfix/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.4.20/drivers/scsi/aic7xxx/aic7xxx_core.c	Fri Nov 29 00:53:14 2002
+++ linux-2.4.20spellfix/drivers/scsi/aic7xxx/aic7xxx_core.c	Thu Dec 12 17:38:00 2002
@@ -388,7 +388,7 @@
 
 	ahc_dump_card_state(ahc);
 
-	/* Tell everyone that this HBA is no longer availible */
+	/* Tell everyone that this HBA is no longer available */
 	ahc_abort_scbs(ahc, CAM_TARGET_WILDCARD, ALL_CHANNELS,
 		       CAM_LUN_WILDCARD, SCB_LIST_NULL, ROLE_UNKNOWN,
 		       CAM_NO_HBA);
@@ -2748,9 +2748,9 @@
 	targ_scsirate = tinfo->scsirate;
 
 	/*
-	 * Parse as much of the message as is availible,
+	 * Parse as much of the message as is available,
 	 * rejecting it if we don't support it.  When
-	 * the entire message is availible and has been
+	 * the entire message is available and has been
 	 * handled, return MSGLOOP_MSGCOMPLETE, indicating
 	 * that we have parsed an entire message.
 	 *
diff -ruN linux-2.4.20/drivers/scsi/aic7xxx_old.c linux-2.4.20spellfix/drivers/scsi/aic7xxx_old.c
--- linux-2.4.20/drivers/scsi/aic7xxx_old.c	Wed Nov 21 23:05:29 2001
+++ linux-2.4.20spellfix/drivers/scsi/aic7xxx_old.c	Thu Dec 12 17:35:55 2002
@@ -5435,9 +5435,9 @@
   target_mask = (0x01 << tindex);
 
   /*
-   * Parse as much of the message as is availible,
+   * Parse as much of the message as is available,
    * rejecting it if we don't support it.  When
-   * the entire message is availible and has been
+   * the entire message is available and has been
    * handled, return TRUE indicating that we have
    * parsed an entire message.
    */
diff -ruN linux-2.4.20/drivers/scsi/ips.c linux-2.4.20spellfix/drivers/scsi/ips.c
--- linux-2.4.20/drivers/scsi/ips.c	Fri Nov 29 00:53:14 2002
+++ linux-2.4.20spellfix/drivers/scsi/ips.c	Thu Dec 12 17:35:00 2002
@@ -7211,7 +7211,7 @@
 /*     Assumes that ips_read_adapter_status() is called first filling in     */
 /*     the data for SubSystem Parameters.                                    */
 /*     Called from ips_write_driver_status() so it also assumes NVRAM Page 5 */
-/*     Data is availaible.                                                   */
+/*     Data is available.                                                   */
 /*                                                                           */
 /*---------------------------------------------------------------------------*/
 static void ips_version_check(ips_ha_t *ha, int intr) {
diff -ruN linux-2.4.20/drivers/scsi/pcmcia/nsp_cs.c linux-2.4.20spellfix/drivers/scsi/pcmcia/nsp_cs.c
--- linux-2.4.20/drivers/scsi/pcmcia/nsp_cs.c	Thu Oct 11 18:04:57 2001
+++ linux-2.4.20spellfix/drivers/scsi/pcmcia/nsp_cs.c	Thu Dec 12 17:38:50 2002
@@ -707,7 +707,7 @@
 		ocount			 += res;
 		//DEBUG(0, " ptr=0x%p this_residual=0x%x ocount=0x%x\n", SCpnt->SCp.ptr, SCpnt->SCp.this_residual, ocount);
 
-		/* go to next scatter list if availavle */
+		/* go to next scatter list if available */
 		if (SCpnt->SCp.this_residual	== 0 &&
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//DEBUG(0, " scatterlist next timeout=%d\n", time_out);
@@ -780,7 +780,7 @@
 		SCpnt->SCp.this_residual -= res;
 		ocount			 += res;
 
-		/* go to next scatter list if availavle */
+		/* go to next scatter list if available */
 		if (SCpnt->SCp.this_residual	== 0 &&
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//DEBUG(0, " scatterlist next\n");
diff -ruN linux-2.4.20/net/ipv6/af_inet6.c linux-2.4.20spellfix/net/ipv6/af_inet6.c
--- linux-2.4.20/net/ipv6/af_inet6.c	Wed Oct 17 23:16:39 2001
+++ linux-2.4.20spellfix/net/ipv6/af_inet6.c	Thu Dec 12 17:28:34 2002
@@ -619,7 +619,7 @@
 	/*
 	 *	ipngwg API draft makes clear that the correct semantics
 	 *	for TCP and UDP is to consider one TCP and UDP instance
-	 *	in a host availiable by both INET and INET6 APIs and
+	 *	in a host available by both INET and INET6 APIs and
 	 *	able to communicate via both network protocols.
 	 */
 
diff -ruN linux-2.4.20/net/ipv6/ip6_output.c linux-2.4.20spellfix/net/ipv6/ip6_output.c
--- linux-2.4.20/net/ipv6/ip6_output.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20spellfix/net/ipv6/ip6_output.c	Thu Dec 12 17:28:59 2002
@@ -563,7 +563,7 @@
 		if (err) {
 #if IP6_DEBUG >= 2
 			printk(KERN_DEBUG "ip6_build_xmit: "
-			       "no availiable source address\n");
+			       "no available source address\n");
 #endif
 			goto out;
 		}

