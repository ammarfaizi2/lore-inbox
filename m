Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWBHSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWBHSuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWBHSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:50:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8625 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1030453AbWBHSuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:50:18 -0500
Date: Wed, 8 Feb 2006 10:50:13 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       paul.mckenney@us.ibm.com
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [patch 02/03] add EXPORT_SYMBOL_GPL_FUTURE() to RCU subsystem
Message-ID: <20060208185013.GC17016@kroah.com>
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208184922.GB17016@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the RCU symbols are going to be changed to GPL in the near future,
let us warn users that this is going to happen.

Cc: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Paul McKenney <paul.mckenney@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/rcupdate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/kernel/rcupdate.c
+++ gregkh-2.6/kernel/rcupdate.c
@@ -569,7 +569,7 @@ void synchronize_kernel(void)
 
 module_param(maxbatch, int, 0);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL_FUTURE(synchronize_kernel); /* WARNING: GPL-only in April 2006. */
