Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWIUVTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWIUVTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIUVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:19:22 -0400
Received: from free-electrons.com ([88.191.23.47]:7829 "EHLO
	sd-2511.dedibox.fr") by vger.kernel.org with ESMTP id S1750862AbWIUVTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:19:20 -0400
From: Michael Opdenacker <michael-lists@free-electrons.com>
Organization: Free Electrons
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in Documentation/DocBook
Date: Thu, 21 Sep 2006 23:18:06 +0200
User-Agent: KMail/1.9.1
Cc: trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609212318.07418.michael-lists@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch against 2.6.18 fixes spelling errors detected
by running "aspell -H -c" on each .tmpl file in Documentation/DocBook

The next step is to run aspell on all regular text files
in the Documentation directory!

	Michael.

---

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

diff -Nurp linux-2.6.18/Documentation/DocBook/gadget.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/gadget.tmpl
--- linux-2.6.18/Documentation/DocBook/gadget.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/gadget.tmpl	2006-09-21 
13:54:36.000000000 +0200
@@ -585,11 +585,11 @@ over time, as this driver framework evol
 for usb controller hardware), other gadget drivers exist.
 </para>
 
-<para>There's an <emphasis>ethernet</emphasis> gadget
+<para>There's an <emphasis>Ethernet</emphasis> gadget
 driver, which implements one of the most useful
 <emphasis>Communications Device Class</emphasis> (CDC) models.  
 One of the standards for cable modem interoperability even
-specifies the use of this ethernet model as one of two
+specifies the use of this Ethernet model as one of two
 mandatory options.
 Gadgets using this code look to a USB host as if they're
 an Ethernet adapter.
@@ -667,7 +667,7 @@ hardware level details could be very dif
 
 <para>Systems need specialized hardware support to implement OTG,
 notably including a special <emphasis>Mini-AB</emphasis> jack
-and associated transciever to support <emphasis>Dual-Role</emphasis>
+and associated transceiver to support <emphasis>Dual-Role</emphasis>
 operation:
 they can act either as a host, using the standard
 Linux-USB host side driver stack,
diff -Nurp linux-2.6.18/Documentation/DocBook/genericirq.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/genericirq.tmpl
--- linux-2.6.18/Documentation/DocBook/genericirq.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/genericirq.tmpl	
2006-09-21 21:42:18.000000000 +0200
@@ -177,7 +177,7 @@
 	<para>
 	Each interrupt is described by an interrupt descriptor structure
 	irq_desc. The interrupt is referenced by an 'unsigned int' numeric
-	value which selects the corresponding interrupt decription structure
+	value which selects the corresponding interrupt description structure
 	in the descriptor structures array.
 	The descriptor structure contains status information and pointers
 	to the interrupt flow method and the interrupt chip structure
@@ -411,7 +411,7 @@ desc->chip->end();
      <para>
 	This handler turned out to be not suitable for all
 	interrupt hardware and was therefore reimplemented with split
-	functionality for egde/level/simple/percpu interrupts. This is not
+	functionality for edge/level/simple/percpu interrupts. This is not
 	only a functional optimization. It also shortens code paths for
 	interrupts.
       </para>
diff -Nurp linux-2.6.18/Documentation/DocBook/journal-api.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/journal-api.tmpl
--- linux-2.6.18/Documentation/DocBook/journal-api.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/journal-api.tmpl	
2006-09-21 21:48:37.000000000 +0200
@@ -4,7 +4,7 @@
 
 <book id="LinuxJBDAPI">
  <bookinfo>
-  <title>The Linux Journalling API</title>
+  <title>The Linux Journaling API</title>
   <authorgroup>
   <author>
      <firstname>Roger</firstname>
@@ -71,7 +71,7 @@
   <sect1>
      <title>Details</title>
 <para>
-The journalling layer is  easy to use. You need to 
+The journaling layer is  easy to use. You need to 
 first of all create a journal_t data structure. There are
 two calls to do this dependent on how you decide to allocate the physical
 media on which the journal resides. The journal_init_inode() call 
@@ -136,7 +136,7 @@ quota support.
 Inside each transaction you need to wrap the modifications to the
 individual buffers (blocks). Before you start to modify a buffer you
 need to call journal_get_{create,write,undo}_access() as appropriate,
