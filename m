Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755347AbWKMVDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbWKMVDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbWKMVDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:03:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31241 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755347AbWKMVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:03:37 -0500
Date: Mon, 13 Nov 2006 22:03:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make arch/i386/kernel/io_apic.c:irq_vector[] static
Message-ID: <20061113210342.GE22565@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq_vector[] can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c.old	2006-11-13 18:13:14.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/io_apic.c	2006-11-13 18:13:25.000000000 +0100
@@ -1242,7 +1242,7 @@
 }
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
-u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
+static u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
 
 static int __assign_irq_vector(int irq)
 {
