Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVCWD5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVCWD5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCWD5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:57:44 -0500
Received: from ccerelrim03.cce.hp.com ([161.114.21.24]:25260 "EHLO
	ccerelrim03.cce.hp.com") by vger.kernel.org with ESMTP
	id S262755AbVCWD50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:57:26 -0500
Message-ID: <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
In-Reply-To: <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
    <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
Date: Tue, 22 Mar 2005 20:57:20 -0700 (MST)
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: "Li Shaohua" <shaohua.li@intel.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Grzegorz Kulewski" <kangur@polcom.net>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Andrew Morton" <akpm@osdl.org>,
       "ACPI List" <acpi-devel@lists.sourceforge.net>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Len Brown" <len.brown@intel.com>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050322205720_15552"
X-Priority: 3 (Normal)
Importance: Normal
X-PMX-Version: 5.0.0.131485, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.22.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050322205720_15552
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> On Wed, 2005-03-23 at 04:57, Bjorn Helgaas wrote:
>> Great.  Shaohua, where should we go from here?  Do you have more
>> concerns with the current patch, or should we ask Andrew to put it
>> in -mm?  If you do have concerns, would you like to propose an
>> alternate patch that fixes the problem for Grzegorz?
> No, the patch is great to me.

Good.  Thanks for all the help in refining this!
Andrew, can we put this in -mm?

BTW, I also have a report that this fixes a problem like
the following.  I've had several similar reports that initially
seemed to be related to "pci=routeirq", so I'm optimistic that
fixing this Via problem will help several folks.

Probing IDE interface ide2...
hde: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
irq 11: nobody cared!
 [<c013769a>] __report_bad_irq+0x2a/0x90
 [<c0136f99>] handle_IRQ_event+0x39/0x70
 [<c01377c3>] note_interrupt+0xa3/0xd0
 [<c0137130>] __do_IRQ+0x160/0x180
 [<c0105649>] do_IRQ+0x19/0x30
 [<c0103b4e>] common_interrupt+0x1a/0x20
 [<c011eb00>] __do_softirq+0x30/0x90
 [<c011eb86>] do_softirq+0x26/0x30
 [<c0136f55>] irq_exit+0x35/0x40
 [<c010564e>] do_IRQ+0x1e/0x30
 [<c0103b4e>] common_interrupt+0x1a/0x20
 [<c0137243>] enable_irq+0x43/0x110
 [<c023adc9>] ide_config_drive_speed+0x149/0x380
 [<c022ff38>] hpt370_tune_chipset+0x158/0x160
 [<c02303dc>] hpt366_config_drive_xfer_rate+0x3c/0xa0
 [<c023d310>] probe_hwif+0x420/0x490
 [<c023d39b>] probe_hwif_init_with_fixup+0x1b/0x70
 [<c0240a6b>] ide_setup_pci_device+0x5b/0xa0
 [<c0231dbe>] init_setup_hpt366+0x17e/0x1b0
 [<c0231e18>] hpt366_init_one+0x28/0x30
 [<c039ccad>] ide_scan_pcidev+0x4d/0x70
 [<c039ccf8>] ide_scan_pcibus+0x28/0xc0
 [<c039cbd0>] probe_for_hwifs+0x10/0x20
 [<c039cc3e>] ide_init+0x5e/0x80
 [<c03808b3>] do_initcalls+0x53/0xc0
 [<c0100410>] init+0x0/0x120
 [<c010043f>] init+0x2f/0x120
 [<c01012c0>] kernel_thread_helper+0x0/0x10
 [<c01012c5>] kernel_thread_helper+0x5/0x10
handlers:
[<c01df538>] (acpi_irq+0x0/0x16)
Disabling IRQ #11

------=_20050322205720_15552
Content-Type: text/plain;
      name="Re_ [ACPI] Re_ Fw_ Anybody_ 2[1].6.11 (stable and -rc) ACPI 
     breaks USB.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="Re_ [ACPI] Re_ Fw_ Anybody_ 2[1].6.11 (stable and -rc) 
     ACPI breaks USB.txt"

On Fri, 2005-03-18 at 11:07 -0700, Bjorn Helgaas wrote:
> OK.  Try this one for size.  It differs from what's currently in
> the tree in these ways:
> 
>     - It's a quirk, so we don't have to clutter acpi_pci_irq_enable()
>       and pirq_enable_irq() with Via-specific code.
> 
>     - It doesn't do anything unless we're in PIC mode.  The comment
>       suggests this issue only affects PIC routing.
> 
>     - We do this for ALL Via devices.  The current code in the tree
>       does it for all devices in the system IF there is a Via device
>       with devfn==0, which misses Grzegorz's case.
> 
> Does anybody have a pointer to a spec that talks about this?  It'd
> be awfully nice to have a reference.
> 
> Grzegorz, can you check to make sure this still works after all the
> tweaking?

Oops, I had the sense of the skip_ioapic_setup test reversed.  Corrected
patch follows.

===== arch/i386/pci/irq.c 1.55 vs edited =====
--- 1.55/arch/i386/pci/irq.c	2005-02-07 22:39:15 -07:00
+++ edited/arch/i386/pci/irq.c	2005-03-15 10:11:44 -07:00
@@ -1026,7 +1026,6 @@
 static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
-	extern int via_interrupt_line_quirk;
 	struct pci_dev *temp_dev;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
@@ -1081,10 +1080,6 @@
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
 		       'A' + pin, pci_name(dev), msg);
 	}
