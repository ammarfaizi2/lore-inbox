Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBFX0l>; Tue, 6 Feb 2001 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBFX0c>; Tue, 6 Feb 2001 18:26:32 -0500
Received: from angel.algonet.se ([194.213.74.112]:5795 "HELO angel.algonet.se")
	by vger.kernel.org with SMTP id <S129053AbRBFX0V>;
	Tue, 6 Feb 2001 18:26:21 -0500
Date: Wed, 7 Feb 2001 00:24:49 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Spelling fixes for commonly misspelled words
Message-ID: <20010207002449.A5833@sm.luth.se>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some grepping for words that are often misspelled, and the below
patch is the result of that. The patch fixes a large number of spelling
errors (64 in total.) The changes that have been made (in many places)
are these:

adress --> address
adressed --> addressed
adressing --> addressing
adresses --> addresses
subadress --> subaddress
aquire --> acquire
garantee --> guarantee
existant --> existent
existance --> existence
frist --> first
desiderable --> desirable

The patch is against 2.4.1-ac4.

diff -ur linux-2.4.1-ac4/Documentation/isdn/INTERFACE linux/Documentation/isdn/INTERFACE
--- linux-2.4.1-ac4/Documentation/isdn/INTERFACE	Thu Aug 26 00:18:07 1999
+++ linux/Documentation/isdn/INTERFACE	Wed Feb  7 00:00:06 2001
@@ -480,7 +480,7 @@
     Parameter:
       driver      = driver-Id
       command     = ISDN_CMD_PROT_IO
-      arg         = The lower 8 Bits define the adressed protocol as defined
+      arg         = The lower 8 Bits define the addressed protocol as defined
                     in ISDN_PTYPE..., the upper bits are used to differenciate
                     the protocol specific CMD.  
       
@@ -734,7 +734,7 @@
     Parameter:
       driver      = driver-Id
       command     = ISDN_STAT_PROT
-      arg         = The lower 8 Bits define the adressed protocol as defined
+      arg         = The lower 8 Bits define the addressed protocol as defined
                     in ISDN_PTYPE..., the upper bits are used to differenciate
                     the protocol specific STAT.  
       
diff -ur linux-2.4.1-ac4/Documentation/s390/cds.txt linux/Documentation/s390/cds.txt
--- linux-2.4.1-ac4/Documentation/s390/cds.txt	Thu Oct 12 23:19:31 2000
+++ linux/Documentation/s390/cds.txt	Wed Feb  7 00:00:06 2001
@@ -549,7 +549,7 @@
 
 typedef struct {
    char            cmd_code; /* command code */
-   char            flags;    /* flags, like IDA adressing, etc. */
+   char            flags;    /* flags, like IDA addressing, etc. */
    unsigned short  count;    /* byte count */
    void           *cda;      /* data address */
 } ccw1_t __attribute__ ((aligned(8)));
diff -ur linux-2.4.1-ac4/arch/alpha/kernel/smp.c linux/arch/alpha/kernel/smp.c
--- linux-2.4.1-ac4/arch/alpha/kernel/smp.c	Wed Jan  3 01:45:37 2001
+++ linux/arch/alpha/kernel/smp.c	Wed Feb  7 00:00:06 2001
@@ -837,7 +837,7 @@
 	atomic_set(&data.unstarted_count, smp_num_cpus - 1);
 	atomic_set(&data.unfinished_count, smp_num_cpus - 1);
 
-	/* Aquire the smp_call_function_data mutex.  */
+	/* Acquire the smp_call_function_data mutex.  */
 	if (pointer_lock(&smp_call_function_data, &data, retry))
 		return -EBUSY;
 
diff -ur linux-2.4.1-ac4/arch/cris/boot/compressed/misc.c linux/arch/cris/boot/compressed/misc.c
--- linux-2.4.1-ac4/arch/cris/boot/compressed/misc.c	Wed Feb  7 00:02:53 2001
+++ linux/arch/cris/boot/compressed/misc.c	Wed Feb  7 00:00:06 2001
@@ -13,7 +13,7 @@
  */
 
 /* where the piggybacked kernel image expects itself to live.
- * it is the same adress we use when we network load an uncompressed
+ * it is the same address we use when we network load an uncompressed
  * image into DRAM, and it is the address the kernel is linked to live
  * at by etrax100.ld.
  */
diff -ur linux-2.4.1-ac4/arch/cris/cris.ld linux/arch/cris/cris.ld
--- linux-2.4.1-ac4/arch/cris/cris.ld	Wed Feb  7 00:02:53 2001
+++ linux/arch/cris/cris.ld	Wed Feb  7 00:00:06 2001
@@ -55,7 +55,7 @@
   	___initcall_start = .;
   	.initcall.init : { *(.initcall.init) }
   	___initcall_end = .;
-	__vmlinux_end = .;            /* last adress of the physical file */
+	__vmlinux_end = .;            /* last address of the physical file */
   	. = ALIGN(8192);
   	___init_end = .;
 
diff -ur linux-2.4.1-ac4/arch/cris/drivers/ethernet.c linux/arch/cris/drivers/ethernet.c
--- linux-2.4.1-ac4/arch/cris/drivers/ethernet.c	Wed Feb  7 00:02:53 2001
+++ linux/arch/cris/drivers/ethernet.c	Wed Feb  7 00:00:06 2001
@@ -273,7 +273,7 @@
 	return 0;
 }
 
