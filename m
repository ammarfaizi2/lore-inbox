Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269153AbTB0C4P>; Wed, 26 Feb 2003 21:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269154AbTB0C4P>; Wed, 26 Feb 2003 21:56:15 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:17165 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269153AbTB0C4K>; Wed, 26 Feb 2003 21:56:10 -0500
Subject: [PATCH] 2.5.63 Nasssty little hobbitsses making ssso many sspelling
	misstakesses!
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Feb 2003 20:05:28 -0700
Message-Id: <1046315130.2543.349.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes:

addresss    -> address    where there was a simple typo.
addresss    -> addresses  where the plural of address was meant.
accesss     -> access
accesssing  -> accessing
progresss   -> progress
Messsage    -> Message
endaineesss -> endianess  two fixes in this one
processsed  -> processed
asssembler  -> assembler
Reasssign   -> Reassign
permisssions -> permissions
asssociated  -> associated

This was diffed against the current 2.5 tree.

Steven

 arch/sparc64/kernel/traps.c                 |    2 +-
 drivers/acorn/block/mfmhd.c                 |    2 +-
 drivers/ide/ide-floppy.c                    |    2 +-
 drivers/net/e1000/e1000_hw.c                |    2 +-
 drivers/net/irda/ali-ircc.c                 |    2 +-
 drivers/net/rclanmtl.c                      |   20 ++++++++++----------
 drivers/net/sk98lin/skxmac2.c               |    2 +-
 drivers/net/wan/pc300_drv.c                 |    2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm.c        |    2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c |    2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h |    2 +-
 drivers/scsi/constants.c                    |    2 +-
 drivers/scsi/nsp32_debug.c                  |    2 +-
 drivers/scsi/pcmcia/nsp_debug.c             |    2 +-
 fs/ChangeLog                                |    2 +-
 fs/freevxfs/vxfs_inode.c                    |    2 +-
 fs/ntfs/ChangeLog                           |    2 +-
 include/net/sctp/user.h                     |    8 ++++----
 18 files changed, 30 insertions(+), 30 deletions(-)