-	/* VIA bridges use interrupt line for apic/pci steering across
-	   the V-Link */
-	else if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 	return 0;
 }
 
===== drivers/acpi/pci_irq.c 1.37 vs edited =====
--- 1.37/drivers/acpi/pci_irq.c	2005-03-01 09:57:29 -07:00
+++ edited/drivers/acpi/pci_irq.c	2005-03-15 10:10:57 -07:00
@@ -388,7 +388,6 @@
 	u8			pin = 0;
 	int			edge_level = ACPI_LEVEL_SENSITIVE;
 	int			active_high_low = ACPI_ACTIVE_LOW;
-	extern int		via_interrupt_line_quirk;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_enable");
 
@@ -437,9 +436,6 @@
 			return_VALUE(0);
 		}
  	}
-
-	if (via_interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq & 15);
 
 	dev->irq = acpi_register_gsi(irq, edge_level, active_high_low);
 
===== drivers/pci/quirks.c 1.72 vs edited =====
--- 1.72/drivers/pci/quirks.c	2005-03-10 01:38:25 -07:00
+++ edited/drivers/pci/quirks.c	2005-03-21 09:22:23 -07:00
@@ -683,19 +683,40 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb );
 
-/*
- *	VIA northbridges care about PCI_INTERRUPT_LINE
- */
-int via_interrupt_line_quirk;
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#endif
 
-static void __devinit quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_irqpic(struct pci_dev *dev)
 {
-	if(pdev->devfn == 0) {
-		printk(KERN_INFO "PCI: Via IRQ fixup\n");
-		via_interrupt_line_quirk = 1;
+	u8 irq, new_irq;
+
+#ifdef CONFIG_X86_IO_APIC
+	if (!skip_ioapic_setup)
+		return;
+#endif
+#ifdef CONFIG_ACPI
+	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
+		return;
+#endif
+	/*
+	 * Some Via devices make an internal connection to the PIC when the
+	 * PCI_INTERRUPT_LINE register is written.  If we've changed the
+	 * device's IRQ, we need to update this routing.
+	 *
+	 * I suspect this only happens for devices on the same chip as the
+	 * PIC, but I don't know how to identify those without listing them
+	 * all individually, which is a maintenance problem.
+	 */
+	new_irq = dev->irq & 0xf;
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	if (new_irq != irq) {
+		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
+			pci_name(dev), irq, new_irq);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
 
 /*
  *	Serverworks CSB5 IDE does not fully support native mode

------=_20050322205720_15552--