-/* set MAC adress of the interface. called from the core after a
+/* set MAC address of the interface. called from the core after a
  * SIOCSIFADDR ioctl, and from the bootup above.
  */
 
@@ -288,7 +288,7 @@
         memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
 
 	/* Write it to the hardware.
-	 * Note the way the adress is wrapped:
+	 * Note the way the address is wrapped:
 	 * *R_NETWORK_SA_0 = a0_0 | (a0_1 << 8) | (a0_2 << 16) | (a0_3 << 24);
 	 * *R_NETWORK_SA_1 = a0_4 | (a0_5 << 8);
 	 */
diff -ur linux-2.4.1-ac4/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.4.1-ac4/arch/i386/mm/fault.c	Sun Nov 12 04:01:11 2000
+++ linux/arch/i386/mm/fault.c	Wed Feb  7 00:00:06 2001
@@ -81,7 +81,7 @@
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
+ * message out (timerlist_lock is acquired through the
  * console unblank code)
  */
 void bust_spinlocks(void)
diff -ur linux-2.4.1-ac4/arch/ia64/kernel/process.c linux/arch/ia64/kernel/process.c
--- linux-2.4.1-ac4/arch/ia64/kernel/process.c	Thu Jan  4 21:50:17 2001
+++ linux/arch/ia64/kernel/process.c	Wed Feb  7 00:00:06 2001
@@ -542,7 +542,7 @@
 		 * context for the last time. There is a possible race
 		 * condition in SMP mode between the child and the
 		 * parent.  by explicitly saving the PMU context here
-		 * we garantee no race.  this call we also stop
+		 * we guarantee no race.  this call we also stop
 		 * monitoring
 		 */
 		ia64_save_pm_regs(current);
diff -ur linux-2.4.1-ac4/arch/ia64/sn/io/pci_bus_cvlink.c linux/arch/ia64/sn/io/pci_bus_cvlink.c
--- linux-2.4.1-ac4/arch/ia64/sn/io/pci_bus_cvlink.c	Fri Jan  5 00:25:55 2001
+++ linux/arch/ia64/sn/io/pci_bus_cvlink.c	Wed Feb  7 00:00:06 2001
@@ -114,9 +114,9 @@
 	pci_bus = pci_bus_to_vertex(busnum);
 	if (!pci_bus) {
 		/*
-		 * During probing, the Linux pci code invents non existant
+		 * During probing, the Linux pci code invents non existent
 		 * bus numbers and pci_dev structures and tries to access
-		 * them to determine existance. Don't crib during probing.
+		 * them to determine existence. Don't crib during probing.
 		 */
 		if (done_probing)
 			printk("devfn_to_vertex: Invalid bus number %d given.\n", busnum);
diff -ur linux-2.4.1-ac4/arch/ia64/sn/io/pcibr.c linux/arch/ia64/sn/io/pcibr.c
--- linux-2.4.1-ac4/arch/ia64/sn/io/pcibr.c	Wed Feb  7 00:02:55 2001
+++ linux/arch/ia64/sn/io/pcibr.c	Wed Feb  7 00:00:06 2001
@@ -8609,7 +8609,7 @@
 			BRIDGE_ERRUPPR_ADDRMASK) << 32)));
 
     /*
-     * need to ensure that the xtalk adress in ioe
+     * need to ensure that the xtalk address in ioe
      * maps to PCI error address read from bridge.
      * How to convert PCI address back to Xtalk address ?
      * (better idea: convert XTalk address to PCI address
diff -ur linux-2.4.1-ac4/arch/mips64/mm/fault.c linux/arch/mips64/mm/fault.c
--- linux-2.4.1-ac4/arch/mips64/mm/fault.c	Wed Nov 29 06:42:04 2000
+++ linux/arch/mips64/mm/fault.c	Wed Feb  7 00:00:07 2001
@@ -61,7 +61,7 @@
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
+ * message out (timerlist_lock is acquired through the
  * console unblank code)
  */
 void bust_spinlocks(void)
diff -ur linux-2.4.1-ac4/arch/parisc/kernel/semaphore.c linux/arch/parisc/kernel/semaphore.c
--- linux-2.4.1-ac4/arch/parisc/kernel/semaphore.c	Wed Feb  7 00:02:58 2001
+++ linux/arch/parisc/kernel/semaphore.c	Wed Feb  7 00:00:07 2001
@@ -187,7 +187,7 @@
 	while (atomic_read(&sem->count) < 0) {
 		set_task_state(current, TASK_UNINTERRUPTIBLE);
 		if (atomic_read(&sem->count) >= 0)
-			break;	/* we must attempt to aquire or bias the lock */
+			break;	/* we must attempt to acquire or bias the lock */
 		schedule();
 	}
 
diff -ur linux-2.4.1-ac4/arch/sparc/kernel/ioport.c linux/arch/sparc/kernel/ioport.c
--- linux-2.4.1-ac4/arch/sparc/kernel/ioport.c	Mon Dec 11 21:37:02 2000
+++ linux/arch/sparc/kernel/ioport.c	Wed Feb  7 00:00:07 2001
@@ -225,7 +225,7 @@
 	 * XXX Playing with implementation details here.
 	 * On sparc64 Ebus has resources with precise boundaries.
 	 * We share drivers with sparc64. Too clever drivers use
