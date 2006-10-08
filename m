Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWJHPCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWJHPCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWJHPCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:02:23 -0400
Received: from main.gmane.org ([80.91.229.2]:39897 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751208AbWJHPCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:02:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] user struct irq_chip instead of struct hw_interrupt_type
Date: Sun, 08 Oct 2006 20:32:07 +0530
Message-ID: <egb3tg$ib2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050809030906040103050002"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.176.9
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809030906040103050002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050809030906040103050002
Content-Type: text/x-patch;
 name="io_apic.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io_apic.c.diff"

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index b7287fb..eafd93e 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2594,7 +2594,7 @@ static void set_ht_irq_affinity(unsigned
 }
 #endif
 
-static struct hw_interrupt_type ht_irq_chip = {
+static struct irq_chip ht_irq_chip = {
 	.name		= "PCI-HT",
 	.mask		= mask_ht_irq,
 	.unmask		= unmask_ht_irq,

--------------050809030906040103050002--

