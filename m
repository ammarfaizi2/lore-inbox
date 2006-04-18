Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWDRVAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWDRVAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWDRVAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:00:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:4040 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932240AbWDRVAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:00:07 -0400
Subject: [PATCH] tpm: spacing cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 15:56:11 -0500
Message-Id: <1145393772.4829.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes minor spacing issues.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm_tis.c	2006-04-18 14:54:17.025607500 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-18 14:59:51.510511500 -0500
@@ -54,8 +57,8 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_BASE = 0xFED4000,
 	TIS_MEM_LEN = 0x5000,
-	TIS_SHORT_TIMEOUT = 750, /* ms */
-	TIS_LONG_TIMEOUT = 2000, /* 2 sec */
+	TIS_SHORT_TIMEOUT = 750,	/* ms */
+	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
 };
 
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
@@ -188,7 +191,7 @@ static int wait_for_stat(struct tpm_chip
 	return -ETIME;
 }
 
-static int recv_data(struct tpm_chip *chip, u8 * buf, size_t count)
+static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0, burstcnt;
 	while (size < count &&
@@ -206,7 +209,7 @@ static int recv_data(struct tpm_chip *ch
 	return size;
 }
 
-static int tpm_tis_recv(struct tpm_chip *chip, u8 * buf, size_t count)
+static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0;
 	int expected, status;
@@ -257,7 +260,7 @@ out:
  * tpm.c can skip polling for the data to be available as the interrupt is
  * waited for here
  */
-static int tpm_tis_send(struct tpm_chip *chip, u8 * buf, size_t len)
+static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 {
 	int rc, status, burstcnt;
 	size_t count = 0;
@@ -374,8 +377,7 @@ static struct tpm_vendor_specific tpm_ti
 		    .fops = &tis_ops,},
 };
 
-static irqreturn_t tis_int_probe(int irq, void *dev_id, struct pt_regs
-				 *regs)
+static irqreturn_t tis_int_probe(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct tpm_chip *chip = (struct tpm_chip *) dev_id;
 	u32 interrupt;
@@ -395,8 +397,7 @@ static irqreturn_t tis_int_probe(int irq
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t tis_int_handler(int irq, void *dev_id, struct pt_regs
-				   *regs)
+static irqreturn_t tis_int_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct tpm_chip *chip = (struct tpm_chip *) dev_id;
 	u32 interrupt;
@@ -426,10 +427,8 @@ static irqreturn_t tis_int_handler(int i
 	return IRQ_HANDLED;
 }
 
-static int __devinit tpm_tis_pnp_init(struct pnp_dev
-				      *pnp_dev, const struct
-				      pnp_device_id
-				      *pnp_id)
+static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
+				      const struct pnp_device_id *pnp_id)
 {
 	u32 vendor, intfcaps, intmask;
 	int rc, i;
 