-	 * start of a resource instead of a base adress.
+	 * start of a resource instead of a base address.
 	 *
 	 * XXX-2 This may be not valid anymore, clean when
 	 * interface to sbus_ioremap() is resolved.
diff -ur linux-2.4.1-ac4/drivers/block/cciss.c linux/drivers/block/cciss.c
--- linux-2.4.1-ac4/drivers/block/cciss.c	Wed Feb  7 00:03:05 2001
+++ linux/drivers/block/cciss.c	Wed Feb  7 00:00:07 2001
@@ -1053,7 +1053,7 @@
 			printk(KERN_WARNING "cciss: fifo full \n");
 			return;
 		}
-		/* Get the frist entry from the Request Q */ 
+		/* Get the first entry from the Request Q */ 
 		removeQ(&(h->reqQ), c);
 		h->Qdepth--;
 	
diff -ur linux-2.4.1-ac4/drivers/block/rd.c linux/drivers/block/rd.c
--- linux-2.4.1-ac4/drivers/block/rd.c	Wed Feb  7 00:03:06 2001
+++ linux/drivers/block/rd.c	Wed Feb  7 00:00:07 2001
@@ -110,7 +110,7 @@
  */
 int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
 /*
- * It would be very desiderable to have a soft-blocksize (that in the case
+ * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
  * doing that we'll achieve a far better MM footprint. Using a rd_blocksize of
  * BLOCK_SIZE in the worst case we'll make PAGE_SIZE/BLOCK_SIZE buffer-pages
diff -ur linux-2.4.1-ac4/drivers/char/serial.c linux/drivers/char/serial.c
--- linux-2.4.1-ac4/drivers/char/serial.c	Wed Feb  7 00:03:09 2001
+++ linux/drivers/char/serial.c	Wed Feb  7 00:00:07 2001
@@ -5123,7 +5123,7 @@
  * Given a complete unknown ISA PnP device, try to use some heuristics to
  * detect modems. Currently use such heuristic set:
  *     - dev->name or dev->bus->name must contain "modem" substring;
- *     - device must have only one IO region (8 byte long) with base adress
+ *     - device must have only one IO region (8 byte long) with base address
  *       0x2e8, 0x3e8, 0x2f8 or 0x3f8.
  *
  * Such detection looks very ugly, but can detect at least some of numerous
diff -ur linux-2.4.1-ac4/drivers/char/synclink.c linux/drivers/char/synclink.c
--- linux-2.4.1-ac4/drivers/char/synclink.c	Tue Nov  7 19:36:42 2000
+++ linux/drivers/char/synclink.c	Wed Feb  7 00:00:07 2001
@@ -1717,7 +1717,7 @@
 	/* Allocate and claim adapter resources */
 	retval = mgsl_claim_resources(info);
 	
-	/* perform existance check and diagnostics */
+	/* perform existence check and diagnostics */
 	if ( !retval )
 		retval = mgsl_adapter_test(info);
 		
diff -ur linux-2.4.1-ac4/drivers/gsc/busdevice.c linux/drivers/gsc/busdevice.c
--- linux-2.4.1-ac4/drivers/gsc/busdevice.c	Wed Feb  7 00:03:10 2001
+++ linux/drivers/gsc/busdevice.c	Wed Feb  7 00:00:07 2001
@@ -74,7 +74,7 @@
 	/* See if this Device belongs to a LASI/ASP/WAX we know about */
 	/* deller: Changed to test only the 3 highest nibbles of the
 	    address-range, since ASP uses hpa of 0xf080yyyy, but devices are 
-	    at adress 0xf082yyyy ! */
+	    at address 0xf082yyyy ! */
 	while (busdev &&
 		(((unsigned long) busdev->hpa & ~0xfffff) != ((unsigned long) dev->hpa & ~0xfffff)))
 	{
diff -ur linux-2.4.1-ac4/drivers/isdn/act2000/capi.h linux/drivers/isdn/act2000/capi.h
--- linux-2.4.1-ac4/drivers/isdn/act2000/capi.h	Fri Nov 17 20:16:20 2000
+++ linux/drivers/isdn/act2000/capi.h	Wed Feb  7 00:00:07 2001
@@ -44,7 +44,7 @@
 	char *description;
 } actcapi_msgdsc;
 
