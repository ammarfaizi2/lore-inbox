Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130327AbQKCSEV>; Fri, 3 Nov 2000 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130525AbQKCSEA>; Fri, 3 Nov 2000 13:04:00 -0500
Received: from palrel1.hp.com ([156.153.255.242]:9 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130327AbQKCSD7>;
	Fri, 3 Nov 2000 13:03:59 -0500
Message-Id: <200011031808.KAA00205@milano.cup.hp.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: remove dead code resource_fixup()
Date: Fri, 03 Nov 2000 10:08:48 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ooops...

------- Forwarded Message

<linux-kernel@vger.rutgers.edu>: host vger.rutgers.edu[128.6.14.121] said: 550
    <linux-kernel@vger.rutgers.edu>... User unknown


Date: Fri, 3 Nov 2000 09:54:19 -0800 (PST)
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <200011031754.JAA00148@milano.cup.hp.com>
To: torvalds@transmeta.com
Subject: PATCH: remove dead code resource_fixup()
Cc: linux-kernel@vger.rutgers.edu

Hi Linus,
The following patch against linux-2.4.0-test10 removes resource_free() code.

"David S. Miller" <davem@redhat.com> wrote:
| Yeah, it's dead code, feel free to send Linus a patch which kills
| it off :-)

thanks,
grant

diff -uNpr linux/arch/ppc/kernel/pci.c linux.patch/arch/ppc/kernel/pci.c
- --- linux/arch/ppc/kernel/pci.c	Sun Sep 17 09:48:07 2000
+++ linux.patch/arch/ppc/kernel/pci.c	Fri Nov  3 09:37:25 2000
@@ -344,11 +344,6 @@ pcibios_fixup_pbus_ranges(struct pci_bus
 	ranges->mem_end -= bus->resource[1]->start;
 }
 
- -unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
- -			     unsigned long start, unsigned long size)
- -{
- -	return start;
- -}
 
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
diff -uNpr linux/arch/sparc/kernel/pcic.c linux.patch/arch/sparc/kernel/pcic.c
- --- linux/arch/sparc/kernel/pcic.c	Tue Oct  3 09:24:41 2000
+++ linux.patch/arch/sparc/kernel/pcic.c	Fri Nov  3 09:37:13 2000
@@ -866,23 +866,6 @@ void pcibios_update_resource(struct pci_
 {
 }
 
- -#if 0
- -void pcibios_update_irq(struct pci_dev *pdev, int irq)
- -{
- -}
- -
- -unsigned long resource_fixup(struct pci_dev *pdev, struct resource *res,
- -			     unsigned long start, unsigned long size)
- -{
- -	return start;
- -}
- -
- -void pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
- -			       struct pbus_set_ranges_data *pranges)
- -{
- -}
- -#endif
- -
 void pcibios_align_resource(void *data, struct resource *res, unsigned long size)
 {
 }
diff -uNpr linux/arch/sparc64/kernel/pci.c linux.patch/arch/sparc64/kernel/pci.c
- --- linux/arch/sparc64/kernel/pci.c	Tue Oct 10 10:33:51 2000
+++ linux.patch/arch/sparc64/kernel/pci.c	Fri Nov  3 09:37:42 2000
@@ -202,12 +202,6 @@ void pcibios_update_irq(struct pci_dev *
 {
 }
 
- -unsigned long resource_fixup(struct pci_dev *pdev, struct resource *res,
- -			     unsigned long start, unsigned long size)
- -{
- -	return start;
- -}
- -
 void pcibios_fixup_pbus_ranges(struct pci_bus *pbus,
 			       struct pbus_set_ranges_data *pranges)
 {

------- End of Forwarded Message
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
