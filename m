Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVAKVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVAKVmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAKVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:41:32 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:51856 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262892AbVAKVjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:39:17 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050111213934.9256.11785.91382@localhost.localdomain>
In-Reply-To: <20050111213927.9256.16501.54102@localhost.localdomain>
References: <20050111213927.9256.16501.54102@localhost.localdomain>
Subject: [PATCH 1/2] frv: replace cli() in arch/frv/kernel/irq-routing.c
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.220.243] at Tue, 11 Jan 2005 15:39:14 -0600
Date: Tue, 11 Jan 2005 15:39:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm2-original/arch/frv/kernel/irq-routing.c linux-2.6.10-mm2/arch/frv/kernel/irq-routing.c
--- linux-2.6.10-mm2-original/arch/frv/kernel/irq-routing.c	2005-01-08 12:16:28.000000000 -0500
+++ linux-2.6.10-mm2/arch/frv/kernel/irq-routing.c	2005-01-08 12:28:17.000000000 -0500
@@ -92,7 +92,7 @@
 
 			if (status & SA_SAMPLE_RANDOM)
 				add_interrupt_randomness(irq);
-			cli();
+			local_irq_disable();
 		}
 	}
 }
