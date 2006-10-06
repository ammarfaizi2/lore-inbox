Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWJFOzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWJFOzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWJFOzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:55:31 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:60745 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161059AbWJFOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:55:28 -0400
Date: Fri, 6 Oct 2006 16:55:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [PATCH] sysrq: irq change build fix.
Message-ID: <20061006145529.GE26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[PATCH] sysrq: irq change build fix.

drivers/char/sysrq.c: In function `sysrq_handle_crashdump':
drivers/char/sysrq.c:98: warning: implicit declaration of function `get_irq_regs'

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/char/sysrq.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/char/sysrq.c linux-2.6-patched/drivers/char/sysrq.c
--- linux-2.6/drivers/char/sysrq.c	2006-10-06 16:29:28.000000000 +0200
+++ linux-2.6-patched/drivers/char/sysrq.c	2006-10-06 16:30:00.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/irq.h>
 
 #include <asm/ptrace.h>
+#include <asm/irq_regs.h>
 
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
