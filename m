Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752459AbWAFQhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbWAFQhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbWAFQg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:36:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752444AbWAFQaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:00 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTbNG011390@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 15/17] FRV: Export __rcuref_hash
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch exports __rcuref_hash which is required by some modules.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 rcu-export-2615.diff
 kernel/rcupdate.c |    1 +
 1 files changed, 1 insertion(+)

diff -uNrp /warthog/kernels/linux-2.6.15/kernel/rcupdate.c linux-2.6.15-frv/kernel/rcupdate.c
--- /warthog/kernels/linux-2.6.15/kernel/rcupdate.c	2006-01-04 12:39:43.000000000 +0000
+++ linux-2.6.15-frv/kernel/rcupdate.c	2006-01-06 14:43:43.000000000 +0000
@@ -564,3 +564,4 @@ EXPORT_SYMBOL(call_rcu);  /* WARNING: GP
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(__rcuref_hash);