-this allows the journalling layer to copy the unmodified data if it
+this allows the journaling layer to copy the unmodified data if it
 needs to. After all the buffer may be part of a previously uncommitted
 transaction. 
 At this point you are at last ready to modify a buffer, and once
@@ -163,7 +163,7 @@ The first thing to note is that each tas
 a single outstanding transaction at any one time, remember nothing
 commits until the outermost journal_stop(). This means
 you must complete the transaction at the end of each file/inode/address
-etc. operation you perform, so that the journalling system isn't re-entered
+etc. operation you perform, so that the journaling system isn't re-entered
 on another journal. Since transactions can't be nested/batched 
 across differing journals, and another filesystem other than
 yours (say ext3) may be modified in a later syscall.
@@ -218,7 +218,7 @@ calls.
 
 <para>
 A new feature of jbd since 2.5.25 is commit callbacks with the new
-journal_callback_set() function you can now ask the journalling layer
+journal_callback_set() function you can now ask the journaling layer
 to call you back when the transaction is finally committed to disk, so that
 you can do some of your own management. The key to this is the 
journal_callback
 struct, this maintains the internal callback information but you can
@@ -246,7 +246,7 @@ particular inode.
 <para>
 Using the journal is a matter of wrapping the different context changes,
 being each mount, each modification (transaction) and each changed buffer
-to tell the journalling layer about them.
+to tell the journaling layer about them.
 </para>
 
 <para>
@@ -286,7 +286,7 @@ an example.
   <chapter id="adt">
      <title>Data Types</title>
      <para>	
-	The journalling layer uses typedefs to 'hide' the concrete definitions
+	The journaling layer uses typedefs to 'hide' the concrete definitions
 	of the structures used. As a client of the JBD layer you can
 	just rely on the using the pointer as a magic cookie  of some sort.
 	
@@ -308,7 +308,7 @@ an example.
 !Efs/jbd/journal.c
 !Ifs/jbd/recovery.c
 	</sect1>
-	<sect1><title>Transasction Level</title>
+	<sect1><title>Transaction Level</title>
 !Efs/jbd/transaction.c	
 	</sect1>
 </chapter>
@@ -324,7 +324,7 @@ an example.
 	   <para>
 	   <citation>
 	   <ulink 
url="http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html">
-	   	Ext3 Journalling FileSystem , OLS 2000, Dr. Stephen Tweedie
+	   	Ext3 Journaling FileSystem , OLS 2000, Dr. Stephen Tweedie
 	   </ulink>
 	   </citation>
 	   </para>
diff -Nurp linux-2.6.18/Documentation/DocBook/kernel-hacking.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.6.18/Documentation/DocBook/kernel-hacking.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-hacking.tmpl	
2006-09-21 22:01:17.000000000 +0200
@@ -123,7 +123,7 @@
 
   <para>
    We'll see a number of ways that the user context can block
-   interrupts, to become truly non-preemptable.
+   interrupts, to become truly non-preemptible.
   </para>
   
   <sect1 id="basics-usercontext">
