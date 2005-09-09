Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbVIICgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbVIICgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbVIICgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:36:52 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:63202 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965239AbVIICgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:36:52 -0400
Date: Thu, 8 Sep 2005 22:33:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13] x86_64: Clean up nmi error message
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509082236_MC3-1-A99D-81DE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86_64 nmi code is missing a newline in one of its messages.

I added a space before the CPU id for readability and killed the trailing
space on the previous line as well.


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>


 arch/x86_64/kernel/nmi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.13-64.orig/arch/x86_64/kernel/nmi.c
+++ 2.6.13-64/arch/x86_64/kernel/nmi.c
@@ -486,8 +486,8 @@ void nmi_watchdog_tick (struct pt_regs *
 							== NOTIFY_STOP) {
 				local_set(&__get_cpu_var(alert_counter), 0);
 				return;
-			} 
-			die_nmi("NMI Watchdog detected LOCKUP on CPU%d", regs);
+			}
+			die_nmi("NMI Watchdog detected LOCKUP on CPU %d\n", regs);
 		}
 	} else {
 		__get_cpu_var(last_irq_sum) = sum;
__
Chuck
