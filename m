Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGELYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGELYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWGELYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:24:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:30120 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964803AbWGELYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:24:01 -0400
Date: Wed, 5 Jul 2006 13:23:57 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hisax fix usage of __init*
Message-ID: <20060705112357.GA7003@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.13-4-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the warnings about the section mismatches for __init*
in the HiSax driver.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/asuscom.c      |    6 +++---
 drivers/isdn/hisax/avm_a1.c       |    2 +-
 drivers/isdn/hisax/avm_pci.c      |    8 ++++----
 drivers/isdn/hisax/bkm_a4t.c      |    4 ++--
 drivers/isdn/hisax/bkm_a8.c       |   16 ++++++++--------
 drivers/isdn/hisax/config.c       |    2 +-
 drivers/isdn/hisax/diva.c         |   14 +++++++-------
 drivers/isdn/hisax/enternow_pci.c |    4 ++--
 drivers/isdn/hisax/gazel.c        |    8 ++++----
 drivers/isdn/hisax/hfc4s8s_l1.c   |    2 +-
 drivers/isdn/hisax/hfc_2bds0.c    |    4 ++--
 drivers/isdn/hisax/hfc_2bs0.c     |    4 ++--
 drivers/isdn/hisax/hfc_pci.c      |    6 +++---
 drivers/isdn/hisax/hfcscard.c     |    6 +++---
 drivers/isdn/hisax/icc.c          |    8 ++++----
 drivers/isdn/hisax/icc.h          |    2 +-
 drivers/isdn/hisax/ipacx.c        |   18 +++++++++---------
 drivers/isdn/hisax/isurf.c        |    4 ++--
 drivers/isdn/hisax/ix1_micro.c    |    6 +++---
 drivers/isdn/hisax/jade.c         |    6 +++---
 drivers/isdn/hisax/mic.c          |    2 +-
 drivers/isdn/hisax/netjet.c       |    2 +-
 drivers/isdn/hisax/niccy.c        |    4 ++--
 drivers/isdn/hisax/nj_s.c         |    4 ++--
 drivers/isdn/hisax/nj_u.c         |    4 ++--
 drivers/isdn/hisax/s0box.c        |    2 +-
 drivers/isdn/hisax/saphir.c       |    2 +-
 drivers/isdn/hisax/sportster.c    |    4 ++--
 drivers/isdn/hisax/teleint.c      |    2 +-
 drivers/isdn/hisax/teles0.c       |    2 +-
 drivers/isdn/hisax/telespci.c     |    4 ++--
 drivers/isdn/hisax/w6692.c        |   10 +++++-----
 32 files changed, 86 insertions(+), 86 deletions(-)

901378e981cfac067bfbbd951d2671763e729c3f
diff --git a/drivers/isdn/hisax/asuscom.c b/drivers/isdn/hisax/asuscom.c
index a98c5e3..93ff941 100644
--- a/drivers/isdn/hisax/asuscom.c
+++ b/drivers/isdn/hisax/asuscom.c
@@ -297,7 +297,7 @@ Asus_card_msg(struct IsdnCardState *cs, 
 }
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id asus_ids[] __initdata = {
+static struct isapnp_device_id asus_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('A', 'S', 'U'), ISAPNP_FUNCTION(0x1688),
 	  ISAPNP_VENDOR('A', 'S', 'U'), ISAPNP_FUNCTION(0x1688), 
 	  (unsigned long) "Asus1688 PnP" },
