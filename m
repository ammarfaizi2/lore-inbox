Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752551AbWAFUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbWAFUex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbWAFUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:34:52 -0500
Received: from fmr22.intel.com ([143.183.121.14]:7054 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752551AbWAFUev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:34:51 -0500
Date: Fri, 6 Jan 2006 12:34:35 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: anil.s.keshavamurthy@intel.com, Systemtap <systemtap@sources.redhat.com>
Subject: [PATCH]Kprobes: conversion from kcalloc to kzalloc
Message-ID: <20060106123435.A32527@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kprobes: Conversion from kcalloc to kzalloc

Conversion from kcalloc(1, ..) to kzalloc()
Signed-of-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---------------------------------------------------------
 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/kernel/kprobes.c
+++ linux-2.6.15-mm1/kernel/kprobes.c
@@ -431,7 +431,7 @@ static int __kprobes register_aggr_kprob
 		copy_kprobe(old_p, p);
 		ret = add_new_kprobe(old_p, p);
 	} else {
-		ap = kcalloc(1, sizeof(struct kprobe), GFP_KERNEL);
+		ap = kzalloc(sizeof(struct kprobe), GFP_KERNEL);
 		if (!ap)
 			return -ENOMEM;
 		add_aggr_kprobe(ap, old_p);
