Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVCXFye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVCXFye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVCXFye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:54:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51082 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263046AbVCXFvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:51:47 -0500
Message-ID: <42425582.7040508@in.ibm.com>
Date: Thu, 24 Mar 2005 11:22:02 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 1/7] Converting resource struct fields to 64 bit
References: <424254E0.6060003@in.ibm.com>
In-Reply-To: <424254E0.6060003@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020107050403020408060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107050403020408060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Regards, Hari

--------------020107050403020408060501
Content-Type: text/plain;
 name="resource-64bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resource-64bit.patch"


---

This patch converts the start and end fields of the
resource structure to 64 bit. The patch makes the necesary
changes in several files to handle this migration.

---

 linux-2.6.12-rc1-hari/arch/arm/kernel/bios32.c                    |    6 -
 linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c                      |    2 
 linux-2.6.12-rc1-hari/arch/i386/pci/i386.c                        |    2 
 linux-2.6.12-rc1-hari/arch/ppc/kernel/pci.c                       |   26 ++---
 linux-2.6.12-rc1-hari/drivers/atm/ambassador.c                    |    2 
 linux-2.6.12-rc1-hari/drivers/atm/firestream.c                    |    4 
 linux-2.6.12-rc1-hari/drivers/block/sx8.c                         |    4 
 linux-2.6.12-rc1-hari/drivers/char/applicom.c                     |    7 -
 linux-2.6.12-rc1-hari/drivers/ide/pci/aec62xx.c                   |    3 
 linux-2.6.12-rc1-hari/drivers/ide/pci/cmd64x.c                    |    3 
 linux-2.6.12-rc1-hari/drivers/ide/pci/hpt34x.c                    |    4 
 linux-2.6.12-rc1-hari/drivers/ide/pci/pdc202xx_new.c              |    4 
 linux-2.6.12-rc1-hari/drivers/ide/pci/pdc202xx_old.c              |    4 
 linux-2.6.12-rc1-hari/drivers/ieee1394/ohci1394.c                 |   10 +-
 linux-2.6.12-rc1-hari/drivers/input/joystick/iforce/iforce-main.c |    4 
 linux-2.6.12-rc1-hari/drivers/input/serio/ct82c710.c              |    6 -
 linux-2.6.12-rc1-hari/drivers/isdn/hisax/telespci.c               |    4 
 linux-2.6.12-rc1-hari/drivers/media/video/bttv-driver.c           |    8 -
 linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-core.c        |    4 
 linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-mpeg.c        |    4 
 linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-video.c       |    4 
 linux-2.6.12-rc1-hari/drivers/media/video/saa7134/saa7134-core.c  |    8 -
 linux-2.6.12-rc1-hari/drivers/message/i2o/iop.c                   |   14 +--
 linux-2.6.12-rc1-hari/drivers/mtd/devices/pmc551.c                |    8 -
 linux-2.6.12-rc1-hari/drivers/mtd/maps/amd76xrom.c                |    5 -
 linux-2.6.12-rc1-hari/drivers/mtd/maps/ichxrom.c                  |    5 -
 linux-2.6.12-rc1-hari/drivers/mtd/maps/scx200_docflash.c          |    4 
 linux-2.6.12-rc1-hari/drivers/net/8139cp.c                        |    8 -
 linux-2.6.12-rc1-hari/drivers/net/8139too.c                       |    4 
 linux-2.6.12-rc1-hari/drivers/net/e100.c                          |    4 
 linux-2.6.12-rc1-hari/drivers/net/skge.c                          |    4 
 linux-2.6.12-rc1-hari/drivers/net/tulip/de2104x.c                 |    8 -
 linux-2.6.12-rc1-hari/drivers/net/tulip/tulip_core.c              |    6 -
 linux-2.6.12-rc1-hari/drivers/net/typhoon.c                       |    5 -
 linux-2.6.12-rc1-hari/drivers/net/wan/dscc4.c                     |   12 +-
 linux-2.6.12-rc1-hari/drivers/net/wan/pc300_drv.c                 |    4 
 linux-2.6.12-rc1-hari/drivers/pci/hotplug/cpcihp_zt5550.c         |    9 +-
 linux-2.6.12-rc1-hari/drivers/pci/hotplug/cpqphp_core.c           |   10 +-
 linux-2.6.12-rc1-hari/drivers/pci/hotplug/pciehp_hpc.c            |    5 -
 linux-2.6.12-rc1-hari/drivers/pci/hotplug/shpchp_hpc.c            |   12 +-
 linux-2.6.12-rc1-hari/drivers/pci/pci-sysfs.c                     |    6 -
 linux-2.6.12-rc1-hari/drivers/pci/pci.c                           |    5 -
 linux-2.6.12-rc1-hari/drivers/pci/proc.c                          |   18 +---
 linux-2.6.12-rc1-hari/drivers/pci/setup-bus.c                     |   11 +-
 linux-2.6.12-rc1-hari/drivers/pci/setup-res.c                     |   18 ++--
 linux-2.6.12-rc1-hari/drivers/pcmcia/i82365.c                     |    5 -
 linux-2.6.12-rc1-hari/drivers/pcmcia/pd6729.c                     |    3 
 linux-2.6.12-rc1-hari/drivers/pcmcia/tcic.c                       |    5 -
 linux-2.6.12-rc1-hari/drivers/pnp/manager.c                       |   12 +-
 linux-2.6.12-rc1-hari/drivers/pnp/resource.c                      |    8 -
 linux-2.6.12-rc1-hari/drivers/scsi/sata_via.c                     |    6 -
 linux-2.6.12-rc1-hari/drivers/serial/8250_pci.c                   |    4 
 linux-2.6.12-rc1-hari/include/linux/ioport.h                      |   21 ++--
 linux-2.6.12-rc1-hari/kernel/resource.c                           |   45 ++++------
 linux-2.6.12-rc1-hari/sound/drivers/mpu401/mpu401.c               |    4 
 linux-2.6.12-rc1-hari/sound/isa/es18xx.c                          |    2 
 linux-2.6.12-rc1-hari/sound/isa/gus/interwave.c                   |    8 -
 linux-2.6.12-rc1-hari/sound/isa/sb/sb16.c                         |    2 
 linux-2.6.12-rc1-hari/sound/oss/forte.c                           |    5 -
 linux-2.6.12-rc1-hari/sound/pci/bt87x.c                           |    5 -
 linux-2.6.12-rc1-hari/sound/pci/sonicvibes.c                      |    4 
 61 files changed, 233 insertions(+), 214 deletions(-)

