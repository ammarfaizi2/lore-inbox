Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUIWNtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUIWNtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268468AbUIWNtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:49:45 -0400
Received: from mail.renesas.com ([202.234.163.13]:7668 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268465AbUIWNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:49:08 -0400
Date: Thu, 23 Sep 2004 22:48:54 +0900 (JST)
Message-Id: <20040923.224854.582763130.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc2-mm2] [m32r] Trivial fix of smc91x.h
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to fix smc91x.h for m32r.
Please apply.

Thanks.

	* drivers/net/smc91x.h:
	Fix LED control.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 smc91x.h |    3 +++
 1 files changed, 3 insertions(+)

diff -ruNp a/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h	2004-09-23 10:11:08.000000000 +0900
+++ b/drivers/net/smc91x.h	2004-09-23 13:16:42.000000000 +0900
@@ -216,6 +216,9 @@ static inline void SMC_outsw (unsigned l
 #define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
 #define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
 
+#define RPC_LSA_DEFAULT		RPC_LED_TX_RX
+#define RPC_LSB_DEFAULT		RPC_LED_100_10
+
 #elif	defined(CONFIG_MACH_LPD7A400) || defined(CONFIG_MACH_LPD7A404)
 
 #include <asm/arch/constants.h>	/* IOBARRIER_VIRT */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