diff -ur 2.5-current/arch/sparc64/kernel/traps.c linux/arch/sparc64/kernel/traps.c
--- 2.5-current/arch/sparc64/kernel/traps.c	Wed Feb 26 19:18:49 2003
+++ linux/arch/sparc64/kernel/traps.c	Wed Feb 26 19:33:50 2003
@@ -764,7 +764,7 @@
 } cheetah_error_table[] = {
 	{	CHAFSR_PERR,	"System interface protocol error"			},
 	{	CHAFSR_IERR,	"Internal processor error"				},
-	{	CHAFSR_ISAP,	"System request parity error on incoming addresss"	},
+	{	CHAFSR_ISAP,	"System request parity error on incoming address"	},
 	{	CHAFSR_UCU,	"Uncorrectable E-cache ECC error for ifetch/data"	},
 	{	CHAFSR_UCC,	"SW Correctable E-cache ECC error for ifetch/data"	},
 	{	CHAFSR_UE,	"Uncorrectable system bus data ECC error for read"	},
diff -ur 2.5-current/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- 2.5-current/drivers/acorn/block/mfmhd.c	Wed Feb 26 19:15:18 2003
+++ linux/drivers/acorn/block/mfmhd.c	Wed Feb 26 19:36:33 2003
@@ -728,7 +728,7 @@
 		};
 		/* Potentially this means that we've done; but we might be doing
 		   a partial access, (over two cylinders) or we may have a number
-		   of fragments in an image file.  First let's deal with partial accesss
+		   of fragments in an image file.  First let's deal with partial access
 		 */
 		if (PartFragRead) {
 			/* Yep - a partial access */
diff -ur 2.5-current/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- 2.5-current/drivers/ide/ide-floppy.c	Wed Feb 26 19:16:28 2003
+++ linux/drivers/ide/ide-floppy.c	Wed Feb 26 19:33:50 2003
@@ -1584,7 +1584,7 @@
 /*
 ** Get ATAPI_FORMAT_UNIT progress indication.
 **
-** Userland gives a pointer to an int.  The int is set to a progresss
+** Userland gives a pointer to an int.  The int is set to a progress
 ** indicator 0-65536, with 65536=100%.
 **
 ** If the drive does not support format progress indication, we just check
diff -ur 2.5-current/drivers/net/e1000/e1000_hw.c linux/drivers/net/e1000/e1000_hw.c
--- 2.5-current/drivers/net/e1000/e1000_hw.c	Wed Feb 26 19:18:47 2003
+++ linux/drivers/net/e1000/e1000_hw.c	Wed Feb 26 19:33:50 2003
@@ -2793,7 +2793,7 @@
  * hw - Struct containing variables accessed by shared code 
  *
  * Places the MAC address in receive address register 0 and clears the rest
- * of the receive addresss registers. Clears the multicast table. Assumes
+ * of the receive address registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
 void
diff -ur 2.5-current/drivers/net/irda/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
--- 2.5-current/drivers/net/irda/ali-ircc.c	Wed Feb 26 19:16:02 2003
+++ linux/drivers/net/irda/ali-ircc.c	Wed Feb 26 19:33:50 2003
@@ -1783,7 +1783,7 @@
 	MessageCount = inb(iobase+ FIR_LSR)&0x07;
 	
 	if (MessageCount > 0)	
-		IRDA_DEBUG(0, "%s(), Messsage count = %d,\n", __FUNCTION__ , MessageCount);	
+		IRDA_DEBUG(0, "%s(), Message count = %d,\n", __FUNCTION__ , MessageCount);	
 		
 	for (i=0; i<=MessageCount; i++)
 	{
diff -ur 2.5-current/drivers/net/rclanmtl.c linux/drivers/net/rclanmtl.c
--- 2.5-current/drivers/net/rclanmtl.c	Wed Feb 26 19:17:13 2003
+++ linux/drivers/net/rclanmtl.c	Wed Feb 26 19:33:50 2003
@@ -818,7 +818,7 @@
 	p_atu->EtherMacLow = 0;	/* first zero return data */
 	p_atu->EtherMacHi = 0;
 
-	off = p_atu->InQueue;	/* get addresss of message */
+	off = p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -880,7 +880,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -925,7 +925,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -965,7 +965,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1079,7 +1079,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1271,7 +1271,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1381,7 +1381,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1502,7 +1502,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1561,7 +1561,7 @@
 	if (pPab == NULL)
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
-	off = pPab->p_atu->InQueue;	/* get addresss of message */
+	off = pPab->p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
@@ -1608,7 +1608,7 @@
 		return RC_RTN_ADPTR_NOT_REGISTERED;
 
 	p_atu = pPab->p_atu;
-	off = p_atu->InQueue;	/* get addresss of message */
+	off = p_atu->InQueue;	/* get address of message */
 
 	if (0xFFFFFFFF == off)
 		return RC_RTN_FREE_Q_EMPTY;
diff -ur 2.5-current/drivers/net/sk98lin/skxmac2.c linux/drivers/net/sk98lin/skxmac2.c
--- 2.5-current/drivers/net/sk98lin/skxmac2.c	Wed Feb 26 19:18:43 2003
+++ linux/drivers/net/sk98lin/skxmac2.c	Wed Feb 26 19:33:50 2003
@@ -169,7 +169,7 @@
  *	fix: AutoNegDone bug
  *
  *	Revision 1.19  1998/10/29 10:14:43  malthoff
- *	Add endainesss comment for reading/writing MAC addresses.
+ *	Add endianess comment for reading/writing MAC addresses.
  *
  *	Revision 1.18  1998/10/28 07:48:55  cgoos
  *	Fix: ASS somtimes signaled although link is up.
diff -ur 2.5-current/drivers/net/wan/pc300_drv.c linux/drivers/net/wan/pc300_drv.c
--- 2.5-current/drivers/net/wan/pc300_drv.c	Wed Feb 26 19:18:35 2003
+++ linux/drivers/net/wan/pc300_drv.c	Wed Feb 26 19:33:50 2003
@@ -1447,7 +1447,7 @@
  * Description:	In the remote loopback mode the clock and data recovered
  *		from the line inputs RL1/2 or RDIP/RDIN are routed back
  *		to the line outputs XL1/2 or XDOP/XDON via the analog
- *		transmitter. As in normal mode they are processsed by
+ *		transmitter. As in normal mode they are processed by
  *		the synchronizer and then sent to the system interface.
  *----------------------------------------------------------------------------
  */
diff -ur 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm.c linux/drivers/scsi/aic7xxx/aicasm/aicasm.c
--- 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm.c	Wed Feb 26 19:15:46 2003
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm.c	Wed Feb 26 19:36:33 2003
@@ -1,5 +1,5 @@
 /*
- * Aic7xxx SCSI host adapter firmware asssembler
+ * Aic7xxx SCSI host adapter firmware assembler
  *
  * Copyright (c) 1997, 1998, 2000, 2001 Justin T. Gibbs.
  * Copyright (c) 2001, 2002 Adaptec Inc.
diff -ur 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
--- 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Wed Feb 26 19:18:48 2003
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Wed Feb 26 19:36:33 2003
@@ -1,5 +1,5 @@
 /*
- * Aic7xxx SCSI host adapter firmware asssembler symbol table implementation
+ * Aic7xxx SCSI host adapter firmware assembler symbol table implementation
  *
  * Copyright (c) 1997 Justin T. Gibbs.
  * Copyright (c) 2002 Adaptec Inc.
diff -ur 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
--- 2.5-current/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h	Wed Feb 26 19:17:25 2003
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h	Wed Feb 26 19:36:33 2003
@@ -1,5 +1,5 @@
 /*
- * Aic7xxx SCSI host adapter firmware asssembler symbol table definitions
+ * Aic7xxx SCSI host adapter firmware assembler symbol table definitions
  *
  * Copyright (c) 1997 Justin T. Gibbs.
  * Copyright (c) 2002 Adaptec Inc.
diff -ur 2.5-current/drivers/scsi/constants.c linux/drivers/scsi/constants.c
--- 2.5-current/drivers/scsi/constants.c	Wed Feb 26 19:17:33 2003
+++ linux/drivers/scsi/constants.c	Wed Feb 26 19:36:33 2003
@@ -36,7 +36,7 @@
 #if (CONSTANTS & CONST_COMMAND)
 static const char * group_0_commands[] = {
 /* 00-03 */ "Test Unit Ready", "Rezero Unit", unknown, "Request Sense",
-/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reasssign Blocks",
+/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reassign Blocks",
 /* 08-0d */ "Read (6)", unknown, "Write (6)", "Seek (6)", unknown, unknown,
 /* 0e-12 */ unknown, "Read Reverse", "Write Filemarks", "Space", "Inquiry",  
 /* 13-16 */ "Verify", "Recover Buffered Data", "Mode Select", "Reserve",
diff -ur 2.5-current/drivers/scsi/nsp32_debug.c linux/drivers/scsi/nsp32_debug.c
--- 2.5-current/drivers/scsi/nsp32_debug.c	Wed Feb 26 19:18:19 2003
+++ linux/drivers/scsi/nsp32_debug.c	Wed Feb 26 19:36:33 2003
@@ -13,7 +13,7 @@
 
 static const char * group_0_commands[] = {
 /* 00-03 */ "Test Unit Ready", "Rezero Unit", unknown, "Request Sense",
-/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reasssign Blocks",
+/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reassign Blocks",
 /* 08-0d */ "Read (6)", unknown, "Write (6)", "Seek (6)", unknown, unknown,
 /* 0e-12 */ unknown, "Read Reverse", "Write Filemarks", "Space", "Inquiry",  
 /* 13-16 */ unknown, "Recover Buffered Data", "Mode Select", "Reserve",
diff -ur 2.5-current/drivers/scsi/pcmcia/nsp_debug.c linux/drivers/scsi/pcmcia/nsp_debug.c
--- 2.5-current/drivers/scsi/pcmcia/nsp_debug.c	Wed Feb 26 19:16:05 2003
+++ linux/drivers/scsi/pcmcia/nsp_debug.c	Wed Feb 26 19:36:33 2003
@@ -15,7 +15,7 @@
 
 static const char * group_0_commands[] = {
 /* 00-03 */ "Test Unit Ready", "Rezero Unit", unknown, "Request Sense",
-/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reasssign Blocks",
+/* 04-07 */ "Format Unit", "Read Block Limits", unknown, "Reassign Blocks",
 /* 08-0d */ "Read (6)", unknown, "Write (6)", "Seek (6)", unknown, unknown,
 /* 0e-12 */ unknown, "Read Reverse", "Write Filemarks", "Space", "Inquiry",  
 /* 13-16 */ unknown, "Recover Buffered Data", "Mode Select", "Reserve",
diff -ur 2.5-current/fs/ChangeLog linux/fs/ChangeLog
--- 2.5-current/fs/ChangeLog	Wed Feb 26 19:14:56 2003
+++ linux/fs/ChangeLog	Wed Feb 26 19:33:50 2003
@@ -41,7 +41,7 @@
 		Moved the check for sticky bit here.
 	* affs/{inode,namei}.c:
 		All AFFS directories have sticky semantics (i.e. non-owner
-		having write permisssions on directory can unlink/rmdir/rename
+		having write permissions on directory can unlink/rmdir/rename
 		only the files he owns), but AFFS didn't set S_ISVTX on them.
 		Fixed. NB: maybe this behaviour should be controlled by mount
 		option. Obvious values being 'sticky' (current behaviour),
diff -ur 2.5-current/fs/freevxfs/vxfs_inode.c linux/fs/freevxfs/vxfs_inode.c
--- 2.5-current/fs/freevxfs/vxfs_inode.c	Wed Feb 26 19:15:17 2003
+++ linux/fs/freevxfs/vxfs_inode.c	Wed Feb 26 19:33:49 2003
@@ -285,7 +285,7 @@
  * *ip:			VFS inode
  *
  * Description:
- *  vxfs_put_fake_inode frees all data asssociated with @ip.
+ *  vxfs_put_fake_inode frees all data associated with @ip.
  */
 void
 vxfs_put_fake_inode(struct inode *ip)
diff -ur 2.5-current/fs/ntfs/ChangeLog linux/fs/ntfs/ChangeLog
--- 2.5-current/fs/ntfs/ChangeLog	Wed Feb 26 19:15:30 2003
+++ linux/fs/ntfs/ChangeLog	Wed Feb 26 19:33:49 2003
@@ -749,7 +749,7 @@
 	  by the kernel.
 
 	The driver is now actually useful! Yey. (-: It undoubtedly has got bugs
-	though and it doesn't implement accesssing compressed files yet. Also,
+	though and it doesn't implement accessing compressed files yet. Also,
 	accessing files with attribute list attributes is not implemented yet
 	either. But for small or simple file systems it should work and allow
 	you to list directories, use stat on directory entries and the file
diff -ur 2.5-current/include/net/sctp/user.h linux/include/net/sctp/user.h
--- 2.5-current/include/net/sctp/user.h	Wed Feb 26 19:14:35 2003
+++ linux/include/net/sctp/user.h	Wed Feb 26 19:37:23 2003
@@ -100,13 +100,13 @@
 #define SCTP_SOCKOPT_BINDX_REM	SCTP_SOCKOPT_BINDX_REM
 	SCTP_SOCKOPT_PEELOFF, 	/* peel off association. */
 #define SCTP_SOCKOPT_PEELOFF	SCTP_SOCKOPT_PEELOFF
-	SCTP_GET_PEER_ADDRS_NUM, 	/* Get number of peer addresss. */
+	SCTP_GET_PEER_ADDRS_NUM, 	/* Get number of peer addresses. */
 #define SCTP_GET_PEER_ADDRS_NUM	SCTP_GET_PEER_ADDRS_NUM
-	SCTP_GET_PEER_ADDRS, 	/* Get all peer addresss. */
+	SCTP_GET_PEER_ADDRS, 	/* Get all peer addresses. */
 #define SCTP_GET_PEER_ADDRS	SCTP_GET_PEER_ADDRS
-	SCTP_GET_LOCAL_ADDRS_NUM, 	/* Get number of local addresss. */
+	SCTP_GET_LOCAL_ADDRS_NUM, 	/* Get number of local addresses. */
 #define SCTP_GET_LOCAL_ADDRS_NUM	SCTP_GET_LOCAL_ADDRS_NUM
-	SCTP_GET_LOCAL_ADDRS, 	/* Get all local addresss. */
+	SCTP_GET_LOCAL_ADDRS, 	/* Get all local addresses. */
 #define SCTP_GET_LOCAL_ADDRS	SCTP_GET_LOCAL_ADDRS
 };
 









