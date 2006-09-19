Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWIST4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWIST4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWIST4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:56:20 -0400
Received: from av2.karneval.cz ([81.27.192.122]:4407 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1752034AbWIST4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:56:19 -0400
Message-id: <91sdasadhisax32191221@karneval.cz>
Subject: [PATCH] hisax niccy cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <keil@isdn4linux.de>
Cc: <isdn4linux@listserv.isdn4linux.de>
Date: Tue, 19 Sep 2006 21:56:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hisax niccy cleanup

Whitespace cleanup, delete unnecesasry parenthesis and braces.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 66826fff9124d65138dd84a47c2b34ba29270702
tree 56bd2ccc93c88f1b127e624195417b319c437afa
parent ca8b00296c6ff25faf9db7fe4b11d1460b64c7d7
author Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 10:33:54 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 19 Sep 2006 10:33:54 +0200

 drivers/isdn/hisax/niccy.c |  223 ++++++++++++++++++++++----------------------
 1 files changed, 109 insertions(+), 114 deletions(-)

diff --git a/drivers/isdn/hisax/niccy.c b/drivers/isdn/hisax/niccy.c
index 489022b..0a361e2 100644
--- a/drivers/isdn/hisax/niccy.c
+++ b/drivers/isdn/hisax/niccy.c
@@ -13,7 +13,6 @@
  *
  */
 
-
 #include <linux/init.h>
 #include "hisax.h"
 #include "isac.h"
@@ -45,33 +44,31 @@ #define PCI_IRQ_ENABLE		0x1f00
 #define PCI_IRQ_DISABLE		0xff0000
 #define PCI_IRQ_ASSERT		0x800000
 
-static inline u_char
-readreg(unsigned int ale, unsigned int adr, u_char off)
+static inline u_char readreg(unsigned int ale, unsigned int adr, u_char off)
 {
 	register u_char ret;
 
 	byteout(ale, off);
 	ret = bytein(adr);
-	return (ret);
+	return ret;
 }
 
-static inline void
-readfifo(unsigned int ale, unsigned int adr, u_char off, u_char * data, int size)
+static inline void readfifo(unsigned int ale, unsigned int adr, u_char off,
+		u_char *data, int size)
 {
 	byteout(ale, off);
 	insb(adr, data, size);
 }
 
-
-static inline void
-writereg(unsigned int ale, unsigned int adr, u_char off, u_char data)
+static inline void writereg(unsigned int ale, unsigned int adr, u_char off,
+		u_char data)
 {
 	byteout(ale, off);
 	byteout(adr, data);
 }
 
-static inline void
-writefifo(unsigned int ale, unsigned int adr, u_char off, u_char * data, int size)
+static inline void writefifo(unsigned int ale, unsigned int adr, u_char off,
+		u_char *data, int size)
 {
 	byteout(ale, off);
 	outsb(adr, data, size);
@@ -79,39 +76,34 @@ writefifo(unsigned int ale, unsigned int
 
 /* Interface functions */
 
-static u_char
-ReadISAC(struct IsdnCardState *cs, u_char offset)
+static u_char ReadISAC(struct IsdnCardState *cs, u_char offset)
 {
-	return (readreg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, offset));
+	return readreg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, offset);
 }
 
-static void
-WriteISAC(struct IsdnCardState *cs, u_char offset, u_char value)
+static void WriteISAC(struct IsdnCardState *cs, u_char offset, u_char value)
 {
 	writereg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, offset, value);
 }
 
-static void
-ReadISACfifo(struct IsdnCardState *cs, u_char * data, int size)
+static void ReadISACfifo(struct IsdnCardState *cs, u_char * data, int size)
 {
 	readfifo(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, 0, data, size);
 }
 
-static void
-WriteISACfifo(struct IsdnCardState *cs, u_char * data, int size)
+static void WriteISACfifo(struct IsdnCardState *cs, u_char * data, int size)
 {
 	writefifo(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, 0, data, size);
 }
 
-static u_char
-ReadHSCX(struct IsdnCardState *cs, int hscx, u_char offset)
+static u_char ReadHSCX(struct IsdnCardState *cs, int hscx, u_char offset)
 {
-	return (readreg(cs->hw.niccy.hscx_ale,
-			cs->hw.niccy.hscx, offset + (hscx ? 0x40 : 0)));
+	return readreg(cs->hw.niccy.hscx_ale,
+			cs->hw.niccy.hscx, offset + (hscx ? 0x40 : 0));
 }
 
