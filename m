Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWALRRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWALRRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWALRR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:17:29 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:59869 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932278AbWALRR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:17:27 -0500
Date: Thu, 12 Jan 2006 18:17:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 9/13] s390: add dummy pm_power_off.
Message-ID: <20060112171712.GJ16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 9/13] s390: add dummy pm_power_off.

Define a dummy pm_power_off pointer to make sys_reboot happy.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/setup.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-01-12 15:43:58.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-01-12 15:43:59.000000000 +0100
@@ -315,6 +315,11 @@ void machine_power_off(void)
 	_machine_power_off();
 }
 
+/*
+ * Dummy power off function.
+ */
+void (*pm_power_off)(void) = machine_power_off;
+
 static void __init
 add_memory_hole(unsigned long start, unsigned long end)
 {