@@ -313,11 +313,11 @@ static struct isapnp_device_id asus_ids[
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &asus_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &asus_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
-int __init
+int __devinit
 setup_asuscom(struct IsdnCard *card)
 {
 	int bytecnt;
diff --git a/drivers/isdn/hisax/avm_a1.c b/drivers/isdn/hisax/avm_a1.c
index 9a8b025..729e906 100644
--- a/drivers/isdn/hisax/avm_a1.c
+++ b/drivers/isdn/hisax/avm_a1.c
@@ -178,7 +178,7 @@ AVM_card_msg(struct IsdnCardState *cs, i
 	return(0);
 }
 
-int __init
+int __devinit
 setup_avm_a1(struct IsdnCard *card)
 {
 	u_char val;
diff --git a/drivers/isdn/hisax/avm_pci.c b/drivers/isdn/hisax/avm_pci.c
index 04f5917..369afd3 100644
--- a/drivers/isdn/hisax/avm_pci.c
+++ b/drivers/isdn/hisax/avm_pci.c
@@ -639,7 +639,7 @@ clear_pending_hdlc_ints(struct IsdnCardS
 }
 #endif  /*  0  */
 
-static void __init
+static void
 inithdlc(struct IsdnCardState *cs)
 {
 	cs->bcs[0].BC_SetStack = setstack_hdlc;
@@ -727,13 +727,13 @@ AVM_card_msg(struct IsdnCardState *cs, i
 }
 
 #ifdef CONFIG_PCI
-static struct pci_dev *dev_avm __initdata = NULL;
+static struct pci_dev *dev_avm __devinitdata = NULL;
 #endif
 #ifdef __ISAPNP__
-static struct pnp_card *pnp_avm_c __initdata = NULL;
+static struct pnp_card *pnp_avm_c __devinitdata = NULL;
 #endif
 
-int __init
+int __devinit
 setup_avm_pcipnp(struct IsdnCard *card)
 {
 	u_int val, ver;
diff --git a/drivers/isdn/hisax/bkm_a4t.c b/drivers/isdn/hisax/bkm_a4t.c
index 3cf1f24..87a6301 100644
--- a/drivers/isdn/hisax/bkm_a4t.c
+++ b/drivers/isdn/hisax/bkm_a4t.c
@@ -255,9 +255,9 @@ BKM_card_msg(struct IsdnCardState *cs, i
 	return (0);
 }
 
-static struct pci_dev *dev_a4t __initdata = NULL;
+static struct pci_dev *dev_a4t __devinitdata = NULL;
 
-int __init
+int __devinit
 setup_bkm_a4t(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/bkm_a8.c b/drivers/isdn/hisax/bkm_a8.c
index 15681f3..dae090a 100644
--- a/drivers/isdn/hisax/bkm_a8.c
+++ b/drivers/isdn/hisax/bkm_a8.c
@@ -260,7 +260,7 @@ BKM_card_msg(struct IsdnCardState *cs, i
 	return (0);
 }
 
-static int __init
+static int __devinit
 sct_alloc_io(u_int adr, u_int len)
 {
 	if (!request_region(adr, len, "scitel")) {
@@ -272,16 +272,16 @@ sct_alloc_io(u_int adr, u_int len)
 	return(0);
 }
 
-static struct pci_dev *dev_a8 __initdata = NULL;
-static u16  sub_vendor_id __initdata = 0;
-static u16  sub_sys_id __initdata = 0;
-static u_char pci_bus __initdata = 0;
-static u_char pci_device_fn __initdata = 0;
-static u_char pci_irq __initdata = 0;
+static struct pci_dev *dev_a8 __devinitdata = NULL;
+static u16  sub_vendor_id __devinitdata = 0;
+static u16  sub_sys_id __devinitdata = 0;
+static u_char pci_bus __devinitdata = 0;
+static u_char pci_device_fn __devinitdata = 0;
+static u_char pci_irq __devinitdata = 0;
 
 #endif /* CONFIG_PCI */
 
-int __init
+int __devinit
 setup_sct_quadro(struct IsdnCard *card)
 {
 #ifdef CONFIG_PCI
diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index 5333be5..e103503 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -1875,7 +1875,7 @@ static void EChannel_proc_rcv(struct his
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 
-static struct pci_device_id hisax_pci_tbl[] __initdata = {
+static struct pci_device_id hisax_pci_tbl[] __devinitdata = {
 #ifdef CONFIG_HISAX_FRITZPCI
 	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,           PCI_ANY_ID, PCI_ANY_ID},
 #endif
diff --git a/drivers/isdn/hisax/diva.c b/drivers/isdn/hisax/diva.c
index 323a02e..e294fa3 100644
--- a/drivers/isdn/hisax/diva.c
+++ b/drivers/isdn/hisax/diva.c
@@ -887,13 +887,13 @@ Diva_card_msg(struct IsdnCardState *cs, 
 	return(0);
 }
 
-static struct pci_dev *dev_diva __initdata = NULL;
-static struct pci_dev *dev_diva_u __initdata = NULL;
-static struct pci_dev *dev_diva201 __initdata = NULL;
-static struct pci_dev *dev_diva202 __initdata = NULL;
+static struct pci_dev *dev_diva __devinitdata = NULL;
+static struct pci_dev *dev_diva_u __devinitdata = NULL;
+static struct pci_dev *dev_diva201 __devinitdata = NULL;
+static struct pci_dev *dev_diva202 __devinitdata = NULL;
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id diva_ids[] __initdata = {
+static struct isapnp_device_id diva_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('G', 'D', 'I'), ISAPNP_FUNCTION(0x51),
 	  ISAPNP_VENDOR('G', 'D', 'I'), ISAPNP_FUNCTION(0x51), 
 	  (unsigned long) "Diva picola" },
@@ -915,12 +915,12 @@ static struct isapnp_device_id diva_ids[
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &diva_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &diva_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
 
-int __init
+int __devinit
 setup_diva(struct IsdnCard *card)
 {
 	int bytecnt = 8;
diff --git a/drivers/isdn/hisax/enternow_pci.c b/drivers/isdn/hisax/enternow_pci.c
index 8fcbe2e..76c7d29 100644
--- a/drivers/isdn/hisax/enternow_pci.c
+++ b/drivers/isdn/hisax/enternow_pci.c
@@ -301,10 +301,10 @@ enpci_interrupt(int intno, void *dev_id,
 }
 
 
-static struct pci_dev *dev_netjet __initdata = NULL;
+static struct pci_dev *dev_netjet __devinitdata = NULL;
 
 /* called by config.c */
-int __init
+int __devinit
 setup_enternow_pci(struct IsdnCard *card)
 {
 	int bytecnt;
diff --git a/drivers/isdn/hisax/gazel.c b/drivers/isdn/hisax/gazel.c
index 3e7d923..fe29372 100644
--- a/drivers/isdn/hisax/gazel.c
+++ b/drivers/isdn/hisax/gazel.c
@@ -484,7 +484,7 @@ reserve_regions(struct IsdnCard *card, s
 	return 1;
 }
 
-static int __init
+static int __devinit
 setup_gazelisa(struct IsdnCard *card, struct IsdnCardState *cs)
 {
 	printk(KERN_INFO "Gazel: ISA PnP card automatic recognition\n");
@@ -532,9 +532,9 @@ setup_gazelisa(struct IsdnCard *card, st
 	return (0);
 }
 
-static struct pci_dev *dev_tel __initdata = NULL;
+static struct pci_dev *dev_tel __devinitdata = NULL;
 
-static int __init
+static int __devinit
 setup_gazelpci(struct IsdnCardState *cs)
 {
 	u_int pci_ioaddr0 = 0, pci_ioaddr1 = 0;
@@ -621,7 +621,7 @@ setup_gazelpci(struct IsdnCardState *cs)
 	return (0);
 }
 
-int __init
+int __devinit
 setup_gazel(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/hfc4s8s_l1.c b/drivers/isdn/hisax/hfc4s8s_l1.c
index 0f967b3..3a5ca8a 100644
--- a/drivers/isdn/hisax/hfc4s8s_l1.c
+++ b/drivers/isdn/hisax/hfc4s8s_l1.c
@@ -1703,7 +1703,7 @@ hfc4s8s_module_init(void)
 /* driver module exit :              */
 /* release the HFC-4s/8s hardware    */
 /*************************************/
-static void
+static void __exit
 hfc4s8s_module_exit(void)
 {
 	pci_unregister_driver(&hfc4s8s_driver);
diff --git a/drivers/isdn/hisax/hfc_2bds0.c b/drivers/isdn/hisax/hfc_2bds0.c
index 637a261..6360e82 100644
--- a/drivers/isdn/hisax/hfc_2bds0.c
+++ b/drivers/isdn/hisax/hfc_2bds0.c
@@ -1015,7 +1015,7 @@ hfc_dbusy_timer(struct IsdnCardState *cs
 {
 }
 
-static unsigned int __init
+static unsigned int
 *init_send_hfcd(int cnt)
 {
 	int i, *send;
@@ -1030,7 +1030,7 @@ static unsigned int __init
 	return(send);
 }
 
-void __init
+void
 init2bds0(struct IsdnCardState *cs)
 {
 	cs->setstack_d = setstack_hfcd;
diff --git a/drivers/isdn/hisax/hfc_2bs0.c b/drivers/isdn/hisax/hfc_2bs0.c
index c964539..d0520ad 100644
--- a/drivers/isdn/hisax/hfc_2bs0.c
+++ b/drivers/isdn/hisax/hfc_2bs0.c
@@ -551,7 +551,7 @@ setstack_hfc(struct PStack *st, struct B
 	return (0);
 }
 
-static void __init
+static void
 init_send(struct BCState *bcs)
 {
 	int i;
@@ -565,7 +565,7 @@ init_send(struct BCState *bcs)
 		bcs->hw.hfc.send[i] = 0x1fff;
 }
 
-void __init
+void
 inithfc(struct IsdnCardState *cs)
 {
 	init_send(&cs->bcs[0]);
diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 7241e73..1df60ca 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1581,7 +1581,7 @@ hfcpci_bh(struct IsdnCardState *cs)
 /********************************/
 /* called for card init message */
 /********************************/
-static void __init
+static void
 inithfcpci(struct IsdnCardState *cs)
 {
 	cs->bcs[0].BC_SetStack = setstack_2b;
@@ -1638,11 +1638,11 @@ hfcpci_card_msg(struct IsdnCardState *cs
 
 
 /* this variable is used as card index when more than one cards are present */
-static struct pci_dev *dev_hfcpci __initdata = NULL;
+static struct pci_dev *dev_hfcpci __devinitdata = NULL;
 
 #endif				/* CONFIG_PCI */
 
-int __init
+int __devinit
 setup_hfcpci(struct IsdnCard *card)
 {
 	u_long flags;
diff --git a/drivers/isdn/hisax/hfcscard.c b/drivers/isdn/hisax/hfcscard.c
index 86ab1c1..4e7f472 100644
--- a/drivers/isdn/hisax/hfcscard.c
+++ b/drivers/isdn/hisax/hfcscard.c
@@ -139,7 +139,7 @@ hfcs_card_msg(struct IsdnCardState *cs, 
 }
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id hfc_ids[] __initdata = {
+static struct isapnp_device_id hfc_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('A', 'N', 'X'), ISAPNP_FUNCTION(0x1114),
 	  ISAPNP_VENDOR('A', 'N', 'X'), ISAPNP_FUNCTION(0x1114), 
 	  (unsigned long) "Acer P10" },
@@ -164,11 +164,11 @@ static struct isapnp_device_id hfc_ids[]
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &hfc_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &hfc_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
-int __init
+int __devinit
 setup_hfcs(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/icc.c b/drivers/isdn/hisax/icc.c
index c615752..2cf7b66 100644
--- a/drivers/isdn/hisax/icc.c
+++ b/drivers/isdn/hisax/icc.c
@@ -24,10 +24,10 @@
 #define DBUSY_TIMER_VALUE 80
 #define ARCOFI_USE 0
 
-static char *ICCVer[] __initdata =
+static char *ICCVer[] =
 {"2070 A1/A3", "2070 B1", "2070 B2/B3", "2070 V2.4"};
 
-void __init
+void
 ICCVersion(struct IsdnCardState *cs, char *s)
 {
 	int val;
@@ -613,7 +613,7 @@ dbusy_timer_handler(struct IsdnCardState
 	}
 }
 
-void __init
+void
 initicc(struct IsdnCardState *cs)
 {
 	cs->setstack_d = setstack_icc;
@@ -646,7 +646,7 @@ initicc(struct IsdnCardState *cs)
 	ph_command(cs, ICC_CMD_DI);
 }
 
-void __init
+void
 clear_pending_icc_ints(struct IsdnCardState *cs)
 {
 	int val, eval;
diff --git a/drivers/isdn/hisax/icc.h b/drivers/isdn/hisax/icc.h
index b3bb3d5..e7f5939 100644
--- a/drivers/isdn/hisax/icc.h
+++ b/drivers/isdn/hisax/icc.h
@@ -65,7 +65,7 @@
 #define ICC_IND_AIL    0xE
 #define ICC_IND_DC     0xF
 
-extern void __init ICCVersion(struct IsdnCardState *cs, char *s);
+extern void ICCVersion(struct IsdnCardState *cs, char *s);
 extern void initicc(struct IsdnCardState *cs);
 extern void icc_interrupt(struct IsdnCardState *cs, u_char val);
 extern void clear_pending_icc_ints(struct IsdnCardState *cs);
diff --git a/drivers/isdn/hisax/ipacx.c b/drivers/isdn/hisax/ipacx.c
index df5fc92..00afd55 100644
--- a/drivers/isdn/hisax/ipacx.c
+++ b/drivers/isdn/hisax/ipacx.c
@@ -38,8 +38,8 @@ static void dbusy_timer_handler(struct I
 static void dch_empty_fifo(struct IsdnCardState *cs, int count);
 static void dch_fill_fifo(struct IsdnCardState *cs);
 static inline void dch_int(struct IsdnCardState *cs);
-static void __devinit dch_setstack(struct PStack *st, struct IsdnCardState *cs);
-static void __devinit dch_init(struct IsdnCardState *cs);
+static void dch_setstack(struct PStack *st, struct IsdnCardState *cs);
+static void dch_init(struct IsdnCardState *cs);
 static void bch_l2l1(struct PStack *st, int pr, void *arg);
 static void bch_empty_fifo(struct BCState *bcs, int count);
 static void bch_fill_fifo(struct BCState *bcs);
@@ -48,8 +48,8 @@ static void bch_mode(struct BCState *bcs
 static void bch_close_state(struct BCState *bcs);
 static int bch_open_state(struct IsdnCardState *cs, struct BCState *bcs);
 static int bch_setstack(struct PStack *st, struct BCState *bcs);
-static void __devinit bch_init(struct IsdnCardState *cs, int hscx);
-static void __init clear_pending_ints(struct IsdnCardState *cs);
+static void bch_init(struct IsdnCardState *cs, int hscx);
+static void clear_pending_ints(struct IsdnCardState *cs);
 
 //----------------------------------------------------------
 // Issue Layer 1 command to chip
@@ -408,7 +408,7 @@ dch_int(struct IsdnCardState *cs)
 
 //----------------------------------------------------------
 //----------------------------------------------------------
-static void __devinit
+static void
 dch_setstack(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = dch_l2l1;
@@ -416,7 +416,7 @@ dch_setstack(struct PStack *st, struct I
 
 //----------------------------------------------------------
 //----------------------------------------------------------
-static void __devinit
+static void
 dch_init(struct IsdnCardState *cs)
 {
 	printk(KERN_INFO "HiSax: IPACX ISDN driver v0.1.0\n");
@@ -823,7 +823,7 @@ bch_setstack(struct PStack *st, struct B
 
 //----------------------------------------------------------
 //----------------------------------------------------------
-static void __devinit
+static void
 bch_init(struct IsdnCardState *cs, int hscx)
 {
 	cs->bcs[hscx].BC_SetStack   = bch_setstack;
@@ -861,7 +861,7 @@ interrupt_ipacx(struct IsdnCardState *cs
 //----------------------------------------------------------
 // Clears chip interrupt status
 //----------------------------------------------------------
-static void __init
+static void
 clear_pending_ints(struct IsdnCardState *cs)
 {
 	int ista;
@@ -883,7 +883,7 @@ clear_pending_ints(struct IsdnCardState 
 // Does chip configuration work
 // Work to do depends on bit mask in part
 //----------------------------------------------------------
-void __init
+void
 init_ipacx(struct IsdnCardState *cs, int part)
 {
 	if (part &1) {  // initialise chip
diff --git a/drivers/isdn/hisax/isurf.c b/drivers/isdn/hisax/isurf.c
index 33747af..715a1a8 100644
--- a/drivers/isdn/hisax/isurf.c
+++ b/drivers/isdn/hisax/isurf.c
@@ -196,10 +196,10 @@ isurf_auxcmd(struct IsdnCardState *cs, i
 }
 
 #ifdef __ISAPNP__
-static struct pnp_card *pnp_c __initdata = NULL;
+static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
-int __init
+int __devinit
 setup_isurf(struct IsdnCard *card)
 {
 	int ver;
diff --git a/drivers/isdn/hisax/ix1_micro.c b/drivers/isdn/hisax/ix1_micro.c
index 908a7e1..3971750 100644
--- a/drivers/isdn/hisax/ix1_micro.c
+++ b/drivers/isdn/hisax/ix1_micro.c
@@ -210,7 +210,7 @@ ix1_card_msg(struct IsdnCardState *cs, i
 }
 
 #ifdef __ISAPNP__
-static struct isapnp_device_id itk_ids[] __initdata = {
+static struct isapnp_device_id itk_ids[] __devinitdata = {
 	{ ISAPNP_VENDOR('I', 'T', 'K'), ISAPNP_FUNCTION(0x25),
 	  ISAPNP_VENDOR('I', 'T', 'K'), ISAPNP_FUNCTION(0x25), 
 	  (unsigned long) "ITK micro 2" },
@@ -220,12 +220,12 @@ static struct isapnp_device_id itk_ids[]
 	{ 0, }
 };
 
-static struct isapnp_device_id *ipid __initdata = &itk_ids[0];
+static struct isapnp_device_id *ipid __devinitdata = &itk_ids[0];
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
 
-int __init
+int __devinit
 setup_ix1micro(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/jade.c b/drivers/isdn/hisax/jade.c
index 2659fec..43d61d1 100644
--- a/drivers/isdn/hisax/jade.c
+++ b/drivers/isdn/hisax/jade.c
@@ -19,7 +19,7 @@
 #include <linux/interrupt.h>
 
 
-int __init
+int
 JadeVersion(struct IsdnCardState *cs, char *s)
 {
     int ver,i;
@@ -253,7 +253,7 @@ setstack_jade(struct PStack *st, struct 
 	return (0);
 }
 
-void __init
+void
 clear_pending_jade_ints(struct IsdnCardState *cs)
 {
 	int val;
@@ -279,7 +279,7 @@ clear_pending_jade_ints(struct IsdnCardS
 	cs->BC_Write_Reg(cs, 1, jade_HDLC_IMR, 0xF8);
 }
 
-void __init
+void
 initjade(struct IsdnCardState *cs)
 {
 	cs->bcs[0].BC_SetStack = setstack_jade;
diff --git a/drivers/isdn/hisax/mic.c b/drivers/isdn/hisax/mic.c
index fe11f22..8c82519 100644
--- a/drivers/isdn/hisax/mic.c
+++ b/drivers/isdn/hisax/mic.c
@@ -189,7 +189,7 @@ mic_card_msg(struct IsdnCardState *cs, i
 	return(0);
 }
 
-int __init
+int __devinit
 setup_mic(struct IsdnCard *card)
 {
 	int bytecnt;
diff --git a/drivers/isdn/hisax/netjet.c b/drivers/isdn/hisax/netjet.c
index 47a47ef..38f648f 100644
--- a/drivers/isdn/hisax/netjet.c
+++ b/drivers/isdn/hisax/netjet.c
@@ -909,7 +909,7 @@ setstack_tiger(struct PStack *st, struct
 }
 
  
-void __init
+void
 inittiger(struct IsdnCardState *cs)
 {
 	if (!(cs->bcs[0].hw.tiger.send = kmalloc(NETJET_DMA_TXSIZE * sizeof(unsigned int),
diff --git a/drivers/isdn/hisax/niccy.c b/drivers/isdn/hisax/niccy.c
index 79a97b1..489022b 100644
--- a/drivers/isdn/hisax/niccy.c
+++ b/drivers/isdn/hisax/niccy.c
@@ -232,12 +232,12 @@ niccy_card_msg(struct IsdnCardState *cs,
 	return(0);
 }
 
-static struct pci_dev *niccy_dev __initdata = NULL;
+static struct pci_dev *niccy_dev __devinitdata = NULL;
 #ifdef __ISAPNP__
 static struct pnp_card *pnp_c __devinitdata = NULL;
 #endif
 
-int __init
+int __devinit
 setup_niccy(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/nj_s.c b/drivers/isdn/hisax/nj_s.c
index e5b900a..80025fd 100644
--- a/drivers/isdn/hisax/nj_s.c
+++ b/drivers/isdn/hisax/nj_s.c
@@ -148,9 +148,9 @@ NETjet_S_card_msg(struct IsdnCardState *
 	return(0);
 }
 
-static struct pci_dev *dev_netjet __initdata = NULL;
+static struct pci_dev *dev_netjet __devinitdata = NULL;
 
-int __init
+int __devinit
 setup_netjet_s(struct IsdnCard *card)
 {
 	int bytecnt,cfg;
diff --git a/drivers/isdn/hisax/nj_u.c b/drivers/isdn/hisax/nj_u.c
index 7002b09..3749716 100644
--- a/drivers/isdn/hisax/nj_u.c
+++ b/drivers/isdn/hisax/nj_u.c
@@ -128,9 +128,9 @@ NETjet_U_card_msg(struct IsdnCardState *
 	return(0);
 }
 
-static struct pci_dev *dev_netjet __initdata = NULL;
+static struct pci_dev *dev_netjet __devinitdata = NULL;
 
-int __init
+int __devinit
 setup_netjet_u(struct IsdnCard *card)
 {
 	int bytecnt;
diff --git a/drivers/isdn/hisax/s0box.c b/drivers/isdn/hisax/s0box.c
index 7b63085..e76042d 100644
--- a/drivers/isdn/hisax/s0box.c
+++ b/drivers/isdn/hisax/s0box.c
@@ -211,7 +211,7 @@ S0Box_card_msg(struct IsdnCardState *cs,
 	return(0);
 }
 
-int __init
+int __devinit
 setup_s0box(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/saphir.c b/drivers/isdn/hisax/saphir.c
index 821776e..d943d36 100644
--- a/drivers/isdn/hisax/saphir.c
+++ b/drivers/isdn/hisax/saphir.c
@@ -241,7 +241,7 @@ saphir_card_msg(struct IsdnCardState *cs
 }
 
 
-int __init
+int __devinit
 setup_saphir(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/sportster.c b/drivers/isdn/hisax/sportster.c
index cdf35dc..a49b694 100644
--- a/drivers/isdn/hisax/sportster.c
+++ b/drivers/isdn/hisax/sportster.c
@@ -184,7 +184,7 @@ Sportster_card_msg(struct IsdnCardState 
 	return(0);
 }
 
-static int __init
+static int __devinit
 get_io_range(struct IsdnCardState *cs)
 {
 	int i, j, adr;
@@ -209,7 +209,7 @@ get_io_range(struct IsdnCardState *cs)
 	}
 }
 
-int __init
+int __devinit
 setup_sportster(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/teleint.c b/drivers/isdn/hisax/teleint.c
index a2b1816..e94dc6f 100644
--- a/drivers/isdn/hisax/teleint.c
+++ b/drivers/isdn/hisax/teleint.c
@@ -261,7 +261,7 @@ TeleInt_card_msg(struct IsdnCardState *c
 	return(0);
 }
 
-int __init
+int __devinit
 setup_TeleInt(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/teles0.c b/drivers/isdn/hisax/teles0.c
index 2b7df8f..f94af09 100644
--- a/drivers/isdn/hisax/teles0.c
+++ b/drivers/isdn/hisax/teles0.c
@@ -265,7 +265,7 @@ Teles_card_msg(struct IsdnCardState *cs,
 	return(0);
 }
 
-int __init
+int __devinit
 setup_teles0(struct IsdnCard *card)
 {
 	u_char val;
diff --git a/drivers/isdn/hisax/telespci.c b/drivers/isdn/hisax/telespci.c
index 9382cdf..dca4468 100644
--- a/drivers/isdn/hisax/telespci.c
+++ b/drivers/isdn/hisax/telespci.c
@@ -284,9 +284,9 @@ TelesPCI_card_msg(struct IsdnCardState *
 	return(0);
 }
 
-static struct pci_dev *dev_tel __initdata = NULL;
+static struct pci_dev *dev_tel __devinitdata = NULL;
 
-int __init
+int __devinit
 setup_telespci(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;
diff --git a/drivers/isdn/hisax/w6692.c b/drivers/isdn/hisax/w6692.c
index 6c68419..c95e773 100644
--- a/drivers/isdn/hisax/w6692.c
+++ b/drivers/isdn/hisax/w6692.c
@@ -44,11 +44,11 @@ static const char *w6692_revision = "$Re
 
 #define DBUSY_TIMER_VALUE 80
 
-static char *W6692Ver[] __initdata =
+static char *W6692Ver[] =
 {"W6692 V00", "W6692 V01", "W6692 V10",
  "W6692 V11"};
 
-static void __init
+static void
 W6692Version(struct IsdnCardState *cs, char *s)
 {
 	int val;
@@ -897,7 +897,7 @@ static void resetW6692(struct IsdnCardSt
 	}
 }
 
-static void __init initW6692(struct IsdnCardState *cs, int part)
+static void initW6692(struct IsdnCardState *cs, int part)
 {
 	if (part & 1) {
 		cs->setstack_d = setstack_W6692;
@@ -992,9 +992,9 @@ w6692_card_msg(struct IsdnCardState *cs,
 
 static int id_idx ;
 
-static struct pci_dev *dev_w6692 __initdata = NULL;
+static struct pci_dev *dev_w6692 __devinitdata = NULL;
 
-int __init 
+int __devinit 
 setup_w6692(struct IsdnCard *card)
 {
 	struct IsdnCardState *cs = card->cs;

-- 
Karsten Keil
SuSE Labs
ISDN development
