Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUJMDQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUJMDQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 23:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJMDQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 23:16:09 -0400
Received: from mail.renesas.com ([202.234.163.13]:11714 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268255AbUJMDQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 23:16:03 -0400
Date: Wed, 13 Oct 2004 12:15:47 +0900 (JST)
Message-Id: <20041013.121547.863739114.takata.hirokazu@renesas.com>
To: jgarzik@pobox.com
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       paul.mundt@nokia.com, nico@cam.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
From: Hirokazu Takata <takata.hirokazu@renesas.com>
In-Reply-To: <416C8E0B.4030409@pobox.com>
References: <416BFD79.1010306@pobox.com>
	<20041013.105243.511706221.takata.hirokazu@renesas.com>
	<416C8E0B.4030409@pobox.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
Date: Tue, 12 Oct 2004 22:08:11 -0400
> Hirokazu Takata wrote:
> > Please throw away this patch and retrieve the previous 
> > m32r-trivial-fix-of-smc91xh.patch again, 
> > if the above patch "[PATCH] net: fix smc91x build for sh/ppc" is applied.
> 
> 
> Would you be kind enough to send me this patch?
> 
> 	Jeff

OK. I will send you again, Jeff.

This patch has been already applied to 2.6.9-rc4-mm1 kernel and 
you can also find it as
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/m32r-trivial-fix-of-smc91xh.patch

Thanks.


To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc2-mm2] [m32r] Trivial fix of smc91x.h
----
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

