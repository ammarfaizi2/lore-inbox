Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262333AbSJISbh>; Wed, 9 Oct 2002 14:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262361AbSJISbh>; Wed, 9 Oct 2002 14:31:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262333AbSJIS3u>; Wed, 9 Oct 2002 14:29:50 -0400
Subject: PATCH: wd7000 indent pass
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 19:26:53 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17zLXp-0006Ld-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just indenting no code changes. 

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/wd7000.c linux.2.5.41-ac2/drivers/scsi/wd7000.c
--- linux.2.5.41/drivers/scsi/wd7000.c	2002-10-07 22:12:26.000000000 +0100
+++ linux.2.5.41-ac2/drivers/scsi/wd7000.c	2002-10-09 16:01:07.000000000 +0100
@@ -216,8 +216,8 @@
  *
  */
 typedef volatile struct mailbox {
-    unchar status;
-    unchar scbptr[3];		/* SCSI-style - MSB first (big endian) */
+	unchar status;
+	unchar scbptr[3];	/* SCSI-style - MSB first (big endian) */
 } Mailbox;
 
 /*
@@ -225,38 +225,36 @@
  *  new global per-adapter data should put in here.
  */
 typedef struct adapter {
-    struct Scsi_Host *sh;	/* Pointer to Scsi_Host structure    */
-    int iobase;			/* This adapter's I/O base address   */
-    int irq;			/* This adapter's IRQ level          */
-    int dma;			/* This adapter's DMA channel        */
-    int int_counter;		/* This adapter's interrupt counter  */
-    int bus_on;			/* This adapter's BUS_ON time        */
-    int bus_off;		/* This adapter's BUS_OFF time       */
-    struct {			/* This adapter's mailboxes          */
-	Mailbox ogmb[OGMB_CNT];	/* Outgoing mailboxes                */
-	Mailbox icmb[ICMB_CNT];	/* Incoming mailboxes                */
-    } mb;
-    int next_ogmb;		/* to reduce contention at mailboxes */
-    unchar control;		/* shadows CONTROL port value        */
-    unchar rev1, rev2;		/* filled in by wd7000_revision      */
+	struct Scsi_Host *sh;	/* Pointer to Scsi_Host structure    */
+	int iobase;		/* This adapter's I/O base address   */
+	int irq;		/* This adapter's IRQ level          */
+	int dma;		/* This adapter's DMA channel        */
+	int int_counter;	/* This adapter's interrupt counter  */
+	int bus_on;		/* This adapter's BUS_ON time        */
+	int bus_off;		/* This adapter's BUS_OFF time       */
+	struct {		/* This adapter's mailboxes          */
+		Mailbox ogmb[OGMB_CNT];	/* Outgoing mailboxes                */
+		Mailbox icmb[ICMB_CNT];	/* Incoming mailboxes                */
+	} mb;
+	int next_ogmb;		/* to reduce contention at mailboxes */
+	unchar control;		/* shadows CONTROL port value        */
+	unchar rev1, rev2;	/* filled in by wd7000_revision      */
 } Adapter;
 
 /*
  * (linear) base address for ROM BIOS
  */
