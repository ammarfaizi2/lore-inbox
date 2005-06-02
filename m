Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVFBW6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFBW6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFBW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:58:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9660 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261665AbVFBWud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:50:33 -0400
Message-ID: <429F8D2D.2000904@pobox.com>
Date: Thu, 02 Jun 2005 18:50:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata doc update
Content-Type: multipart/mixed;
 boundary="------------040807060105080405060503"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040807060105080405060503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


No code changes, just updating docs to the latest code.

Please pull from 'docs' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

diffstat/changelog/patch attached.



--------------040807060105080405060503
Content-Type: text/plain;
 name="libata-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.txt"



 Documentation/DocBook/libata.tmpl |  156 ++++++++++--
 drivers/scsi/ata_piix.c           |   16 -
 drivers/scsi/libata-core.c        |  470 ++++++++++++++++++++++++++++++++++----
 drivers/scsi/libata-scsi.c        |    2 
 include/linux/libata.h            |   58 ++++
 5 files changed, 610 insertions(+), 92 deletions(-)



commit d7aaf48128ec7fcefcee92ea22833afc1a80e268
tree 16ff78f6be6a5519944bb7bfc6034dfbd71ae97f
parent decc6d0b68f27bbb8a0357fccf41936a3c196b03
parent 1e86d1c648508fd50e6c9960576b87906a7906ad
author <jgarzik@pretzel.yyz.us> Fri, 03 Jun 2005 02:43:09 -0400
committer Jeff Garzik <jgarzik@pobox.com> Fri, 03 Jun 2005 02:43:09 -0400

Automatic merge of /spare/repo/linux-2.6/.git branch HEAD

--------------------------
commit decc6d0b68f27bbb8a0357fccf41936a3c196b03
tree 837af8973907f1a197d2ca9983da4135c83bd562
parent 0baab86b00cdf9785ac2bb2ce1ab63995b3866ca
author Jeff Garzik <jgarzik@pobox.com> Fri, 03 Jun 2005 02:42:33 -0400
committer Jeff Garzik <jgarzik@pobox.com> Fri, 03 Jun 2005 02:42:33 -0400

libata: kernel-doc warning fixes

--------------------------
commit 0baab86b00cdf9785ac2bb2ce1ab63995b3866ca
tree 9a92597d6e1653a9a9b3ed7f371d62237e68a6e9
parent 92bab26be5544d8b495389646490fcfdca6dbcf2
author Edward Falk <efalk@google.com> Fri, 03 Jun 2005 02:17:13 -0400
committer Jeff Garzik <jgarzik@pobox.com> Fri, 03 Jun 2005 02:17:13 -0400

libata: update inline source docs

--------------------------
commit 92bab26be5544d8b495389646490fcfdca6dbcf2
tree 370094359db3814caa62a02195c2d37c6c61585d
parent 0cba632b737fc2de76934137b8dccf92d9fa4d19
author Jeff Garzik <jgarzik@pobox.com> Wed, 01 Jun 2005 04:43:57 -0400
committer Jeff Garzik <jgarzik@pobox.com> Wed, 01 Jun 2005 04:43:57 -0400

libata: more docs updates

--------------------------
commit 0cba632b737fc2de76934137b8dccf92d9fa4d19
tree f2de8c9152ca956aaaaad57ddbe9fc373d4b39d7
parent 780a87f71841932db8dbb0f1eb9daf3a973a6bd6
author Jeff Garzik <jgarzik@pobox.com> Tue, 31 May 2005 03:49:12 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 31 May 2005 03:49:12 -0400

libata: doc updates

--------------------------
commit 780a87f71841932db8dbb0f1eb9daf3a973a6bd6
tree 443bad8a11c4502785265578e7a424ca3c67326a
parent 07dd39b9f62e0532c6922459c3a26d54a07bc231
author Jeff Garzik <jgarzik@pobox.com> Mon, 30 May 2005 23:41:05 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 30 May 2005 23:41:05 -0400

libata: more doc updates

Document recently-added ata_port_operations hooks.

Fill several doc stubs in libata-core.c.

--------------------------
commit 07dd39b9f62e0532c6922459c3a26d54a07bc231
tree 900a79ca5defcfcb96e583d6b9cb8092c9144b0b
parent 254feb882a7c6e4e51416dff6a97d847fbbba551
author Jeff Garzik <jgarzik@pobox.com> Mon, 30 May 2005 21:15:52 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 30 May 2005 21:15:52 -0400

libata: minor DocBook update

--------------------------



diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -14,7 +14,7 @@
   </authorgroup>
 
   <copyright>
-   <year>2003</year>
+   <year>2003-2005</year>
    <holder>Jeff Garzik</holder>
   </copyright>
 
@@ -44,30 +44,38 @@
 
 <toc></toc>
 
-  <chapter id="libataThanks">
-     <title>Thanks</title>
+  <chapter id="libataIntroduction">
+     <title>Introduction</title>
   <para>
