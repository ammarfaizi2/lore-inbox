Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422965AbWJFU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422965AbWJFU7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWJFU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:59:14 -0400
Received: from natblert.rzone.de ([81.169.145.181]:12425 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1422962AbWJFU7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:59:11 -0400
Date: Fri, 6 Oct 2006 22:52:16 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] powerpc: spu fixup after irq changes
Message-ID: <20061006205216.GA8272@aepfle.de>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org> <20061006203434.GA7932@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061006203434.GA7932@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


remove struct pt_regs * from remaining spu irq functions.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
on top of previous irq fixup


 arch/powerpc/platforms/cell/spu_base.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -147,7 +147,7 @@ static int __spu_trap_data_map(struct sp
 }
 
 static irqreturn_t
-spu_irq_class_0(int irq, void *data, struct pt_regs *regs)
+spu_irq_class_0(int irq, void *data)
 {
 	struct spu *spu;
 
@@ -186,7 +186,7 @@ spu_irq_class_0_bottom(struct spu *spu)
 EXPORT_SYMBOL_GPL(spu_irq_class_0_bottom);
 
 static irqreturn_t
-spu_irq_class_1(int irq, void *data, struct pt_regs *regs)
+spu_irq_class_1(int irq, void *data)
 {
 	struct spu *spu;
 	unsigned long stat, mask, dar, dsisr;
@@ -224,7 +224,7 @@ spu_irq_class_1(int irq, void *data, str
 EXPORT_SYMBOL_GPL(spu_irq_class_1_bottom);
 
 static irqreturn_t
-spu_irq_class_2(int irq, void *data, struct pt_regs *regs)
+spu_irq_class_2(int irq, void *data)
 {
 	struct spu *spu;
 	unsigned long stat;
