Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVCMDxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVCMDxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCMDxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:53:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7686 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262665AbVCMDxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:53:35 -0500
Date: Sun, 13 Mar 2005 04:53:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/smp.c: remove a pointless "inline"
Message-ID: <20050313035325.GP3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of send_IPI_mask_sequence are in other files, so marking it 
"inline" is quite pointless.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/arch/i386/kernel/smp.c.old	2005-03-13 04:28:29.000000000 +0100
+++ linux-2.6.11-mm3-full/arch/i386/kernel/smp.c	2005-03-13 04:28:42.000000000 +0100
@@ -189,7 +189,7 @@
 	local_irq_restore(flags);
 }
 
-inline void send_IPI_mask_sequence(cpumask_t mask, int vector)
+void send_IPI_mask_sequence(cpumask_t mask, int vector)
 {
 	unsigned long cfg, flags;
 	unsigned int query_cpu;
