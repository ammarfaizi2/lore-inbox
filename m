Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWGFEfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWGFEfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWGFEfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:35:54 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:62550 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S965170AbWGFEfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:35:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HANMvrESBTA
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] smsc-ircc2: fix section reference mismatches
Date: Thu, 6 Jul 2006 00:35:51 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607060035.51815.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: smsc-ircc2: fix section reference mismatches
From: Dmitry Torokhov <dtor@insightbb.com>

subsystem_configurations array is only used by an __init function,
therefore it should be marked __initdata, not __devinitdata.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/net/irda/smsc-ircc2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/net/irda/smsc-ircc2.c
===================================================================
--- work.orig/drivers/net/irda/smsc-ircc2.c
+++ work/drivers/net/irda/smsc-ircc2.c
@@ -2353,7 +2353,7 @@ static int __init smsc_superio_lpc(unsig
 #ifdef CONFIG_PCI
 #define PCIID_VENDOR_INTEL 0x8086
 #define PCIID_VENDOR_ALI 0x10b9
-static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __devinitdata = {
+static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __initdata = {
 	{
 		.vendor = PCIID_VENDOR_INTEL, /* Intel 82801DBM LPC bridge */
 		.device = 0x24cc,