-  The bulk of the ATA knowledge comes thanks to long conversations with
-  Andre Hedrick (www.linux-ide.org).
+  libATA is a library used inside the Linux kernel to support ATA host
+  controllers and devices.  libATA provides an ATA driver API, class
+  transports for ATA and ATAPI devices, and SCSI&lt;-&gt;ATA translation
+  for ATA devices according to the T10 SAT specification.
   </para>
   <para>
-  Thanks to Alan Cox for pointing out similarities 
-  between SATA and SCSI, and in general for motivation to hack on
-  libata.
-  </para>
-  <para>
-  libata's device detection
-  method, ata_pio_devchk, and in general all the early probing was
-  based on extensive study of Hale Landis's probe/reset code in his
-  ATADRVR driver (www.ata-atapi.com).
+  This Guide documents the libATA driver API, library functions, library
+  internals, and a couple sample ATA low-level drivers.
   </para>
   </chapter>
 
   <chapter id="libataDriverApi">
      <title>libata Driver API</title>
+     <para>
+     struct ata_port_operations is defined for every low-level libata
+     hardware driver, and it controls how the low-level driver
+     interfaces with the ATA and SCSI layers.
+     </para>
+     <para>
+     FIS-based drivers will hook into the system with ->qc_prep() and
+     ->qc_issue() high-level hooks.  Hardware which behaves in a manner
+     similar to PCI IDE hardware may utilize several generic helpers,
+     defining at a bare minimum the bus I/O addresses of the ATA shadow
+     register blocks.
+     </para>
      <sect1>
         <title>struct ata_port_operations</title>
 
+	<sect2><title>Disable ATA port</title>
 	<programlisting>
 void (*port_disable) (struct ata_port *);
 	</programlisting>
@@ -78,6 +86,9 @@ void (*port_disable) (struct ata_port *)
 	unplug).
 	</para>
 
+	</sect2>
+
+	<sect2><title>Post-IDENTIFY device configuration</title>
 	<programlisting>
 void (*dev_config) (struct ata_port *, struct ata_device *);
 	</programlisting>