-static const long wd7000_biosaddr[] =
-{
-    0xc0000, 0xc2000, 0xc4000, 0xc6000, 0xc8000, 0xca000, 0xcc000, 0xce000,
-    0xd0000, 0xd2000, 0xd4000, 0xd6000, 0xd8000, 0xda000, 0xdc000, 0xde000
+static const long wd7000_biosaddr[] = {
+	0xc0000, 0xc2000, 0xc4000, 0xc6000, 0xc8000, 0xca000, 0xcc000, 0xce000,
+	0xd0000, 0xd2000, 0xd4000, 0xd6000, 0xd8000, 0xda000, 0xdc000, 0xde000
 };
 #define NUM_ADDRS (sizeof(wd7000_biosaddr)/sizeof(long))
 
-static const unsigned short wd7000_iobase[] =
-{
-    0x0300, 0x0308, 0x0310, 0x0318, 0x0320, 0x0328, 0x0330, 0x0338,
-    0x0340, 0x0348, 0x0350, 0x0358, 0x0360, 0x0368, 0x0370, 0x0378,
-    0x0380, 0x0388, 0x0390, 0x0398, 0x03a0, 0x03a8, 0x03b0, 0x03b8,
-    0x03c0, 0x03c8, 0x03d0, 0x03d8, 0x03e0, 0x03e8, 0x03f0, 0x03f8
+static const unsigned short wd7000_iobase[] = {
+	0x0300, 0x0308, 0x0310, 0x0318, 0x0320, 0x0328, 0x0330, 0x0338,
+	0x0340, 0x0348, 0x0350, 0x0358, 0x0360, 0x0368, 0x0370, 0x0378,
+	0x0380, 0x0388, 0x0390, 0x0398, 0x03a0, 0x03a8, 0x03b0, 0x03b8,
+	0x03c0, 0x03c8, 0x03d0, 0x03d8, 0x03e0, 0x03e8, 0x03f0, 0x03f8
 };
 #define NUM_IOPORTS (sizeof(wd7000_iobase)/sizeof(unsigned short))
 
@@ -270,36 +268,35 @@
  * The following is set up by wd7000_detect, and used thereafter for
  * proc and other global ookups
  */
- 
+
 #define UNITS	8
 static struct Scsi_Host *wd7000_host[UNITS];
 
-#define BUS_ON    64	/* x 125ns = 8000ns (BIOS default) */
-#define BUS_OFF   15	/* x 125ns = 1875ns (BIOS default) */
+#define BUS_ON    64		/* x 125ns = 8000ns (BIOS default) */
+#define BUS_OFF   15		/* x 125ns = 1875ns (BIOS default) */
 
 /*
  *  Standard Adapter Configurations - used by wd7000_detect
  */
 typedef struct {
-    short irq;		/* IRQ level                                  */
-    short dma;		/* DMA channel                                */
-    unsigned iobase;	/* I/O base address                           */
-    short bus_on;	/* Time that WD7000 spends on the AT-bus when */
-			/* transferring data. BIOS default is 8000ns. */
-    short bus_off;	/* Time that WD7000 spends OFF THE BUS after  */
-			/* while it is transferring data.             */
-			/* BIOS default is 1875ns                     */
+	short irq;		/* IRQ level                                  */
+	short dma;		/* DMA channel                                */
+	unsigned iobase;	/* I/O base address                           */
+	short bus_on;		/* Time that WD7000 spends on the AT-bus when */
+	/* transferring data. BIOS default is 8000ns. */
+	short bus_off;		/* Time that WD7000 spends OFF THE BUS after  */
+	/* while it is transferring data.             */
+	/* BIOS default is 1875ns                     */
 } Config;
 
 /*
  * Add here your configuration...
  */
-static Config configs[] =
-{
-    { 15,  6, 0x350, BUS_ON, BUS_OFF },	/* defaults for single adapter */
-    { 11,  5, 0x320, BUS_ON, BUS_OFF },	/* defaults for second adapter */
-    {  7,  6, 0x350, BUS_ON, BUS_OFF },	/* My configuration (Zaga)     */
-    { -1, -1, 0x0,   BUS_ON, BUS_OFF }	/* Empty slot                  */
+static Config configs[] = {
+	{15, 6, 0x350, BUS_ON, BUS_OFF},	/* defaults for single adapter */
+	{11, 5, 0x320, BUS_ON, BUS_OFF},	/* defaults for second adapter */
+	{7, 6, 0x350, BUS_ON, BUS_OFF},	/* My configuration (Zaga)     */
+	{-1, -1, 0x0, BUS_ON, BUS_OFF}	/* Empty slot                  */
 };
 #define NUM_CONFIGS (sizeof(configs)/sizeof(Config))
 
@@ -309,14 +306,13 @@
  *  added for the Future Domain version.
  */
 typedef struct signature {
-    const char *sig;		/* String to look for            */
-    unsigned long ofs;		/* offset from BIOS base address */
-    unsigned len;		/* length of string              */
+	const char *sig;	/* String to look for            */
+	unsigned long ofs;	/* offset from BIOS base address */
+	unsigned len;		/* length of string              */
 } Signature;
 
-static const Signature signatures[] =
-{
-    {"SSTBIOS", 0x0000d, 7}	/* "SSTBIOS" @ offset 0x0000d */
+static const Signature signatures[] = {
+	{"SSTBIOS", 0x0000d, 7}	/* "SSTBIOS" @ offset 0x0000d */
 };
 #define NUM_SIGNATURES (sizeof(signatures)/sizeof(Signature))
 
@@ -363,14 +359,14 @@
  * For INITIALIZATION:
  */
 typedef struct initCmd {
-    unchar op;			/* command opcode (= 1)                    */
-    unchar ID;			/* Adapter's SCSI ID                       */
-    unchar bus_on;		/* Bus on time, x 125ns (see below)        */
-    unchar bus_off;		/* Bus off time, ""         ""             */
-    unchar rsvd;		/* Reserved                                */
-    unchar mailboxes[3];	/* Address of Mailboxes, MSB first         */
-    unchar ogmbs;		/* Number of outgoing MBs, max 64, 0,1 = 1 */
-    unchar icmbs;		/* Number of incoming MBs,   ""       ""   */
+	unchar op;		/* command opcode (= 1)                    */
+	unchar ID;		/* Adapter's SCSI ID                       */
+	unchar bus_on;		/* Bus on time, x 125ns (see below)        */
+	unchar bus_off;		/* Bus off time, ""         ""             */
+	unchar rsvd;		/* Reserved                                */
+	unchar mailboxes[3];	/* Address of Mailboxes, MSB first         */
+	unchar ogmbs;		/* Number of outgoing MBs, max 64, 0,1 = 1 */
+	unchar icmbs;		/* Number of incoming MBs,   ""       ""   */
 } InitCmd;
 
 /*
@@ -430,29 +426,29 @@
  *  WD7000-specific scatter/gather element structure
  */
 typedef struct sgb {
-    unchar len[3];
-    unchar ptr[3];		/* Also SCSI-style - MSB first */
+	unchar len[3];
+	unchar ptr[3];		/* Also SCSI-style - MSB first */
 } Sgb;
 
 typedef struct scb {		/* Command Control Block 5.4.1               */
-    unchar op;			/* Command Control Block Operation Code      */
-    unchar idlun;		/* op=0,2:Target Id, op=1:Initiator Id       */
-				/* Outbound data transfer, length is checked */
-				/* Inbound data transfer, length is checked  */
-				/* Logical Unit Number                       */
-    unchar cdb[12];		/* SCSI Command Block                        */
-    volatile unchar status;	/* SCSI Return Status                        */
-    volatile unchar vue;	/* Vendor Unique Error Code                  */
-    unchar maxlen[3];		/* Maximum Data Transfer Length              */
-    unchar dataptr[3];		/* SCSI Data Block Pointer                   */
-    unchar linkptr[3];		/* Next Command Link Pointer                 */
-    unchar direc;		/* Transfer Direction                        */
-    unchar reserved2[6];	/* SCSI Command Descriptor Block             */
-				/* end of hardware SCB                       */
-    Scsi_Cmnd *SCpnt;		/* Scsi_Cmnd using this SCB                  */
-    Sgb sgb[WD7000_SG];		/* Scatter/gather list for this SCB          */
-    Adapter *host;		/* host adapter                              */
-    struct scb *next;		/* for lists of scbs                         */
+	unchar op;		/* Command Control Block Operation Code      */
+	unchar idlun;		/* op=0,2:Target Id, op=1:Initiator Id       */
+	/* Outbound data transfer, length is checked */
+	/* Inbound data transfer, length is checked  */
+	/* Logical Unit Number                       */
+	unchar cdb[12];		/* SCSI Command Block                        */
+	volatile unchar status;	/* SCSI Return Status                        */
+	volatile unchar vue;	/* Vendor Unique Error Code                  */
+	unchar maxlen[3];	/* Maximum Data Transfer Length              */
+	unchar dataptr[3];	/* SCSI Data Block Pointer                   */
+	unchar linkptr[3];	/* Next Command Link Pointer                 */
+	unchar direc;		/* Transfer Direction                        */
+	unchar reserved2[6];	/* SCSI Command Descriptor Block             */
+	/* end of hardware SCB                       */
+	Scsi_Cmnd *SCpnt;	/* Scsi_Cmnd using this SCB                  */
+	Sgb sgb[WD7000_SG];	/* Scatter/gather list for this SCB          */
+	Adapter *host;		/* host adapter                              */
+	struct scb *next;	/* for lists of scbs                         */
 } Scb;
 
 /*
@@ -484,56 +480,56 @@
 #define ICB_OP_GET_EPARMS     0x8F	/* read execution parameters           */
 
 typedef struct icbRecvCmd {
-    unchar op;
-    unchar IDlun;		/* Initiator SCSI ID/lun     */
-    unchar len[3];		/* command buffer length     */
-    unchar ptr[3];		/* command buffer address    */
-    unchar rsvd[7];		/* reserved                  */
-    volatile unchar vue;	/* vendor-unique error code  */
-    volatile unchar status;	/* returned (icmb) status    */
-    volatile unchar phase;	/* used by interrupt handler */
+	unchar op;
+	unchar IDlun;		/* Initiator SCSI ID/lun     */
+	unchar len[3];		/* command buffer length     */
+	unchar ptr[3];		/* command buffer address    */
+	unchar rsvd[7];		/* reserved                  */
+	volatile unchar vue;	/* vendor-unique error code  */
+	volatile unchar status;	/* returned (icmb) status    */
+	volatile unchar phase;	/* used by interrupt handler */
 } IcbRecvCmd;
 
 typedef struct icbSendStat {
-    unchar op;
-    unchar IDlun;		/* Target SCSI ID/lun                  */
-    unchar stat;		/* (outgoing) completion status byte 1 */
-    unchar rsvd[12];		/* reserved                            */
-    volatile unchar vue;	/* vendor-unique error code            */
-    volatile unchar status;	/* returned (icmb) status              */
-    volatile unchar phase;	/* used by interrupt handler           */
+	unchar op;
+	unchar IDlun;		/* Target SCSI ID/lun                  */
+	unchar stat;		/* (outgoing) completion status byte 1 */
+	unchar rsvd[12];	/* reserved                            */
+	volatile unchar vue;	/* vendor-unique error code            */
+	volatile unchar status;	/* returned (icmb) status              */
+	volatile unchar phase;	/* used by interrupt handler           */
 } IcbSendStat;
 
 typedef struct icbRevLvl {
-    unchar op;
-    volatile unchar primary;	/* primary revision level (returned)   */
-    volatile unchar secondary;	/* secondary revision level (returned) */
-    unchar rsvd[12];		/* reserved                            */
-    volatile unchar vue;	/* vendor-unique error code            */
-    volatile unchar status;	/* returned (icmb) status              */
-    volatile unchar phase;	/* used by interrupt handler           */
+	unchar op;
+	volatile unchar primary;	/* primary revision level (returned)   */
+	volatile unchar secondary;	/* secondary revision level (returned) */
+	unchar rsvd[12];	/* reserved                            */
+	volatile unchar vue;	/* vendor-unique error code            */
+	volatile unchar status;	/* returned (icmb) status              */
+	volatile unchar phase;	/* used by interrupt handler           */
 } IcbRevLvl;
 
 typedef struct icbUnsMask {	/* I'm totally guessing here */
-    unchar op;
-    volatile unchar mask[14];	/* mask bits                 */
+	unchar op;
+	volatile unchar mask[14];	/* mask bits                 */
 #if 0
-    unchar rsvd[12];		/* reserved                  */
+	unchar rsvd[12];	/* reserved                  */
 #endif
-    volatile unchar vue;	/* vendor-unique error code  */
-    volatile unchar status;	/* returned (icmb) status    */
-    volatile unchar phase;	/* used by interrupt handler */
+	volatile unchar vue;	/* vendor-unique error code  */
+	volatile unchar status;	/* returned (icmb) status    */
+	volatile unchar phase;	/* used by interrupt handler */
 } IcbUnsMask;
 
 typedef struct icbDiag {
-    unchar op;
-    unchar type;		/* diagnostics type code (0-3) */
-    unchar len[3];		/* buffer length               */
-    unchar ptr[3];		/* buffer address              */
-    unchar rsvd[7];		/* reserved                    */
-    volatile unchar vue;	/* vendor-unique error code    */
-    volatile unchar status;	/* returned (icmb) status      */
-    volatile unchar phase;	/* used by interrupt handler   */
+	unchar op;
+	unchar type;		/* diagnostics type code (0-3) */
+	unchar len[3];		/* buffer length               */
+	unchar ptr[3];		/* buffer address              */
+	unchar rsvd[7];		/* reserved                    */
+	volatile unchar vue;	/* vendor-unique error code    */
+	volatile unchar status;	/* returned (icmb) status      */
+	volatile unchar phase;	/* used by interrupt handler   */
 } IcbDiag;
 
 #define ICB_DIAG_POWERUP   0	/* Power-up diags only       */
@@ -542,34 +538,34 @@
 #define ICB_DIAG_FULL      3	/* do both 1 & 2             */
 
 typedef struct icbParms {
-    unchar op;
-    unchar rsvd1;		/* reserved                  */
-    unchar len[3];		/* parms buffer length       */
-    unchar ptr[3];		/* parms buffer address      */
-    unchar idx[2];		/* index (MSB-LSB)           */
-    unchar rsvd2[5];		/* reserved                  */
-    volatile unchar vue;	/* vendor-unique error code  */
-    volatile unchar status;	/* returned (icmb) status    */
-    volatile unchar phase;	/* used by interrupt handler */
+	unchar op;
+	unchar rsvd1;		/* reserved                  */
+	unchar len[3];		/* parms buffer length       */
+	unchar ptr[3];		/* parms buffer address      */
+	unchar idx[2];		/* index (MSB-LSB)           */
+	unchar rsvd2[5];	/* reserved                  */
+	volatile unchar vue;	/* vendor-unique error code  */
+	volatile unchar status;	/* returned (icmb) status    */
+	volatile unchar phase;	/* used by interrupt handler */
 } IcbParms;
 
 typedef struct icbAny {
-    unchar op;
-    unchar data[14];		/* format-specific data      */
-    volatile unchar vue;	/* vendor-unique error code  */
-    volatile unchar status;	/* returned (icmb) status    */
-    volatile unchar phase;	/* used by interrupt handler */
+	unchar op;
+	unchar data[14];	/* format-specific data      */
+	volatile unchar vue;	/* vendor-unique error code  */
+	volatile unchar status;	/* returned (icmb) status    */
+	volatile unchar phase;	/* used by interrupt handler */
 } IcbAny;
 
 typedef union icb {
-    unchar op;			/* ICB opcode                     */
-    IcbRecvCmd recv_cmd;	/* format for receive command     */
-    IcbSendStat send_stat;	/* format for send status         */
-    IcbRevLvl rev_lvl;		/* format for get revision level  */
-    IcbDiag diag;		/* format for execute diagnostics */
-    IcbParms eparms;		/* format for get/set exec parms  */
-    IcbAny icb;			/* generic format                 */
-    unchar data[18];
+	unchar op;		/* ICB opcode                     */
+	IcbRecvCmd recv_cmd;	/* format for receive command     */
+	IcbSendStat send_stat;	/* format for send status         */
+	IcbRevLvl rev_lvl;	/* format for get revision level  */
+	IcbDiag diag;		/* format for execute diagnostics */
+	IcbParms eparms;	/* format for get/set exec parms  */
+	IcbAny icb;		/* generic format                 */
+	unchar data[18];
 } Icb;
 
 #ifdef MODULE
@@ -586,22 +582,19 @@
 static Scb scbs[MAX_SCBS];
 static Scb *scbfree;		/* free list         */
 static int freescbs = MAX_SCBS;	/* free list counter */
-static spinlock_t scbpool_lock; /* guards the scb free list and count */
+static spinlock_t scbpool_lock;	/* guards the scb free list and count */
 
 /*
  *  END of data/declarations - code follows.
  */
 static void __init setup_error(char *mesg, int *ints)
 {
-    if (ints[0] == 3)
-        printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x\" -> %s\n",
-               ints[1], ints[2], ints[3], mesg);
-    else if (ints[0] == 4)
-        printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x,%d\" -> %s\n",
-               ints[1], ints[2], ints[3], ints[4], mesg);
-    else
-        printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x,%d,%d\" -> %s\n",
-               ints[1], ints[2], ints[3], ints[4], ints[5], mesg);
+	if (ints[0] == 3)
+		printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x\" -> %s\n", ints[1], ints[2], ints[3], mesg);
+	else if (ints[0] == 4)
+		printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x,%d\" -> %s\n", ints[1], ints[2], ints[3], ints[4], mesg);
+	else
+		printk(KERN_ERR "wd7000_setup: \"wd7000=%d,%d,0x%x,%d,%d\" -> %s\n", ints[1], ints[2], ints[3], ints[4], ints[5], mesg);
 }
 
 
