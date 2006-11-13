Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755354AbWKMVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbWKMVEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbWKMVEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:04:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755352AbWKMVED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:04:03 -0500
Date: Mon, 13 Nov 2006 22:04:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make arch/i386/kernel/cpu/common.c:alloc_gdt() static
Message-ID: <20061113210408.GH22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global alloc_gdt() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm1/arch/i386/kernel/cpu/common.c.old	2006-11-13 17:57:57.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/cpu/common.c	2006-11-13 17:58:35.000000000 +0100
@@ -609,7 +609,7 @@
 	return regs;
 }
 
-__cpuinit int alloc_gdt(int cpu)
+static __cpuinit int alloc_gdt(int cpu)
 {
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	struct desc_struct *gdt;