diff -puN arch/arm/kernel/bios32.c~resource-64bit arch/arm/kernel/bios32.c
--- linux-2.6.12-rc1/arch/arm/kernel/bios32.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/arm/kernel/bios32.c	2005-03-23 17:47:50.000000000 +0530
@@ -304,7 +304,7 @@ static inline int pdev_bad_for_parity(st
 static void __devinit
 pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
 {
-	unsigned long offset;
+	u64 offset;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -619,9 +619,9 @@ char * __init pcibios_setup(char *str)
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
-	unsigned long start = res->start;
+	u64 start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/i386/kernel/efi.c~resource-64bit arch/i386/kernel/efi.c
--- linux-2.6.12-rc1/arch/i386/kernel/efi.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/kernel/efi.c	2005-03-23 17:47:50.000000000 +0530
@@ -590,7 +590,7 @@ efi_initialize_iomem_resources(struct re
 		res->end = res->start + ((md->num_pages << EFI_PAGE_SHIFT) - 1);
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		if (request_resource(&iomem_resource, res) < 0)
-			printk(KERN_ERR PFX "Failed to allocate res %s : 0x%lx-0x%lx\n",
+			printk(KERN_ERR PFX "Failed to allocate res %s : 0x%llx-0x%llx\n",
 				res->name, res->start, res->end);
 		/*
 		 * We don't know which region contains kernel data so we try
diff -puN arch/i386/pci/i386.c~resource-64bit arch/i386/pci/i386.c
--- linux-2.6.12-rc1/arch/i386/pci/i386.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/i386/pci/i386.c	2005-03-23 17:47:50.000000000 +0530
@@ -51,7 +51,7 @@ pcibios_align_resource(void *data, struc
 		       unsigned long size, unsigned long align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -puN arch/ppc/kernel/pci.c~resource-64bit arch/ppc/kernel/pci.c
--- linux-2.6.12-rc1/arch/ppc/kernel/pci.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/arch/ppc/kernel/pci.c	2005-03-23 17:47:50.000000000 +0530
@@ -114,7 +114,7 @@ pcibios_fixup_resources(struct pci_dev *
 		if (!res->flags)
 			continue;
 		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
+			DBG("PCI:%s Resource %d [%08Lx-%08Lx] is unassigned\n",
 			    pci_name(dev), i, res->start, res->end);
 			res->end -= res->start;
 			res->start = 0;
@@ -173,17 +173,17 @@ EXPORT_SYMBOL(pcibios_resource_to_bus);
  * but we want to try to avoid allocating at 0x2900-0x2bff
  * which might have be mirrored at 0x0100-0x03ff..
  */
-void pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+void pcibios_align_resource(void *data, struct resource *res, u64 size,
+		       u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
 			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", pci_name(dev),
+			       " (%Ld bytes)\n", pci_name(dev),
 			       dev->resource - res, size);
 		}
 
@@ -255,7 +255,7 @@ pcibios_allocate_bus_resources(struct li
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
+			DBG("PCI: bridge rsrc %Lx..%Lx (%lx), parent %p\n",
 			    res->start, res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
@@ -306,7 +306,7 @@ reparent_resources(struct resource *pare
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%lx..%lx] under %s\n",
+		DBG(KERN_INFO "PCI: reparented %s [%Lx..%Lx] under %s\n",
 		    p->name, p->start, p->end, res->name);
 	}
 	return 0;
@@ -362,12 +362,12 @@ pci_relocate_bridge_resource(struct pci_
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		DBG(KERN_ERR "PCI: huh? couldn't move to %Lx..%Lx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %Lx..%Lx\n",
 	       bus->number, i, res->start, res->end);
 	return 0;
 }
@@ -479,14 +479,14 @@ static inline void alloc_resource(struct
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
+	DBG("PCI:%s: Resource %d: %016Lx-%016Lx (f=%lx)\n",
 	    pci_name(dev), idx, r->start, r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
+			DBG("PCI:  parent is %p: %016Lx-%016Lx (f=%lx)\n",
 			    pr, pr->start, pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
@@ -1061,7 +1061,7 @@ do_update_p2p_io_resource(struct pci_bus
 	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
 	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
 	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %08lx-%08lx\n", res.start, res.end);
+	DBG("  IO window: %016Lx-%016Lx\n", res.start, res.end);
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -1210,7 +1210,7 @@ do_fixup_p2p_level(struct pci_bus *bus)
 				if ((r->flags & IORESOURCE_IO) == 0)
 					continue;
 				DBG("Trying to allocate from %08lx, size %08lx from parent"
-				    " res %d: %08lx -> %08lx\n",
+				    " res %d: %016Lx -> %016Lx\n",
 					res->start, res->end, i, r->start, r->end);
 			
 				if (allocate_resource(r, res, res->end + 1, res->start, max,
diff -puN drivers/atm/ambassador.c~resource-64bit drivers/atm/ambassador.c
--- linux-2.6.12-rc1/drivers/atm/ambassador.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/atm/ambassador.c	2005-03-23 17:47:50.000000000 +0530
@@ -2255,7 +2255,7 @@ static int __devinit amb_probe(struct pc
 	}
 
 	PRINTD (DBG_INFO, "found Madge ATM adapter (amb) at"
-		" IO %lx, IRQ %u, MEM %p", pci_resource_start(pci_dev, 1),
+		" IO %llx, IRQ %u, MEM %p", (unsigned long long)pci_resource_start(pci_dev, 1),
 		irq, bus_to_virt(pci_resource_start(pci_dev, 0)));
 
 	// check IO region
diff -puN drivers/atm/firestream.c~resource-64bit drivers/atm/firestream.c
--- linux-2.6.12-rc1/drivers/atm/firestream.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/atm/firestream.c	2005-03-23 17:47:50.000000000 +0530
@@ -1656,9 +1656,9 @@ static int __devinit fs_init (struct fs_
 	func_enter ();
 	pci_dev = dev->pci_dev;
 
-	printk (KERN_INFO "found a FireStream %d card, base %08lx, irq%d.\n", 
+	printk (KERN_INFO "found a FireStream %d card, base %08llx, irq%d.\n",
 		IS_FS50(dev)?50:155,
-		pci_resource_start(pci_dev, 0), dev->pci_dev->irq);
+		(unsigned long long)pci_resource_start(pci_dev, 0), dev->pci_dev->irq);
 
 	if (fs_debug & FS_DEBUG_INIT)
 		my_hd ((unsigned char *) dev, sizeof (*dev));
diff -puN drivers/block/sx8.c~resource-64bit drivers/block/sx8.c
--- linux-2.6.12-rc1/drivers/block/sx8.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/block/sx8.c	2005-03-23 17:47:50.000000000 +0530
@@ -1689,9 +1689,9 @@ static int carm_init_one (struct pci_dev
 	DPRINTK("waiting for probe_sem\n");
 	down(&host->probe_sem);
 
-	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
+	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       pci_resource_start(pdev, 0), pdev->irq, host->major);
+	       (unsigned long long)pci_resource_start(pdev, 0), pdev->irq, host->major);
 
 	carm_host_id++;
 	pci_set_drvdata(pdev, host);
diff -puN drivers/char/applicom.c~resource-64bit drivers/char/applicom.c
--- linux-2.6.12-rc1/drivers/char/applicom.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/char/applicom.c	2005-03-23 17:47:50.000000000 +0530
@@ -215,13 +215,14 @@ int __init applicom_init(void)
 		RamIO = ioremap(dev->resource[0].start, LEN_RAM_IO);
 
 		if (!RamIO) {
-			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
+			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%llx\n",
+				(unsigned long long)dev->resource[0].start);
 			pci_disable_device(dev);
 			return -EIO;
 		}
 
-		printk(KERN_INFO "Applicom %s found at mem 0x%lx, irq %d\n",
-		       applicom_pci_devnames[dev->device-1], dev->resource[0].start, 
+		printk(KERN_INFO "Applicom %s found at mem 0x%llx, irq %d\n",
+		       applicom_pci_devnames[dev->device-1], (unsigned long long)dev->resource[0].start,
 		       dev->irq);
 
 		boardno = ac_register_board(dev->resource[0].start, RamIO,0);
diff -puN drivers/ide/pci/aec62xx.c~resource-64bit drivers/ide/pci/aec62xx.c
--- linux-2.6.12-rc1/drivers/ide/pci/aec62xx.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ide/pci/aec62xx.c	2005-03-23 17:47:50.000000000 +0530
@@ -301,7 +301,8 @@ static unsigned int __devinit init_chips
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08llx\n", name,
+			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	if (bus_speed <= 33)
diff -puN drivers/ide/pci/cmd64x.c~resource-64bit drivers/ide/pci/cmd64x.c
--- linux-2.6.12-rc1/drivers/ide/pci/cmd64x.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ide/pci/cmd64x.c	2005-03-23 17:47:50.000000000 +0530
@@ -609,7 +609,8 @@ static unsigned int __devinit init_chips
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08llx\n", name,
+		(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff -puN drivers/ide/pci/hpt34x.c~resource-64bit drivers/ide/pci/hpt34x.c
--- linux-2.6.12-rc1/drivers/ide/pci/hpt34x.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ide/pci/hpt34x.c	2005-03-23 17:47:50.000000000 +0530
@@ -175,8 +175,8 @@ static unsigned int __devinit init_chips
 		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
 			pci_write_config_byte(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
-				dev->resource[PCI_ROM_RESOURCE].start);
+			printk(KERN_INFO "HPT345: ROM enabled at 0x%08llx\n",
+				(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
 	} else {
diff -puN drivers/ide/pci/pdc202xx_new.c~resource-64bit drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.12-rc1/drivers/ide/pci/pdc202xx_new.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ide/pci/pdc202xx_new.c	2005-03-23 17:47:50.000000000 +0530
@@ -313,8 +313,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08llx\n",
+			name, (unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #ifdef CONFIG_PPC_PMAC
diff -puN drivers/ide/pci/pdc202xx_old.c~resource-64bit drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.12-rc1/drivers/ide/pci/pdc202xx_old.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ide/pci/pdc202xx_old.c	2005-03-23 17:47:50.000000000 +0530
@@ -580,8 +580,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08llx\n",
+			name, (unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	/*
diff -puN drivers/ieee1394/ohci1394.c~resource-64bit drivers/ieee1394/ohci1394.c
--- linux-2.6.12-rc1/drivers/ieee1394/ohci1394.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/ieee1394/ohci1394.c	2005-03-23 17:47:50.000000000 +0530
@@ -584,11 +584,11 @@ static void ohci_initialize(struct ti_oh
 	sprintf (irq_buf, "%s", __irq_itoa(ohci->dev->irq));
 #endif
 	PRINT(KERN_INFO, "OHCI-1394 %d.%d (PCI): IRQ=[%s]  "
-	      "MMIO=[%lx-%lx]  Max Packet=[%d]",
+	      "MMIO=[%llx-%llx]  Max Packet=[%d]",
 	      ((((buf) >> 16) & 0xf) + (((buf) >> 20) & 0xf) * 10),
 	      ((((buf) >> 4) & 0xf) + ((buf) & 0xf) * 10), irq_buf,
-	      pci_resource_start(ohci->dev, 0),
-	      pci_resource_start(ohci->dev, 0) + OHCI1394_REGISTER_SIZE - 1,
+	      (unsigned long long)pci_resource_start(ohci->dev, 0),
+	      (unsigned long long)pci_resource_start(ohci->dev, 0) + OHCI1394_REGISTER_SIZE - 1,
 	      ohci->max_packet_size);
 
 	/* Check all of our ports to make sure that if anything is
@@ -3251,8 +3251,8 @@ static int __devinit ohci1394_pci_probe(
 	 * clearly says it's 2kb, so this shouldn't be a problem. */
 	ohci_base = pci_resource_start(dev, 0);
 	if (pci_resource_len(dev, 0) != OHCI1394_REGISTER_SIZE)
-		PRINT(KERN_WARNING, "Unexpected PCI resource length of %lx!",
-		      pci_resource_len(dev, 0));
+		PRINT(KERN_WARNING, "Unexpected PCI resource length of %llx!",
+		      (unsigned long long)pci_resource_len(dev, 0));
 
 	/* Seems PCMCIA handles this internally. Not sure why. Seems
 	 * pretty bogus to force a driver to special case this.  */
diff -puN drivers/input/joystick/iforce/iforce-main.c~resource-64bit drivers/input/joystick/iforce/iforce-main.c
--- linux-2.6.12-rc1/drivers/input/joystick/iforce/iforce-main.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/input/joystick/iforce/iforce-main.c	2005-03-23 17:47:50.000000000 +0530
@@ -526,9 +526,9 @@ int iforce_init_device(struct iforce *if
 
 	printk(KERN_DEBUG "iforce->dev.open = %p\n", iforce->dev.open);
 
-	printk(KERN_INFO "input: %s [%d effects, %ld bytes memory]\n",
+	printk(KERN_INFO "input: %s [%d effects, %lld bytes memory]\n",
 		iforce->dev.name, iforce->dev.ff_effects_max,
-		iforce->device_memory.end);
+		(unsigned long long)iforce->device_memory.end);
 
 	return 0;
 }
diff -puN drivers/input/serio/ct82c710.c~resource-64bit drivers/input/serio/ct82c710.c
--- linux-2.6.12-rc1/drivers/input/serio/ct82c710.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/input/serio/ct82c710.c	2005-03-23 17:47:50.000000000 +0530
@@ -187,7 +187,7 @@ static struct serio * __init ct82c710_al
 		serio->write = ct82c710_write;
 		serio->dev.parent = &ct82c710_device->dev;
 		strlcpy(serio->name, "C&T 82c710 mouse port", sizeof(serio->name));
-		snprintf(serio->phys, sizeof(serio->phys), "isa%04lx/serio0", CT82C710_DATA);
+		snprintf(serio->phys, sizeof(serio->phys), "isa%04llx/serio0", (unsigned long long)CT82C710_DATA);
 	}
 
 	return serio;
@@ -209,8 +209,8 @@ static int __init ct82c710_init(void)
 
 	serio_register_port(ct82c710_port);
 
-	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#lx irq %d\n",
-		CT82C710_DATA, CT82C710_IRQ);
+	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#llx irq %d\n",
+		(unsigned long long)CT82C710_DATA, CT82C710_IRQ);
 
 	return 0;
 }
diff -puN drivers/isdn/hisax/telespci.c~resource-64bit drivers/isdn/hisax/telespci.c
--- linux-2.6.12-rc1/drivers/isdn/hisax/telespci.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/isdn/hisax/telespci.c	2005-03-23 17:47:50.000000000 +0530
@@ -311,8 +311,8 @@ setup_telespci(struct IsdnCard *card)
 		}
 		cs->hw.teles0.membase = ioremap(pci_resource_start(dev_tel, 0),
 			PAGE_SIZE);
-		printk(KERN_INFO "Found: Zoran, base-address: 0x%lx, irq: 0x%x\n",
-			pci_resource_start(dev_tel, 0), dev_tel->irq);
+		printk(KERN_INFO "Found: Zoran, base-address: 0x%llx, irq: 0x%x\n",
+			(unsigned long long)pci_resource_start(dev_tel, 0), dev_tel->irq);
 	} else {
 		printk(KERN_WARNING "TelesPCI: No PCI card found\n");
 		return(0);
diff -puN drivers/media/video/bttv-driver.c~resource-64bit drivers/media/video/bttv-driver.c
--- linux-2.6.12-rc1/drivers/media/video/bttv-driver.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/media/video/bttv-driver.c	2005-03-23 17:47:50.000000000 +0530
@@ -3821,8 +3821,8 @@ static int __devinit bttv_probe(struct p
 	if (!request_mem_region(pci_resource_start(dev,0),
 				pci_resource_len(dev,0),
 				btv->c.name)) {
-                printk(KERN_WARNING "bttv%d: can't request iomem (0x%lx).\n",
-		       btv->c.nr, pci_resource_start(dev,0));
+                printk(KERN_WARNING "bttv%d: can't request iomem (0x%llx).\n",
+		       btv->c.nr, (unsigned long long)pci_resource_start(dev,0));
 		return -EBUSY;
 	}
         pci_set_master(dev);
@@ -3838,8 +3838,8 @@ static int __devinit bttv_probe(struct p
         pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
         printk(KERN_INFO "bttv%d: Bt%d (rev %d) at %s, ",
                bttv_num,btv->id, btv->revision, pci_name(dev));
-        printk("irq: %d, latency: %d, mmio: 0x%lx\n",
-	       btv->c.pci->irq, lat, pci_resource_start(dev,0));
+        printk("irq: %d, latency: %d, mmio: 0x%llx\n",
+	       btv->c.pci->irq, lat, (unsigned long long)pci_resource_start(dev,0));
 	schedule();
 
 	btv->bt848_mmio=ioremap(pci_resource_start(dev,0), 0x1000);
diff -puN drivers/media/video/cx88/cx88-core.c~resource-64bit drivers/media/video/cx88/cx88-core.c
--- linux-2.6.12-rc1/drivers/media/video/cx88/cx88-core.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-core.c	2005-03-23 17:47:50.000000000 +0530
@@ -1096,8 +1096,8 @@ static int get_ressources(struct cx88_co
 			       pci_resource_len(pci,0),
 			       core->name))
 		return 0;
-	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-	       core->name,pci_resource_start(pci,0));
+	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+	       core->name, (unsigned long long)pci_resource_start(pci,0));
 	return -EBUSY;
 }
 
diff -puN drivers/media/video/cx88/cx88-mpeg.c~resource-64bit drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.12-rc1/drivers/media/video/cx88/cx88-mpeg.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-mpeg.c	2005-03-23 17:47:50.000000000 +0530
@@ -344,9 +344,9 @@ int cx8802_init_common(struct cx8802_dev
 	pci_read_config_byte(dev->pci, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(dev->pci, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s/2: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->core->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->core->name,
 	       pci_name(dev->pci), dev->pci_rev, dev->pci->irq,
-	       dev->pci_lat,pci_resource_start(dev->pci,0));
+	       dev->pci_lat, (unsigned long long)pci_resource_start(dev->pci,0));
 
 	/* initialize driver struct */
         init_MUTEX(&dev->lock);
diff -puN drivers/media/video/cx88/cx88-video.c~resource-64bit drivers/media/video/cx88/cx88-video.c
--- linux-2.6.12-rc1/drivers/media/video/cx88/cx88-video.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/media/video/cx88/cx88-video.c	2005-03-23 17:47:50.000000000 +0530
@@ -2016,9 +2016,9 @@ static int __devinit cx8800_initdev(stru
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s/0: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", core->name,
+	       "latency: %d, mmio: 0x%llx\n", core->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat, (unsigned long long)pci_resource_start(pci_dev,0));
 
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev,0xffffffff)) {
diff -puN drivers/media/video/saa7134/saa7134-core.c~resource-64bit drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.12-rc1/drivers/media/video/saa7134/saa7134-core.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/media/video/saa7134/saa7134-core.c	2005-03-23 17:47:50.000000000 +0530
@@ -906,9 +906,9 @@ static int __devinit saa7134_initdev(str
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat, (unsigned long long)pci_resource_start(pci_dev,0));
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev,0xffffffff)) {
 		printk("%s: Oops: no 32bit PCI DMA ???\n",dev->name);
@@ -940,8 +940,8 @@ static int __devinit saa7134_initdev(str
 				pci_resource_len(pci_dev,0),
 				dev->name)) {
 		err = -EBUSY;
-		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-		       dev->name,pci_resource_start(pci_dev,0));
+		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+		       dev->name, (unsigned long long)pci_resource_start(pci_dev,0));
 		goto fail1;
 	}
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0), 0x1000);
diff -puN drivers/message/i2o/iop.c~resource-64bit drivers/message/i2o/iop.c
--- linux-2.6.12-rc1/drivers/message/i2o/iop.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/message/i2o/iop.c	2005-03-23 17:47:50.000000000 +0530
@@ -767,9 +767,10 @@ static int i2o_iop_systab_set(struct i2o
 			c->mem_alloc = 1;
 			sb->current_mem_size = 1 + res->end - res->start;
 			sb->current_mem_base = res->start;
-			printk(KERN_INFO "%s: allocated %ld bytes of PCI memory"
-			       " at 0x%08lX.\n", c->name,
-			       1 + res->end - res->start, res->start);
+			printk(KERN_INFO "%s: allocated %lld bytes of PCI memory"
+			       " at 0x%08llX.\n", c->name,
+				(unsigned long long)(1 + res->end - res->start),
+				(unsigned long long)(res->start));
 		}
 	}
 
@@ -790,9 +791,10 @@ static int i2o_iop_systab_set(struct i2o
 			c->io_alloc = 1;
 			sb->current_io_size = 1 + res->end - res->start;
 			sb->current_mem_base = res->start;
-			printk(KERN_INFO "%s: allocated %ld bytes of PCI I/O at"
-			       " 0x%08lX.\n", c->name,
-			       1 + res->end - res->start, res->start);
+			printk(KERN_INFO "%s: allocated %lld bytes of PCI I/O at"
+			       " 0x%08llX.\n", c->name,
+				(unsigned long long)1 + res->end - res->start,
+				(unsigned long long)(res->start));
 		}
 	}
 
