Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTBPEee>; Sat, 15 Feb 2003 23:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTBPEee>; Sat, 15 Feb 2003 23:34:34 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:19981 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265815AbTBPEeb>; Sat, 15 Feb 2003 23:34:31 -0500
Subject: [PATCH] 2.5.61 fix spelling of necessary in 11 files
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 21:36:08 -0700
Message-Id: <1045370169.10680.110.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the spelling of "necessary" in 11 files, plus these other
fixes which were nearby:

divisable -> divisible
feild -> field
effectivly -> effectively
belive -> believe 

Steven

diff -ur linux-2.5.61-1.1027-orig/arch/mips/ddb5xxx/common/nile4.c linux-2.5.61-1.1027/arch/mips/ddb5xxx/common/nile4.c
--- linux-2.5.61-1.1027-orig/arch/mips/ddb5xxx/common/nile4.c	Thu Jan 16 19:22:22 2003
+++ linux-2.5.61-1.1027/arch/mips/ddb5xxx/common/nile4.c	Sat Feb 15 21:12:51 2003
@@ -109,7 +109,7 @@
          * When programming a PDAR, the register should be read immediately
          * after writing it. This ensures that address decoders are properly
          * configured.
-	 * [jsun] is this really necesary?
+	 * [jsun] is this really necessary?
          */
         ddb_in32(pdar);
         ddb_in32(pdar + 4);
diff -ur linux-2.5.61-1.1027-orig/drivers/acorn/block/fd1772.c linux-2.5.61-1.1027/drivers/acorn/block/fd1772.c
--- linux-2.5.61-1.1027-orig/drivers/acorn/block/fd1772.c	Thu Jan 16 19:22:00 2003
+++ linux-2.5.61-1.1027/drivers/acorn/block/fd1772.c	Sat Feb 15 21:14:30 2003
@@ -336,7 +336,7 @@
  */
 static int Probing = 0;
 
-/* This flag is set when a dummy seek is necesary to make the WP
+/* This flag is set when a dummy seek is necessary to make the WP
  * status bit accessible.
  */
 static int NeedSeek = 0;
diff -ur linux-2.5.61-1.1027-orig/drivers/isdn/hisax/amd7930_fn.c linux-2.5.61-1.1027/drivers/isdn/hisax/amd7930_fn.c
--- linux-2.5.61-1.1027-orig/drivers/isdn/hisax/amd7930_fn.c	Thu Jan 16 19:22:21 2003
+++ linux-2.5.61-1.1027/drivers/isdn/hisax/amd7930_fn.c	Sat Feb 15 20:17:24 2003
@@ -176,7 +176,7 @@
 
         cs->dc.amd7930.old_state = cs->dc.amd7930.ph_state;
 
