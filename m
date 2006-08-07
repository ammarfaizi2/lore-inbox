Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWHGPHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWHGPHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWHGPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:07:10 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:21787 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932123AbWHGPHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:07:08 -0400
Date: Mon, 7 Aug 2006 17:07:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [patch] s390: add __cpuinit to appldata_cpu_notify
Message-ID: <20060807150707.GE10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] add __cpuinit to appldata_cpu_notify

Use __cpuinit for CPU hotplug notifier function.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-08-07 14:14:46.000000000 +0200
@@ -618,7 +618,7 @@ appldata_offline_cpu(int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int
+static int __cpuinit
 appldata_cpu_notify(struct notifier_block *self,
 		    unsigned long action, void *hcpu)
 {