diff -puN drivers/mtd/devices/pmc551.c~resource-64bit drivers/mtd/devices/pmc551.c
--- linux-2.6.12-rc1/drivers/mtd/devices/pmc551.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/mtd/devices/pmc551.c	2005-03-23 17:47:50.000000000 +0530
@@ -552,11 +552,11 @@ static u32 fixup_pmc551 (struct pci_dev 
         /*
          * Some screen fun
          */
-        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%lx\n",
+        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%llx\n",
 	       (size<1024)?size:(size<1048576)?size>>10:size>>20,
                (size<1024)?'B':(size<1048576)?'K':'M',
 	       size, ((dcmd&(0x1<<3)) == 0)?"non-":"",
-               (dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK );
+               (unsigned long long)(dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK );
 
         /*
          * Check to see the state of the memory
@@ -686,8 +686,8 @@ static int __init init_pmc551(void)
                         break;
                 }
 
-                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%lX\n",
-				    PCI_Device->resource[0].start);
+                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llX\n",
+				    (unsigned long long)PCI_Device->resource[0].start);
 
                 /*
                  * The PMC551 device acts VERY weird if you don't init it
diff -puN drivers/mtd/maps/amd76xrom.c~resource-64bit drivers/mtd/maps/amd76xrom.c
--- linux-2.6.12-rc1/drivers/mtd/maps/amd76xrom.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/mtd/maps/amd76xrom.c	2005-03-23 17:47:50.000000000 +0530
@@ -123,9 +123,10 @@ static int __devinit amd76xrom_init_one 
 		window->rsrc.parent = NULL;
 		printk(KERN_ERR MOD_NAME
 			" %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.08llx-0x%.08llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 #if 0
diff -puN drivers/mtd/maps/ichxrom.c~resource-64bit drivers/mtd/maps/ichxrom.c
--- linux-2.6.12-rc1/drivers/mtd/maps/ichxrom.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/mtd/maps/ichxrom.c	2005-03-23 17:47:50.000000000 +0530
@@ -177,9 +177,10 @@ static int __devinit ichxrom_init_one (s
 		window->rsrc.parent = NULL;
 		printk(KERN_DEBUG MOD_NAME
 			": %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.08llx-0x%.08llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 	/* Map the firmware hub into my address space. */
diff -puN drivers/mtd/maps/scx200_docflash.c~resource-64bit drivers/mtd/maps/scx200_docflash.c
--- linux-2.6.12-rc1/drivers/mtd/maps/scx200_docflash.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/mtd/maps/scx200_docflash.c	2005-03-23 17:47:50.000000000 +0530
@@ -164,8 +164,8 @@ static int __init init_scx200_docflash(v
 		outl(pmr, scx200_cb_base + SCx200_PMR);
 	}
 	
-       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n", 
-	       docmem.start, docmem.end, width);
+       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%llx-0x%llx, width %d\n",
+	       (unsigned long long)docmem.start, (unsigned long long)docmem.end, width);
 
 	scx200_docflash_map.size = size;
 	if (width == 8)