-static void
-WriteHSCX(struct IsdnCardState *cs, int hscx, u_char offset, u_char value)
+static void WriteHSCX(struct IsdnCardState *cs, int hscx, u_char offset,
+		u_char value)
 {
 	writereg(cs->hw.niccy.hscx_ale,
 		 cs->hw.niccy.hscx, offset + (hscx ? 0x40 : 0), value);
@@ -130,8 +122,8 @@ #define WRITEHSCXFIFO(cs, nr, ptr, cnt) 
 
 #include "hscx_irq.c"
 
-static irqreturn_t
-niccy_interrupt(int intno, void *dev_id, struct pt_regs *regs)
+static irqreturn_t niccy_interrupt(int intno, void *dev_id,
+		struct pt_regs *regs)
 {
 	struct IsdnCardState *cs = dev_id;
 	u_char val;
@@ -141,21 +133,23 @@ niccy_interrupt(int intno, void *dev_id,
 	if (cs->subtyp == NICCY_PCI) {
 		int ival;
 		ival = inl(cs->hw.niccy.cfg_reg + PCI_IRQ_CTRL_REG);
-		if (!(ival & PCI_IRQ_ASSERT)) { /* IRQ not for us (shared) */
+		if (!(ival & PCI_IRQ_ASSERT)) {	/* IRQ not for us (shared) */
 			spin_unlock_irqrestore(&cs->lock, flags);
 			return IRQ_NONE;
 		}
 		outl(ival, cs->hw.niccy.cfg_reg + PCI_IRQ_CTRL_REG);
 	}
-	val = readreg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_ISTA + 0x40);
-      Start_HSCX:
+	val = readreg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx,
+			HSCX_ISTA + 0x40);
+Start_HSCX:
 	if (val)
 		hscx_int_main(cs, val);
 	val = readreg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, ISAC_ISTA);
-      Start_ISAC:
+Start_ISAC:
 	if (val)
 		isac_interrupt(cs, val);
-	val = readreg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_ISTA + 0x40);
+	val = readreg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx,
+			HSCX_ISTA + 0x40);
 	if (val) {
 		if (cs->debug & L1_DEB_HSCX)
 			debugl1(cs, "HSCX IntStat after IntRoutine");
@@ -168,21 +162,21 @@ niccy_interrupt(int intno, void *dev_id,
 		goto Start_ISAC;
 	}
 	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK, 0xFF);
-	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK + 0x40, 0xFF);
+	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK + 0x40,
+		 0xFF);
 	writereg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, ISAC_MASK, 0xFF);
 	writereg(cs->hw.niccy.isac_ale, cs->hw.niccy.isac, ISAC_MASK, 0);
 	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK, 0);
-	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK + 0x40, 0);
+	writereg(cs->hw.niccy.hscx_ale, cs->hw.niccy.hscx, HSCX_MASK + 0x40,0);
 	spin_unlock_irqrestore(&cs->lock, flags);
 	return IRQ_HANDLED;
 }
 
