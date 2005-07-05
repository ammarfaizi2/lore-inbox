Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVGEQ65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVGEQ65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVGEQ6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:58:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVGEQ4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:56:45 -0400
Date: Tue, 5 Jul 2005 09:55:52 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: [PATCH] skge: remove unused declarations
Message-ID: <20050705095552.0150dffb@dxpl.pdx.osdl.net>
In-Reply-To: <20050701225158.GA6762@redhat.com>
References: <200506281916.j5SJGi5m012509@hera.kernel.org>
	<20050701225158.GA6762@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that adds back the dev reg enum's. 
BTW: I haven't tested this driver on big endian systems yet.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Index: sky2/drivers/net/skge.h
===================================================================
--- sky2.orig/drivers/net/skge.h
+++ sky2/drivers/net/skge.h
@@ -8,6 +8,19 @@
 #define PCI_DEV_REG1	0x40
 #define PCI_DEV_REG2	0x44
 
+enum pci_dev_reg_2 {
+	PCI_VPD_WR_THR	= 0xffL<<24,	/* Bit 31..24:	VPD Write Threshold */
+	PCI_DEV_SEL	= 0x7fL<<17,	/* Bit 23..17:	EEPROM Device Select */
+	PCI_VPD_ROM_SZ	= 7L<<14,	/* Bit 16..14:	VPD ROM Size	*/
+
+	PCI_PATCH_DIR	= 0xfL<<8,	/* Bit 11.. 8:	Ext Patches dir 3..0 */
+	PCI_EXT_PATCHS	= 0xfL<<4,	/* Bit	7.. 4:	Extended Patches 3..0 */
+	PCI_EN_DUMMY_RD	= 1<<3,		/* Enable Dummy Read */
+	PCI_REV_DESC	= 1<<2,		/* Reverse Desc. Bytes */
+
+	PCI_USEDATA64	= 1<<0,		/* Use 64Bit Data bus ext */
+};
+
 #define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
 			       PCI_STATUS_REC_MASTER_ABORT | \
