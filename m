Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWFNODN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWFNODN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWFNODN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:03:13 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:56127 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964938AbWFNODM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:03:12 -0400
Date: Wed, 14 Jun 2006 16:03:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [patch 13/24] s390: add __cpuinit to appldata cpu hotplug notifier.
Message-ID: <20060614140310.GN9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] add __cpuinit to appldata cpu hotplug notifier.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-06-14 14:29:09.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-06-14 14:29:48.000000000 +0200
@@ -633,7 +633,7 @@ appldata_offline_cpu(int cpu)
 	spin_unlock(&appldata_timer_lock);
 }
 
-static int
+static int __cpuinit
 appldata_cpu_notify(struct notifier_block *self,
 		    unsigned long action, void *hcpu)
 {