-        /* abort transmit if nessesary */
+        /* abort transmit if necessary */
         if ((message & 0xf0) && (cs->tx_skb)) {
                 wByteAMD(cs, 0x21, 0xC2);
                 wByteAMD(cs, 0x21, 0x02);
diff -ur linux-2.5.61-1.1027-orig/drivers/mtd/chips/jedec.c linux-2.5.61-1.1027/drivers/mtd/chips/jedec.c
--- linux-2.5.61-1.1027-orig/drivers/mtd/chips/jedec.c	Mon Feb 10 12:23:00 2003
+++ linux-2.5.61-1.1027/drivers/mtd/chips/jedec.c	Sat Feb 15 21:13:54 2003
@@ -754,7 +754,7 @@
 		       size_t *retlen, const u_char *buf)
 {
    /* Does IO to the currently selected chip. It takes the bank addressing
-      base (which is divisable by the chip size) adds the necesary lower bits
+      base (which is divisible by the chip size) adds the necessary lower bits
       of addrshift (interleve index) and then adds the control register index. */
    #define flread(x) map->read8(map,base+(off&((1<<chip->addrshift)-1))+((x)<<chip->addrshift))
    #define flwrite(v,x) map->write8(map,v,base+(off&((1<<chip->addrshift)-1))+((x)<<chip->addrshift))
diff -ur linux-2.5.61-1.1027-orig/drivers/usb/image/scanner.c linux-2.5.61-1.1027/drivers/usb/image/scanner.c
--- linux-2.5.61-1.1027-orig/drivers/usb/image/scanner.c	Mon Feb 10 12:23:04 2003
+++ linux-2.5.61-1.1027/drivers/usb/image/scanner.c	Sat Feb 15 20:16:58 2003
@@ -54,7 +54,7 @@
  *      allocation/registration for linux-2.3.22+.
  *    - Adopted David Brownell's <david-b@pacbell.net> technique for 
  *      assigning bulk endpoints.
- *    - Removed unnessesary #include's
+ *    - Removed unnecessary #include's
  *    - Scanner model now reported via syslog INFO after being detected 
  *      *and* configured.
  *    - Added user specified vendor:product USB ID's which can be passed 
diff -ur linux-2.5.61-1.1027-orig/fs/befs/btree.c linux-2.5.61-1.1027/fs/befs/btree.c
--- linux-2.5.61-1.1027-orig/fs/befs/btree.c	Thu Jan 16 19:21:34 2003
+++ linux-2.5.61-1.1027/fs/befs/btree.c	Sat Feb 15 21:05:05 2003
@@ -56,9 +56,9 @@
 /* Note:
  * 
  * The book states 2 confusing things about befs b+trees. First, 
- * it states that the overflow feild of node headers is used by internal nodes 
- * to point to another node that "effectivly continues this one". Here is what 
- * I belive that means. Each key in internal nodes points to another node that
+ * it states that the overflow field of node headers is used by internal nodes
+ * to point to another node that "effectively continues this one". Here is what
+ * I believe that means. Each key in internal nodes points to another node that
  * contains key values less than itself. Inspection reveals that the last key 
  * in the internal node is not the last key in the index. Keys that are 
  * greater than the last key in the internal node go into the overflow node. 
@@ -124,7 +124,7 @@
  * @sup: Buffer in which to place the btree superblock
  *
  * Calls befs_read_datastream to read in the btree superblock and
- * makes sure it is in cpu byteorder, byteswapping if nessisary.
+ * makes sure it is in cpu byteorder, byteswapping if necessary.
  *
  * On success, returns BEFS_OK and *@sup contains the btree superblock,
  * in cpu byte order.
@@ -179,8 +179,8 @@
  * @node_off: Starting offset (in bytes) of the node in @ds
  *
  * Calls befs_read_datastream to read in the indicated btree node and
- * makes sure its header feilds are in cpu byteorder, byteswapping if 
- * nessisary.
+ * makes sure its header fields are in cpu byteorder, byteswapping if
+ * necessary.
  * Note: node->bh must be NULL when this function called first
  * time. Don't forget brelse(node->bh) after last call.
  *
diff -ur linux-2.5.61-1.1027-orig/fs/befs/datastream.c linux-2.5.61-1.1027/fs/befs/datastream.c
--- linux-2.5.61-1.1027-orig/fs/befs/datastream.c	Thu Jan 16 19:22:43 2003
+++ linux-2.5.61-1.1027/fs/befs/datastream.c	Sat Feb 15 20:15:50 2003
@@ -229,7 +229,7 @@
 	
 	Algorithm:
 	Linear search. Checks each element of array[] to see if it
-	contains the blockno-th filesystem block. This is nessisary
+	contains the blockno-th filesystem block. This is necessary
 	because the block runs map variable amounts of data. Simply
 	keeps a count of the number of blocks searched so far (sum),
 	incrementing this by the length of each block run as we come
diff -ur linux-2.5.61-1.1027-orig/net/ipv4/ip_gre.c linux-2.5.61-1.1027/net/ipv4/ip_gre.c
--- linux-2.5.61-1.1027-orig/net/ipv4/ip_gre.c	Thu Jan 16 19:22:27 2003
+++ linux-2.5.61-1.1027/net/ipv4/ip_gre.c	Sat Feb 15 21:10:57 2003
@@ -454,7 +454,7 @@
 			/* Impossible event. */
 			return;
 		case ICMP_FRAG_NEEDED:
-			/* And it is the only really necesary thing :-) */
+			/* And it is the only really necessary thing :-) */
 			rel_info = ntohs(skb->h.icmph->un.frag.mtu);
 			if (rel_info < grehlen+68)
 				return;
diff -ur linux-2.5.61-1.1027-orig/net/ipv4/ipip.c linux-2.5.61-1.1027/net/ipv4/ipip.c
--- linux-2.5.61-1.1027-orig/net/ipv4/ipip.c	Thu Jan 16 19:23:01 2003
+++ linux-2.5.61-1.1027/net/ipv4/ipip.c	Sat Feb 15 21:11:22 2003
@@ -383,7 +383,7 @@
 			/* Impossible event. */
 			return;
 		case ICMP_FRAG_NEEDED:
-			/* And it is the only really necesary thing :-) */
+			/* And it is the only really necessary thing :-) */
 			rel_info = ntohs(skb->h.icmph->un.frag.mtu);
 			if (rel_info < hlen+68)
 				return;
diff -ur linux-2.5.61-1.1027-orig/net/sched/sch_cbq.c linux-2.5.61-1.1027/net/sched/sch_cbq.c
--- linux-2.5.61-1.1027-orig/net/sched/sch_cbq.c	Thu Jan 16 19:21:39 2003
+++ linux-2.5.61-1.1027/net/sched/sch_cbq.c	Sat Feb 15 21:11:57 2003
@@ -797,7 +797,7 @@
 			   That is not all.
 			   To maintain the rate allocated to the class,
 			   we add to undertime virtual clock,
-			   necesary to complete transmitted packet.
+			   necessary to complete transmitted packet.
 			   (len/phys_bandwidth has been already passed
 			   to the moment of cbq_update)
 			 */
diff -ur linux-2.5.61-1.1027-orig/sound/pci/cs46xx/dsp_spos_scb_lib.c linux-2.5.61-1.1027/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- linux-2.5.61-1.1027-orig/sound/pci/cs46xx/dsp_spos_scb_lib.c	Mon Feb 10 12:23:10 2003
+++ linux-2.5.61-1.1027/sound/pci/cs46xx/dsp_spos_scb_lib.c	Sat Feb 15 21:13:19 2003
@@ -1543,7 +1543,7 @@
 	/* dont touch anything if SPDIF is open */
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
 		/* when cs46xx_iec958_post_close(...) is called it
-		   will call this function if necesary depending on
+		   will call this function if necessary depending on
 		   this bit */
 		ins->spdif_status_out |= DSP_SPDIF_STATUS_OUTPUT_ENABLED;
 