@@ -796,7 +796,7 @@ printk(KERN_INFO "my ip: %d.%d.%d.%d\n",
    </para>
 
    <para>
-   Most registerable structures have an
+   Most registrable structures have an
    <structfield>owner</structfield> field, such as in the
    <structname>file_operations</structname> structure. Set this field
    to the macro <symbol>THIS_MODULE</symbol>.
@@ -1028,7 +1028,7 @@ printk(KERN_INFO "my ip: %d.%d.%d.%d\n",
 
    <para>
     The preferred method of initializing structures is to use
-    designated initialisers, as defined by ISO C99, eg:
+    designated initializers, as defined by ISO C99, eg:
    </para>
    <programlisting>
 static struct block_device_operations opt_fops = {
diff -Nurp linux-2.6.18/Documentation/DocBook/kernel-locking.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.6.18/Documentation/DocBook/kernel-locking.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/kernel-locking.tmpl	
2006-09-21 22:06:56.000000000 +0200
@@ -1717,10 +1717,10 @@ as it would be on UP.
 </para>
 
 <para>
-There is a furthur optimization possible here: remember our original
+There is a further optimization possible here: remember our original
 cache code, where there were no reference counts and the caller simply
 held the lock whenever using the object?  This is still possible: if
-you hold the lock, noone can delete the object, so you don't need to
+you hold the lock, no one can delete the object, so you don't need to
 get and put the reference count.
 </para>
 
diff -Nurp linux-2.6.18/Documentation/DocBook/libata.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl
--- linux-2.6.18/Documentation/DocBook/libata.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/libata.tmpl	2006-09-21 
22:14:56.000000000 +0200
@@ -252,7 +252,7 @@ void (*dev_select)(struct ata_port *ap, 
 	<para>
 	Most drivers for taskfile-based hardware use
 	ata_std_dev_select() for this hook.  Controllers which do not
-	support second drives on a port (such as SATA contollers) will
+	support second drives on a port (such as SATA controllers) will
 	use ata_noop_dev_select().
 	</para>
 
@@ -332,7 +332,7 @@ int (*qc_issue) (struct ata_queued_cmd *
 	</programlisting>
 
 	<para>
-	Higher-level hooks, these two hooks can potentially supercede
+	Higher-level hooks, these two hooks can potentially supersede
 	several of the above taskfile/DMA engine hooks.  ->qc_prep is
 	called after the buffers have been DMA-mapped, and is typically
 	used to populate the hardware's DMA scatter-gather table.
@@ -683,7 +683,7 @@ and other resources, etc.
 
 	<listitem>
 	<para>
-	ATA_QCFLAG_ACTIVE is clared from qc->flags.
+	ATA_QCFLAG_ACTIVE is cleared from qc->flags.
 	</para>
 	</listitem>
 
@@ -714,7 +714,7 @@ and other resources, etc.
 
 	   <listitem>
 	   <para>
-	   qc->waiting is claread &amp; completed (in that order).
+	   qc->waiting is cleared &amp; completed (in that order).
 	   </para>
 	   </listitem>
 
@@ -924,7 +924,7 @@ and other resources, etc.
         <title>HSM violation</title>
         <para>
         This error is indicated when STATUS value doesn't match HSM
-        requirement during issuing or excution any ATA/ATAPI command.
+        requirement during issuing or executing any ATA/ATAPI command.
         </para>
 
 	<itemizedlist>
@@ -951,7 +951,7 @@ and other resources, etc.
 
         <listitem>
 	<para>
-	!BSY &amp;&amp; ERR after CDB tranfer starts but before the
+	!BSY &amp;&amp; ERR after CDB transfer starts but before the
         last byte of CDB is transferred.  ATA/ATAPI standard states
         that &quot;The device shall not terminate the PACKET command
         with an error before the last byte of the command packet has
@@ -1054,9 +1054,9 @@ and other resources, etc.
 	   Upto ATA/ATAPI-7, the standard specifies that ABRT could be
 	   set on ICRC errors and on cases where a device is not able
 	   to complete a command.  Combined with the fact that MWDMA
-	   and PIO transfer errors aren't allowed to use ICRC bit upto
+	   and PIO transfer errors aren't allowed to use ICRC bit up to
 	   ATA/ATAPI-7, it seems to imply that ABRT bit alone could
-	   indicate tranfer errors.
+	   indicate transfer errors.
 	   </para>
 	   <para>
 	   However, ATA/ATAPI-8 draft revision 1f removes the part
@@ -1128,7 +1128,7 @@ and other resources, etc.
 	<para>
 	Depending on commands, not all STATUS/ERROR bits are
 	applicable.  These non-applicable bits are marked with
-	&quot;na&quot; in the output descriptions but upto ATA/ATAPI-7
+	&quot;na&quot; in the output descriptions but up to ATA/ATAPI-7
 	no definition of &quot;na&quot; can be found.  However,
 	ATA/ATAPI-8 draft revision 1f describes &quot;N/A&quot; as
 	follows.
@@ -1169,7 +1169,7 @@ and other resources, etc.
 
 	<para>
 	Once sense data is acquired, this type of errors can be
-	handled similary to other SCSI errors.  Note that sense data
+	handled similarly to other SCSI errors.  Note that sense data
 	may indicate ATA bus error (e.g. Sense Key 04h HARDWARE ERROR
 	&amp;&amp; ASC/ASCQ 47h/00h SCSI PARITY ERROR).  In such
 	cases, the error should be considered as an ATA bus error and
@@ -1415,7 +1415,7 @@ and other resources, etc.
 	<para>
 	HBA resetting is implementation specific.  For a controller
 	complying to taskfile/BMDMA PCI IDE, stopping active DMA
-	transaction may be sufficient iff BMDMA state is the only HBA
+	transaction may be sufficient if BMDMA state is the only HBA
 	context.  But even mostly taskfile/BMDMA PCI IDE complying
 	controllers may have implementation specific requirements and
 	mechanism to reset themselves.  This must be addressed by
diff -Nurp linux-2.6.18/Documentation/DocBook/librs.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/librs.tmpl
--- linux-2.6.18/Documentation/DocBook/librs.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/librs.tmpl	2006-09-21 
22:18:07.000000000 +0200
@@ -101,7 +101,7 @@ static struct rs_control *rs_decoder;
  * Primitve polynomial is x^10+x^3+1
  * first consecutive root is 0
  * primitve element to generate roots = 1
- * generator polinomial degree (number of roots) = 6
+ * generator polynomial degree (number of roots) = 6
  */
 rs_decoder = init_rs (10, 0x409, 0, 1, 6);
 		</programlisting>
@@ -121,7 +121,7 @@ rs_decoder = init_rs (10, 0x409, 0, 1, 6
 			ECC, where the all 0xFF is inverted to an all 0x00.
 			The Reed-Solomon code for all 0x00 is all 0x00. The
 			code is inverted before storing to FLASH so it is 0xFF
-			too. This prevent's that reading from an erased FLASH
+			too. This prevents that reading from an erased FLASH
 			results in ECC errors.
 		</para>
 		<para>
diff -Nurp linux-2.6.18/Documentation/DocBook/mcabook.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/mcabook.tmpl
--- linux-2.6.18/Documentation/DocBook/mcabook.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/mcabook.tmpl	2006-09-21 
22:20:18.000000000 +0200
@@ -82,7 +82,7 @@
   </para>
   <para>
 	Finally the MCA bus functions provide a parallel set of DMA
-	functions mimicing the ISA bus DMA functions as closely as possible,
+	functions mimicking the ISA bus DMA functions as closely as possible,
 	although also supporting the additional DMA functionality on the
 	MCA bus controllers.
   </para>
diff -Nurp linux-2.6.18/Documentation/DocBook/mtdnand.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/mtdnand.tmpl
--- linux-2.6.18/Documentation/DocBook/mtdnand.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/mtdnand.tmpl	2006-09-21 
22:32:00.000000000 +0200
@@ -91,7 +91,7 @@
 		<listitem><para>
 	  	[MTD Interface]</para><para>
 		These functions provide the interface to the MTD kernel API. 
-		They are not replacable and provide functionality
+		They are not replaceable and provide functionality
 		which is complete hardware independent.
 		</para></listitem>
 		<listitem><para>
@@ -100,14 +100,14 @@
 		</para></listitem>
 		<listitem><para>
 	  	[GENERIC]</para><para>
-		Generic functions are not replacable and provide functionality
+		Generic functions are not replaceable and provide functionality
 		which is complete hardware independent.
 		</para></listitem>
 		<listitem><para>
 	  	[DEFAULT]</para><para>
 		Default functions provide hardware related functionality which is suitable
 		for most of the implementations. These functions can be replaced by the
-		board driver if neccecary. Those functions are called via pointers in the
+		board driver if necessary. Those functions are called via pointers in the
 		NAND chip description structure. The board driver can set the functions 
which
 		should be replaced by board dependent functions before calling nand_scan().
 		If the function pointer is NULL on entry to nand_scan() then the pointer
@@ -250,7 +250,7 @@ static void board_hwcontrol(struct mtd_i
 		<title>Device ready function</title>
 		<para>
 			If the hardware interface has the ready busy pin of the NAND chip 
connected to a
-			GPIO or other accesible I/O pin, this function is used to read back the 
state of the
+			GPIO or other accessible I/O pin, this function is used to read back the 
state of the
 			pin. The function has no arguments and should return 0, if the device is 
busy (R/B pin 
 			is low) and 1, if the device is ready (R/B pin is high).
 			If the hardware interface does not give access to the ready busy pin, then
@@ -265,7 +265,7 @@ static void board_hwcontrol(struct mtd_i
 			is set up nand_scan() is called. This function tries to
 			detect and identify then chip. If a chip is found all the
 			internal data fields are initialized accordingly.
-			The structure(s) have to be zeroed out first and then filled with the 
neccecary 
+			The structure(s) have to be zeroed out first and then filled with the 
necessary 
 			information about the device.
 		</para>
 		<programlisting>
@@ -285,7 +285,7 @@ int __init board_init (void)
 	/* Initialize structures */
 	memset ((char *) board_mtd, 0, sizeof(struct mtd_info) + sizeof(struct 
nand_chip));
 
-	/* map physical adress */
+	/* map physical address */
 	baseaddr = (unsigned long)ioremap(CHIP_PHYSICAL_ADDRESS, 1024);
 	if(!baseaddr){
 		printk("Ioremap to access NAND chip failed\n");
@@ -309,7 +309,7 @@ int __init board_init (void)
 	this->dev_ready = board_dev_ready;
 	this->eccmode = NAND_ECC_SOFT;
 
-	/* Scan to find existance of the device */
+	/* Scan to find existence of the device */
 	if (nand_scan (board_mtd, 1)) {
 		err = -ENXIO;
 		goto out_ior;
@@ -331,7 +331,7 @@ module_init(board_init);
 	<sect1>
 		<title>Exit function</title>
 		<para>
-			The exit function is only neccecary if the driver is
+			The exit function is only necessary if the driver is
 			compiled as a module. It releases all resources which
 			are held by the chip driver and unregisters the partitions
 			in the MTD layer.
@@ -343,7 +343,7 @@ static void __exit board_cleanup (void)
 	/* Release resources, unregister device */
 	nand_release (board_mtd);
 
-	/* unmap physical adress */
+	/* unmap physical address */
 	iounmap((void *)baseaddr);
 	
 	/* Free the MTD device structure */
@@ -488,17 +488,17 @@ static void board_select_chip (struct mt
 				Reed-Solomon library.
 			</para>
 			<para>
-				The ECC bytes must be placed immidiately after the data
+				The ECC bytes must be placed immediately after the data
 				bytes in order to make the syndrome generator work. This
 				is contrary to the usual layout used by software ECC. The
-				seperation of data and out of band area is not longer
+				separation of data and out of band area is not longer
 				possible. The nand driver code handles this layout and
 				the remaining free bytes in the oob area are managed by 
 				the autoplacement code. Provide a matching oob-layout
 				in this case. See rts_from4.c and diskonchip.c for 
 				implementation reference. In those cases we must also
 				use bad block tables on FLASH, because the ECC layout is
-				interferring with the bad block marker positions.
+				interfering with the bad block marker positions.
 				See bad block table support for details.
 			</para>
 		</sect2>
@@ -546,7 +546,7 @@ static void board_select_chip (struct mt
 		<para>	
 			nand_scan() calls the function nand_default_bbt(). 
 			nand_default_bbt() selects appropriate default
-			bad block table desriptors depending on the chip information
+			bad block table descriptors depending on the chip information
 			which was retrieved by nand_scan().
 		</para>
 		<para>
@@ -558,7 +558,7 @@ static void board_select_chip (struct mt
 		<sect2>
 			<title>Flash based tables</title>
 			<para>
-				It may be desired or neccecary to keep a bad block table in FLASH. 
+				It may be desired or necessary to keep a bad block table in FLASH. 
 				For AG-AND chips this is mandatory, as they have no factory marked
 				bad blocks. They have factory marked good blocks. The marker pattern
 				is erased when the block is erased to be reused. So in case of
@@ -569,10 +569,10 @@ static void board_select_chip (struct mt
 				of the blocks.
 			</para>
 			<para>
-				The blocks in which the tables are stored are procteted against
+				The blocks in which the tables are stored are protected against
 				accidental access by marking them bad in the memory bad block
-				table. The bad block table managment functions are allowed
-				to circumvernt this protection.
+				table. The bad block table management functions are allowed
+				to circumvent this protection.
 			</para>
 			<para>
 				The simplest way to activate the FLASH based bad block table support 
@@ -596,7 +596,7 @@ static void board_select_chip (struct mt
 				User defined tables are created by filling out a 
 				nand_bbt_descr structure and storing the pointer in the
 				nand_chip structure member bbt_td before calling nand_scan(). 
-				If a mirror table is neccecary a second structure must be
+				If a mirror table is necessary a second structure must be
 				created and a pointer to this structure must be stored
 				in bbt_md inside the nand_chip structure. If the bbt_md 
 				member is set to NULL then only the main table is used
@@ -632,7 +632,7 @@ static void board_select_chip (struct mt
 				holds the bad block table. Store a pointer to the pattern  
 				in the pattern field. Further the length of the pattern has to be 
 				stored in len and the offset in the spare area must be given
-				in the offs member of the nand_bbt_descr stucture. For mirrored
+				in the offs member of the nand_bbt_descr structure. For mirrored
 				bad block tables different patterns are mandatory.</para></listitem>
 				<listitem><para>Table creation</para>
 				<para>Set the option NAND_BBT_CREATE to enable the table creation
@@ -774,7 +774,7 @@ struct nand_oobinfo {
 			</para>
 			<para>
 				If the spare area buffer is NULL then only the ECC placement is
-				done according to the default builtin scheme.
+				done according to the default built-in scheme.
 			</para>
 		</sect2>
 		<sect2>
@@ -1027,19 +1027,19 @@ in this page</entry>
 <row>
 <entry>0x37</entry>
 <entry>ECC byte 15</entry>
-<entry>Error correction code byte 0 of the sixt 256 Bytes of data
+<entry>Error correction code byte 0 of the sixth 256 Bytes of data
 in this page</entry>
 </row>
 <row>
 <entry>0x38</entry>
 <entry>ECC byte 16</entry>
-<entry>Error correction code byte 1 of the sixt 256 Bytes of data
+<entry>Error correction code byte 1 of the sixth 256 Bytes of data
 in this page</entry>
 </row>
 <row>
 <entry>0x39</entry>
 <entry>ECC byte 17</entry>
-<entry>Error correction code byte 2 of the sixt 256 Bytes of data
+<entry>Error correction code byte 2 of the sixth 256 Bytes of data
 in this page</entry>
 </row>
 <row>
@@ -1063,19 +1063,19 @@ data in this page</entry>
 <row>
 <entry>0x3D</entry>
 <entry>ECC byte 21</entry>
-<entry>Error correction code byte 0 of the eigth 256 Bytes of data
+<entry>Error correction code byte 0 of the eighth 256 Bytes of data
 in this page</entry>
 </row>
 <row>
 <entry>0x3E</entry>
 <entry>ECC byte 22</entry>
-<entry>Error correction code byte 1 of the eigth 256 Bytes of data
+<entry>Error correction code byte 1 of the eighth 256 Bytes of data
 in this page</entry>
 </row>
 <row>
 <entry>0x3F</entry>
 <entry>ECC byte 23</entry>
-<entry>Error correction code byte 2 of the eigth 256 Bytes of data
+<entry>Error correction code byte 2 of the eighth 256 Bytes of data
 in this page</entry>
 </row>
 </tbody></tgroup></informaltable>
@@ -1086,11 +1086,11 @@ in this page</entry>
   <chapter id="filesystems">
      	<title>Filesystem support</title>
 	<para>
-		The NAND driver provides all neccecary functions for a
+		The NAND driver provides all necessary functions for a
 		filesystem via the MTD interface.
 	</para>
 	<para>
-		Filesystems must be aware of the NAND pecularities and
+		Filesystems must be aware of the NAND peculiarities and
 		restrictions. One major restrictions of NAND Flash is, that you cannot 
 		write as often as you want to a page. The consecutive writes to a page, 
 		before erasing it again, are restricted to 1-3 writes, depending on the 
@@ -1134,7 +1134,7 @@ in this page</entry>
      	<sect2>   
 		<title>Constants for chip id table</title>
      		<para>
-		These constants are defined in nand.h. They are ored together to describe
+		These constants are defined in nand.h. They are ORed together to describe
 		the chip functionality.
      		<programlisting>
 /* Chip can not auto increment pages */
@@ -1159,7 +1159,7 @@ in this page</entry>
      	<sect2>   
 		<title>Constants for runtime options</title>
      		<para>
-		These constants are defined in nand.h. They are ored together to describe
+		These constants are defined in nand.h. They are ORed together to describe
 		the functionality.
      		<programlisting>
 /* Use a flash based bad block table. This option is parsed by the
@@ -1245,13 +1245,13 @@ in this page</entry>
 #define NAND_BBT_PERCHIP	0x00000080
 /* bbt has a version counter at offset veroffs */
 #define NAND_BBT_VERSION	0x00000100
-/* Create a bbt if none axists */
+/* Create a bbt if none exists */
 #define NAND_BBT_CREATE		0x00000200
 /* Search good / bad pattern through all pages of a block */
 #define NAND_BBT_SCANALLPAGES	0x00000400
 /* Scan block empty during good / bad block scan */
 #define NAND_BBT_SCANEMPTY	0x00000800
-/* Write bbt if neccecary */
+/* Write bbt if necessary */
 #define NAND_BBT_WRITE		0x00001000
 /* Read and write back block contents when writing bbt */
 #define NAND_BBT_SAVECONTENT	0x00002000
diff -Nurp linux-2.6.18/Documentation/DocBook/usb.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/usb.tmpl
--- linux-2.6.18/Documentation/DocBook/usb.tmpl	2006-09-20 05:42:06.000000000 
+0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/usb.tmpl	2006-09-21 
22:38:21.000000000 +0200
@@ -105,7 +105,7 @@
 
     <para>Within the kernel,
     host-side drivers for USB devices talk to the "usbcore" APIs.
-    There are two types of public "usbcore" APIs, targetted at two different
+    There are two types of public "usbcore" APIs, targeted at two different
     layers of USB driver.  Those are
     <emphasis>general purpose</emphasis> drivers, exposed through
     driver frameworks such as block, character, or network devices;
@@ -163,7 +163,7 @@
 
 	<listitem><para>The Linux USB API supports synchronous calls for
 	control and bulk messaging.
-	It also supports asynchnous calls for all kinds of data transfer,
+	It also supports asynchronous calls for all kinds of data transfer,
 	using request structures called "URBs" (USB Request Blocks).
 	</para></listitem>
 
@@ -383,7 +383,7 @@
 	    <para>The significance of that is that by default, all user mode
 	    device drivers need super-user privileges.
 	    You can change modes or ownership in a driver setup
-	    when the device hotplugs, or maye just start the
+	    when the device hotplugs, or maybe just start the
 	    driver right then, as a privileged server (or some activity
 	    within one).
 	    That's the most secure approach for multi-user systems,
@@ -690,7 +690,7 @@ usbdev_ioctl (int fd, int ifno, unsigned
 		    </para><para>
 		    This request lets kernel drivers talk to user mode code
 		    through filesystem operations even when they don't create
-		    a charactor or block special device.
+		    a character or block special device.
 		    It's also been used to do things like ask devices what
 		    device special file should be used.
 		    Two pre-defined ioctls are used
@@ -765,7 +765,7 @@ usbdev_ioctl (int fd, int ifno, unsigned
 		    masked with USB_DIR_IN when referring to an endpoint which
 		    sends data to the host from the device.
 		    The length of the data buffer is identified by "len";
-		    Recent kernels support requests up to about 128KBytes.
+		    Recent kernels support requests up to about 128 KBytes.
 		    <emphasis>FIXME say how read length is returned,
 		    and how short reads are handled.</emphasis>.
 		    </para></listitem></varlistentry>
diff -Nurp linux-2.6.18/Documentation/DocBook/videobook.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/videobook.tmpl
--- linux-2.6.18/Documentation/DocBook/videobook.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/videobook.tmpl	
2006-09-21 22:43:14.000000000 +0200
@@ -116,7 +116,7 @@ static struct video_device my_radio
   <para>
         The only defined value relevant for a radio card is VID_TYPE_TUNER 
which
         indicates that the device can be tuned. Clearly our radio is going to 
have some
-        way to change channel so it is tuneable.
+        way to change channel so it is tunable.
   </para>
   <para>
         The VID_HARDWARE_ types are unique to each device. Numbers are 
assigned by
@@ -186,7 +186,7 @@ int __init myradio_init(struct video_ini
 
         Radio devices are assigned in this block. As with all of these
         selections the actual number assignment is done by the video layer
-        accordijng to what is free.</entry>
+        according to what is free.</entry>
 	</row><row>
         <entry>VFL_TYPE_GRABBER</entry><entry>/dev/video{n}</entry><entry>
         Video capture devices and also -- counter-intuitively for the name --
@@ -460,7 +460,7 @@ static int radio_ioctl(struct video_devi
         strength of 0xFFFF (maximum) and no stereo detected.
   </para>
   <para>
-        To finish off we set the range that can be tuned to be 87-108Mhz, the 
normal
+        To finish off we set the range that can be tuned to be 87-108 MHz, 
the normal
         FM broadcast radio range. It is important to find out what the card 
is
         actually capable of tuning. It is easy enough to simply use the FM 
broadcast
         range. Unfortunately if you do this you will discover the FM 
broadcast
diff -Nurp linux-2.6.18/Documentation/DocBook/writing_usb_driver.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/writing_usb_driver.tmpl
--- linux-2.6.18/Documentation/DocBook/writing_usb_driver.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/writing_usb_driver.tmpl	
2006-09-21 22:45:30.000000000 +0200
@@ -210,7 +210,7 @@ static int skel_probe(struct usb_interfa
   <para>
      The driver now needs to verify that this device is actually one that it
      can accept. If so, it returns 0.
-     If not, or if any error occurs during initialization, an errorcode
+     If not, or if any error occurs during initialization, an error code
      (such as <literal>-ENOMEM</literal> or <literal>-ENODEV</literal>)
      is returned from the probe function.
   </para>
diff -Nurp linux-2.6.18/Documentation/DocBook/z8530book.tmpl 
linux-2.6.18-aspell-docbook/Documentation/DocBook/z8530book.tmpl
--- linux-2.6.18/Documentation/DocBook/z8530book.tmpl	2006-09-20 
05:42:06.000000000 +0200
+++ linux-2.6.18-aspell-docbook/Documentation/DocBook/z8530book.tmpl	
2006-09-21 22:47:59.000000000 +0200
@@ -90,13 +90,13 @@
 	host machine but not to the DMA subsystem. When running PIO the
 	Z8530 has extremely tight timing requirements. Doing high speeds,
 	even with a Z85230 will be tricky. Typically you should expect to
-	achieve at best 9600 baud with a Z8C530 and 64Kbits with a Z85230.
+	achieve at best 9600 baud with a Z8C530 and 64 Kbits with a Z85230.
   </para>
   <para>
 	The DMA mode supports the chip when it is configured to use dual DMA
 	channels on an ISA bus. The better cards tend to support this mode
 	of operation for a single channel. With DMA running the Z85230 tops
-	out when it starts to hit ISA DMA constraints at about 512Kbits. It
+	out when it starts to hit ISA DMA constraints at about 512 Kbits. It
 	is worth noting here that many PC machines hang or crash when the
 	chip is driven fast enough to hold the ISA bus solid.
   </para>
@@ -132,7 +132,7 @@
 	The structure holds two channel structures. 
 	Initialise chanA.ctrlio and chanA.dataio with the address of the
 	control and data ports. You can or this with Z8530_PORT_SLEEP to
-	indicate your interface needs the 5uS delay for chip settling done
+	indicate your interface needs the 5 uS delay for chip settling done
 	in software. The PORT_SLEEP option is architecture specific. Other
 	flags may become available on future platforms, eg for MMIO.
 	Initialise the chanA.irqs to &amp;z8530_nop to start the chip up

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)
