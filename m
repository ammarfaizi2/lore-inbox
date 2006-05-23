Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWEWRwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWEWRwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWEWRwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:52:00 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:7558 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751145AbWEWRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:52:00 -0400
Date: Tue, 23 May 2006 19:51:59 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] -mm: make using_apic_timer __read_mostly
Message-ID: <20060523175158.GB24461@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i386 run-tested on 2.6.17-rc4-mm3 (no x86_64 testing possible here).

this might collide with recent i386/x86_64 reunification efforts, though...

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/apic.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/apic.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/apic.c	2006-05-23 19:14:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/apic.c	2006-05-22 15:47:03.000000000 +0200
@@ -114,7 +114,7 @@
 }
 
 /* Using APIC to generate smp_local_timer_interrupt? */
-int using_apic_timer = 0;
+int using_apic_timer __read_mostly = 0;
 
 static int enabled_via_apicbase;
 
diff -urN linux-2.6.17-rc4-mm3.orig/arch/x86_64/kernel/apic.c linux-2.6.17-rc4-mm3.my/arch/x86_64/kernel/apic.c
--- linux-2.6.17-rc4-mm3.orig/arch/x86_64/kernel/apic.c	2006-05-23 19:14:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/x86_64/kernel/apic.c	2006-05-23 19:45:01.000000000 +0200
@@ -51,7 +51,7 @@
 static cpumask_t timer_interrupt_broadcast_ipi_mask;
 
 /* Using APIC to generate smp_local_timer_interrupt? */
-int using_apic_timer = 0;
+int using_apic_timer __read_mostly = 0;
 
 static void apic_pm_activate(void);
 