-static void
-release_io_niccy(struct IsdnCardState *cs)
+static void release_io_niccy(struct IsdnCardState *cs)
 {
 	if (cs->subtyp == NICCY_PCI) {
 		int val;
-		
+
 		val = inl(cs->hw.niccy.cfg_reg + PCI_IRQ_CTRL_REG);
 		val &= PCI_IRQ_DISABLE;
 		outl(val, cs->hw.niccy.cfg_reg + PCI_IRQ_CTRL_REG);
@@ -194,8 +188,7 @@ release_io_niccy(struct IsdnCardState *c
 	}
 }
 
-static void
-niccy_reset(struct IsdnCardState *cs)
+static void niccy_reset(struct IsdnCardState *cs)
 {
 	if (cs->subtyp == NICCY_PCI) {
 		int val;
@@ -207,29 +200,28 @@ niccy_reset(struct IsdnCardState *cs)
 	inithscxisac(cs, 3);
 }
 
-static int
-niccy_card_msg(struct IsdnCardState *cs, int mt, void *arg)
+static int niccy_card_msg(struct IsdnCardState *cs, int mt, void *arg)
 {
 	u_long flags;
 
 	switch (mt) {
-		case CARD_RESET:
-			spin_lock_irqsave(&cs->lock, flags);
-			niccy_reset(cs);
-			spin_unlock_irqrestore(&cs->lock, flags);
-			return(0);
-		case CARD_RELEASE:
-			release_io_niccy(cs);
-			return(0);
-		case CARD_INIT:
-			spin_lock_irqsave(&cs->lock, flags);
-			niccy_reset(cs);
-			spin_unlock_irqrestore(&cs->lock, flags);
-			return(0);
-		case CARD_TEST:
-			return(0);
+	case CARD_RESET:
+		spin_lock_irqsave(&cs->lock, flags);
+		niccy_reset(cs);
+		spin_unlock_irqrestore(&cs->lock, flags);
+		return 0;
+	case CARD_RELEASE:
+		release_io_niccy(cs);
+		return 0;
+	case CARD_INIT:
+		spin_lock_irqsave(&cs->lock, flags);
+		niccy_reset(cs);
+		spin_unlock_irqrestore(&cs->lock, flags);
+		return 0;
+	case CARD_TEST:
+		return 0;
 	}
-	return(0);
+	return 0;
 }
 
 static struct pci_dev *niccy_dev __devinitdata = NULL;
@@ -237,8 +229,7 @@ #ifdef __ISAPNP__
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
-int __devinit
-setup_niccy(struct IsdnCard *card)
+int __devinit setup_niccy(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
 	char tmp[64];
@@ -246,40 +237,44 @@ setup_niccy(struct IsdnCard *card)
 	strcpy(tmp, niccy_revision);
 	printk(KERN_INFO "HiSax: Niccy driver Rev. %s\n", HiSax_getrev(tmp));
 	if (cs->typ != ISDN_CTYPE_NICCY)
-		return (0);
+		return 0;
 #ifdef __ISAPNP__
 	if (!card->para[1] && isapnp_present()) {
 		struct pnp_dev *pnp_d = NULL;
 		int err;
 
-		if ((pnp_c = pnp_find_card(
-			ISAPNP_VENDOR('S', 'D', 'A'),
-			ISAPNP_FUNCTION(0x0150), pnp_c))) {
-			if (!(pnp_d = pnp_find_dev(pnp_c,
-				ISAPNP_VENDOR('S', 'D', 'A'),
-				ISAPNP_FUNCTION(0x0150), pnp_d))) {
-				printk(KERN_ERR "NiccyPnP: PnP error card found, no device\n");
-				return (0);
+		pnp_c = pnp_find_card(ISAPNP_VENDOR('S', 'D', 'A'),
+				ISAPNP_FUNCTION(0x0150), pnp_c);
+		if (pnp_c) {
+			pnp_d = pnp_find_dev(pnp_c,
+					ISAPNP_VENDOR('S', 'D', 'A')
+					ISAPNP_FUNCTION(0x0150), pnp_d);
+			if (!pnp_d) {
+				printk(KERN_ERR "NiccyPnP: PnP error card "
+					"found, no device\n");
+				return 0;
 			}
 			pnp_disable_dev(pnp_d);
 			err = pnp_activate_dev(pnp_d);
-			if (err<0) {
-				printk(KERN_WARNING "%s: pnp_activate_dev ret(%d)\n",
-					__FUNCTION__, err);
-				return(0);
+			if (err < 0) {
+				printk(KERN_WARNING "%s: pnp_activate_dev "
+					"ret(%d)\n", __FUNCTION__, err);
+				return 0;
 			}
 			card->para[1] = pnp_port_start(pnp_d, 0);
 			card->para[2] = pnp_port_start(pnp_d, 1);
 			card->para[0] = pnp_irq(pnp_d, 0);
-			if (!card->para[0] || !card->para[1] || !card->para[2]) {
-				printk(KERN_ERR "NiccyPnP:some resources are missing %ld/%lx/%lx\n",
-					card->para[0], card->para[1], card->para[2]);
+			if (!card->para[0] || !card->para[1] ||
+					!card->para[2]) {
+				printk(KERN_ERR "NiccyPnP:some resources are "
+					"missing %ld/%lx/%lx\n",
+					card->para[0], card->para[1],
+					card->para[2]);
 				pnp_disable_dev(pnp_d);
-				return(0);
+				return 0;
 			}
-		} else {
+		} else
 			printk(KERN_INFO "NiccyPnP: no ISAPnP card found\n");
-		}
 	}
 #endif
 	if (card->para[1]) {
@@ -291,50 +286,51 @@ #endif
 		cs->subtyp = NICCY_PNP;
 		cs->irq = card->para[0];
 		if (!request_region(cs->hw.niccy.isac, 2, "niccy data")) {
-			printk(KERN_WARNING
-				"HiSax: %s data port %x-%x already in use\n",
-				CardType[card->typ],
-				cs->hw.niccy.isac,
-				cs->hw.niccy.isac + 1);
-			return (0);
+			printk(KERN_WARNING "HiSax: %s data port %x-%x "
+				"already in use\n", CardType[card->typ],
+				cs->hw.niccy.isac, cs->hw.niccy.isac + 1);
+			return 0;
 		}
 		if (!request_region(cs->hw.niccy.isac_ale, 2, "niccy addr")) {
-			printk(KERN_WARNING
-				"HiSax: %s address port %x-%x already in use\n",
-				CardType[card->typ],
+			printk(KERN_WARNING "HiSax: %s address port %x-%x "
+				"already in use\n", CardType[card->typ],
 				cs->hw.niccy.isac_ale,
 				cs->hw.niccy.isac_ale + 1);
 			release_region(cs->hw.niccy.isac, 2);
-			return (0);
+			return 0;
 		}
 	} else {
 #ifdef CONFIG_PCI
 		u_int pci_ioaddr;
 		cs->subtyp = 0;
 		if ((niccy_dev = pci_find_device(PCI_VENDOR_ID_SATSAGEM,
-			PCI_DEVICE_ID_SATSAGEM_NICCY, niccy_dev))) {
+						 PCI_DEVICE_ID_SATSAGEM_NICCY,
+						 niccy_dev))) {
 			if (pci_enable_device(niccy_dev))
-				return(0);
+				return 0;
 			/* get IRQ */
 			if (!niccy_dev->irq) {
-				printk(KERN_WARNING "Niccy: No IRQ for PCI card found\n");
-				return(0);
+				printk(KERN_WARNING
+				       "Niccy: No IRQ for PCI card found\n");
+				return 0;
 			}
 			cs->irq = niccy_dev->irq;
 			cs->hw.niccy.cfg_reg = pci_resource_start(niccy_dev, 0);
 			if (!cs->hw.niccy.cfg_reg) {
-				printk(KERN_WARNING "Niccy: No IO-Adr for PCI cfg found\n");
-				return(0);
+				printk(KERN_WARNING
+				       "Niccy: No IO-Adr for PCI cfg found\n");
+				return 0;
 			}
 			pci_ioaddr = pci_resource_start(niccy_dev, 1);
 			if (!pci_ioaddr) {
-				printk(KERN_WARNING "Niccy: No IO-Adr for PCI card found\n");
-				return(0);
+				printk(KERN_WARNING
+				       "Niccy: No IO-Adr for PCI card found\n");
+				return 0;
 			}
 			cs->subtyp = NICCY_PCI;
 		} else {
 			printk(KERN_WARNING "Niccy: No PCI card found\n");
-			return(0);
+			return 0;
 		}
 		cs->irq_flags |= IRQF_SHARED;
 		cs->hw.niccy.isac = pci_ioaddr + ISAC_PCI_DATA;
@@ -343,29 +339,28 @@ #ifdef CONFIG_PCI
 		cs->hw.niccy.hscx_ale = pci_ioaddr + HSCX_PCI_ADDR;
 		if (!request_region(cs->hw.niccy.isac, 4, "niccy")) {
 			printk(KERN_WARNING
-				"HiSax: %s data port %x-%x already in use\n",
-				CardType[card->typ],
-				cs->hw.niccy.isac,
-				cs->hw.niccy.isac + 4);
-			return (0);
+			       "HiSax: %s data port %x-%x already in use\n",
+			       CardType[card->typ],
+			       cs->hw.niccy.isac, cs->hw.niccy.isac + 4);
+			return 0;
 		}
 		if (!request_region(cs->hw.niccy.cfg_reg, 0x40, "niccy pci")) {
 			printk(KERN_WARNING
 			       "HiSax: %s pci port %x-%x already in use\n",
-				CardType[card->typ],
-				cs->hw.niccy.cfg_reg,
-				cs->hw.niccy.cfg_reg + 0x40);
+			       CardType[card->typ],
+			       cs->hw.niccy.cfg_reg,
+			       cs->hw.niccy.cfg_reg + 0x40);
 			release_region(cs->hw.niccy.isac, 4);
-			return (0);
+			return 0;
 		}
 #else
 		printk(KERN_WARNING "Niccy: io0 0 and NO_PCI_BIOS\n");
 		printk(KERN_WARNING "Niccy: unable to config NICCY PCI\n");
-		return (0);
-#endif /* CONFIG_PCI */
+		return 0;
+#endif				/* CONFIG_PCI */
 	}
 	printk(KERN_INFO "HiSax: %s %s config irq:%d data:0x%X ale:0x%X\n",
-		CardType[cs->typ], (cs->subtyp==1) ? "PnP":"PCI",
+		CardType[cs->typ], (cs->subtyp == 1) ? "PnP" : "PCI",
 		cs->irq, cs->hw.niccy.isac, cs->hw.niccy.isac_ale);
 	setup_isac(cs);
 	cs->readisac = &ReadISAC;
@@ -379,10 +374,10 @@ #endif /* CONFIG_PCI */
 	cs->irq_func = &niccy_interrupt;
 	ISACVersion(cs, "Niccy:");
 	if (HscxVersion(cs, "Niccy:")) {
-		printk(KERN_WARNING
-		    "Niccy: wrong HSCX versions check IO address\n");
+		printk(KERN_WARNING "Niccy: wrong HSCX versions check IO "
+			"address\n");
 		release_io_niccy(cs);
-		return (0);
+		return 0;
 	}
-	return (1);
+	return 1;
 }