diff -puN drivers/net/8139cp.c~resource-64bit drivers/net/8139cp.c
--- linux-2.6.12-rc1/drivers/net/8139cp.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/8139cp.c	2005-03-23 17:47:50.000000000 +0530
@@ -1725,8 +1725,8 @@ static int cp_init_one (struct pci_dev *
 	}
 	if (pci_resource_len(pdev, 1) < CP_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -1758,8 +1758,8 @@ static int cp_init_one (struct pci_dev *
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%lx) on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff -puN drivers/net/8139too.c~resource-64bit drivers/net/8139too.c
--- linux-2.6.12-rc1/drivers/net/8139too.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/8139too.c	2005-03-23 17:47:50.000000000 +0530
@@ -1337,9 +1337,9 @@ static int rtl8139_open (struct net_devi
 	netif_start_queue (dev);
 
 	if (netif_msg_ifup(tp))
-		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#lx IRQ %d"
+		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#llx IRQ %d"
 			" GP Pins %2.2x %s-duplex.\n",
-			dev->name, pci_resource_start (tp->pci_dev, 1),
+			dev->name, (unsigned long long)pci_resource_start (tp->pci_dev, 1),
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->mii.full_duplex ? "full" : "half");
 
diff -puN drivers/net/e100.c~resource-64bit drivers/net/e100.c
--- linux-2.6.12-rc1/drivers/net/e100.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/e100.c	2005-03-23 17:47:50.000000000 +0530
@@ -2316,9 +2316,9 @@ static int __devinit e100_probe(struct p
 		goto err_out_free;
 	}
 
-	DPRINTK(PROBE, INFO, "addr 0x%lx, irq %d, "
+	DPRINTK(PROBE, INFO, "addr 0x%llx, irq %d, "
 		"MAC addr %02X:%02X:%02X:%02X:%02X:%02X\n",
-		pci_resource_start(pdev, 0), pdev->irq,
+		(unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 		netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
 		netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
 
diff -puN drivers/net/skge.c~resource-64bit drivers/net/skge.c
--- linux-2.6.12-rc1/drivers/net/skge.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/skge.c	2005-03-23 17:47:50.000000000 +0530
@@ -3229,8 +3229,8 @@ static int __devinit skge_probe(struct p
 	if (err)
 		goto err_out_free_irq;
 
-	printk(KERN_INFO PFX "addr 0x%lx irq %d chip %s rev %d\n",
-	       pci_resource_start(pdev, 0), pdev->irq,
+	printk(KERN_INFO PFX "addr 0x%llx irq %d chip %s rev %d\n",
+	       (unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 	       skge_board_name(hw), chip_rev(hw));
 
 	if ((dev = skge_devinit(hw, 0)) == NULL)
diff -puN drivers/net/tulip/de2104x.c~resource-64bit drivers/net/tulip/de2104x.c
--- linux-2.6.12-rc1/drivers/net/tulip/de2104x.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/tulip/de2104x.c	2005-03-23 17:47:50.000000000 +0530
@@ -2007,8 +2007,8 @@ static int __init de_init_one (struct pc
 	}
 	if (pci_resource_len(pdev, 1) < DE_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -2016,8 +2016,8 @@ static int __init de_init_one (struct pc
 	regs = ioremap_nocache(pciaddr, DE_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%lx) on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff -puN drivers/net/tulip/tulip_core.c~resource-64bit drivers/net/tulip/tulip_core.c
--- linux-2.6.12-rc1/drivers/net/tulip/tulip_core.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/tulip/tulip_core.c	2005-03-23 17:47:50.000000000 +0530
@@ -1359,10 +1359,10 @@ static int __devinit tulip_init_one (str
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
-		printk (KERN_ERR PFX "%s: I/O region (0x%lx@0x%lx) too small, "
+		printk (KERN_ERR PFX "%s: I/O region (0x%llx@0x%llx) too small, "
 			"aborting\n", pci_name(pdev),
-			pci_resource_len (pdev, 0),
-			pci_resource_start (pdev, 0));
+			(unsigned long long)pci_resource_len (pdev, 0),
+			(unsigned long long)pci_resource_start (pdev, 0));
 		goto err_out_free_netdev;
 	}
 
diff -puN drivers/net/typhoon.c~resource-64bit drivers/net/typhoon.c
--- linux-2.6.12-rc1/drivers/net/typhoon.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/typhoon.c	2005-03-23 17:47:50.000000000 +0530
@@ -2569,9 +2569,10 @@ typhoon_init_one(struct pci_dev *pdev, c
 
 	pci_set_drvdata(pdev, dev);
 
-	printk(KERN_INFO "%s: %s at %s 0x%lx, ",
+	printk(KERN_INFO "%s: %s at %s 0x%llx, ",
 	       dev->name, typhoon_card_info[card_id].name,
-	       use_mmio ? "MMIO" : "IO", pci_resource_start(pdev, use_mmio));
+	       use_mmio ? "MMIO" : "IO",
+		(unsigned long long)pci_resource_start(pdev, use_mmio));
 	for(i = 0; i < 5; i++)
 		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x\n", dev->dev_addr[i]);
diff -puN drivers/net/wan/dscc4.c~resource-64bit drivers/net/wan/dscc4.c
--- linux-2.6.12-rc1/drivers/net/wan/dscc4.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/wan/dscc4.c	2005-03-23 17:47:50.000000000 +0530
@@ -731,15 +731,15 @@ static int __devinit dscc4_init_one(stru
 	ioaddr = ioremap(pci_resource_start(pdev, 0),
 					pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk(KERN_ERR "%s: cannot remap MMIO region %lx @ %lx\n",
-			DRV_NAME, pci_resource_len(pdev, 0),
-			pci_resource_start(pdev, 0));
+		printk(KERN_ERR "%s: cannot remap MMIO region %llx @ %llx\n",
+			DRV_NAME, (unsigned long long)pci_resource_len(pdev, 0),
+			(unsigned long long)pci_resource_start(pdev, 0));
 		rc = -EIO;
 		goto err_free_mmio_regions_2;
 	}
-	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#lx (regs), %#lx (lbi), IRQ %d\n",
-	        pci_resource_start(pdev, 0),
-	        pci_resource_start(pdev, 1), pdev->irq);
+	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#llx (regs), %#llx (lbi), IRQ %d\n",
+	        (unsigned long long)pci_resource_start(pdev, 0),
+	        (unsigned long long)pci_resource_start(pdev, 1), pdev->irq);
 
 	/* Cf errata DS5 p.2 */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xf8);
diff -puN drivers/net/wan/pc300_drv.c~resource-64bit drivers/net/wan/pc300_drv.c
--- linux-2.6.12-rc1/drivers/net/wan/pc300_drv.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/net/wan/pc300_drv.c	2005-03-23 17:47:50.000000000 +0530
@@ -3441,9 +3441,9 @@ cpc_init_one(struct pci_dev *pdev, const
 
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
-		printk("PC300 found at RAM 0x%08lx, "
+		printk("PC300 found at RAM 0x%08llx, "
 		       "but could not allocate card structure.\n",
-		       pci_resource_start(pdev, 3));
+		       (unsigned long long)pci_resource_start(pdev, 3));
 		return -ENOMEM;
 	}
 	memset(card, 0, sizeof(pc300_t));
diff -puN drivers/pci/hotplug/cpcihp_zt5550.c~resource-64bit drivers/pci/hotplug/cpcihp_zt5550.c
--- linux-2.6.12-rc1/drivers/pci/hotplug/cpcihp_zt5550.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/hotplug/cpcihp_zt5550.c	2005-03-23 17:47:50.000000000 +0530
@@ -85,8 +85,8 @@ static int zt5550_hc_config(struct pci_d
 	}
 	hc_dev = pdev;
 	dbg("hc_dev = %p", hc_dev);
-	dbg("pci resource start %lx", pci_resource_start(hc_dev, 1));
-	dbg("pci resource len %lx", pci_resource_len(hc_dev, 1));
+	dbg("pci resource start %llx", (unsigned long long)pci_resource_start(hc_dev, 1));
+	dbg("pci resource len %llx", (unsigned long long)pci_resource_len(hc_dev, 1));
 
 	if(!request_mem_region(pci_resource_start(hc_dev, 1),
 				pci_resource_len(hc_dev, 1), MY_NAME)) {
@@ -97,8 +97,9 @@ static int zt5550_hc_config(struct pci_d
 	hc_registers =
 	    ioremap(pci_resource_start(hc_dev, 1), pci_resource_len(hc_dev, 1));
 	if(!hc_registers) {
-		err("cannot remap MMIO region %lx @ %lx",
-		    pci_resource_len(hc_dev, 1), pci_resource_start(hc_dev, 1));
+		err("cannot remap MMIO region %llx @ %llx",
+		    (unsigned long long)pci_resource_len(hc_dev, 1),
+			(unsigned long long)pci_resource_start(hc_dev, 1));
 		release_mem_region(pci_resource_start(hc_dev, 1),
 				   pci_resource_len(hc_dev, 1));
 		return -ENODEV;
diff -puN drivers/pci/hotplug/cpqphp_core.c~resource-64bit drivers/pci/hotplug/cpqphp_core.c
--- linux-2.6.12-rc1/drivers/pci/hotplug/cpqphp_core.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/hotplug/cpqphp_core.c	2005-03-23 17:47:50.000000000 +0530
@@ -1066,8 +1066,8 @@ static int cpqhpc_probe(struct pci_dev *
 	}
 	
 	dbg("pdev = %p\n", pdev);
-	dbg("pci resource start %lx\n", pci_resource_start(pdev, 0));
-	dbg("pci resource len %lx\n", pci_resource_len(pdev, 0));
+	dbg("pci resource start %llx\n", (unsigned long long)pci_resource_start(pdev, 0));
+	dbg("pci resource len %llx\n", (unsigned long long)pci_resource_len(pdev, 0));
 
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 				pci_resource_len(pdev, 0), MY_NAME)) {
@@ -1079,9 +1079,9 @@ static int cpqhpc_probe(struct pci_dev *
 	ctrl->hpc_reg = ioremap(pci_resource_start(pdev, 0),
 					pci_resource_len(pdev, 0));
 	if (!ctrl->hpc_reg) {
-		err("cannot remap MMIO region %lx @ %lx\n",
-				pci_resource_len(pdev, 0),
-				pci_resource_start(pdev, 0));
+		err("cannot remap MMIO region %llx @ %llx\n",
+				(unsigned long long)pci_resource_len(pdev, 0),
+				(unsigned long long)pci_resource_start(pdev, 0));
 		rc = -ENODEV;
 		goto err_free_mem_region;
 	}
diff -puN drivers/pci/hotplug/pciehp_hpc.c~resource-64bit drivers/pci/hotplug/pciehp_hpc.c
--- linux-2.6.12-rc1/drivers/pci/hotplug/pciehp_hpc.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/hotplug/pciehp_hpc.c	2005-03-23 17:47:50.000000000 +0530
@@ -1343,8 +1343,9 @@ int pcie_init(struct controller * ctrl,
 		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), dev->irq);
 	for ( rc = 0; rc < DEVICE_COUNT_RESOURCE; rc++)
 		if (pci_resource_len(pdev, rc) > 0)
-			dbg("pci resource[%d] start=0x%lx(len=0x%lx)\n", rc,
-				pci_resource_start(pdev, rc), pci_resource_len(pdev, rc));
+			dbg("pci resource[%d] start=0x%llx(len=0x%llx)\n", rc,
+				(unsigned long long)pci_resource_start(pdev, rc),
+				(unsigned long long)pci_resource_len(pdev, rc));
 
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, 
 		pdev->subsystem_vendor, pdev->subsystem_device);
diff -puN drivers/pci/hotplug/shpchp_hpc.c~resource-64bit drivers/pci/hotplug/shpchp_hpc.c
--- linux-2.6.12-rc1/drivers/pci/hotplug/shpchp_hpc.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/hotplug/shpchp_hpc.c	2005-03-23 17:47:50.000000000 +0530
@@ -1482,8 +1482,9 @@ int shpc_init(struct controller * ctrl,
 		PCI_FUNC(pdev->devfn), pdev->irq);
 	for ( rc = 0; rc < DEVICE_COUNT_RESOURCE; rc++)
 		if (pci_resource_len(pdev, rc) > 0)
-			dbg("pci resource[%d] start=0x%lx(len=0x%lx), shpc_base_offset %x\n", rc,
-				pci_resource_start(pdev, rc), pci_resource_len(pdev, rc), shpc_base_offset);
+			dbg("pci resource[%d] start=0x%llx(len=0x%llx), shpc_base_offset %x\n", rc,
+				(unsigned long long)pci_resource_start(pdev, rc),
+				(unsigned long long)pci_resource_len(pdev, rc), shpc_base_offset);
 
 	info("HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n", pdev->vendor, pdev->device, pdev->subsystem_vendor, 
 		pdev->subsystem_device);
@@ -1498,13 +1499,14 @@ int shpc_init(struct controller * ctrl,
 
 	php_ctlr->creg = ioremap(pci_resource_start(pdev, 0) + shpc_base_offset, pci_resource_len(pdev, 0));
 	if (!php_ctlr->creg) {
-		err("%s: cannot remap MMIO region %lx @ %lx\n", __FUNCTION__, pci_resource_len(pdev, 0), 
-			pci_resource_start(pdev, 0) + shpc_base_offset);
+		err("%s: cannot remap MMIO region %llx @ %llx\n", __FUNCTION__,
+			(unsigned long long)pci_resource_len(pdev, 0),
+			(unsigned long long)pci_resource_start(pdev, 0) + shpc_base_offset);
 		release_mem_region(pci_resource_start(pdev, 0) + shpc_base_offset, pci_resource_len(pdev, 0));
 		goto abort_free_ctlr;
 	}
 	dbg("%s: php_ctlr->creg %p\n", __FUNCTION__, php_ctlr->creg);
-	dbg("%s: physical addr %p\n", __FUNCTION__, (void*)pci_resource_start(pdev, 0));
+	dbg("%s: physical addr %llx\n", __FUNCTION__, (unsigned long long)pci_resource_start(pdev, 0));
 
 	init_MUTEX(&ctrl->crit_sect);
 	/* Setup wait queue */
diff -puN drivers/pci/pci.c~resource-64bit drivers/pci/pci.c
--- linux-2.6.12-rc1/drivers/pci/pci.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/pci.c	2005-03-23 17:47:50.000000000 +0530
@@ -623,10 +623,11 @@ int pci_request_region(struct pci_dev *p
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
+	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%llx@%llx for device %s\n",
 		pci_resource_flags(pdev, bar) & IORESOURCE_IO ? "I/O" : "mem",
 		bar + 1, /* PCI BAR # */
-		pci_resource_len(pdev, bar), pci_resource_start(pdev, bar),
+		(unsigned long long)pci_resource_len(pdev, bar),
+		(unsigned long long)pci_resource_start(pdev, bar),
 		pci_name(pdev));
 	return -EBUSY;
 }
diff -puN drivers/pci/pci-sysfs.c~resource-64bit drivers/pci/pci-sysfs.c
--- linux-2.6.12-rc1/drivers/pci/pci-sysfs.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/pci-sysfs.c	2005-03-23 17:47:50.000000000 +0530
@@ -65,9 +65,9 @@ resource_show(struct device * dev, char 
 		max = DEVICE_COUNT_RESOURCE;
 
 	for (i = 0; i < max; i++) {
-		str += sprintf(str,"0x%016lx 0x%016lx 0x%016lx\n",
-			       pci_resource_start(pci_dev,i),
-			       pci_resource_end(pci_dev,i),
+		str += sprintf(str,"0x%016llx 0x%016llx 0x%016lx\n",
+			       (unsigned long long)pci_resource_start(pci_dev,i),
+			       (unsigned long long)pci_resource_end(pci_dev,i),
 			       pci_resource_flags(pci_dev,i));
 	}
 	return (str - buf);
diff -puN drivers/pci/proc.c~resource-64bit drivers/pci/proc.c
--- linux-2.6.12-rc1/drivers/pci/proc.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/proc.c	2005-03-23 17:47:50.000000000 +0530
@@ -301,12 +301,6 @@ static struct file_operations proc_bus_p
 #endif /* HAVE_PCI_MMAP */
 };
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
-
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
 {
@@ -358,13 +352,13 @@ static int show_device(struct seq_file *
 			dev->irq);
 	/* Here should be 7 and not PCI_NUM_RESOURCES as we need to preserve compatibility */
 	for(i=0; i<7; i++)
-		seq_printf(m, LONG_FORMAT,
-			dev->resource[i].start |
-			(dev->resource[i].flags & PCI_REGION_FLAG_MASK));
+		seq_printf(m, "\t%16llx",
+			(unsigned long long)(dev->resource[i].start |
+			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
 	for(i=0; i<7; i++)
-		seq_printf(m, LONG_FORMAT,
-			dev->resource[i].start < dev->resource[i].end ?
-			dev->resource[i].end - dev->resource[i].start + 1 : 0);
+		seq_printf(m, "\t%16llx",
+			(unsigned long long)(dev->resource[i].start < dev->resource[i].end ?
+			dev->resource[i].end - dev->resource[i].start + 1 : 0));
 	seq_putc(m, '\t');
 	if (drv)
 		seq_printf(m, "%s", drv->name);
diff -puN drivers/pci/setup-bus.c~resource-64bit drivers/pci/setup-bus.c
--- linux-2.6.12-rc1/drivers/pci/setup-bus.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/setup-bus.c	2005-03-23 17:47:50.000000000 +0530
@@ -332,8 +332,8 @@ static int __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
 	struct pci_dev *dev;
-	unsigned long min_align, align, size;
-	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
+	u64 min_align, align, size;
+	u64 aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
 	struct resource *b_res = find_free_bus_resource(bus, type);
 
@@ -359,8 +359,9 @@ pbus_size_mem(struct pci_bus *bus, unsig
 			order = __ffs(align) - 20;
 			if (order > 11) {
 				printk(KERN_WARNING "PCI: region %s/%d "
-				       "too large: %lx-%lx\n",
-				       pci_name(dev), i, r->start, r->end);
+				       "too large: %llx-%llx\n",
+				       pci_name(dev), i, (unsigned long long)r->start,
+				       (unsigned long long)r->end);
 				r->flags = 0;
 				continue;
 			}
@@ -379,7 +380,7 @@ pbus_size_mem(struct pci_bus *bus, unsig
 	align = 0;
 	min_align = 0;
 	for (order = 0; order <= max_order; order++) {
-		unsigned long align1 = 1UL << (order + 20);
+		u64 align1 = 1UL << (order + 20);
 
 		if (!align)
 			min_align = align1;
diff -puN drivers/pci/setup-res.c~resource-64bit drivers/pci/setup-res.c
--- linux-2.6.12-rc1/drivers/pci/setup-res.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pci/setup-res.c	2005-03-23 17:47:50.000000000 +0530
@@ -108,10 +108,11 @@ pci_claim_resource(struct pci_dev *dev, 
 		err = insert_resource(root, res);
 
 	if (err) {
-		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",
+		printk(KERN_ERR "PCI: %s region %d of %s %s [%llx:%llx]\n",
 		       root ? "Address space collision on" :
 			      "No parent found for",
-		       resource, dtype, pci_name(dev), res->start, res->end);
+		       resource, dtype, pci_name(dev), (unsigned long long)res->start,
+			(unsigned long long)res->end);
 	}
 
 	return err;
@@ -121,7 +122,7 @@ int pci_assign_resource(struct pci_dev *
 {
 	struct pci_bus *bus = dev->bus;
 	struct resource *res = dev->resource + resno;
-	unsigned long size, min, align;
+	u64 size, min, align;
 	int ret;
 
 	size = res->end - res->start + 1;
@@ -148,9 +149,9 @@ int pci_assign_resource(struct pci_dev *
 	}
 
 	if (ret) {
-		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
+		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%llx@%llx for %s\n",
 		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
-		       resno, size, res->start, pci_name(dev));
+		       resno, (unsigned long long)size, (unsigned long long)res->start, pci_name(dev));
 	} else if (resno < PCI_BRIDGE_RESOURCES) {
 		pci_update_resource(dev, res, resno);
 	}
@@ -167,7 +168,7 @@ pdev_sort_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		unsigned long r_align;
+		u64 r_align;
 
 		r = &dev->resource[i];
 		r_align = r->end - r->start;
@@ -176,8 +177,9 @@ pdev_sort_resources(struct pci_dev *dev,
 			continue;
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, pci_name(dev));
+					    "[%llx:%llx] of %s\n",
+					    i, (unsigned long long)r->start,
+						(unsigned long long)r->end, pci_name(dev));
 			continue;
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
diff -puN drivers/pcmcia/i82365.c~resource-64bit drivers/pcmcia/i82365.c
--- linux-2.6.12-rc1/drivers/pcmcia/i82365.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pcmcia/i82365.c	2005-03-23 17:47:50.000000000 +0530
@@ -1165,9 +1165,10 @@ static int i365_set_mem_map(u_short sock
     u_short base, i;
     u_char map;
     
-    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#lx-%#lx, "
+    debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, %#llx-%#llx, "
 	  "%#x)\n", sock, mem->map, mem->flags, mem->speed,
-	  mem->res->start, mem->res->end, mem->card_start);
+	  (unsigned long long)mem->res->start,
+		(unsigned long long)mem->res->end, mem->card_start);
 
     map = mem->map;
     if ((map > 4) || (mem->card_start > 0x3ffffff) ||
diff -puN drivers/pcmcia/pd6729.c~resource-64bit drivers/pcmcia/pd6729.c
--- linux-2.6.12-rc1/drivers/pcmcia/pd6729.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pcmcia/pd6729.c	2005-03-23 17:47:50.000000000 +0530
@@ -715,7 +715,8 @@ static int __devinit pd6729_pci_probe(st
 		goto err_out_free_mem;
 
 	printk(KERN_INFO "pd6729: Cirrus PD6729 PCI to PCMCIA Bridge "
-		"at 0x%lx on irq %d\n",	pci_resource_start(dev, 0), dev->irq);
+		"at 0x%llx on irq %d\n",
+		(unsigned long long)pci_resource_start(dev, 0), dev->irq);
  	/*
 	 * Since we have no memory BARs some firmware may not
 	 * have had PCI_COMMAND_MEMORY enabled, yet the device needs it.
diff -puN drivers/pcmcia/tcic.c~resource-64bit drivers/pcmcia/tcic.c
--- linux-2.6.12-rc1/drivers/pcmcia/tcic.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pcmcia/tcic.c	2005-03-23 17:47:50.000000000 +0530
@@ -833,8 +833,9 @@ static int tcic_set_mem_map(struct pcmci
     u_long base, len, mmap;
 
     debug(1, "SetMemMap(%d, %d, %#2.2x, %d ns, "
-	  "%#lx-%#lx, %#x)\n", psock, mem->map, mem->flags,
-	  mem->speed, mem->res->start, mem->res->end, mem->card_start);
+	  "%#llx-%#llx, %#x)\n", psock, mem->map, mem->flags,
+	  mem->speed, (unsigned long long)mem->res->start,
+		(unsigned long long)mem->res->end, mem->card_start);
     if ((mem->map > 3) || (mem->card_start > 0x3ffffff) ||
 	(mem->res->start > 0xffffff) || (mem->res->end > 0xffffff) ||
 	(mem->res->start > mem->res->end) || (mem->speed > 1000))
diff -puN drivers/pnp/manager.c~resource-64bit drivers/pnp/manager.c
--- linux-2.6.12-rc1/drivers/pnp/manager.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pnp/manager.c	2005-03-23 17:47:50.000000000 +0530
@@ -25,7 +25,8 @@ DECLARE_MUTEX(pnp_res_mutex);
 
 static int pnp_assign_port(struct pnp_dev *dev, struct pnp_port *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -68,7 +69,8 @@ static int pnp_assign_port(struct pnp_de
 
 static int pnp_assign_mem(struct pnp_dev *dev, struct pnp_mem *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 
 	if (!dev || !rule)
 		return -EINVAL;
@@ -121,7 +123,8 @@ static int pnp_assign_mem(struct pnp_dev
 
 static int pnp_assign_irq(struct pnp_dev * dev, struct pnp_irq *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* IRQ priority: this table is good for i386 */
@@ -173,7 +176,8 @@ static int pnp_assign_irq(struct pnp_dev
 
 static int pnp_assign_dma(struct pnp_dev *dev, struct pnp_dma *rule, int idx)
 {
-	unsigned long *start, *end, *flags;
+	u64 *start, *end;
+	unsigned long *flags;
 	int i;
 
 	/* DMA priority: this table is good for i386 */
diff -puN drivers/pnp/resource.c~resource-64bit drivers/pnp/resource.c
--- linux-2.6.12-rc1/drivers/pnp/resource.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/pnp/resource.c	2005-03-23 17:47:50.000000000 +0530
@@ -242,7 +242,7 @@ int pnp_check_port(struct pnp_dev * dev,
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *port, *end, *tport, *tend;
+	u64 *port, *end, *tport, *tend;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -298,7 +298,7 @@ int pnp_check_mem(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long *addr, *end, *taddr, *tend;
+	u64 *addr, *end, *taddr, *tend;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -359,7 +359,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 {
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * irq = &dev->res.irq_resource[idx].start;
+	u64 * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.irq_resource[idx].flags))
@@ -424,7 +424,7 @@ int pnp_check_dma(struct pnp_dev * dev, 
 #ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
-	unsigned long * dma = &dev->res.dma_resource[idx].start;
+	u64 * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
 	if (cannot_compare(dev->res.dma_resource[idx].flags))
diff -puN drivers/scsi/sata_via.c~resource-64bit drivers/scsi/sata_via.c
--- linux-2.6.12-rc1/drivers/scsi/sata_via.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/scsi/sata_via.c	2005-03-23 17:47:50.000000000 +0530
@@ -327,10 +327,10 @@ static int svia_init_one (struct pci_dev
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||
 		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
-			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
+			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%llx, val 0x%llx)\n",
 			       pci_name(pdev), i,
-			       pci_resource_start(pdev, i),
-			       pci_resource_len(pdev, i));
+			       (unsigned long long)pci_resource_start(pdev, i),
+			       (unsigned long long)pci_resource_len(pdev, i));
 			rc = -ENODEV;
 			goto err_out_regions;
 		}
diff -puN drivers/serial/8250_pci.c~resource-64bit drivers/serial/8250_pci.c
--- linux-2.6.12-rc1/drivers/serial/8250_pci.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/drivers/serial/8250_pci.c	2005-03-23 17:47:50.000000000 +0530
@@ -589,8 +589,8 @@ pci_default_setup(struct pci_dev *dev, s
 	else
 		offset += idx * board->uart_offset;
 
-	maxnr = (pci_resource_len(dev, bar) - board->first_offset) /
-		(8 << board->reg_shift);
+	maxnr = (pci_resource_len(dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
diff -puN include/linux/ioport.h~resource-64bit include/linux/ioport.h
--- linux-2.6.12-rc1/include/linux/ioport.h~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/include/linux/ioport.h	2005-03-23 17:47:50.000000000 +0530
@@ -9,13 +9,14 @@
 #define _LINUX_IOPORT_H
 
 #include <linux/compiler.h>
+#include <linux/types.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
  */
 struct resource {
 	const char *name;
-	unsigned long start, end;
+	u64 start, end;
 	unsigned long flags;
 	struct resource *parent, *sibling, *child;
 };
@@ -96,31 +97,31 @@ extern struct resource * ____request_res
 extern int release_resource(struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     unsigned long size,
-			     unsigned long min, unsigned long max,
-			     unsigned long align,
+			     u64 size,
+			     u64 min, u64 max,
+			     u64 align,
 			     void (*alignf)(void *, struct resource *,
 					    unsigned long, unsigned long),
 			     void *alignf_data);
-int adjust_resource(struct resource *res, unsigned long start,
-		    unsigned long size);
+int adjust_resource(struct resource *res, u64 start,
+		    u64 size);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
 
-extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+extern struct resource * __request_region(struct resource *, u64 start, u64 n, const char *name);
 
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
-extern void __release_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, u64, u64);
+extern void __release_region(struct resource *, u64, u64);
 
-static inline int __deprecated check_region(unsigned long s, unsigned long n)
+static inline int __deprecated check_region(u64 s, u64 n)
 {
 	return __check_region(&ioport_resource, s, n);
 }
diff -puN kernel/resource.c~resource-64bit kernel/resource.c
--- linux-2.6.12-rc1/kernel/resource.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/kernel/resource.c	2005-03-23 17:47:50.000000000 +0530
@@ -23,7 +23,7 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0x0000,
+	.start	= 0x0000ULL,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -32,8 +32,8 @@ EXPORT_SYMBOL(ioport_resource);
 
 struct resource iomem_resource = {
 	.name	= "PCI mem",
-	.start	= 0UL,
-	.end	= ~0UL,
+	.start	= 0ULL,
+	.end	= ~0ULL,
 	.flags	= IORESOURCE_MEM,
 };
 
@@ -83,10 +83,10 @@ static int r_show(struct seq_file *m, vo
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
-	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
-			width, r->start,
-			width, r->end,
+			width, (unsigned long long)r->start,
+			width, (unsigned long long)r->end,
 			r->name ? r->name : "<BAD>");
 	return 0;
 }
@@ -151,8 +151,8 @@ __initcall(ioresources_init);
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	u64 start = new->start;
+	u64 end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -181,8 +181,6 @@ static int __release_resource(struct res
 {
 	struct resource *tmp, **p;
 
-	WARN_ON(old->child);
-
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;
@@ -238,9 +236,9 @@ EXPORT_SYMBOL(release_resource);
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 unsigned long size,
-			 unsigned long min, unsigned long max,
-			 unsigned long align,
+			 u64 size,
+			 u64 min, u64 max,
+			 u64 align,
 			 void (*alignf)(void *, struct resource *,
 					unsigned long, unsigned long),
 			 void *alignf_data)
@@ -284,9 +282,9 @@ static int find_resource(struct resource
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      unsigned long size,
-		      unsigned long min, unsigned long max,
-		      unsigned long align,
+		      u64 size,
+		      u64 min, u64 max,
+		      u64 align,
 		      void (*alignf)(void *, struct resource *,
 				     unsigned long, unsigned long),
 		      void *alignf_data)
@@ -380,10 +378,10 @@ EXPORT_SYMBOL(insert_resource);
  * arguments.  Returns -EBUSY if it can't fit.  Existing children of
  * the resource are assumed to be immutable.
  */
-int adjust_resource(struct resource *res, unsigned long start, unsigned long size)
+int adjust_resource(struct resource *res, u64 start, u64 size)
 {
 	struct resource *tmp, *parent = res->parent;
-	unsigned long end = start + size - 1;
+	u64 end = start + size - 1;
 	int result = -EBUSY;
 
 	write_lock(&resource_lock);
@@ -430,7 +428,7 @@ EXPORT_SYMBOL(adjust_resource);
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+struct resource * __request_region(struct resource *parent, u64 start, u64 n, const char *name)
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
@@ -467,7 +465,7 @@ struct resource * __request_region(struc
 
 EXPORT_SYMBOL(__request_region);
 
-int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __deprecated __check_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource * res;
 
@@ -482,10 +480,10 @@ int __deprecated __check_region(struct r
 
 EXPORT_SYMBOL(__check_region);
 
-void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+void __release_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource **p;
-	unsigned long end;
+	u64 end;
 
 	p = &parent->child;
 	end = start + n - 1;
@@ -515,7 +513,8 @@ void __release_region(struct resource *p
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource <%08llx-%08llx>\n",
+	(unsigned long long)start, (unsigned long long)end);
 }
 
 EXPORT_SYMBOL(__release_region);
diff -puN sound/drivers/mpu401/mpu401.c~resource-64bit sound/drivers/mpu401/mpu401.c
--- linux-2.6.12-rc1/sound/drivers/mpu401/mpu401.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/drivers/mpu401/mpu401.c	2005-03-23 17:47:50.000000000 +0530
@@ -126,8 +126,8 @@ static int __init snd_mpu401_pnp(int dev
 		return -ENODEV;
 	}
 	if (pnp_port_len(device, 0) < IO_EXTENT) {
-		snd_printk(KERN_ERR "PnP port length is %ld, expected %d\n",
-			   pnp_port_len(device, 0), IO_EXTENT);
+		snd_printk(KERN_ERR "PnP port length is %lld, expected %d\n",
+			   (unsigned long long)pnp_port_len(device, 0), IO_EXTENT);
 		return -ENODEV;
 	}
 	port[dev] = pnp_port_start(device, 0);
diff -puN sound/isa/es18xx.c~resource-64bit sound/isa/es18xx.c
--- linux-2.6.12-rc1/sound/isa/es18xx.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/isa/es18xx.c	2005-03-23 17:47:50.000000000 +0530
@@ -1938,7 +1938,7 @@ static int __devinit snd_audiodrive_pnp(
 		snd_printk(KERN_ERR PFX "PnP control configure failure (out of resources?)\n");
 		return -EAGAIN;
 	}
-	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
+	snd_printdd("pnp: port=0x%llx\n", (unsigned long long)pnp_port_start(acard->devc, 0));
 	/* PnP initialization */
 	pdev = acard->dev;
 	pnp_init_resource_table(cfg);
diff -puN sound/isa/gus/interwave.c~resource-64bit sound/isa/gus/interwave.c
--- linux-2.6.12-rc1/sound/isa/gus/interwave.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/isa/gus/interwave.c	2005-03-23 17:47:50.000000000 +0530
@@ -616,10 +616,10 @@ static int __devinit snd_interwave_pnp(i
 	if (dma2[dev] >= 0)
 		dma2[dev] = pnp_dma(pdev, 1);
 	irq[dev] = pnp_irq(pdev, 0);
-	snd_printdd("isapnp IW: sb port=0x%lx, gf1 port=0x%lx, codec port=0x%lx\n",
-				pnp_port_start(pdev, 0),
-				pnp_port_start(pdev, 1),
-				pnp_port_start(pdev, 2));
+	snd_printdd("isapnp IW: sb port=0x%llx, gf1 port=0x%llx, codec port=0x%llx\n",
+				(unsigned long long)pnp_port_start(pdev, 0),
+				(unsigned long long)pnp_port_start(pdev, 1),
+				(unsigned long long)pnp_port_start(pdev, 2));
 	snd_printdd("isapnp IW: dma1=%i, dma2=%i, irq=%i\n", dma1[dev], dma2[dev], irq[dev]);
 #ifdef SNDRV_STB
 	/* Tone Control initialization */
diff -puN sound/isa/sb/sb16.c~resource-64bit sound/isa/sb/sb16.c
--- linux-2.6.12-rc1/sound/isa/sb/sb16.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/isa/sb/sb16.c	2005-03-23 17:47:50.000000000 +0530
@@ -322,7 +322,7 @@ static int __devinit snd_card_sb16_pnp(i
 			goto __wt_error; 
 		} 
 		awe_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pnp_port_start(pdev, 0));
+		snd_printdd("pnp SB16: wavetable port=0x%llx\n", (unsigned long long)pnp_port_start(pdev, 0));
 	} else {
 __wt_error:
 		if (pdev) {
diff -puN sound/oss/forte.c~resource-64bit sound/oss/forte.c
--- linux-2.6.12-rc1/sound/oss/forte.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/oss/forte.c	2005-03-23 17:47:50.000000000 +0530
@@ -2034,8 +2034,9 @@ forte_probe (struct pci_dev *pci_dev, co
 	
 	pci_set_drvdata (pci_dev, chip);
 
-	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%04lX IRQ %u\n", 
-		chip->iobase, pci_resource_end (pci_dev, 0), chip->irq);
+	printk (KERN_INFO PFX "FM801 chip found at 0x%04lX-0x%04llX IRQ %u\n",
+		chip->iobase, (unsigned long long)pci_resource_end (pci_dev, 0),
+		chip->irq);
 
 	/* Power it up */
 	if ((ret = forte_chip_init (chip)) == 0)
diff -puN sound/pci/bt87x.c~resource-64bit sound/pci/bt87x.c
--- linux-2.6.12-rc1/sound/pci/bt87x.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/pci/bt87x.c	2005-03-23 17:47:50.000000000 +0530
@@ -876,8 +876,9 @@ static int __devinit snd_bt87x_probe(str
 
 	strcpy(card->driver, "Bt87x");
 	sprintf(card->shortname, "Brooktree Bt%x", pci->device);
-	sprintf(card->longname, "%s at %#lx, irq %i",
-		card->shortname, pci_resource_start(pci, 0), chip->irq);
+	sprintf(card->longname, "%s at %#llx, irq %i",
+		card->shortname, (unsigned long long)pci_resource_start(pci, 0),
+		chip->irq);
 	strcpy(card->mixername, "Bt87x");
 
 	err = snd_card_register(card);
diff -puN sound/pci/sonicvibes.c~resource-64bit sound/pci/sonicvibes.c
--- linux-2.6.12-rc1/sound/pci/sonicvibes.c~resource-64bit	2005-03-23 17:47:50.000000000 +0530
+++ linux-2.6.12-rc1-hari/sound/pci/sonicvibes.c	2005-03-23 17:47:50.000000000 +0530
@@ -1462,10 +1462,10 @@ static int __devinit snd_sonic_probe(str
 
 	strcpy(card->driver, "SonicVibes");
 	strcpy(card->shortname, "S3 SonicVibes");
-	sprintf(card->longname, "%s rev %i at 0x%lx, irq %i",
+	sprintf(card->longname, "%s rev %i at 0x%llx, irq %i",
 		card->shortname,
 		sonic->revision,
-		pci_resource_start(pci, 1),
+		(unsigned long long)pci_resource_start(pci, 1),
 		sonic->irq);
 
 	if ((err = snd_sonicvibes_pcm(sonic, 0, NULL)) < 0) {
_

--------------020107050403020408060501--