@@ -88,6 +99,9 @@ void (*dev_config) (struct ata_port *, s
 	issue of SET FEATURES - XFER MODE, and prior to operation.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Set PIO/DMA mode</title>
 	<programlisting>
 void (*set_piomode) (struct ata_port *, struct ata_device *);
 void (*set_dmamode) (struct ata_port *, struct ata_device *);
@@ -108,6 +122,9 @@ void (*post_set_mode) (struct ata_port *
 	->set_dma_mode() is only called if DMA is possible.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Taskfile read/write</title>
 	<programlisting>
 void (*tf_load) (struct ata_port *ap, struct ata_taskfile *tf);
 void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -120,6 +137,9 @@ void (*tf_read) (struct ata_port *ap, st
 	taskfile register values.
 	</para>
 
+	</sect2>
+
+	<sect2><title>ATA command execute</title>
 	<programlisting>
 void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	</programlisting>
@@ -129,17 +149,37 @@ void (*exec_command)(struct ata_port *ap
 	->tf_load(), to be initiated in hardware.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Per-cmd ATAPI DMA capabilities filter</title>
+	<programlisting>
+int (*check_atapi_dma) (struct ata_queued_cmd *qc);
+	</programlisting>
+
+	<para>
+Allow low-level driver to filter ATA PACKET commands, returning a status
+indicating whether or not it is OK to use DMA for the supplied PACKET
+command.
+	</para>
+
+	</sect2>
+
+	<sect2><title>Read specific ATA shadow registers</title>
 	<programlisting>
 u8   (*check_status)(struct ata_port *ap);
-void (*dev_select)(struct ata_port *ap, unsigned int device);
+u8   (*check_altstatus)(struct ata_port *ap);
+u8   (*check_err)(struct ata_port *ap);
 	</programlisting>
 
 	<para>
-	Reads the Status ATA shadow register from hardware.  On some
-	hardware, this has the side effect of clearing the interrupt
-	condition.
+	Reads the Status/AltStatus/Error ATA shadow register from
+	hardware.  On some hardware, reading the Status register has
+	the side effect of clearing the interrupt condition.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Select ATA device on bus</title>
 	<programlisting>
 void (*dev_select)(struct ata_port *ap, unsigned int device);
 	</programlisting>
@@ -147,9 +187,13 @@ void (*dev_select)(struct ata_port *ap, 
 	<para>
 	Issues the low-level hardware command(s) that causes one of N
 	hardware devices to be considered 'selected' (active and
-	available for use) on the ATA bus.
+	available for use) on the ATA bus.  This generally has no
+meaning on FIS-based devices.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Reset ATA bus</title>
 	<programlisting>
 void (*phy_reset) (struct ata_port *ap);
 	</programlisting>
@@ -162,17 +206,31 @@ void (*phy_reset) (struct ata_port *ap);
 	functions ata_bus_reset() or sata_phy_reset() for this hook.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Control PCI IDE BMDMA engine</title>
 	<programlisting>
 void (*bmdma_setup) (struct ata_queued_cmd *qc);
 void (*bmdma_start) (struct ata_queued_cmd *qc);
+void (*bmdma_stop) (struct ata_port *ap);
+u8   (*bmdma_status) (struct ata_port *ap);
 	</programlisting>
 
 	<para>
-	When setting up an IDE BMDMA transaction, these hooks arm
-	(->bmdma_setup) and fire (->bmdma_start) the hardware's DMA
-	engine.
+When setting up an IDE BMDMA transaction, these hooks arm
+(->bmdma_setup), fire (->bmdma_start), and halt (->bmdma_stop)
+the hardware's DMA engine.  ->bmdma_status is used to read the standard
+PCI IDE DMA Status register.
 	</para>
 
+	<para>
+These hooks are typically either no-ops, or simply not implemented, in
+FIS-based drivers.
+	</para>
+
+	</sect2>
+
+	<sect2><title>High-level taskfile hooks</title>
 	<programlisting>
 void (*qc_prep) (struct ata_queued_cmd *qc);
 int (*qc_issue) (struct ata_queued_cmd *qc);
@@ -190,20 +248,26 @@ int (*qc_issue) (struct ata_queued_cmd *
 	->qc_issue is used to make a command active, once the hardware
 	and S/G tables have been prepared.  IDE BMDMA drivers use the
 	helper function ata_qc_issue_prot() for taskfile protocol-based
-	dispatch.  More advanced drivers roll their own ->qc_issue
-	implementation, using this as the "issue new ATA command to
-	hardware" hook.
+	dispatch.  More advanced drivers implement their own ->qc_issue.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Timeout (error) handling</title>
 	<programlisting>
 void (*eng_timeout) (struct ata_port *ap);
 	</programlisting>
 
 	<para>
-	This is a high level error handling function, called from the
-	error handling thread, when a command times out.
+This is a high level error handling function, called from the
+error handling thread, when a command times out.  Most newer
+hardware will implement its own error handling code here.  IDE BMDMA
+drivers may use the helper function ata_eng_timeout().
 	</para>
 
+	</sect2>
+
+	<sect2><title>Hardware interrupt handling</title>
 	<programlisting>
 irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
 void (*irq_clear) (struct ata_port *);
@@ -216,6 +280,9 @@ void (*irq_clear) (struct ata_port *);
 	is quiet.
 	</para>
 
+	</sect2>
+
+	<sect2><title>SATA phy read/write</title>
 	<programlisting>
 u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -227,6 +294,9 @@ void (*scr_write) (struct ata_port *ap, 
 	if ->phy_reset hook called the sata_phy_reset() helper function.
 	</para>
 
+	</sect2>
+
+	<sect2><title>Init and shutdown</title>
 	<programlisting>
 int (*port_start) (struct ata_port *ap);
 void (*port_stop) (struct ata_port *ap);
@@ -240,15 +310,17 @@ void (*host_stop) (struct ata_host_set *
 	tasks.  
 	</para>
 	<para>
-	->host_stop() is called when the rmmod or hot unplug process
-	begins.  The hook must stop all hardware interrupts, DMA
-	engines, etc.
-	</para>
-	<para>
 	->port_stop() is called after ->host_stop().  It's sole function
 	is to release DMA/memory resources, now that they are no longer
 	actively being used.
 	</para>
+	<para>
+	->host_stop() is called after all ->port_stop() calls
+have completed.  The hook must finalize hardware shutdown, release DMA
+and other resources, etc.
+	</para>
+
+	</sect2>
 
      </sect1>
   </chapter>
@@ -279,4 +351,24 @@ void (*host_stop) (struct ata_host_set *
 !Idrivers/scsi/sata_sil.c
   </chapter>
 
+  <chapter id="libataThanks">
+     <title>Thanks</title>
+  <para>
+  The bulk of the ATA knowledge comes thanks to long conversations with
+  Andre Hedrick (www.linux-ide.org), and long hours pondering the ATA
+  and SCSI specifications.
+  </para>
+  <para>
+  Thanks to Alan Cox for pointing out similarities 
+  between SATA and SCSI, and in general for motivation to hack on
+  libata.
+  </para>
+  <para>
+  libata's device detection
+  method, ata_pio_devchk, and in general all the early probing was
+  based on extensive study of Hale Landis's probe/reset code in his
+  ATADRVR driver (www.ata-atapi.com).
+  </para>
+  </chapter>
+
 </book>
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -665,15 +665,6 @@ static int piix_init_one (struct pci_dev
 	return ata_pci_init_one(pdev, port_info, n_ports);
 }
 
-/**
- *	piix_init -
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
 static int __init piix_init(void)
 {
 	int rc;
@@ -689,13 +680,6 @@ static int __init piix_init(void)
 	return 0;
 }
 
-/**
- *	piix_exit -
- *
- *	LOCKING:
- *
- */
-
 static void __exit piix_exit(void)
 {
 	pci_unregister_driver(&piix_pci_driver);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -186,6 +186,28 @@ static void ata_tf_load_mmio(struct ata_
 	ata_wait_idle(ap);
 }
 
+
+/**
+ *	ata_tf_load - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@tf: ATA taskfile register set
+ *
+ *	Outputs ATA taskfile to standard ATA host controller using MMIO
+ *	or PIO as indicated by the ATA_FLAG_MMIO flag.
+ *	Writes the control, feature, nsect, lbal, lbam, and lbah registers.
+ *	Optionally (ATA_TFLAG_LBA48) writes hob_feature, hob_nsect,
+ *	hob_lbal, hob_lbam, and hob_lbah.
+ *
+ *	This function waits for idle (!BUSY and !DRQ) after writing
+ *	registers.  If the control register has a new value, this
+ *	function also waits for idle after writing control and before
+ *	writing the remaining registers.
+ *
+ *	May be used as the tf_load() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 void ata_tf_load(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -195,11 +217,11 @@ void ata_tf_load(struct ata_port *ap, st
 }
 
 /**
- *	ata_exec_command - issue ATA command to host controller
+ *	ata_exec_command_pio - issue ATA command to host controller
  *	@ap: port to which command is being issued
  *	@tf: ATA taskfile register set
  *
- *	Issues PIO/MMIO write to ATA command register, with proper
+ *	Issues PIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
  *	LOCKING:
@@ -235,6 +257,18 @@ static void ata_exec_command_mmio(struct
 	ata_pause(ap);
 }
 
+
+/**
+ *	ata_exec_command - issue ATA command to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
+ *
+ *	Issues PIO/MMIO write to ATA command register, with proper
+ *	synchronization with interrupt handler / other threads.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -305,7 +339,7 @@ void ata_tf_to_host_nolock(struct ata_po
 }
 
 /**
- *	ata_tf_read - input device's ATA taskfile shadow registers
+ *	ata_tf_read_pio - input device's ATA taskfile shadow registers
  *	@ap: Port from which input is read
  *	@tf: ATA taskfile register set for storing input
  *
@@ -368,6 +402,23 @@ static void ata_tf_read_mmio(struct ata_
 	}
 }
 
+
+/**
+ *	ata_tf_read - input device's ATA taskfile shadow registers
+ *	@ap: Port from which input is read
+ *	@tf: ATA taskfile register set for storing input
+ *
+ *	Reads ATA taskfile registers for currently-selected device
+ *	into @tf.
+ *
+ *	Reads nsect, lbal, lbam, lbah, and device.  If ATA_TFLAG_LBA48
+ *	is set, also reads the hob registers.
+ *
+ *	May be used as the tf_read() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -381,7 +432,7 @@ void ata_tf_read(struct ata_port *ap, st
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	and return it's value. This also clears pending interrupts
+ *	and return its value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
@@ -397,7 +448,7 @@ static u8 ata_check_status_pio(struct at
  *	@ap: port where the device is
  *
  *	Reads ATA taskfile status register for currently-selected device
- *	via MMIO and return it's value. This also clears pending interrupts
+ *	via MMIO and return its value. This also clears pending interrupts
  *      from this device
  *
  *	LOCKING:
@@ -408,6 +459,20 @@ static u8 ata_check_status_mmio(struct a
        	return readb((void __iomem *) ap->ioaddr.status_addr);
 }
 
+
+/**
+ *	ata_check_status - Read device status reg & clear interrupt
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile status register for currently-selected device
+ *	and return its value. This also clears pending interrupts
+ *      from this device
+ *
+ *	May be used as the check_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_check_status(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
@@ -415,6 +480,20 @@ u8 ata_check_status(struct ata_port *ap)
 	return ata_check_status_pio(ap);
 }
 
+
+/**
+ *	ata_altstatus - Read device alternate status reg
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile alternate status register for
+ *	currently-selected device and return its value.
+ *
+ *	Note: may NOT be used as the check_altstatus() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_altstatus(struct ata_port *ap)
 {
 	if (ap->ops->check_altstatus)
@@ -425,6 +504,20 @@ u8 ata_altstatus(struct ata_port *ap)
 	return inb(ap->ioaddr.altstatus_addr);
 }
 
+
+/**
+ *	ata_chk_err - Read device error reg
+ *	@ap: port where the device is
+ *
+ *	Reads ATA taskfile error register for
+ *	currently-selected device and return its value.
+ *
+ *	Note: may NOT be used as the check_err() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 u8 ata_chk_err(struct ata_port *ap)
 {
 	if (ap->ops->check_err)
@@ -873,10 +966,24 @@ void ata_dev_id_string(u16 *id, unsigned
 	}
 }
 
+
+/**
+ *	ata_noop_dev_select - Select device 0/1 on ATA bus
+ *	@ap: ATA channel to manipulate
+ *	@device: ATA device (numbered from zero) to select
+ *
+ *	This function performs no actual function.
+ *
+ *	May be used as the dev_select() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	caller.
+ */
 void ata_noop_dev_select (struct ata_port *ap, unsigned int device)
 {
 }
 
+
 /**
  *	ata_std_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
@@ -884,7 +991,9 @@ void ata_noop_dev_select (struct ata_por
  *
  *	Use the method defined in the ATA specification to
  *	make either device 0, or device 1, active on the
- *	ATA channel.
+ *	ATA channel.  Works with both PIO and MMIO.
+ *
+ *	May be used as the dev_select() entry in ata_port_operations.
  *
  *	LOCKING:
  *	caller.
@@ -1190,7 +1299,12 @@ err_out:
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
+ *	Master ATA bus probing function.  Initiates a hardware-dependent
+ *	bus reset, then attempts to identify any devices found on
+ *	the bus.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
  *	Zero on success, non-zero on error.
@@ -1229,10 +1343,14 @@ err_out:
 }
 
 /**
- *	ata_port_probe -
- *	@ap:
+ *	ata_port_probe - Mark port as enabled
+ *	@ap: Port for which we indicate enablement
  *
- *	LOCKING:
+ *	Modify @ap data structure such that the system
+ *	thinks that the entire port is enabled.
+ *
+ *	LOCKING: host_set lock, or some other form of
+ *	serialization.
  */
 
 void ata_port_probe(struct ata_port *ap)
@@ -1241,10 +1359,15 @@ void ata_port_probe(struct ata_port *ap)
 }
 
 /**
- *	__sata_phy_reset -
- *	@ap:
+ *	__sata_phy_reset - Wake/reset a low-level SATA PHY
+ *	@ap: SATA port associated with target SATA PHY.
+ *
+ *	This function issues commands to standard SATA Sxxx
+ *	PHY registers, to wake up the phy (and device), and
+ *	clear any reset condition.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 void __sata_phy_reset(struct ata_port *ap)
@@ -1289,10 +1412,14 @@ void __sata_phy_reset(struct ata_port *a
 }
 
 /**
- *	__sata_phy_reset -
- *	@ap:
+ *	sata_phy_reset - Reset SATA bus.
+ *	@ap: SATA port associated with target SATA PHY.
+ *
+ *	This function resets the SATA bus, and then probes
+ *	the bus for devices.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 void sata_phy_reset(struct ata_port *ap)
@@ -1304,10 +1431,16 @@ void sata_phy_reset(struct ata_port *ap)
 }
 
 /**
- *	ata_port_disable -
- *	@ap:
+ *	ata_port_disable - Disable port.
+ *	@ap: Port to be disabled.
  *
- *	LOCKING:
+ *	Modify @ap data structure such that the system
+ *	thinks that the entire port is disabled, and should
+ *	never attempt to probe or communicate with devices
+ *	on this port.
+ *
+ *	LOCKING: host_set lock, or some other form of
+ *	serialization.
  */
 
 void ata_port_disable(struct ata_port *ap)
@@ -1416,7 +1549,10 @@ static void ata_host_set_dma(struct ata_
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
  *
+ *	Set ATA device disk transfer mode (PIO3, UDMA6, etc.).
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 static void ata_set_mode(struct ata_port *ap)
@@ -1467,7 +1603,10 @@ err_out:
  *	@tmout_pat: impatience timeout
  *	@tmout: overall timeout
  *
- *	LOCKING:
+ *	Sleep until ATA Status register bit BSY clears,
+ *	or a timeout occurs.
+ *
+ *	LOCKING: None.
  *
  */
 
@@ -1553,10 +1692,14 @@ static void ata_bus_post_reset(struct at
 }
 
 /**
- *	ata_bus_edd -
- *	@ap:
+ *	ata_bus_edd - Issue EXECUTE DEVICE DIAGNOSTIC command.
+ *	@ap: Port to reset and probe
+ *
+ *	Use the EXECUTE DEVICE DIAGNOSTIC command to reset and
+ *	probe the bus.  Not often used these days.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  */
 
@@ -1633,8 +1776,8 @@ static unsigned int ata_bus_softreset(st
  *	the device is ATA or ATAPI.
  *
  *	LOCKING:
- *	Inherited from caller.  Some functions called by this function
- *	obtain the host_set lock.
+ *	PCI/etc. bus probe sem.
+ *	Obtains host_set lock.
  *
  *	SIDE EFFECTS:
  *	Sets ATA_FLAG_PORT_DISABLED if bus reset fails.
@@ -1876,7 +2019,11 @@ static int fgb(u32 bitmap)
  *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
  *	@xfer_shift_out: (output) bit shift that selects this mode
  *
+ *	Based on host and device capabilities, determine the
+ *	maximum transfer mode that is amenable to all.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
  *	Zero on success, negative on error.
@@ -1909,7 +2056,11 @@ static int ata_choose_xfer_mode(struct a
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
  *
+ *	Issue SET FEATURES - XFER MODE command to device @dev
+ *	on port @ap.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  */
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
@@ -1947,10 +2098,13 @@ static void ata_dev_set_xfermode(struct 
 }
 
 /**
- *	ata_sg_clean -
- *	@qc:
+ *	ata_sg_clean - Unmap DMA memory associated with command
+ *	@qc: Command containing DMA memory to be released
+ *
+ *	Unmap all mapped DMA memory associated with this command.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  */
 
 static void ata_sg_clean(struct ata_queued_cmd *qc)
@@ -1981,7 +2135,11 @@ static void ata_sg_clean(struct ata_queu
  *	ata_fill_sg - Fill PCI IDE PRD table
  *	@qc: Metadata associated with taskfile to be transferred
  *
+ *	Fill PCI IDE PRD (scatter-gather) table with segments
+ *	associated with the current disk command.
+ *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 static void ata_fill_sg(struct ata_queued_cmd *qc)
@@ -2028,7 +2186,13 @@ static void ata_fill_sg(struct ata_queue
  *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
+ *	Allow low-level driver to filter ATA PACKET commands, returning
+ *	a status indicating whether or not it is OK to use DMA for the
+ *	supplied PACKET command.
+ *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
  *	RETURNS: 0 when ATAPI DMA can be used
  *               nonzero otherwise
  */
@@ -2046,6 +2210,8 @@ int ata_check_atapi_dma(struct ata_queue
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
+ *	Prepare ATA taskfile for submission.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
@@ -2057,6 +2223,32 @@ void ata_qc_prep(struct ata_queued_cmd *
 	ata_fill_sg(qc);
 }
 
+/**
+ *	ata_sg_init_one - Associate command with memory buffer
+ *	@qc: Command to be associated
+ *	@buf: Memory buffer
+ *	@buflen: Length of memory buffer, in bytes.
+ *
+ *	Initialize the data-related elements of queued_cmd @qc
+ *	to point to a single memory buffer, @buf of byte length @buflen.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+
+
+/**
+ *	ata_sg_init_one - Prepare a one-entry scatter-gather list.
+ *	@qc:  Queued command
+ *	@buf:  transfer buffer
+ *	@buflen:  length of buf
+ *
+ *	Builds a single-entry scatter-gather list to initiate a
+ *	transfer utilizing the specified buffer.
+ *
+ *	LOCKING:
+ */
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
 	struct scatterlist *sg;
@@ -2074,6 +2266,32 @@ void ata_sg_init_one(struct ata_queued_c
 	sg->length = buflen;
 }
 
+/**
+ *	ata_sg_init - Associate command with scatter-gather table.
+ *	@qc: Command to be associated
+ *	@sg: Scatter-gather table.
+ *	@n_elem: Number of elements in s/g table.
+ *
+ *	Initialize the data-related elements of queued_cmd @qc
+ *	to point to a scatter-gather table @sg, containing @n_elem
+ *	elements.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+
+/**
+ *	ata_sg_init - Assign a scatter gather list to a queued command
+ *	@qc:  Queued command
+ *	@sg:  Scatter-gather list
+ *	@n_elem:  length of sg list
+ *
+ *	Attaches a scatter-gather list to a queued command.
+ *
+ *	LOCKING:
+ */
+
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
@@ -2083,14 +2301,16 @@ void ata_sg_init(struct ata_queued_cmd *
 }
 
 /**
- *	ata_sg_setup_one -
- *	@qc:
+ *	ata_sg_setup_one - DMA-map the memory buffer associated with a command.
+ *	@qc: Command with memory buffer to be mapped.
+ *
+ *	DMA-map the memory buffer associated with queued_cmd @qc.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *
+ *	Zero on success, negative on error.
  */
 
 static int ata_sg_setup_one(struct ata_queued_cmd *qc)
@@ -2115,13 +2335,16 @@ static int ata_sg_setup_one(struct ata_q
 }
 
 /**
- *	ata_sg_setup -
- *	@qc:
+ *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
+ *	@qc: Command with scatter-gather table to be mapped.
+ *
+ *	DMA-map the scatter-gather table associated with queued_cmd @qc.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
+ *	Zero on success, negative on error.
  *
  */
 
@@ -2151,6 +2374,7 @@ static int ata_sg_setup(struct ata_queue
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  *
  *	RETURNS:
  *
@@ -2198,6 +2422,7 @@ static unsigned long ata_pio_poll(struct
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  */
 
 static void ata_pio_complete (struct ata_port *ap)
@@ -2240,6 +2465,18 @@ static void ata_pio_complete (struct ata
 	ata_qc_complete(qc, drv_stat);
 }
 
+
+/**
+ *	swap_buf_le16 -
+ *	@buf:  Buffer to swap
+ *	@buf_words:  Number of 16-bit words in buffer.
+ *
+ *	Swap halves of 16-bit words if needed to convert from
+ *	little-endian byte order to native cpu byte order, or
+ *	vice-versa.
+ *
+ *	LOCKING:
+ */
 void swap_buf_le16(u16 *buf, unsigned int buf_words)
 {
 #ifdef __BIG_ENDIAN
@@ -2415,6 +2652,7 @@ err_out:
  *	@ap:
  *
  *	LOCKING:
+ *	None.  (executing in kernel thread context)
  */
 
 static void ata_pio_block(struct ata_port *ap)
@@ -2583,6 +2821,7 @@ static void atapi_request_sense(struct a
  *	transaction completed successfully.
  *
  *	LOCKING:
+ *	Inherited from SCSI layer (none, can sleep)
  */
 
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
@@ -2692,6 +2931,7 @@ out:
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
+ *	None.
  */
 
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
@@ -2717,6 +2957,7 @@ static struct ata_queued_cmd *ata_qc_new
  *	@dev: Device from whom we request an available command structure
  *
  *	LOCKING:
+ *	None.
  */
 
 struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
@@ -2781,6 +3022,7 @@ static void __ata_qc_complete(struct ata
  *	in case something prevents using it.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
@@ -2794,9 +3036,13 @@ void ata_qc_free(struct ata_queued_cmd *
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
- *	@drv_stat: ATA status register contents
+ *	@drv_stat: ATA Status register contents
+ *
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
  *
  *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
  *
  */
 
@@ -2892,6 +3138,7 @@ err_out:
 	return -1;
 }
 
+
 /**
  *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
  *	@qc: command to issue to device
@@ -2901,6 +3148,8 @@ err_out:
  *	classes called "protocols", and issuing each type of protocol
  *	is slightly different.
  *
+ *	May be used as the qc_issue() entry in ata_port_operations.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
@@ -2958,7 +3207,7 @@ int ata_qc_issue_prot(struct ata_queued_
 }
 
 /**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
@@ -3065,6 +3314,18 @@ static void ata_bmdma_start_pio (struct 
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+
+/**
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes the ATA_DMA_START flag to the DMA command register.
+ *
+ *	May be used as the bmdma_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_bmdma_start(struct ata_queued_cmd *qc)
 {
 	if (qc->ap->flags & ATA_FLAG_MMIO)
@@ -3073,6 +3334,20 @@ void ata_bmdma_start(struct ata_queued_c
 		ata_bmdma_start_pio(qc);
 }
 
+
+/**
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes address of PRD table to device's PRD Table Address
+ *	register, sets the DMA control register, and calls
+ *	ops->exec_command() to start the transfer.
+ *
+ *	May be used as the bmdma_setup() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
 void ata_bmdma_setup(struct ata_queued_cmd *qc)
 {
 	if (qc->ap->flags & ATA_FLAG_MMIO)
@@ -3081,6 +3356,19 @@ void ata_bmdma_setup(struct ata_queued_c
 		ata_bmdma_setup_pio(qc);
 }
 
+
+/**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
     if (ap->flags & ATA_FLAG_MMIO) {
@@ -3093,6 +3381,19 @@ void ata_bmdma_irq_clear(struct ata_port
 
 }
 
+
+/**
+ *	ata_bmdma_status - Read PCI IDE BMDMA status
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Read and return BMDMA status register.
+ *
+ *	May be used as the bmdma_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 u8 ata_bmdma_status(struct ata_port *ap)
 {
 	u8 host_stat;
@@ -3104,6 +3405,19 @@ u8 ata_bmdma_status(struct ata_port *ap)
 	return host_stat;
 }
 
+
+/**
+ *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clears the ATA_DMA_START flag in the dma control register
+ *
+ *	May be used as the bmdma_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
 void ata_bmdma_stop(struct ata_port *ap)
 {
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -3203,13 +3517,18 @@ idle_irq:
 
 /**
  *	ata_interrupt - Default ATA host interrupt handler
- *	@irq: irq line
- *	@dev_instance: pointer to our host information structure
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host_set information structure
  *	@regs: unused
  *
+ *	Default interrupt handler for PCI IDE devices.  Calls
+ *	ata_host_intr() for each port that is not disabled.
+ *
  *	LOCKING:
+ *	Obtains host_set lock during operation.
  *
  *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
  *
  */
 
@@ -3302,6 +3621,19 @@ err_out:
 	ata_qc_complete(qc, ATA_ERR);
 }
 
+
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -3315,6 +3647,18 @@ int ata_port_start (struct ata_port *ap)
 	return 0;
 }
 
+
+/**
+ *	ata_port_stop - Undo ata_port_start()
+ *	@ap: Port to shut down
+ *
+ *	Frees the PRD table.
+ *
+ *	May be used as the port_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ */
+
 void ata_port_stop (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -3357,7 +3701,11 @@ static void ata_host_remove(struct ata_p
  *	@ent: Probe information provided by low-level driver
  *	@port_no: Port number associated with this ata_port
  *
+ *	Initialize a new ata_port structure, and its associated
+ *	scsi_host.
+ *
  *	LOCKING:
+ *	Inherited from caller.
  *
  */
 
@@ -3412,9 +3760,13 @@ static void ata_host_init(struct ata_por
  *	@host_set: Collections of ports to which we add
  *	@port_no: Port number associated with this host
  *
+ *	Attach low-level ATA driver to system.
+ *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
+ *	New ata_port on success, for NULL on error.
  *
  */
 
@@ -3447,12 +3799,22 @@ err_out:
 }
 
 /**
- *	ata_device_add -
- *	@ent:
+ *	ata_device_add - Register hardware device with ATA and SCSI layers
+ *	@ent: Probe information describing hardware device to be registered
+ *
+ *	This function processes the information provided in the probe
+ *	information struct @ent, allocates the necessary ATA and SCSI
+ *	host information structures, initializes them, and registers
+ *	everything with requisite kernel subsystems.
+ *
+ *	This function requests irqs, probes the ATA bus, and probes
+ *	the SCSI bus.
  *
  *	LOCKING:
+ *	PCI/etc. bus probe sem.
  *
  *	RETURNS:
+ *	Number of ports registered.  Zero on error (no ports registered).
  *
  */
 
@@ -3604,7 +3966,15 @@ int ata_scsi_release(struct Scsi_Host *h
 /**
  *	ata_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
+ *
+ *	Utility function which initializes data_addr, error_addr,
+ *	feature_addr, nsect_addr, lbal_addr, lbam_addr, lbah_addr,
+ *	device_addr, status_addr, and command_addr to standard offsets
+ *	relative to cmd_addr.
+ *
+ *	Does not set ctl_addr, altstatus_addr, bmdma_addr, or scr_addr.
  */
+
 void ata_std_ports(struct ata_ioports *ioaddr)
 {
 	ioaddr->data_addr = ioaddr->cmd_addr + ATA_REG_DATA;
@@ -3646,6 +4016,20 @@ ata_probe_ent_alloc(struct device *dev, 
 	return probe_ent;
 }
 
+
+
+/**
+ *	ata_pci_init_native_mode - Initialize native-mode driver
+ *	@pdev:  pci device to be initialized
+ *	@port:  array[2] of pointers to port info structures.
+ *
+ *	Utility function which allocates and initializes an
+ *	ata_probe_ent structure for a standard dual-port
+ *	PIO-based IDE controller.  The returned ata_probe_ent
+ *	structure can be passed to ata_device_add().  The returned
+ *	ata_probe_ent structure should then be freed with kfree().
+ */
+
 #ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
@@ -3727,10 +4111,19 @@ ata_pci_init_legacy_mode(struct pci_dev 
  *	@port_info: Information from low-level host driver
  *	@n_ports: Number of ports attached to host controller
  *
+ *	This is a helper function which can be called from a driver's
+ *	xxx_init_one() probe function if the hardware uses traditional
+ *	IDE taskfile registers.
+ *
+ *	This function calls pci_enable_device(), reserves its register
+ *	regions, sets the dma mask, enables bus master mode, and calls
+ *	ata_device_add()
+ *
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
  *
  *	RETURNS:
+ *	Zero on success, negative on errno-based value on error.
  *
  */
 
@@ -3949,15 +4342,6 @@ int pci_test_config_bits(struct pci_dev 
 #endif /* CONFIG_PCI */
 
 
-/**
- *	ata_init -
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
 static int __init ata_init(void)
 {
 	ata_wq = create_workqueue("ata");
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -947,7 +947,7 @@ unsigned int ata_scsiop_inq_83(struct at
 }
 
 /**
- *	ata_scsiop_noop -
+ *	ata_scsiop_noop - Command handler that simply returns success.
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -467,12 +467,34 @@ static inline u8 ata_chk_status(struct a
 	return ap->ops->check_status(ap);
 }
 
+
+/**
+ *	ata_pause - Flush writes and pause 400 nanoseconds.
+ *	@ap: Port to wait for.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline void ata_pause(struct ata_port *ap)
 {
 	ata_altstatus(ap);
 	ndelay(400);
 }
 
+
+/**
+ *	ata_busy_wait - Wait for a port status register
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to max*10 microseconds for the selected bits in the port's
+ *	status register to be cleared.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
 			       unsigned int max)
 {
@@ -487,6 +509,18 @@ static inline u8 ata_busy_wait(struct at
 	return status;
 }
 
+
+/**
+ *	ata_wait_idle - Wait for a port to be idle.
+ *	@ap: Port to wait for.
+ *
+ *	Waits up to 10ms for port's BUSY and DRQ signals to clear.
+ *	Returns final value of status register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
@@ -525,6 +559,18 @@ static inline void ata_tf_init(struct at
 		tf->device = ATA_DEVICE_OBS | ATA_DEV1;
 }
 
+
+/**
+ *	ata_irq_on - Enable interrupts on a port.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Enable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static inline u8 ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
@@ -544,6 +590,18 @@ static inline u8 ata_irq_on(struct ata_p
 	return tmp;
 }
 
+
+/**
+ *	ata_irq_ack - Acknowledge a device interrupt.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Wait up to 10 ms for legacy IDE device to become idle (BUSY
+ *	or BUSY+DRQ clear).  Obtain dma status and port status from
+ *	device.  Clear the interrupt.  Return port status.
+ *
+ *	LOCKING:
+ */
+
 static inline u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
 {
 	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;

--------------040807060105080405060503--
