Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753379AbWKMVD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbWKMVD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbWKMVD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:03:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30217 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753379AbWKMVD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:03:26 -0500
Date: Mon, 13 Nov 2006 22:03:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [-mm patch] arch/i386/kernel/apic.c: make a function static
Message-ID: <20061113210331.GD22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global local_apic_timer_interrupt() 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm1/arch/i386/kernel/apic.c.old	2006-11-13 17:51:59.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/apic.c	2006-11-13 17:53:14.000000000 +0100
@@ -545,7 +545,7 @@
 /*
  * The guts of the apic timer interrupt
  */
-fastcall void local_apic_timer_interrupt(struct pt_regs *regs)
+static fastcall void local_apic_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(lapic_events, cpu).evdev;