-/* CAPI Adress */
+/* CAPI Address */
 typedef struct actcapi_addr {
 	__u8 len;                            /* Length of element            */
 	__u8 tnp;                            /* Type/Numbering Plan          */
diff -ur linux-2.4.1-ac4/drivers/isdn/eicon/idi.h linux/drivers/isdn/eicon/idi.h
--- linux-2.4.1-ac4/drivers/isdn/eicon/idi.h	Mon Dec 11 22:21:41 2000
+++ linux/drivers/isdn/eicon/idi.h	Wed Feb  7 00:00:07 2001
@@ -65,7 +65,7 @@
 struct postcall_s {
   word        command;         /* command = 0x0300 */
   word        dummy;           /* not used */
-  IDI_CALL    callback;        /* routine adress to call back */
+  IDI_CALL    callback;        /* routine address to call back */
   ENTITY      *contxt;         /* ptr to entity to use */
 };
 
diff -ur linux-2.4.1-ac4/drivers/isdn/hisax/l3dss1.c linux/drivers/isdn/hisax/l3dss1.c
--- linux-2.4.1-ac4/drivers/isdn/hisax/l3dss1.c	Wed Feb  7 00:03:18 2001
+++ linux/drivers/isdn/hisax/l3dss1.c	Wed Feb  7 00:00:08 2001
@@ -2112,7 +2112,7 @@
         MsgHead(p, pc->callref, MT_FACILITY);
 
         for (subp = pc->chan->setup.phone; (*subp) && (*subp != '.'); subp++) len_phone++; /* len of phone number */
-        if (*subp++ == '.') len_sub = strlen(subp) + 2; /* length including info subadress element */ 
+        if (*subp++ == '.') len_sub = strlen(subp) + 2; /* length including info subaddress element */ 
 
 	*p++ = 0x1c;   /* Facility info element */
         *p++ = len_phone + len_sub + 2 + 2 + 8 + 3 + 3; /* length of element */
@@ -2138,7 +2138,7 @@
 	 *p++ = pc->chan->setup.phone[l];
 
         if (len_sub)
-	  { *p++ = 0x04; /* called party subadress */
+	  { *p++ = 0x04; /* called party subaddress */
             *p++ = len_sub - 2;
             while (*subp) *p++ = *subp++;
           }
diff -ur linux-2.4.1-ac4/drivers/isdn/hisax/l3ni1.c linux/drivers/isdn/hisax/l3ni1.c
--- linux-2.4.1-ac4/drivers/isdn/hisax/l3ni1.c	Wed Feb  7 00:03:18 2001
+++ linux/drivers/isdn/hisax/l3ni1.c	Wed Feb  7 00:00:08 2001
@@ -1973,7 +1973,7 @@
         MsgHead(p, pc->callref, MT_FACILITY);
 
         for (subp = pc->chan->setup.phone; (*subp) && (*subp != '.'); subp++) len_phone++; /* len of phone number */
-        if (*subp++ == '.') len_sub = strlen(subp) + 2; /* length including info subadress element */ 
+        if (*subp++ == '.') len_sub = strlen(subp) + 2; /* length including info subaddress element */ 
 
 	*p++ = 0x1c;   /* Facility info element */
         *p++ = len_phone + len_sub + 2 + 2 + 8 + 3 + 3; /* length of element */
@@ -1999,7 +1999,7 @@
 	 *p++ = pc->chan->setup.phone[l];
 
         if (len_sub)
-	  { *p++ = 0x04; /* called party subadress */
+	  { *p++ = 0x04; /* called party subaddress */
             *p++ = len_sub - 2;
             while (*subp) *p++ = *subp++;
           }
diff -ur linux-2.4.1-ac4/drivers/isdn/icn/icn.h linux/drivers/isdn/icn/icn.h
--- linux-2.4.1-ac4/drivers/isdn/icn/icn.h	Mon Dec 11 22:21:14 2000
+++ linux/drivers/isdn/icn/icn.h	Wed Feb  7 00:00:08 2001
@@ -217,9 +217,9 @@
 #ifdef MODULE
 MODULE_AUTHOR("Fritz Elfert");
 MODULE_PARM(portbase, "i");
-MODULE_PARM_DESC(portbase, "Port adress of first card");
+MODULE_PARM_DESC(portbase, "Port address of first card");
 MODULE_PARM(membase, "i");
-MODULE_PARM_DESC(membase, "Shared memory adress of all cards");
+MODULE_PARM_DESC(membase, "Shared memory address of all cards");
 MODULE_PARM(icn_id, "s");
 MODULE_PARM_DESC(icn_id, "ID-String of first card");
 MODULE_PARM(icn_id2, "s");
diff -ur linux-2.4.1-ac4/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.4.1-ac4/drivers/media/video/tvaudio.c	Tue Dec  5 21:43:47 2000
+++ linux/drivers/media/video/tvaudio.c	Wed Feb  7 00:00:08 2001
@@ -123,7 +123,7 @@
 
 
 /* ---------------------------------------------------------------------- */
-/* i2c adresses                                                           */
+/* i2c addresses                                                           */
 
 static unsigned short normal_i2c[] = {
 	I2C_TDA8425   >> 1,
diff -ur linux-2.4.1-ac4/drivers/net/irda/irport.c linux/drivers/net/irda/irport.c
--- linux-2.4.1-ac4/drivers/net/irda/irport.c	Mon Nov 13 05:43:07 2000
+++ linux/drivers/net/irda/irport.c	Wed Feb  7 00:00:08 2001
@@ -1006,7 +1006,7 @@
 
 #ifdef MODULE
 MODULE_PARM(io, "1-4i");
-MODULE_PARM_DESC(io, "Base I/O adresses");
+MODULE_PARM_DESC(io, "Base I/O addresses");
 MODULE_PARM(irq, "1-4i");
 MODULE_PARM_DESC(irq, "IRQ lines");
 
diff -ur linux-2.4.1-ac4/drivers/net/skfp/drvfbi.c linux/drivers/net/skfp/drvfbi.c
--- linux-2.4.1-ac4/drivers/net/skfp/drvfbi.c	Mon Mar 13 04:11:17 2000
+++ linux/drivers/net/skfp/drvfbi.c	Wed Feb  7 00:00:08 2001
@@ -849,7 +849,7 @@
 
 #ifdef	EISA
 
-/*arrays with io adresses of dma controller length and adress registers*/
+/*arrays with io addresses of dma controller length and address registers*/
 static const int cntr[8] = { 0x001,0x003,0x005,0x007,0,0x0c6,0x0ca,0x0ce } ;
 static const int base[8] = { 0x000,0x002,0x004,0x006,0,0x0c4,0x0c8,0x0cc } ;
 static const int page[8] = { 0x087,0x083,0x081,0x082,0,0x08b,0x089,0x08a } ;
diff -ur linux-2.4.1-ac4/drivers/net/skfp/hwmtm.c linux/drivers/net/skfp/hwmtm.c
--- linux-2.4.1-ac4/drivers/net/skfp/hwmtm.c	Fri May 12 20:43:26 2000
+++ linux/drivers/net/skfp/hwmtm.c	Wed Feb  7 00:00:08 2001
@@ -688,7 +688,7 @@
  *		interrupt service routine, handles the interrupt requests
  *		generated by the FDDI adapter.
  *
- * NOTE:	The operating system dependent module must garantee that the
+ * NOTE:	The operating system dependent module must guarantee that the
  *		interrupts of the adapter are disabled when it calls fddi_isr.
  *
  *	About the USE_BREAK_ISR mechanismn:
diff -ur linux-2.4.1-ac4/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- linux-2.4.1-ac4/drivers/parport/parport_pc.c	Wed Feb  7 00:03:43 2001
+++ linux/drivers/parport/parport_pc.c	Wed Feb  7 00:00:08 2001
@@ -1426,7 +1426,7 @@
 /*
  * Checks for port existence, all ports support SPP MODE
  * Returns: 
- *         0           :  No parallel port at this adress
+ *         0           :  No parallel port at this address
  *  PARPORT_MODE_PCSPP :  SPP port detected 
  *                        (if the user specified an ioport himself,
  *                         this shall always be the case!)
diff -ur linux-2.4.1-ac4/drivers/sbus/char/envctrl.c linux/drivers/sbus/char/envctrl.c
--- linux-2.4.1-ac4/drivers/sbus/char/envctrl.c	Fri Nov 10 00:57:41 2000
+++ linux/drivers/sbus/char/envctrl.c	Wed Feb  7 00:00:08 2001
@@ -229,7 +229,7 @@
 		printk(KERN_INFO "envctrl: Busy bit will not clear.\n");
 }
 
-/* Function Description: Send the adress for a read access.
+/* Function Description: Send the address for a read access.
  * Return : 0 if not acknowledged, otherwise acknowledged.
  */
 static int envctrl_i2c_read_addr(unsigned char addr)
@@ -255,7 +255,7 @@
 	}
 }
 
-/* Function Description: Send the adress for write mode.  
+/* Function Description: Send the address for write mode.  
  * Return : None.
  */
 static void envctrl_i2c_write_addr(unsigned char addr)
diff -ur linux-2.4.1-ac4/drivers/scsi/megaraid.c linux/drivers/scsi/megaraid.c
--- linux-2.4.1-ac4/drivers/scsi/megaraid.c	Mon Feb  5 21:00:32 2001
+++ linux/drivers/scsi/megaraid.c	Wed Feb  7 00:00:08 2001
@@ -1263,7 +1263,7 @@
 }
 
 /*--------------------------------------------------------------------
- * Initializes the adress of the controller's mailbox register
+ * Initializes the address of the controller's mailbox register
  *  The mailbox register is used to issue commands to the card.
  *  Format of the mailbox area:
  *   00 01 command
diff -ur linux-2.4.1-ac4/drivers/scsi/ncr53c8xx.c linux/drivers/scsi/ncr53c8xx.c
--- linux-2.4.1-ac4/drivers/scsi/ncr53c8xx.c	Mon Sep 18 22:36:25 2000
+++ linux/drivers/scsi/ncr53c8xx.c	Wed Feb  7 00:00:09 2001
@@ -7706,7 +7706,7 @@
 /*==========================================================
 **
 **
-**	Aquire a control block
+**	Acquire a control block
 **
 **
 **==========================================================
diff -ur linux-2.4.1-ac4/drivers/scsi/sym53c8xx.c linux/drivers/scsi/sym53c8xx.c
--- linux-2.4.1-ac4/drivers/scsi/sym53c8xx.c	Mon Jan  1 19:23:21 2001
+++ linux/drivers/scsi/sym53c8xx.c	Wed Feb  7 00:00:09 2001
@@ -1465,7 +1465,7 @@
 #endif
 
 /*
-**	If the CPU and the NCR use same endian-ness adressing,
+**	If the CPU and the NCR use same endian-ness addressing,
 **	no byte reordering is needed for script patching.
 **	Macro cpu_to_scr() is to be used for script patching.
 **	Macro scr_to_cpu() is to be used for getting a DWORD 
@@ -1504,7 +1504,7 @@
 */
 
 /*
-**	If the CPU and the NCR use same endian-ness adressing,
+**	If the CPU and the NCR use same endian-ness addressing,
 **	no byte reordering is needed for accessing chip io 
 **	registers. Functions suffixed by '_raw' are assumed 
 **	to access the chip over the PCI without doing byte 
@@ -8961,7 +8961,7 @@
 **		scntl3:	(see the manual)
 **
 **	current script command:
-**		dsp:	script adress (relative to start of script).
+**		dsp:	script address (relative to start of script).
 **		dbc:	first word of script command.
 **
 **	First 24 register of the chip:
@@ -11869,7 +11869,7 @@
 /*==========================================================
 **
 **
-**	Aquire a control block
+**	Acquire a control block
 **
 **
 **==========================================================
diff -ur linux-2.4.1-ac4/drivers/scsi/sym53c8xx_comm.h linux/drivers/scsi/sym53c8xx_comm.h
--- linux-2.4.1-ac4/drivers/scsi/sym53c8xx_comm.h	Mon Oct 16 21:56:50 2000
+++ linux/drivers/scsi/sym53c8xx_comm.h	Wed Feb  7 00:00:11 2001
@@ -1115,7 +1115,7 @@
 **	Btw, ncr_offb() and ncr_offw() macros only apply to 
 **	constants and so donnot generate bloated code.
 **
-**	If the CPU and the NCR use same endian-ness adressing,
+**	If the CPU and the NCR use same endian-ness addressing,
 **	no byte reordering is needed for script patching.
 **	Macro cpu_to_scr() is to be used for script patching.
 **	Macro scr_to_cpu() is to be used for getting a DWORD 
@@ -1164,7 +1164,7 @@
 **	would have been correctly designed for PCI, this 
 **	option would be useless.
 **
-**	If the CPU and the NCR use same endian-ness adressing,
+**	If the CPU and the NCR use same endian-ness addressing,
 **	no byte reordering is needed for accessing chip io 
 **	registers. Functions suffixed by '_raw' are assumed 
 **	to access the chip over the PCI without doing byte 
diff -ur linux-2.4.1-ac4/drivers/video/imsttfb.c linux/drivers/video/imsttfb.c
--- linux-2.4.1-ac4/drivers/video/imsttfb.c	Sat Aug  5 03:06:34 2000
+++ linux/drivers/video/imsttfb.c	Wed Feb  7 00:00:11 2001
@@ -178,10 +178,10 @@
 
 /* TI TVP 3030 RAMDAC Direct Registers */
 enum {
-	TVPADDRW = 0x00,	/* 0  Palette/Cursor RAM Write Adress/Index */
+	TVPADDRW = 0x00,	/* 0  Palette/Cursor RAM Write Address/Index */
 	TVPPDATA = 0x04,	/* 1  Palette Data RAM Data */
 	TVPPMASK = 0x08,	/* 2  Pixel Read-Mask */
-	TVPPADRR = 0x0c,	/* 3  Palette/Cursor RAM Read Adress */
+	TVPPADRR = 0x0c,	/* 3  Palette/Cursor RAM Read Address */
 	TVPCADRW = 0x10,	/* 4  Cursor/Overscan Color Write Address */
 	TVPCDATA = 0x14,	/* 5  Cursor/Overscan Color Data */
 				/* 6  reserved */
diff -ur linux-2.4.1-ac4/include/asm-cris/ide.h linux/include/asm-cris/ide.h
--- linux-2.4.1-ac4/include/asm-cris/ide.h	Wed Feb  7 00:04:12 2001
+++ linux/include/asm-cris/ide.h	Wed Feb  7 00:00:11 2001
@@ -129,7 +129,7 @@
 #define ide_release_lock(lock)		do {} while (0)
 #define ide_get_lock(lock, hdlr, data)	do {} while (0)
 
-/* the drive adressing is done through a controller register on the Etrax CPU */
+/* the drive addressing is done through a controller register on the Etrax CPU */
 void OUT_BYTE(unsigned char data, ide_ioreg_t reg);
 unsigned char IN_BYTE(ide_ioreg_t reg);
 
diff -ur linux-2.4.1-ac4/include/asm-cris/page.h linux/include/asm-cris/page.h
--- linux-2.4.1-ac4/include/asm-cris/page.h	Wed Feb  7 00:04:12 2001
+++ linux/include/asm-cris/page.h	Wed Feb  7 00:00:11 2001
@@ -100,7 +100,7 @@
 /* to index into the page map. our pages all start at physical addr PAGE_OFFSET so
  * we can let the map start there. notice that we subtract PAGE_OFFSET because
  * we start our mem_map there - in other ports they map mem_map physically and
- * use __pa instead. in our system both the physical and virtual adress of DRAM
+ * use __pa instead. in our system both the physical and virtual address of DRAM
  * is too high to let mem_map start at 0, so we do it this way instead (similar
  * to arm and m68k I think)
  */ 
diff -ur linux-2.4.1-ac4/include/asm-i386/highmem.h linux/include/asm-i386/highmem.h
--- linux-2.4.1-ac4/include/asm-i386/highmem.h	Wed Feb  7 00:04:13 2001
+++ linux/include/asm-i386/highmem.h	Wed Feb  7 00:00:11 2001
@@ -2,7 +2,7 @@
  * highmem.h: virtual kernel memory mappings for high memory
  *
  * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual adresses.
+ * are not addressable by direct kernel virtual addresses.
  *
  * Copyright (C) 1999 Gerhard Wichert, Siemens AG
  *		      Gerhard.Wichert@pdb.siemens.de
diff -ur linux-2.4.1-ac4/include/asm-ia64/sn/pci/pcibr.h linux/include/asm-ia64/sn/pci/pcibr.h
--- linux-2.4.1-ac4/include/asm-ia64/sn/pci/pcibr.h	Thu Jan  4 22:00:15 2001
+++ linux/include/asm-ia64/sn/pci/pcibr.h	Wed Feb  7 00:00:12 2001
@@ -47,7 +47,7 @@
  *	These functions are normal device driver entry points
  *	and are called along with the similar entry points from
  *	other device drivers. They are included here as documentation
- *	of their existance and purpose.
+ *	of their existence and purpose.
  *
  *	pcibr_init() is called to inform us that there is a pcibr driver
  *	configured into the kernel; it is responsible for registering
diff -ur linux-2.4.1-ac4/include/asm-parisc/hardware.h linux/include/asm-parisc/hardware.h
--- linux-2.4.1-ac4/include/asm-parisc/hardware.h	Wed Feb  7 00:04:13 2001
+++ linux/include/asm-parisc/hardware.h	Wed Feb  7 00:00:12 2001
@@ -10,7 +10,7 @@
 };
 
 
-#define MAX_ADD_ADDRS	5	/* 5 additional adress ranges should be sufficient */
+#define MAX_ADD_ADDRS	5	/* 5 additional address ranges should be sufficient */
 
 struct hp_device {
 	void 		*hpa;
diff -ur linux-2.4.1-ac4/include/asm-parisc/pdc.h linux/include/asm-parisc/pdc.h
--- linux-2.4.1-ac4/include/asm-parisc/pdc.h	Wed Feb  7 00:04:13 2001
+++ linux/include/asm-parisc/pdc.h	Wed Feb  7 00:00:12 2001
@@ -215,7 +215,7 @@
 #ifdef __LP64__
 		cc_padW:32,
 #endif
-		cc_alias:4,	/* alias boundaries for virtual adresses   */
+		cc_alias:4,	/* alias boundaries for virtual addresses   */
 		cc_block: 4,	/* to determine most efficient stride */
 		cc_line	: 3,	/* maximum amount written back as a result of store (multiple of 16 bytes) */
 		cc_pad0 : 2,	/* reserved */
diff -ur linux-2.4.1-ac4/include/asm-ppc/highmem.h linux/include/asm-ppc/highmem.h
--- linux-2.4.1-ac4/include/asm-ppc/highmem.h	Thu Nov  9 04:01:34 2000
+++ linux/include/asm-ppc/highmem.h	Wed Feb  7 00:00:12 2001
@@ -4,7 +4,7 @@
  * PowerPC version, stolen from the i386 version.
  *
  * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual adresses.
+ * are not addressable by direct kernel virtual addresses.
  *
  * Copyright (C) 1999 Gerhard Wichert, Siemens AG
  *		      Gerhard.Wichert@pdb.siemens.de
diff -ur linux-2.4.1-ac4/include/asm-ppc/tqm860.h linux/include/asm-ppc/tqm860.h
--- linux-2.4.1-ac4/include/asm-ppc/tqm860.h	Sun Nov 12 03:23:11 2000
+++ linux/include/asm-ppc/tqm860.h	Wed Feb  7 00:00:12 2001
@@ -28,7 +28,7 @@
 	 unsigned long	bi_immr_base;	/* base of IMMR register */
 	 unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
 	 unsigned long	bi_ip_addr;	/* IP Address */
-	 unsigned char	bi_enetaddr[6];	/* Ethernet adress */
+	 unsigned char	bi_enetaddr[6];	/* Ethernet address */
 	 unsigned char	bi_reserved[2];	/* -- just for alignment -- */
 	 unsigned long	bi_putchar;	/* Addr of monitor putchar() to Console	*/
 	 unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
diff -ur linux-2.4.1-ac4/include/asm-ppc/tqm8xxL.h linux/include/asm-ppc/tqm8xxL.h
--- linux-2.4.1-ac4/include/asm-ppc/tqm8xxL.h	Sun Nov 12 03:23:11 2000
+++ linux/include/asm-ppc/tqm8xxL.h	Wed Feb  7 00:00:12 2001
@@ -28,7 +28,7 @@
 	 unsigned long	bi_immr_base;	/* base of IMMR register */
 	 unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
 	 unsigned long	bi_ip_addr;	/* IP Address */
-	 unsigned char	bi_enetaddr[6];	/* Ethernet adress */
+	 unsigned char	bi_enetaddr[6];	/* Ethernet address */
 	 unsigned char	bi_reserved[2];	/* -- just for alignment -- */
 	 unsigned long	bi_putchar;	/* Addr of monitor putchar() to Console	*/
 	 unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
diff -ur linux-2.4.1-ac4/include/asm-s390/irq.h linux/include/asm-s390/irq.h
--- linux-2.4.1-ac4/include/asm-s390/irq.h	Wed Feb  7 00:04:14 2001
+++ linux/include/asm-s390/irq.h	Wed Feb  7 00:00:12 2001
@@ -186,7 +186,7 @@
 
 typedef struct {
       __u8  cmd_code;/* command code */
-      __u8  flags;   /* flags, like IDA adressing, etc. */
+      __u8  flags;   /* flags, like IDA addressing, etc. */
       __u16 count;   /* byte count */
       __u32 cda;     /* data address */
    } __attribute__ ((packed,aligned(8))) ccw1_t;
diff -ur linux-2.4.1-ac4/include/asm-s390x/irq.h linux/include/asm-s390x/irq.h
--- linux-2.4.1-ac4/include/asm-s390x/irq.h	Wed Feb  7 00:04:15 2001
+++ linux/include/asm-s390x/irq.h	Wed Feb  7 00:00:12 2001
@@ -186,7 +186,7 @@
 
 typedef struct {
       __u8  cmd_code;/* command code */
-      __u8  flags;   /* flags, like IDA adressing, etc. */
+      __u8  flags;   /* flags, like IDA addressing, etc. */
       __u16 count;   /* byte count */
       __u32 cda;     /* data address */
    } __attribute__ ((packed,aligned(8))) ccw1_t;
diff -ur linux-2.4.1-ac4/include/asm-sparc/highmem.h linux/include/asm-sparc/highmem.h
--- linux-2.4.1-ac4/include/asm-sparc/highmem.h	Thu Nov  9 04:01:34 2000
+++ linux/include/asm-sparc/highmem.h	Wed Feb  7 00:00:12 2001
@@ -2,7 +2,7 @@
  * highmem.h: virtual kernel memory mappings for high memory
  *
  * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual adresses.
+ * are not addressable by direct kernel virtual addresses.
  *
  * Copyright (C) 1999 Gerhard Wichert, Siemens AG
  *		      Gerhard.Wichert@pdb.siemens.de
diff -ur linux-2.4.1-ac4/include/linux/i2c.h linux/include/linux/i2c.h
--- linux-2.4.1-ac4/include/linux/i2c.h	Fri Dec 29 23:35:47 2000
+++ linux/include/linux/i2c.h	Wed Feb  7 00:00:12 2001
@@ -454,7 +454,7 @@
  *	corresponding header files.
  */
 				/* -> bit-adapter specific ioctls	*/
-#define I2C_RETRIES	0x0701	/* number times a device adress should	*/
+#define I2C_RETRIES	0x0701	/* number times a device address should	*/
 				/* be polled when not acknowledging 	*/
 #define I2C_TIMEOUT	0x0702	/* set timeout - call with int 		*/
 
@@ -471,7 +471,7 @@
 #define I2C_FUNCS	0x0705	/* Get the adapter functionality */
 #define I2C_RDWR	0x0707	/* Combined R/W transfer (one stop only)*/
 #if 0
-#define I2C_ACK_TEST	0x0710	/* See if a slave is at a specific adress */
+#define I2C_ACK_TEST	0x0710	/* See if a slave is at a specific address */
 #endif
 
 #define I2C_SMBUS	0x0720	/* SMBus-level access */
diff -ur linux-2.4.1-ac4/kernel/signal.c linux/kernel/signal.c
--- linux-2.4.1-ac4/kernel/signal.c	Thu Jan  4 05:45:26 2001
+++ linux/kernel/signal.c	Wed Feb  7 00:00:12 2001
@@ -519,7 +519,7 @@
 	if (bad_signal(sig, info, t))
 		goto out_nolock;
 
-	/* The null signal is a permissions and process existance probe.
+	/* The null signal is a permissions and process existence probe.
 	   No signal is actually delivered.  Same goes for zombies. */
 	ret = 0;
 	if (!sig || !t->sig)
diff -ur linux-2.4.1-ac4/mm/filemap.c linux/mm/filemap.c
--- linux-2.4.1-ac4/mm/filemap.c	Wed Feb  7 00:04:18 2001
+++ linux/mm/filemap.c	Wed Feb  7 00:00:12 2001
@@ -1689,7 +1689,7 @@
 	unsigned long end = address + size;
 	int error = 0;
 
-	/* Aquire the lock early; it may be possible to avoid dropping
+	/* Acquire the lock early; it may be possible to avoid dropping
 	 * and reaquiring it repeatedly.
 	 */
 	spin_lock(&vma->vm_mm->page_table_lock);
diff -ur linux-2.4.1-ac4/mm/swapfile.c linux/mm/swapfile.c
--- linux-2.4.1-ac4/mm/swapfile.c	Wed Feb  7 00:04:19 2001
+++ linux/mm/swapfile.c	Wed Feb  7 00:00:12 2001
@@ -818,7 +818,7 @@
 
 /*
  * Verify that a swap entry is valid and increment its swap map count.
- * Kernel_lock is held, which guarantees existance of swap device.
+ * Kernel_lock is held, which guarantees existence of swap device.
  *
  * Note: if swap_map[] reaches SWAP_MAP_MAX the entries are treated as
  * "permanent", but will be reclaimed by the next swapoff.
diff -ur linux-2.4.1-ac4/net/core/dev.c linux/net/core/dev.c
--- linux-2.4.1-ac4/net/core/dev.c	Wed Feb  7 00:04:20 2001
+++ linux/net/core/dev.c	Wed Feb  7 00:00:12 2001
@@ -429,7 +429,7 @@
 
 /* 
    Return value is changed to int to prevent illegal usage in future.
-   It is still legal to use to check for device existance.
+   It is still legal to use to check for device existence.
 
    User should understand, that the result returned by this function
    is meaningless, if it was not issued under rtnl semaphore.
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