@@ -621,23 +614,19 @@
  */
 static int __init wd7000_setup(char *str)
 {
-	static short wd7000_card_num; /* .bss will zero this */
+	static short wd7000_card_num;	/* .bss will zero this */
 	short i;
 	int ints[6];
 
-	(void)get_options(str, ARRAY_SIZE(ints), ints);
+	(void) get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (wd7000_card_num >= NUM_CONFIGS) {
-		printk(KERN_ERR
-			"%s: Too many \"wd7000=\" configurations in "
-			"command line!\n", __FUNCTION__);
+		printk(KERN_ERR "%s: Too many \"wd7000=\" configurations in " "command line!\n", __FUNCTION__);
 		return 0;
 	}
 
 	if ((ints[0] < 3) || (ints[0] > 5)) {
-		printk(KERN_ERR "%s: Error in command line!  "
-			"Usage: wd7000=<IRQ>,<DMA>,IO>[,<BUS_ON>"
-			"[,<BUS_OFF>]]\n", __FUNCTION__);
+		printk(KERN_ERR "%s: Error in command line!  " "Usage: wd7000=<IRQ>,<DMA>,IO>[,<BUS_ON>" "[,<BUS_OFF>]]\n", __FUNCTION__);
 	} else {
 		for (i = 0; i < NUM_IRQS; i++)
 			if (ints[1] == wd7000_irq[i])
@@ -671,8 +660,7 @@
 
 		if (ints[0] > 3) {
 			if ((ints[4] < 500) || (ints[4] > 31875)) {
-				setup_error("BUS_ON value is out of range (500"
-					    " to 31875 nanoseconds)!", ints);
+				setup_error("BUS_ON value is out of range (500" " to 31875 nanoseconds)!", ints);
 				configs[wd7000_card_num].bus_on = BUS_ON;
 			} else
 				configs[wd7000_card_num].bus_on = ints[4] / 125;
@@ -681,12 +669,10 @@
 
 		if (ints[0] > 4) {
 			if ((ints[5] < 500) || (ints[5] > 31875)) {
-				setup_error("BUS_OFF value is out of range (500"
-					    " to 31875 nanoseconds)!", ints);
+				setup_error("BUS_OFF value is out of range (500" " to 31875 nanoseconds)!", ints);
 				configs[wd7000_card_num].bus_off = BUS_OFF;
 			} else
-				configs[wd7000_card_num].bus_off = ints[5] /
-								   125;
+				configs[wd7000_card_num].bus_off = ints[5] / 125;
 		} else
 			configs[wd7000_card_num].bus_off = BUS_OFF;
 
@@ -696,32 +682,22 @@
 
 				for (; j < wd7000_card_num; j++)
 					if (configs[i].irq == configs[j].irq) {
-						setup_error("duplicated IRQ!",
-							    ints);
-						return 0;
-					}
-					if (configs[i].dma == configs[j].dma) {
-						setup_error("duplicated DMA "
-							    "channel!", ints);
-						return 0;
-					}
-					if (configs[i].iobase ==
-					    configs[j].iobase) {
-						setup_error("duplicated I/O "
-							    "base address!",
-							    ints);
+						setup_error("duplicated IRQ!", ints);
 						return 0;
 					}
+				if (configs[i].dma == configs[j].dma) {
+					setup_error("duplicated DMA " "channel!", ints);
+					return 0;
+				}
+				if (configs[i].iobase == configs[j].iobase) {
+					setup_error("duplicated I/O " "base address!", ints);
+					return 0;
+				}
 			}
 		}
 
 		dprintk(KERN_DEBUG "wd7000_setup: IRQ=%d, DMA=%d, I/O=0x%x, "
-				  "BUS_ON=%dns, BUS_OFF=%dns\n",
-			configs[wd7000_card_num].irq,
-			configs[wd7000_card_num].dma,
-			configs[wd7000_card_num].iobase,
-			configs[wd7000_card_num].bus_on * 125,
-			configs[wd7000_card_num].bus_off * 125);
+			"BUS_ON=%dns, BUS_OFF=%dns\n", configs[wd7000_card_num].irq, configs[wd7000_card_num].dma, configs[wd7000_card_num].iobase, configs[wd7000_card_num].bus_on * 125, configs[wd7000_card_num].bus_off * 125);
 
 		wd7000_card_num++;
 	}
@@ -740,29 +716,29 @@
  * (They were simply 4-byte versions of these routines).
  */
 typedef union {			/* let's cheat... */
-    int i;
-    unchar u[sizeof (int)];	/* the sizeof(int) makes it more portable */
+	int i;
+	unchar u[sizeof(int)];	/* the sizeof(int) makes it more portable */
 } i_u;
 
 
-static inline void any2scsi (unchar * scsi, int any)
+static inline void any2scsi(unchar * scsi, int any)
 {
-    *scsi++ = ((i_u) any).u[2];
-    *scsi++ = ((i_u) any).u[1];
-    *scsi++ = ((i_u) any).u[0];
+	*scsi++ = ((i_u) any).u[2];
+	*scsi++ = ((i_u) any).u[1];
+	*scsi++ = ((i_u) any).u[0];
 }
 
 
-static inline int scsi2int (unchar * scsi)
+static inline int scsi2int(unchar * scsi)
 {
-    i_u result;
+	i_u result;
 
-    result.i = 0;		/* clears unused bytes */
-    result.u[2] = *scsi++;
-    result.u[1] = *scsi++;
-    result.u[0] = *scsi++;
+	result.i = 0;		/* clears unused bytes */
+	result.u[2] = *scsi++;
+	result.u[1] = *scsi++;
+	result.u[0] = *scsi++;
 
-    return (result.i);
+	return (result.i);
 }
 #else
 /*
@@ -780,63 +756,63 @@
 #endif
 
 
-static inline void wd7000_enable_intr (Adapter *host)
+static inline void wd7000_enable_intr(Adapter * host)
 {
-    host->control |= INT_EN;
-    outb (host->control, host->iobase + ASC_CONTROL);
+	host->control |= INT_EN;
+	outb(host->control, host->iobase + ASC_CONTROL);
 }
 
 
-static inline void wd7000_enable_dma (Adapter *host)
+static inline void wd7000_enable_dma(Adapter * host)
 {
-    unsigned long flags;
-    host->control |= DMA_EN;
-    outb (host->control, host->iobase + ASC_CONTROL);
-    
-    flags = claim_dma_lock();
-    set_dma_mode (host->dma, DMA_MODE_CASCADE);
-    enable_dma (host->dma);
-    release_dma_lock(flags);
-    
+	unsigned long flags;
+	host->control |= DMA_EN;
+	outb(host->control, host->iobase + ASC_CONTROL);
+
+	flags = claim_dma_lock();
+	set_dma_mode(host->dma, DMA_MODE_CASCADE);
+	enable_dma(host->dma);
+	release_dma_lock(flags);
+
 }
 
 
 #define WAITnexttimeout 200	/* 2 seconds */
 
-static inline short WAIT (unsigned port, unsigned mask, unsigned allof, unsigned noneof)
+static inline short WAIT(unsigned port, unsigned mask, unsigned allof, unsigned noneof)
 {
-    register unsigned WAITbits;
-    register unsigned long WAITtimeout = jiffies + WAITnexttimeout;
+	register unsigned WAITbits;
+	register unsigned long WAITtimeout = jiffies + WAITnexttimeout;
 
-    while (time_before_eq(jiffies, WAITtimeout)) {
-	WAITbits = inb (port) & mask;
+	while (time_before_eq(jiffies, WAITtimeout)) {
+		WAITbits = inb(port) & mask;
 
-	if (((WAITbits & allof) == allof) && ((WAITbits & noneof) == 0))
-	    return (0);
-    }
+		if (((WAITbits & allof) == allof) && ((WAITbits & noneof) == 0))
+			return (0);
+	}
 
-    return (1);
+	return (1);
 }
 
 
