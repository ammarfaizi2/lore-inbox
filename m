Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUITWbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUITWbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUITWbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:31:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:10407 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263117AbUITWbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:31:23 -0400
Date: Mon, 20 Sep 2004 17:31:21 -0500
To: linuxppc64-dev@ozlabs.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Message-ID: <20040920223121.GC1872@austin.ibm.com>
References: <20040920221933.GB1872@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20040920221933.GB1872@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Forgot to attach the actual patch.

On Mon, Sep 20, 2004 at 05:19:33PM -0500, Linas Vepstas was heard to remark:
> Hi,


This file mixes tabs with 8 spaces, leading to poor display 
if one's editor doesn't have tab-stops set to 8.   Please apply.

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pseries-pci-whitespace.patch"

===== pSeries_pci.c 1.44 vs edited =====
--- 1.44/arch/ppc64/kernel/pSeries_pci.c	Mon Sep 13 19:23:15 2004
+++ edited/pSeries_pci.c	Mon Sep 20 17:08:48 2004
@@ -170,7 +170,7 @@
 	u8 intpin;
 	struct device_node *node;
 
-    	pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &intpin);
+	pci_read_config_byte(pci_dev, PCI_INTERRUPT_PIN, &intpin);
 
 	if (intpin == 0) {
 		PPCDBG(PPCDBG_BUSWALK,"\tDevice: %s No Interrupt used by device.\n", pci_name(pci_dev));
@@ -206,8 +206,8 @@
 #define ISA_SPACE_IO 0x1
 
 static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
-		                      unsigned long phb_io_base_phys,
-				      void * phb_io_base_virt)
+                                      unsigned long phb_io_base_phys,
+                                      void * phb_io_base_virt)
 {
 	struct isa_range *range;
 	unsigned long pci_addr;
@@ -304,8 +304,8 @@
 						hose->io_base_phys,
 						hose->io_base_virt);
 					of_node_put(isa_dn);
-                                        /* Allow all IO */
-                                        io_page_mask = -1;
+					/* Allow all IO */
+					io_page_mask = -1;
 				}
 			}
 
@@ -466,7 +466,7 @@
 	}
 
 	of_prop = (struct property *)alloc_bootmem(sizeof(struct property) +
-			sizeof(phb->global_number));        
+			sizeof(phb->global_number));
 
 	if (!of_prop) {
 		kfree(phb);
@@ -571,30 +571,30 @@
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (dev->resource[i].flags & IORESOURCE_IO) {
 			unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
-                        unsigned long start, end, mask;
+			unsigned long start, end, mask;
 
-                        start = dev->resource[i].start += offset;
-                        end = dev->resource[i].end += offset;
+			start = dev->resource[i].start += offset;
+			end = dev->resource[i].end += offset;
 
-                        /* Need to allow IO access to pages that are in the
-                           ISA range */
-                        if (start < MAX_ISA_PORT) {
-                                if (end > MAX_ISA_PORT)
-                                        end = MAX_ISA_PORT;
-
-                                start >>= PAGE_SHIFT;
-                                end >>= PAGE_SHIFT;
-
-                                /* get the range of pages for the map */
-                                mask = ((1 << (end+1))-1) ^ ((1 << start)-1);
-                                io_page_mask |= mask;
-                        }
+			/* Need to allow IO access to pages that are in the
+			   ISA range */
+			if (start < MAX_ISA_PORT) {
+				if (end > MAX_ISA_PORT)
+					end = MAX_ISA_PORT;
+
+				start >>= PAGE_SHIFT;
+				end >>= PAGE_SHIFT;
+
+				/* get the range of pages for the map */
+				mask = ((1 << (end+1))-1) ^ ((1 << start)-1);
+				io_page_mask |= mask;
+			}
 		}
-                else if (dev->resource[i].flags & IORESOURCE_MEM) {
+		else if (dev->resource[i].flags & IORESOURCE_MEM) {
 			dev->resource[i].start += hose->pci_mem_offset;
 			dev->resource[i].end += hose->pci_mem_offset;
 		}
-        }
+	}
 }
 EXPORT_SYMBOL(pcibios_fixup_device_resources);
 
@@ -796,21 +796,21 @@
 int
 pcibios_scan_all_fns(struct pci_bus *bus, int devfn)
 {
-       struct device_node *busdn, *dn;
+	struct device_node *busdn, *dn;
+
+	if (bus->self)
+		busdn = pci_device_to_OF_node(bus->self);
+	else
+		busdn = bus->sysdata;   /* must be a phb */
 
-       if (bus->self)
-               busdn = pci_device_to_OF_node(bus->self);
-       else
-               busdn = bus->sysdata;   /* must be a phb */
-
-       /*
-        * Check to see if there is any of the 8 functions are in the
-        * device tree.  If they are then we need to scan all the
-        * functions of this slot.
-        */
-       for (dn = busdn->child; dn; dn = dn->sibling)
-               if ((dn->devfn >> 3) == (devfn >> 3))
-                       return 1;
+	/*
+	* Check to see if there is any of the 8 functions are in the
+	* device tree.  If they are then we need to scan all the
+	* functions of this slot.
+	*/
+	for (dn = busdn->child; dn; dn = dn->sibling)
+		if ((dn->devfn >> 3) == (devfn >> 3))
+			return 1;
 
-       return 0;
+	return 0;
 }

--CE+1k2dSO48ffgeK--
