Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTEMRMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTEMRMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:12:15 -0400
Received: from pc1-cmbg4-4-cust110.cmbg.cable.ntl.com ([81.96.70.110]:56327
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S262439AbTEMRMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:12:13 -0400
Message-ID: <3EC12A98.9040003@thekelleys.org.uk>
Date: Tue, 13 May 2003 18:25:44 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-GB; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] eliminates irqN: nobody cared! and backtrace on inserting
 16bit PCMCIA card.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.69.orig/drivers/pcmcia/rsrc_mgr.c  linux-2.5.69/drivers/pcmcia/rsrc_mgr.c
--- linux-2.5.69.orig/drivers/pcmcia/rsrc_mgr.c Mon May  5 00:53:32 2003
+++ linux-2.5.69/drivers/pcmcia/rsrc_mgr.c      Tue May 13 18:18:35 2003
@@ -601,7 +601,7 @@

  #ifdef CONFIG_PCMCIA_PROBE

-static irqreturn_t fake_irq(int i, void *d, struct pt_regs *r) { return IRQ_NONE; }
+static irqreturn_t fake_irq(int i, void *d, struct pt_regs *r) { return IRQ_HANDLED; }
  static inline int check_irq(int irq)
  {
      if (request_irq(irq, fake_irq, 0, "bogus", NULL) != 0)