-static inline int command_out (Adapter * host, unchar * cmd, int len)
+static inline int command_out(Adapter * host, unchar * cmd, int len)
 {
-    if (!WAIT (host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
-	while (len--) {
-	    do {
-		outb (*cmd, host->iobase + ASC_COMMAND);
-		WAIT (host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0);
-	    } while (inb (host->iobase + ASC_STAT) & CMD_REJ);
+	if (!WAIT(host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
+		while (len--) {
+			do {
+				outb(*cmd, host->iobase + ASC_COMMAND);
+				WAIT(host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0);
+			} while (inb(host->iobase + ASC_STAT) & CMD_REJ);
 
-	    cmd++;
-	}
+			cmd++;
+		}
 
-	return (1);
-    }
+		return (1);
+	}
 
-    printk(KERN_WARNING "wd7000 command_out: WAIT failed(%d)\n", len + 1);
+	printk(KERN_WARNING "wd7000 command_out: WAIT failed(%d)\n", len + 1);
 
-    return (0);
+	return (0);
 }
 
 
@@ -852,655 +828,645 @@
  */
 static inline Scb *alloc_scbs(struct Scsi_Host *host, int needed)
 {
-    register Scb *scb, *p = NULL;
-    register unsigned long flags;
-    register unsigned long timeout = jiffies + WAITnexttimeout;
-    register unsigned long now;
-    int i;
-
-    if (needed <= 0)
-	return (NULL);		/* sanity check */
-
-    spin_unlock_irq(host->host_lock);
-	
-retry:
-    while (freescbs < needed) {
-	timeout = jiffies + WAITnexttimeout;
-	do {
-	    /* FIXME: can we actually just yield here ?? */
-	    for (now = jiffies; now == jiffies; )
-	    	cpu_relax();	/* wait a jiffy */
-	} while (freescbs < needed && time_before_eq(jiffies, timeout));
-	/*
-	 *  If we get here with enough free Scbs, we can take them.
-	 *  Otherwise, we timed out and didn't get enough.
-	 */
+	register Scb *scb, *p = NULL;
+	register unsigned long flags;
+	register unsigned long timeout = jiffies + WAITnexttimeout;
+	register unsigned long now;
+	int i;
+
+	if (needed <= 0)
+		return (NULL);	/* sanity check */
+
+	spin_unlock_irq(host->host_lock);
+
+      retry:
+	while (freescbs < needed) {
+		timeout = jiffies + WAITnexttimeout;
+		do {
+			/* FIXME: can we actually just yield here ?? */
+			for (now = jiffies; now == jiffies;)
+				cpu_relax();	/* wait a jiffy */
+		} while (freescbs < needed && time_before_eq(jiffies, timeout));
+		/*
+		 *  If we get here with enough free Scbs, we can take them.
+		 *  Otherwise, we timed out and didn't get enough.
+		 */
+		if (freescbs < needed) {
+			printk(KERN_ERR "wd7000: can't get enough free SCBs.\n");
+			return (NULL);
+		}
+	}
+
+	/* Take the lock, then check we didnt get beaten, if so try again */
+	spin_lock_irqsave(&scbpool_lock, flags);
 	if (freescbs < needed) {
-	    printk (KERN_ERR "wd7000: can't get enough free SCBs.\n");
-	    spin_unlock_irq(host->host_lock);
-	    return (NULL);
+		spin_unlock_irqrestore(&scbpool_lock, flags);
+		goto retry;
+	}
+
+	scb = scbfree;
+	freescbs -= needed;
+	for (i = 0; i < needed; i++) {
+		p = scbfree;
+		scbfree = p->next;
 	}
-    }
+	p->next = NULL;
 
-    /* Take the lock, then check we didnt get beaten, if so try again */
-    spin_lock_irqsave(&scbpool_lock, flags);
-    if(freescbs < needed)
-    {
-    	spin_unlock_irqrestore(&scbpool_lock, flags);
-    	goto retry;
-    }
-    	
-    scb = scbfree;
-    freescbs -= needed;
-    for (i = 0; i < needed; i++) {
-	p = scbfree;
-	scbfree = p->next;
-    }
-    p->next = NULL;
-   
-    spin_unlock_irqrestore(&scbpool_lock, flags);
+	spin_unlock_irqrestore(&scbpool_lock, flags);
 
-    spin_lock_irq(host->host_lock);
-    return (scb);
+	spin_lock_irq(host->host_lock);
+	return (scb);
 }
 
 
-static inline void free_scb (Scb *scb)
+static inline void free_scb(Scb * scb)
 {
-    register unsigned long flags;
+	register unsigned long flags;
 
-    spin_lock_irqsave(&scbpool_lock, flags);
+	spin_lock_irqsave(&scbpool_lock, flags);
 
-    memset (scb, 0, sizeof (Scb));
-    scb->next = scbfree;
-    scbfree = scb;
-    freescbs++;
+	memset(scb, 0, sizeof(Scb));
+	scb->next = scbfree;
+	scbfree = scb;
+	freescbs++;
 
-    spin_unlock_irqrestore(&scbpool_lock, flags);
+	spin_unlock_irqrestore(&scbpool_lock, flags);
 }
 
 
-static inline void init_scbs (void)
+static inline void init_scbs(void)
 {
-    int i;
+	int i;
 
-    spin_lock_init(&scbpool_lock);
+	spin_lock_init(&scbpool_lock);
 
-    /* This is only ever called before the SCB pool is active */
-    
-    scbfree = &(scbs[0]);
-    memset (scbs, 0, sizeof (scbs));
-    for (i = 0; i < MAX_SCBS - 1; i++) {
-	scbs[i].next = &(scbs[i + 1]);
-	scbs[i].SCpnt = NULL;
-    }
-    scbs[MAX_SCBS - 1].next = NULL;
-    scbs[MAX_SCBS - 1].SCpnt = NULL;
+	/* This is only ever called before the SCB pool is active */
+
+	scbfree = &(scbs[0]);
+	memset(scbs, 0, sizeof(scbs));
+	for (i = 0; i < MAX_SCBS - 1; i++) {
+		scbs[i].next = &(scbs[i + 1]);
+		scbs[i].SCpnt = NULL;
+	}
+	scbs[MAX_SCBS - 1].next = NULL;
+	scbs[MAX_SCBS - 1].SCpnt = NULL;
 }
 
 
-static int mail_out (Adapter *host, Scb *scbptr)
+static int mail_out(Adapter * host, Scb * scbptr)
 /*
  *  Note: this can also be used for ICBs; just cast to the parm type.
  */
 {
-    register int i, ogmb;
-    register unsigned long flags;
-    unchar start_ogmb;
-    Mailbox *ogmbs = host->mb.ogmb;
-    int *next_ogmb = &(host->next_ogmb);
-
-    dprintk("wd7000_mail_out: 0x%06lx", (long) scbptr);
-
-    /* We first look for a free outgoing mailbox */
-    spin_lock_irqsave(host->sh->host_lock, flags);
-    ogmb = *next_ogmb;
-    for (i = 0; i < OGMB_CNT; i++) {
-	if (ogmbs[ogmb].status == 0) {
-	    dprintk(" using OGMB 0x%x", ogmb);
-	    ogmbs[ogmb].status = 1;
-	    any2scsi ((unchar *) ogmbs[ogmb].scbptr, (int) scbptr);
+	register int i, ogmb;
+	register unsigned long flags;
+	unchar start_ogmb;
+	Mailbox *ogmbs = host->mb.ogmb;
+	int *next_ogmb = &(host->next_ogmb);
+
+	dprintk("wd7000_mail_out: 0x%06lx", (long) scbptr);
+
+	/* We first look for a free outgoing mailbox */
+	spin_lock_irqsave(host->sh->host_lock, flags);
+	ogmb = *next_ogmb;
+	for (i = 0; i < OGMB_CNT; i++) {
+		if (ogmbs[ogmb].status == 0) {
+			dprintk(" using OGMB 0x%x", ogmb);
+			ogmbs[ogmb].status = 1;
+			any2scsi((unchar *) ogmbs[ogmb].scbptr, (int) scbptr);
 
-	    *next_ogmb = (ogmb + 1) % OGMB_CNT;
-	    break;
+			*next_ogmb = (ogmb + 1) % OGMB_CNT;
+			break;
+		} else
+			ogmb = (ogmb + 1) % OGMB_CNT;
 	}
-	else
-	    ogmb = (ogmb + 1) % OGMB_CNT;
-    }
-    spin_unlock_irqrestore(host->sh->host_lock, flags);
-    
-    dprintk(", scb is 0x%06lx", (long) scbptr);
+	spin_unlock_irqrestore(host->sh->host_lock, flags);
 
-    if (i >= OGMB_CNT) {
-	/*
-	 *  Alternatively, we might issue the "interrupt on free OGMB",
-	 *  and sleep, but it must be ensured that it isn't the init
-	 *  task running.  Instead, this version assumes that the caller
-	 *  will be persistent, and try again.  Since it's the adapter
-	 *  that marks OGMB's free, waiting even with interrupts off
-	 *  should work, since they are freed very quickly in most cases.
-	 */
-	dprintk(", no free OGMBs.\n");
-	return (0);
-    }
+	dprintk(", scb is 0x%06lx", (long) scbptr);
+
+	if (i >= OGMB_CNT) {
+		/*
+		 *  Alternatively, we might issue the "interrupt on free OGMB",
+		 *  and sleep, but it must be ensured that it isn't the init
+		 *  task running.  Instead, this version assumes that the caller
+		 *  will be persistent, and try again.  Since it's the adapter
+		 *  that marks OGMB's free, waiting even with interrupts off
+		 *  should work, since they are freed very quickly in most cases.
+		 */
+		dprintk(", no free OGMBs.\n");
+		return (0);
+	}
 
-    wd7000_enable_intr (host);
+	wd7000_enable_intr(host);
 
-    start_ogmb = START_OGMB | ogmb;
-    command_out (host, &start_ogmb, 1);
+	start_ogmb = START_OGMB | ogmb;
+	command_out(host, &start_ogmb, 1);
 
-    dprintk(", awaiting interrupt.\n");
+	dprintk(", awaiting interrupt.\n");
 
-    return (1);
+	return (1);
 }
 
 
-static int make_code (unsigned hosterr, unsigned scsierr)
+static int make_code(unsigned hosterr, unsigned scsierr)
 {
 #ifdef WD7000_DEBUG
-    int in_error = hosterr;
+	int in_error = hosterr;
 #endif
 
-    switch ((hosterr >> 8) & 0xff) {
-	case 0:  /* Reserved */
-                 hosterr = DID_ERROR;
-                 break;
-	case 1:  /* Command Complete, no errors */
-                 hosterr = DID_OK;
-                 break;
-	case 2:  /* Command complete, error logged in scb status (scsierr) */
-                 hosterr = DID_OK;
-                 break;
-	case 4:  /* Command failed to complete - timeout */
-                 hosterr = DID_TIME_OUT;
-                 break;
-	case 5:  /* Command terminated; Bus reset by external device */
-                 hosterr = DID_RESET;
-                 break;
-	case 6:  /* Unexpected Command Received w/ host as target */
-                 hosterr = DID_BAD_TARGET;
-                 break;
-	case 80: /* Unexpected Reselection */
-	case 81: /* Unexpected Selection */
-                 hosterr = DID_BAD_INTR;
-                 break;
-	case 82: /* Abort Command Message  */
-                 hosterr = DID_ABORT;
-                 break;
-	case 83: /* SCSI Bus Software Reset */
-	case 84: /* SCSI Bus Hardware Reset */
-                 hosterr = DID_RESET;
-                 break;
-	default: /* Reserved */
-                 hosterr = DID_ERROR;
-    }
+	switch ((hosterr >> 8) & 0xff) {
+	case 0:		/* Reserved */
+		hosterr = DID_ERROR;
+		break;
+	case 1:		/* Command Complete, no errors */
+		hosterr = DID_OK;
+		break;
+	case 2:		/* Command complete, error logged in scb status (scsierr) */
+		hosterr = DID_OK;
+		break;
+	case 4:		/* Command failed to complete - timeout */
+		hosterr = DID_TIME_OUT;
+		break;
+	case 5:		/* Command terminated; Bus reset by external device */
+		hosterr = DID_RESET;
+		break;
+	case 6:		/* Unexpected Command Received w/ host as target */
+		hosterr = DID_BAD_TARGET;
+		break;
+	case 80:		/* Unexpected Reselection */
+	case 81:		/* Unexpected Selection */
+		hosterr = DID_BAD_INTR;
+		break;
+	case 82:		/* Abort Command Message  */
+		hosterr = DID_ABORT;
+		break;
+	case 83:		/* SCSI Bus Software Reset */
+	case 84:		/* SCSI Bus Hardware Reset */
+		hosterr = DID_RESET;
+		break;
+	default:		/* Reserved */
+		hosterr = DID_ERROR;
+	}
 #ifdef WD7000_DEBUG
-    if (scsierr || hosterr)
-	dprintk("\nSCSI command error: SCSI 0x%02x host 0x%04x return %d\n",
-		scsierr, in_error, hosterr);
+	if (scsierr || hosterr)
+		dprintk("\nSCSI command error: SCSI 0x%02x host 0x%04x return %d\n", scsierr, in_error, hosterr);
 #endif
-    return (scsierr | (hosterr << 16));
+	return (scsierr | (hosterr << 16));
 }
 
 
-static void wd7000_scsi_done (Scsi_Cmnd *SCpnt)
+static void wd7000_scsi_done(Scsi_Cmnd * SCpnt)
 {
-    dprintk("wd7000_scsi_done: 0x%06lx\n", (long)SCpnt);
-    SCpnt->SCp.phase = 0;
+	dprintk("wd7000_scsi_done: 0x%06lx\n", (long) SCpnt);
+	SCpnt->SCp.phase = 0;
 }
 
 
 #define wd7000_intr_ack(host)   outb (0, host->iobase + ASC_INTR_ACK)
 
-static void wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
+static void wd7000_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
 {
-    register int flag, icmb, errstatus, icmb_status;
-    register int host_error, scsi_error;
-    register Scb *scb;		/* for SCSI commands */
-    register IcbAny *icb;	/* for host commands */
-    register Scsi_Cmnd *SCpnt;
-    Adapter *host = (Adapter *)dev_id;
-    Mailbox *icmbs = host->mb.icmb;
-
-    host->int_counter++;
-
-    dprintk("wd7000_intr_handle: irq = %d, host = 0x%06lx\n", irq, (long) host);
-
-    flag = inb (host->iobase + ASC_INTR_STAT);
-
-    dprintk("wd7000_intr_handle: intr stat = 0x%02x\n", flag);
-
-    if (!(inb (host->iobase + ASC_STAT) & INT_IM)) {
-	/* NB: these are _very_ possible if IRQ 15 is being used, since
-	 * it's the "garbage collector" on the 2nd 8259 PIC.  Specifically,
-	 * any interrupt signal into the 8259 which can't be identified
-	 * comes out as 7 from the 8259, which is 15 to the host.  Thus, it
-	 * is a good thing the WD7000 has an interrupt status port, so we
-	 * can sort these out.  Otherwise, electrical noise and other such
-	 * problems would be indistinguishable from valid interrupts...
-	 */
-	dprintk("wd7000_intr_handle: phantom interrupt...\n");
-	wd7000_intr_ack (host);
-	return;
-    }
-
-    if (flag & MB_INTR) {
-	/* The interrupt is for a mailbox */
-	if (!(flag & IMB_INTR)) {
-	    dprintk("wd7000_intr_handle: free outgoing mailbox\n");
-	    /*
-	     * If sleep_on() and the "interrupt on free OGMB" command are
-	     * used in mail_out(), wake_up() should correspondingly be called
-	     * here.  For now, we don't need to do anything special.
-	     */
-	    wd7000_intr_ack (host);
-	    return;
-	}
-	else {
-	    /* The interrupt is for an incoming mailbox */
-	    icmb = flag & MB_MASK;
-	    icmb_status = icmbs[icmb].status;
-	    if (icmb_status & 0x80) {	/* unsolicited - result in ICMB */
-		dprintk("wd7000_intr_handle: unsolicited interrupt 0x%02x\n",
-			icmb_status);
-		wd7000_intr_ack (host);
+	register int flag, icmb, errstatus, icmb_status;
+	register int host_error, scsi_error;
+	register Scb *scb;	/* for SCSI commands */
+	register IcbAny *icb;	/* for host commands */
+	register Scsi_Cmnd *SCpnt;
+	Adapter *host = (Adapter *) dev_id;
+	Mailbox *icmbs = host->mb.icmb;
+
+	host->int_counter++;
+
+	dprintk("wd7000_intr_handle: irq = %d, host = 0x%06lx\n", irq, (long) host);
+
+	flag = inb(host->iobase + ASC_INTR_STAT);
+
+	dprintk("wd7000_intr_handle: intr stat = 0x%02x\n", flag);
+
+	if (!(inb(host->iobase + ASC_STAT) & INT_IM)) {
+		/* NB: these are _very_ possible if IRQ 15 is being used, since
+		 * it's the "garbage collector" on the 2nd 8259 PIC.  Specifically,
+		 * any interrupt signal into the 8259 which can't be identified
+		 * comes out as 7 from the 8259, which is 15 to the host.  Thus, it
+		 * is a good thing the WD7000 has an interrupt status port, so we
+		 * can sort these out.  Otherwise, electrical noise and other such
+		 * problems would be indistinguishable from valid interrupts...
+		 */
+		dprintk("wd7000_intr_handle: phantom interrupt...\n");
+		wd7000_intr_ack(host);
 		return;
-	    }
-	    /* Aaaargh! (Zaga) */
-	    scb = isa_bus_to_virt(scsi2int ((unchar *) icmbs[icmb].scbptr));
-	    icmbs[icmb].status = 0;
-	    if (!(scb->op & ICB_OP_MASK)) {	/* an SCB is done */
-		SCpnt = scb->SCpnt;
-		if (--(SCpnt->SCp.phase) <= 0) {	/* all scbs are done */
-		    host_error = scb->vue | (icmb_status << 8);
-		    scsi_error = scb->status;
-		    errstatus = make_code (host_error, scsi_error);
-		    SCpnt->result = errstatus;
-
-		    free_scb (scb);
+	}
 
-		    SCpnt->scsi_done (SCpnt);
-		}
-	    }
-	    else {		/* an ICB is done */
-		icb = (IcbAny *) scb;
-		icb->status = icmb_status;
-		icb->phase = 0;
-	    }
-	}			/* incoming mailbox */
-    }
+	if (flag & MB_INTR) {
+		/* The interrupt is for a mailbox */
+		if (!(flag & IMB_INTR)) {
+			dprintk("wd7000_intr_handle: free outgoing mailbox\n");
+			/*
+			 * If sleep_on() and the "interrupt on free OGMB" command are
+			 * used in mail_out(), wake_up() should correspondingly be called
+			 * here.  For now, we don't need to do anything special.
+			 */
+			wd7000_intr_ack(host);
+			return;
+		} else {
+			/* The interrupt is for an incoming mailbox */
+			icmb = flag & MB_MASK;
+			icmb_status = icmbs[icmb].status;
+			if (icmb_status & 0x80) {	/* unsolicited - result in ICMB */
+				dprintk("wd7000_intr_handle: unsolicited interrupt 0x%02x\n", icmb_status);
+				wd7000_intr_ack(host);
+				return;
+			}
+			/* Aaaargh! (Zaga) */
+			scb = isa_bus_to_virt(scsi2int((unchar *) icmbs[icmb].scbptr));
+			icmbs[icmb].status = 0;
+			if (!(scb->op & ICB_OP_MASK)) {	/* an SCB is done */
+				SCpnt = scb->SCpnt;
+				if (--(SCpnt->SCp.phase) <= 0) {	/* all scbs are done */
+					host_error = scb->vue | (icmb_status << 8);
+					scsi_error = scb->status;
+					errstatus = make_code(host_error, scsi_error);
+					SCpnt->result = errstatus;
+
+					free_scb(scb);
+
+					SCpnt->scsi_done(SCpnt);
+				}
+			} else {	/* an ICB is done */
+				icb = (IcbAny *) scb;
+				icb->status = icmb_status;
+				icb->phase = 0;
+			}
+		}		/* incoming mailbox */
+	}
 
-    wd7000_intr_ack (host);
+	wd7000_intr_ack(host);
 
-    dprintk("wd7000_intr_handle: return from interrupt handler\n");
+	dprintk("wd7000_intr_handle: return from interrupt handler\n");
 }
 
-static void do_wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
+static void do_wd7000_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
 {
-    unsigned long flags;
-    struct Scsi_Host *host = dev_id;
+	unsigned long flags;
+	struct Scsi_Host *host = dev_id;
 
-    spin_lock_irqsave(host->host_lock, flags);
-    wd7000_intr_handle(irq, dev_id, regs);
-    spin_unlock_irqrestore(host->host_lock, flags);
+	spin_lock_irqsave(host->host_lock, flags);
+	wd7000_intr_handle(irq, dev_id, regs);
+	spin_unlock_irqrestore(host->host_lock, flags);
 }
 
 
-static int wd7000_queuecommand (Scsi_Cmnd *SCpnt, void (*done) (Scsi_Cmnd *))
+static int wd7000_queuecommand(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
-    register Scb *scb;
-    register Sgb *sgb;
-    register unchar *cdb = (unchar *) SCpnt->cmnd;
-    register unchar idlun;
-    register short cdblen;
-    Adapter *host = (Adapter *) SCpnt->host->hostdata;
-
-    cdblen = SCpnt->cmd_len;
-    idlun = ((SCpnt->target << 5) & 0xe0) | (SCpnt->lun & 7);
-    SCpnt->scsi_done = done;
-    SCpnt->SCp.phase = 1;
-    scb = alloc_scbs(SCpnt->host, 1);
-    scb->idlun = idlun;
-    memcpy (scb->cdb, cdb, cdblen);
-    scb->direc = 0x40;		/* Disable direction check */
+	register Scb *scb;
+	register Sgb *sgb;
+	register unchar *cdb = (unchar *) SCpnt->cmnd;
+	register unchar idlun;
+	register short cdblen;
+	Adapter *host = (Adapter *) SCpnt->host->hostdata;
 
-    scb->SCpnt = SCpnt;		/* so we can find stuff later */
-    SCpnt->host_scribble = (unchar *) scb;
-    scb->host = host;
+	cdblen = SCpnt->cmd_len;
+	idlun = ((SCpnt->target << 5) & 0xe0) | (SCpnt->lun & 7);
+	SCpnt->scsi_done = done;
+	SCpnt->SCp.phase = 1;
+	scb = alloc_scbs(SCpnt->host, 1);
+	scb->idlun = idlun;
+	memcpy(scb->cdb, cdb, cdblen);
+	scb->direc = 0x40;	/* Disable direction check */
 
-    if (SCpnt->use_sg) {
-	struct scatterlist *sg = (struct scatterlist *) SCpnt->request_buffer;
-	unsigned i;
+	scb->SCpnt = SCpnt;	/* so we can find stuff later */
+	SCpnt->host_scribble = (unchar *) scb;
+	scb->host = host;
 
-	if (SCpnt->host->sg_tablesize == SG_NONE) {
-	    panic ("wd7000_queuecommand: scatter/gather not supported.\n");
-	}
-	dprintk ("Using scatter/gather with %d elements.\n", SCpnt->use_sg);
+	if (SCpnt->use_sg) {
+		struct scatterlist *sg = (struct scatterlist *) SCpnt->request_buffer;
+		unsigned i;
 
-	sgb = scb->sgb;
-	scb->op = 1;
-	any2scsi (scb->dataptr, (int) sgb);
-	any2scsi (scb->maxlen, SCpnt->use_sg * sizeof (Sgb));
+		if (SCpnt->host->sg_tablesize == SG_NONE) {
+			panic("wd7000_queuecommand: scatter/gather not supported.\n");
+		}
+		dprintk("Using scatter/gather with %d elements.\n", SCpnt->use_sg);
 
-	for (i = 0; i < SCpnt->use_sg; i++) {
-	    any2scsi (sgb[i].ptr,
-		      isa_page_to_bus(sg[i].page) + sg[i].offset);
-	    any2scsi (sgb[i].len, sg[i].length);
+		sgb = scb->sgb;
+		scb->op = 1;
+		any2scsi(scb->dataptr, (int) sgb);
+		any2scsi(scb->maxlen, SCpnt->use_sg * sizeof(Sgb));
+
+		for (i = 0; i < SCpnt->use_sg; i++) {
+			any2scsi(sgb[i].ptr, isa_page_to_bus(sg[i].page) + sg[i].offset);
+			any2scsi(sgb[i].len, sg[i].length);
+		}
+	} else {
+		scb->op = 0;
+		any2scsi(scb->dataptr, isa_virt_to_bus(SCpnt->request_buffer));
+		any2scsi(scb->maxlen, SCpnt->request_bufflen);
 	}
-    }
-    else {
-	scb->op = 0;
-	any2scsi (scb->dataptr, isa_virt_to_bus(SCpnt->request_buffer));
-	any2scsi (scb->maxlen, SCpnt->request_bufflen);
-    }
-    
-    /* FIXME: drop lock and yield here ? */
 
-    while (!mail_out (host, scb))
-    	cpu_relax();	/* keep trying */
+	/* FIXME: drop lock and yield here ? */
+
+	while (!mail_out(host, scb))
+		cpu_relax();	/* keep trying */
 
-    return 0;
+	return 0;
 }
 
 
-static int wd7000_command (Scsi_Cmnd *SCpnt)
+static int wd7000_command(Scsi_Cmnd * SCpnt)
 {
-    wd7000_queuecommand (SCpnt, wd7000_scsi_done);
+	wd7000_queuecommand(SCpnt, wd7000_scsi_done);
 
-    while (SCpnt->SCp.phase > 0)
-    {
-    	cpu_relax();
-	barrier();		/* phase counts scbs down to 0 */
-    }
+	while (SCpnt->SCp.phase > 0) {
+		cpu_relax();
+		barrier();	/* phase counts scbs down to 0 */
+	}
 
-    return (SCpnt->result);
+	return (SCpnt->result);
 }
 
 
-static int wd7000_diagnostics (Adapter *host, int code)
+static int wd7000_diagnostics(Adapter * host, int code)
 {
-    static IcbDiag icb = {ICB_OP_DIAGNOSTICS};
-    static unchar buf[256];
-    unsigned long timeout;
+	static IcbDiag icb = { ICB_OP_DIAGNOSTICS };
+	static unchar buf[256];
+	unsigned long timeout;
 
-    icb.type = code;
-    any2scsi (icb.len, sizeof (buf));
-    any2scsi (icb.ptr, (int) &buf);
-    icb.phase = 1;
-    /*
-     * This routine is only called at init, so there should be OGMBs
-     * available.  I'm assuming so here.  If this is going to
-     * fail, I can just let the timeout catch the failure.
-     */
-    mail_out (host, (struct scb *) &icb);
-    timeout = jiffies + WAITnexttimeout;	/* wait up to 2 seconds */
-    while (icb.phase && time_before(jiffies, timeout))
-    {
-	cpu_relax();		/* wait for completion */
-	barrier();
-    }
+	icb.type = code;
+	any2scsi(icb.len, sizeof(buf));
+	any2scsi(icb.ptr, (int) &buf);
+	icb.phase = 1;
+	/*
+	 * This routine is only called at init, so there should be OGMBs
+	 * available.  I'm assuming so here.  If this is going to
+	 * fail, I can just let the timeout catch the failure.
+	 */
+	mail_out(host, (struct scb *) &icb);
+	timeout = jiffies + WAITnexttimeout;	/* wait up to 2 seconds */
+	while (icb.phase && time_before(jiffies, timeout)) {
+		cpu_relax();	/* wait for completion */
+		barrier();
+	}
 
-    if (icb.phase) {
-	printk ("wd7000_diagnostics: timed out.\n");
-	return (0);
-    }
-    if (make_code (icb.vue | (icb.status << 8), 0)) {
-	printk ("wd7000_diagnostics: failed (0x%02x,0x%02x)\n",
-		icb.vue, icb.status);
-	return (0);
-    }
+	if (icb.phase) {
+		printk("wd7000_diagnostics: timed out.\n");
+		return (0);
+	}
+	if (make_code(icb.vue | (icb.status << 8), 0)) {
+		printk("wd7000_diagnostics: failed (0x%02x,0x%02x)\n", icb.vue, icb.status);
+		return (0);
+	}
 
-    return (1);
+	return (1);
 }
 
 
-static int wd7000_adapter_reset(Adapter *host)
+static int wd7000_adapter_reset(Adapter * host)
 {
-    InitCmd init_cmd =
-    {
-	INITIALIZATION,
- 	7,
-	host->bus_on,
-	host->bus_off,
-	0,
-	{ 0, 0, 0 },
-	OGMB_CNT,
-	ICMB_CNT
-    };
-    int diag;
-    /*
-     *  Reset the adapter - only.  The SCSI bus was initialized at power-up,
-     *  and we need to do this just so we control the mailboxes, etc.
-     */
-    outb (ASC_RES, host->iobase + ASC_CONTROL);
-    udelay(40);			/* reset pulse: this is 40us, only need 25us */
-    outb (0, host->iobase + ASC_CONTROL);
-    host->control = 0;		/* this must always shadow ASC_CONTROL */
-
-    if (WAIT (host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
-	printk ("wd7000_init: WAIT timed out.\n");
-	return -1;		/* -1 = not ok */
-    }
-
-    if ((diag = inb (host->iobase + ASC_INTR_STAT)) != 1) {
-	printk ("wd7000_init: ");
-
-	switch (diag) {
-	    case 2:  printk ("RAM failure.\n");
-		     break;
-	    case 3:  printk ("FIFO R/W failed\n");
-		     break;
-	    case 4:  printk ("SBIC register R/W failed\n");
-		     break;
-	    case 5:  printk ("Initialization D-FF failed.\n");
-		     break;
-	    case 6:  printk ("Host IRQ D-FF failed.\n");
-		     break;
-	    case 7:  printk ("ROM checksum error.\n");
-		     break;
-	    default: printk ("diagnostic code 0x%02Xh received.\n", diag);
-	}
-	return -1;
-    }
-   /* Clear mailboxes */
-    memset (&(host->mb), 0, sizeof (host->mb));
-
-    /* Execute init command */
-    any2scsi ((unchar *) & (init_cmd.mailboxes), (int) &(host->mb));
-    if (!command_out (host, (unchar *) &init_cmd, sizeof (init_cmd))) {
-	printk (KERN_ERR "wd7000_adapter_reset: adapter initialization failed.\n");
-	return -1;
-    }
-
-    if (WAIT (host->iobase + ASC_STAT, ASC_STATMASK, ASC_INIT, 0)) {
-	printk ("wd7000_adapter_reset: WAIT timed out.\n");
-	return -1;
-    }
-    return 0;
-}
-
-static int wd7000_init (Adapter *host)
-{
-    if(wd7000_adapter_reset(host) == -1)
-    	return 0;
-
- 
-    if (request_irq (host->irq, do_wd7000_intr_handle, SA_INTERRUPT, "wd7000", host)) {
-	printk ("wd7000_init: can't get IRQ %d.\n", host->irq);
-	return (0);
-    }
-    if (request_dma (host->dma, "wd7000")) {
-	printk ("wd7000_init: can't get DMA channel %d.\n", host->dma);
-	free_irq (host->irq, host);
-	return (0);
-    }
-    wd7000_enable_dma (host);
-    wd7000_enable_intr (host);
-
-    if (!wd7000_diagnostics (host, ICB_DIAG_FULL)) {
-	free_dma (host->dma);
-	free_irq (host->irq, NULL);
-	return (0);
-    }
+	InitCmd init_cmd = {
+		INITIALIZATION,
+		7,
+		host->bus_on,
+		host->bus_off,
+		0,
+		{0, 0, 0},
+		OGMB_CNT,
+		ICMB_CNT
+	};
+	int diag;
+	/*
+	 *  Reset the adapter - only.  The SCSI bus was initialized at power-up,
+	 *  and we need to do this just so we control the mailboxes, etc.
+	 */
+	outb(ASC_RES, host->iobase + ASC_CONTROL);
+	udelay(40);		/* reset pulse: this is 40us, only need 25us */
+	outb(0, host->iobase + ASC_CONTROL);
+	host->control = 0;	/* this must always shadow ASC_CONTROL */
+
+	if (WAIT(host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
+		printk("wd7000_init: WAIT timed out.\n");
+		return -1;	/* -1 = not ok */
+	}
+
+	if ((diag = inb(host->iobase + ASC_INTR_STAT)) != 1) {
+		printk("wd7000_init: ");
+
+		switch (diag) {
+		case 2:
+			printk("RAM failure.\n");
+			break;
+		case 3:
+			printk("FIFO R/W failed\n");
+			break;
+		case 4:
+			printk("SBIC register R/W failed\n");
+			break;
+		case 5:
+			printk("Initialization D-FF failed.\n");
+			break;
+		case 6:
+			printk("Host IRQ D-FF failed.\n");
+			break;
+		case 7:
+			printk("ROM checksum error.\n");
+			break;
+		default:
+			printk("diagnostic code 0x%02Xh received.\n", diag);
+		}
+		return -1;
+	}
+	/* Clear mailboxes */
+	memset(&(host->mb), 0, sizeof(host->mb));
+
+	/* Execute init command */
+	any2scsi((unchar *) & (init_cmd.mailboxes), (int) &(host->mb));
+	if (!command_out(host, (unchar *) & init_cmd, sizeof(init_cmd))) {
+		printk(KERN_ERR "wd7000_adapter_reset: adapter initialization failed.\n");
+		return -1;
+	}
+
+	if (WAIT(host->iobase + ASC_STAT, ASC_STATMASK, ASC_INIT, 0)) {
+		printk("wd7000_adapter_reset: WAIT timed out.\n");
+		return -1;
+	}
+	return 0;
+}
 
-    return (1);
+static int wd7000_init(Adapter * host)
+{
+	if (wd7000_adapter_reset(host) == -1)
+		return 0;
+
+
+	if (request_irq(host->irq, do_wd7000_intr_handle, SA_INTERRUPT, "wd7000", host)) {
+		printk("wd7000_init: can't get IRQ %d.\n", host->irq);
+		return (0);
+	}
+	if (request_dma(host->dma, "wd7000")) {
+		printk("wd7000_init: can't get DMA channel %d.\n", host->dma);
+		free_irq(host->irq, host);
+		return (0);
+	}
+	wd7000_enable_dma(host);
+	wd7000_enable_intr(host);
+
+	if (!wd7000_diagnostics(host, ICB_DIAG_FULL)) {
+		free_dma(host->dma);
+		free_irq(host->irq, NULL);
+		return (0);
+	}
+
+	return (1);
 }
 
 
-static void wd7000_revision (Adapter *host)
+static void wd7000_revision(Adapter * host)
 {
-    static IcbRevLvl icb =
-    {ICB_OP_GET_REVISION};
-
-    icb.phase = 1;
-    /*
-     * Like diagnostics, this is only done at init time, in fact, from
-     * wd7000_detect, so there should be OGMBs available.  If it fails,
-     * the only damage will be that the revision will show up as 0.0,
-     * which in turn means that scatter/gather will be disabled.
-     */
-    mail_out (host, (struct scb *) &icb);
-    while (icb.phase)
-    {
-	cpu_relax();		/* wait for completion */
-	barrier();
-    }
-    host->rev1 = icb.primary;
-    host->rev2 = icb.secondary;
+	static IcbRevLvl icb = { ICB_OP_GET_REVISION };
+
+	icb.phase = 1;
+	/*
+	 * Like diagnostics, this is only done at init time, in fact, from
+	 * wd7000_detect, so there should be OGMBs available.  If it fails,
+	 * the only damage will be that the revision will show up as 0.0,
+	 * which in turn means that scatter/gather will be disabled.
+	 */
+	mail_out(host, (struct scb *) &icb);
+	while (icb.phase) {
+		cpu_relax();	/* wait for completion */
+		barrier();
+	}
+	host->rev1 = icb.primary;
+	host->rev2 = icb.secondary;
 }
 
 
 #undef SPRINTF
 #define SPRINTF(args...) { if (pos < (buffer + length)) pos += sprintf (pos, ## args); }
 
-static int wd7000_set_info (char *buffer, int length, struct Scsi_Host *host)
+static int wd7000_set_info(char *buffer, int length, struct Scsi_Host *host)
 {
-    dprintk("Buffer = <%.*s>, length = %d\n", length, buffer, length);
+	dprintk("Buffer = <%.*s>, length = %d\n", length, buffer, length);
 
-    /*
-     * Currently this is a no-op
-     */
-    dprintk("Sorry, this function is currently out of order...\n");
-    return (length);
+	/*
+	 * Currently this is a no-op
+	 */
+	dprintk("Sorry, this function is currently out of order...\n");
+	return (length);
 }
 
 
-static int wd7000_proc_info (char *buffer, char **start, off_t offset, int length, int hostno, int inout)
+static int wd7000_proc_info(char *buffer, char **start, off_t offset, int length, int hostno, int inout)
 {
-    struct Scsi_Host *host = NULL;
-    Scsi_Device *scd;
-    Adapter *adapter;
-    unsigned long flags;
-    char *pos = buffer;
-    short i;
+	struct Scsi_Host *host = NULL;
+	Scsi_Device *scd;
+	Adapter *adapter;
+	unsigned long flags;
+	char *pos = buffer;
+	short i;
 
 #ifdef WD7000_DEBUG
-    Mailbox *ogmbs, *icmbs;
-    short count;
+	Mailbox *ogmbs, *icmbs;
+	short count;
 #endif
 
-    /*
-     * Find the specified host board.
-     */
-    for (i = 0; i < UNITS; i++)
-	if (wd7000_host[i] && (wd7000_host[i]->host_no == hostno)) {
-	    host = wd7000_host[i];
-
-	    break;
-	}
-
-    /*
-     * Host not found!
-     */
-    if (! host)
-	return (-ESRCH);
-
-    /*
-     * Has data been written to the file ?
-     */
-    if (inout)
-	return (wd7000_set_info (buffer, length, host));
-
-    adapter = (Adapter *) host->hostdata;
-
-    spin_lock_irqsave(host->host_lock, flags);
-    SPRINTF ("Host scsi%d: Western Digital WD-7000 (rev %d.%d)\n", hostno, adapter->rev1, adapter->rev2);
-    SPRINTF ("  IO base:      0x%x\n", adapter->iobase);
-    SPRINTF ("  IRQ:          %d\n", adapter->irq);
-    SPRINTF ("  DMA channel:  %d\n", adapter->dma);
-    SPRINTF ("  Interrupts:   %d\n", adapter->int_counter);
-    SPRINTF ("  BUS_ON time:  %d nanoseconds\n", adapter->bus_on * 125);
-    SPRINTF ("  BUS_OFF time: %d nanoseconds\n", adapter->bus_off * 125);
+	/*
+	 * Find the specified host board.
+	 */
+	for (i = 0; i < UNITS; i++)
+		if (wd7000_host[i] && (wd7000_host[i]->host_no == hostno)) {
+			host = wd7000_host[i];
 
-#ifdef WD7000_DEBUG
-    ogmbs = adapter->mb.ogmb;
-    icmbs = adapter->mb.icmb;
+			break;
+		}
 
-    SPRINTF ("\nControl port value: 0x%x\n", adapter->control);
-    SPRINTF ("Incoming mailbox:\n");
-    SPRINTF ("  size: %d\n", ICMB_CNT);
-    SPRINTF ("  queued messages: ");
+	/*
+	 * Host not found!
+	 */
+	if (!host)
+		return (-ESRCH);
 
-    for (i = count = 0; i < ICMB_CNT; i++)
-	if (icmbs[i].status) {
-	    count++;
-	    SPRINTF ("0x%x ", i);
-	}
+	/*
+	 * Has data been written to the file ?
+	 */
+	if (inout)
+		return (wd7000_set_info(buffer, length, host));
 
-    SPRINTF (count ? "\n" : "none\n");
+	adapter = (Adapter *) host->hostdata;
 
-    SPRINTF ("Outgoing mailbox:\n");
-    SPRINTF ("  size: %d\n", OGMB_CNT);
-    SPRINTF ("  next message: 0x%x\n", adapter->next_ogmb);
-    SPRINTF ("  queued messages: ");
+	spin_lock_irqsave(host->host_lock, flags);
+	SPRINTF("Host scsi%d: Western Digital WD-7000 (rev %d.%d)\n", hostno, adapter->rev1, adapter->rev2);
+	SPRINTF("  IO base:      0x%x\n", adapter->iobase);
+	SPRINTF("  IRQ:          %d\n", adapter->irq);
+	SPRINTF("  DMA channel:  %d\n", adapter->dma);
+	SPRINTF("  Interrupts:   %d\n", adapter->int_counter);
+	SPRINTF("  BUS_ON time:  %d nanoseconds\n", adapter->bus_on * 125);
+	SPRINTF("  BUS_OFF time: %d nanoseconds\n", adapter->bus_off * 125);
 
-    for (i = count = 0; i < OGMB_CNT; i++)
-	if (ogmbs[i].status) {
-	    count++;
-	    SPRINTF ("0x%x ", i);
-	}
+#ifdef WD7000_DEBUG
+	ogmbs = adapter->mb.ogmb;
+	icmbs = adapter->mb.icmb;
+
+	SPRINTF("\nControl port value: 0x%x\n", adapter->control);
+	SPRINTF("Incoming mailbox:\n");
+	SPRINTF("  size: %d\n", ICMB_CNT);
+	SPRINTF("  queued messages: ");
+
+	for (i = count = 0; i < ICMB_CNT; i++)
+		if (icmbs[i].status) {
+			count++;
+			SPRINTF("0x%x ", i);
+		}
+
+	SPRINTF(count ? "\n" : "none\n");
 
-    SPRINTF (count ? "\n" : "none\n");
+	SPRINTF("Outgoing mailbox:\n");
+	SPRINTF("  size: %d\n", OGMB_CNT);
+	SPRINTF("  next message: 0x%x\n", adapter->next_ogmb);
+	SPRINTF("  queued messages: ");
+
+	for (i = count = 0; i < OGMB_CNT; i++)
+		if (ogmbs[i].status) {
+			count++;
+			SPRINTF("0x%x ", i);
+		}
+
+	SPRINTF(count ? "\n" : "none\n");
 #endif
 
-    /*
-     * Display driver information for each device attached to the board.
-     */
-    scd = host->host_queue;
-   
-    SPRINTF ("\nAttached devices: %s\n", scd ? "" : "none");
-
-    for ( ; scd; scd = scd->next)
-	if (scd->host->host_no == hostno) {
-	    SPRINTF ("  [Channel: %02d, Id: %02d, Lun: %02d]  ",
-		     scd->channel, scd->id, scd->lun);
-	    SPRINTF ("%s ", (scd->type < MAX_SCSI_DEVICE_CODE) ?
-		     scsi_device_types[(short) scd->type] : "Unknown device");
-
-	    for (i = 0; (i < 8) && (scd->vendor[i] >= 0x20); i++)
-		SPRINTF ("%c", scd->vendor[i]);
-	    SPRINTF (" ");
-
-	    for (i = 0; (i < 16) && (scd->model[i] >= 0x20); i++)
-		SPRINTF ("%c", scd->model[i]);
-	    SPRINTF ("\n");
-	}
-
-    SPRINTF ("\n");
-
-    spin_unlock_irqrestore(host->host_lock, flags);
-
-    /*
-     * Calculate start of next buffer, and return value.
-     */
-    *start = buffer + offset;
+	/*
+	 * Display driver information for each device attached to the board.
+	 */
+	scd = host->host_queue;
 
-    if ((pos - buffer) < offset)
-	return (0);
-    else if ((pos - buffer - offset) < length)
-	return (pos - buffer - offset);
-    else
-	return (length);
+	SPRINTF("\nAttached devices: %s\n", scd ? "" : "none");
+
+	for (; scd; scd = scd->next)
+		if (scd->host->host_no == hostno) {
+			SPRINTF("  [Channel: %02d, Id: %02d, Lun: %02d]  ", scd->channel, scd->id, scd->lun);
+			SPRINTF("%s ", (scd->type < MAX_SCSI_DEVICE_CODE) ? scsi_device_types[(short) scd->type] : "Unknown device");
+
+			for (i = 0; (i < 8) && (scd->vendor[i] >= 0x20); i++)
+				SPRINTF("%c", scd->vendor[i]);
+			SPRINTF(" ");
+
+			for (i = 0; (i < 16) && (scd->model[i] >= 0x20); i++)
+				SPRINTF("%c", scd->model[i]);
+			SPRINTF("\n");
+		}
+
+	SPRINTF("\n");
+
+	spin_unlock_irqrestore(host->host_lock, flags);
+
+	/*
+	 * Calculate start of next buffer, and return value.
+	 */
+	*start = buffer + offset;
+
+	if ((pos - buffer) < offset)
+		return (0);
+	else if ((pos - buffer - offset) < length)
+		return (pos - buffer - offset);
+	else
+		return (length);
 }
 
 
@@ -1515,191 +1481,181 @@
  *
  */
 
-static int wd7000_detect (Scsi_Host_Template *tpnt)
+static int wd7000_detect(Scsi_Host_Template * tpnt)
 {
-    short present = 0, biosaddr_ptr, sig_ptr, i, pass;
-    short biosptr[NUM_CONFIGS];
-    unsigned iobase;
-    Adapter *host = NULL;
-    struct Scsi_Host *sh;
-    int unit = 0;
+	short present = 0, biosaddr_ptr, sig_ptr, i, pass;
+	short biosptr[NUM_CONFIGS];
+	unsigned iobase;
+	Adapter *host = NULL;
+	struct Scsi_Host *sh;
+	int unit = 0;
 
-    dprintk("wd7000_detect: started\n");
+	dprintk("wd7000_detect: started\n");
 
 #ifdef MODULE
 	if (wd7000)
-		wd7000_setup(wd7000);     
+		wd7000_setup(wd7000);
 #endif
 
-    for (i = 0; i < UNITS; wd7000_host[i++] = NULL) ;
-    for (i = 0; i < NUM_CONFIGS; biosptr[i++] = -1) ;
-
-    tpnt->proc_name = "wd7000";
-    tpnt->proc_info = &wd7000_proc_info;
+	for (i = 0; i < UNITS; wd7000_host[i++] = NULL);
+	for (i = 0; i < NUM_CONFIGS; biosptr[i++] = -1);
 
-    /*
-     * Set up SCB free list, which is shared by all adapters
-     */
-    init_scbs ();
+	tpnt->proc_name = "wd7000";
+	tpnt->proc_info = &wd7000_proc_info;
 
-    for (pass = 0; pass < NUM_CONFIGS; pass++) {
 	/*
-	 * First, search for BIOS SIGNATURE...
+	 * Set up SCB free list, which is shared by all adapters
 	 */
-	for (biosaddr_ptr = 0; biosaddr_ptr < NUM_ADDRS; biosaddr_ptr++)
-	    for (sig_ptr = 0; sig_ptr < NUM_SIGNATURES; sig_ptr++) {
-		for (i = 0; i < pass; i++)
-		    if (biosptr[i] == biosaddr_ptr)
-			break;
-
-		if (i == pass) {
-		    void *biosaddr = ioremap (wd7000_biosaddr[biosaddr_ptr] +
-			                      signatures[sig_ptr].ofs,
-					      signatures[sig_ptr].len);
-		    short bios_match=0;
-		    
-		    if(biosaddr)
-		    	bios_match = memcmp ((char *) biosaddr, signatures[sig_ptr].sig,
-			                       signatures[sig_ptr].len);
-
-		    iounmap (biosaddr);
+	init_scbs();
 
-		    if (! bios_match)
-		        goto bios_matched;
-		}
-	    }
+	for (pass = 0; pass < NUM_CONFIGS; pass++) {
+		/*
+		 * First, search for BIOS SIGNATURE...
+		 */
+		for (biosaddr_ptr = 0; biosaddr_ptr < NUM_ADDRS; biosaddr_ptr++)
+			for (sig_ptr = 0; sig_ptr < NUM_SIGNATURES; sig_ptr++) {
+				for (i = 0; i < pass; i++)
+					if (biosptr[i] == biosaddr_ptr)
+						break;
+
+				if (i == pass) {
+					void *biosaddr = ioremap(wd7000_biosaddr[biosaddr_ptr] + signatures[sig_ptr].ofs,
+								 signatures[sig_ptr].len);
+					short bios_match = 0;
+
+					if (biosaddr)
+						bios_match = memcmp((char *) biosaddr, signatures[sig_ptr].sig, signatures[sig_ptr].len);
+
+					iounmap(biosaddr);
+
+					if (!bios_match)
+						goto bios_matched;
+				}
+			}
 
-      bios_matched:
-	/*
-	 * BIOS SIGNATURE has been found.
-	 */
+	      bios_matched:
+		/*
+		 * BIOS SIGNATURE has been found.
+		 */
 #ifdef WD7000_DEBUG
-	dprintk("wd7000_detect: pass %d\n", pass + 1);
+		dprintk("wd7000_detect: pass %d\n", pass + 1);
 
-	if (biosaddr_ptr == NUM_ADDRS)
-	    dprintk("WD-7000 SST BIOS not detected...\n");
-	else
-	    dprintk("WD-7000 SST BIOS detected at 0x%lx: checking...\n",
-		    wd7000_biosaddr[biosaddr_ptr]);
+		if (biosaddr_ptr == NUM_ADDRS)
+			dprintk("WD-7000 SST BIOS not detected...\n");
+		else
+			dprintk("WD-7000 SST BIOS detected at 0x%lx: checking...\n", wd7000_biosaddr[biosaddr_ptr]);
 #endif
 
-	if (configs[pass].irq < 0)
-	    continue;
-	    
-	if (unit == UNITS)
-	    continue;
-
-	iobase = configs[pass].iobase;
-
-	dprintk("wd7000_detect: check IO 0x%x region...\n", iobase);
-
-	if (request_region (iobase, 4, "wd7000")) {
-
-	    dprintk("wd7000_detect: ASC reset (IO 0x%x) ...", iobase);
-	    /*
-	     * ASC reset...
-	     */
-	    outb (ASC_RES, iobase + ASC_CONTROL);
-	    set_current_state(TASK_UNINTERRUPTIBLE);
-	    schedule_timeout(HZ/100);
-	    outb (0, iobase + ASC_CONTROL);
-
-	    if (WAIT (iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
-		dprintk("failed!\n");
-		goto err_release;
-	    } else 
-		dprintk("ok!\n");
+		if (configs[pass].irq < 0)
+			continue;
 
-	    if (inb (iobase + ASC_INTR_STAT) == 1) {
-		/*
-		 *  We register here, to get a pointer to the extra space,
-		 *  which we'll use as the Adapter structure (host) for
-		 *  this adapter.  It is located just after the registered
-		 *  Scsi_Host structure (sh), and is located by the empty
-		 *  array hostdata.
-		 */
-		sh = scsi_register (tpnt, sizeof (Adapter));
-		if(sh==NULL)
-		    goto err_release;
-
-		host = (Adapter *) sh->hostdata;
-
-		dprintk("wd7000_detect: adapter allocated at 0x%x\n",
-			(int)host);
-		memset (host, 0, sizeof (Adapter));
-
-		host->irq = configs[pass].irq;
-		host->dma = configs[pass].dma;
-		host->iobase = iobase;
-		host->int_counter = 0;
-		host->bus_on = configs[pass].bus_on;
-		host->bus_off = configs[pass].bus_off;
-		host->sh = wd7000_host[unit] = sh;
-		unit++;
-
-		dprintk("wd7000_detect: Trying init WD-7000 card at IO "
-			"0x%x, IRQ %d, DMA %d...\n",
-			host->iobase, host->irq, host->dma);
+		if (unit == UNITS)
+			continue;
 
-		if (!wd7000_init (host)) 	/* Initialization failed */
-		    goto err_unregister;
+		iobase = configs[pass].iobase;
 
-		/*
-		 *  OK from here - we'll use this adapter/configuration.
-		 */
-		wd7000_revision (host);		/* important for scatter/gather */
-
-		/*
-		 *  For boards before rev 6.0, scatter/gather isn't supported.
-		 */
-		if (host->rev1 < 6)
-		    sh->sg_tablesize = SG_NONE;
+		dprintk("wd7000_detect: check IO 0x%x region...\n", iobase);
+
+		if (request_region(iobase, 4, "wd7000")) {
+
+			dprintk("wd7000_detect: ASC reset (IO 0x%x) ...", iobase);
+			/*
+			 * ASC reset...
+			 */
+			outb(ASC_RES, iobase + ASC_CONTROL);
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ / 100);
+			outb(0, iobase + ASC_CONTROL);
+
+			if (WAIT(iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
+				dprintk("failed!\n");
+				goto err_release;
+			} else
+				dprintk("ok!\n");
 
-		present++;	/* count it */
+			if (inb(iobase + ASC_INTR_STAT) == 1) {
+				/*
+				 *  We register here, to get a pointer to the extra space,
+				 *  which we'll use as the Adapter structure (host) for
+				 *  this adapter.  It is located just after the registered
+				 *  Scsi_Host structure (sh), and is located by the empty
+				 *  array hostdata.
+				 */
+				sh = scsi_register(tpnt, sizeof(Adapter));
+				if (sh == NULL)
+					goto err_release;
+
+				host = (Adapter *) sh->hostdata;
+
+				dprintk("wd7000_detect: adapter allocated at 0x%x\n", (int) host);
+				memset(host, 0, sizeof(Adapter));
+
+				host->irq = configs[pass].irq;
+				host->dma = configs[pass].dma;
+				host->iobase = iobase;
+				host->int_counter = 0;
+				host->bus_on = configs[pass].bus_on;
+				host->bus_off = configs[pass].bus_off;
+				host->sh = wd7000_host[unit] = sh;
+				unit++;
+
+				dprintk("wd7000_detect: Trying init WD-7000 card at IO " "0x%x, IRQ %d, DMA %d...\n", host->iobase, host->irq, host->dma);
+
+				if (!wd7000_init(host))	/* Initialization failed */
+					goto err_unregister;
+
+				/*
+				 *  OK from here - we'll use this adapter/configuration.
+				 */
+				wd7000_revision(host);	/* important for scatter/gather */
+
+				/*
+				 *  For boards before rev 6.0, scatter/gather isn't supported.
+				 */
+				if (host->rev1 < 6)
+					sh->sg_tablesize = SG_NONE;
+
+				present++;	/* count it */
+
+				if (biosaddr_ptr != NUM_ADDRS)
+					biosptr[pass] = biosaddr_ptr;
+
+				printk(KERN_INFO "Western Digital WD-7000 (rev %d.%d) ", host->rev1, host->rev2);
+				printk("using IO 0x%x, IRQ %d, DMA %d.\n", host->iobase, host->irq, host->dma);
+				printk("  BUS_ON time: %dns, BUS_OFF time: %dns\n", host->bus_on * 125, host->bus_off * 125);
+			}
+		} else
+			dprintk("wd7000_detect: IO 0x%x region already allocated!\n", iobase);
 
-		if (biosaddr_ptr != NUM_ADDRS)
-		    biosptr[pass] = biosaddr_ptr;
+		continue;
 
-		printk (KERN_INFO "Western Digital WD-7000 (rev %d.%d) ",
-			host->rev1, host->rev2);
-		printk ("using IO 0x%x, IRQ %d, DMA %d.\n",
-			host->iobase, host->irq, host->dma);
-                printk ("  BUS_ON time: %dns, BUS_OFF time: %dns\n",
-                        host->bus_on * 125, host->bus_off * 125);
-	    }
-	} else
-		dprintk("wd7000_detect: IO 0x%x region already allocated!\n",
-			iobase);
-
-	continue;
-
-    err_unregister:
-	scsi_unregister (sh);
-    err_release:
-	release_region(iobase, 4);
+	      err_unregister:
+		scsi_unregister(sh);
+	      err_release:
+		release_region(iobase, 4);
 
-    }
+	}
 
-    if (!present)
-	printk ("Failed initialization of WD-7000 SCSI card!\n");
+	if (!present)
+		printk("Failed initialization of WD-7000 SCSI card!\n");
 
-    return (present);
+	return (present);
 }
 
 
 /*
  *  I have absolutely NO idea how to do an abort with the WD7000...
  */
-static int wd7000_abort (Scsi_Cmnd *SCpnt)
+static int wd7000_abort(Scsi_Cmnd * SCpnt)
 {
-    Adapter *host = (Adapter *) SCpnt->host->hostdata;
+	Adapter *host = (Adapter *) SCpnt->host->hostdata;
 
-    if (inb (host->iobase + ASC_STAT) & INT_IM) {
-	printk ("wd7000_abort: lost interrupt\n");
-	wd7000_intr_handle (host->irq, NULL, NULL);
+	if (inb(host->iobase + ASC_STAT) & INT_IM) {
+		printk("wd7000_abort: lost interrupt\n");
+		wd7000_intr_handle(host->irq, NULL, NULL);
+		return FAILED;
+	}
 	return FAILED;
-    }
-    return FAILED;
 }
 
 
@@ -1707,28 +1663,28 @@
  *  I also have no idea how to do a reset...
  */
 
-static int wd7000_bus_reset (Scsi_Cmnd *SCpnt)
+static int wd7000_bus_reset(Scsi_Cmnd * SCpnt)
 {
-    return FAILED;
+	return FAILED;
 }
 
-static int wd7000_device_reset (Scsi_Cmnd *SCpnt)
+static int wd7000_device_reset(Scsi_Cmnd * SCpnt)
 {
-    return FAILED;
+	return FAILED;
 }
 
 /*
  *  Last resort. Reinitialize the board.
  */
- 
-static int wd7000_host_reset (Scsi_Cmnd *SCpnt)
+
+static int wd7000_host_reset(Scsi_Cmnd * SCpnt)
 {
-    Adapter *host = (Adapter *) SCpnt->host->hostdata;
-    
-    if(wd7000_adapter_reset(host)<0)
-	    return FAILED;
-    wd7000_enable_intr (host);
-    return SUCCESS;
+	Adapter *host = (Adapter *) SCpnt->host->hostdata;
+
+	if (wd7000_adapter_reset(host) < 0)
+		return FAILED;
+	wd7000_enable_intr(host);
+	return SUCCESS;
 }
 
 
@@ -1736,52 +1692,46 @@
  *  This was borrowed directly from aha1542.c. (Zaga)
  */
 
-static int wd7000_biosparam (Disk *disk, struct block_device *bdev, int *ip)
+static int wd7000_biosparam(Disk * disk, struct block_device *bdev, int *ip)
 {
-    dprintk("wd7000_biosparam: dev=%s, size=%d, ", bdevname(bdev),
-	    disk->capacity);
+	dprintk("wd7000_biosparam: dev=%s, size=%d, ", bdevname(bdev), disk->capacity);
 
-    /*
-     * try default translation
-     */
-    ip[0] = 64;
-    ip[1] = 32;
-    ip[2] = disk->capacity / (64 * 32);
-
-    /*
-     * for disks >1GB do some guessing
-     */
-    if (ip[2] >= 1024) {
-	int info[3];
+	/*
+	 * try default translation
+	 */
+	ip[0] = 64;
+	ip[1] = 32;
+	ip[2] = disk->capacity / (64 * 32);
 
 	/*
-	 * try to figure out the geometry from the partition table
+	 * for disks >1GB do some guessing
 	 */
-	if ((scsicam_bios_param (disk, bdev, info) < 0) ||
-	    !(((info[0] == 64) && (info[1] == 32)) ||
-	      ((info[0] == 255) && (info[1] == 63)))) {
-	    printk ("wd7000_biosparam: unable to verify geometry for disk with >1GB.\n"
-		    "                  using extended translation.\n");
-
-	    ip[0] = 255;
-	    ip[1] = 63;
-	    ip[2] = disk->capacity / (255 * 63);
-	}
-	else {
-	    ip[0] = info[0];
-	    ip[1] = info[1];
-	    ip[2] = info[2];
-
-	    if (info[0] == 255)
-		printk(KERN_INFO "%s: current partition table is "
-			"using extended translation.\n", __FUNCTION__);
+	if (ip[2] >= 1024) {
+		int info[3];
+
+		/*
+		 * try to figure out the geometry from the partition table
+		 */
+		if ((scsicam_bios_param(disk, bdev, info) < 0) || !(((info[0] == 64) && (info[1] == 32)) || ((info[0] == 255) && (info[1] == 63)))) {
+			printk("wd7000_biosparam: unable to verify geometry for disk with >1GB.\n" "                  using extended translation.\n");
+
+			ip[0] = 255;
+			ip[1] = 63;
+			ip[2] = disk->capacity / (255 * 63);
+		} else {
+			ip[0] = info[0];
+			ip[1] = info[1];
+			ip[2] = info[2];
+
+			if (info[0] == 255)
+				printk(KERN_INFO "%s: current partition table is " "using extended translation.\n", __FUNCTION__);
+		}
 	}
-    }
 
-    dprintk("bios geometry: head=%d, sec=%d, cyl=%d\n", ip[0], ip[1], ip[2]);
-    dprintk("WARNING: check, if the bios geometry is correct.\n");
+	dprintk("bios geometry: head=%d, sec=%d, cyl=%d\n", ip[0], ip[1], ip[2]);
+	dprintk("WARNING: check, if the bios geometry is correct.\n");
 
-    return (0);
+	return (0);
 }
 
 MODULE_AUTHOR("Thomas Wuensche, John Boyd, Miroslav Zagorac");
