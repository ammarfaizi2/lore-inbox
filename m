Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUJFJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUJFJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUJFJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:25:57 -0400
Received: from mail.renesas.com ([202.234.163.13]:31479 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269162AbUJFJZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:25:45 -0400
Date: Wed, 06 Oct 2004 18:25:20 +0900 (JST)
Message-Id: <20041006.182520.608416918.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
       takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2] Fix to compile smc91x network driver
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to fix a compile error of smc91x network deriver.
Please apply.

It was a typo or something like that. ;-)

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/net/smc91x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -ruNp a/drivers/net/smc91x.c b/drivers/net/smc91x.c
--- a/drivers/net/smc91x.c	2004-10-05 12:39:24.000000000 +0900
+++ b/drivers/net/smc91x.c	2004-10-05 21:05:44.000000000 +0900
@@ -568,7 +568,7 @@ done:
 	int __ret;							\
 	local_irq_disable();						\
 	__ret = spin_trylock(lock);					\
-	if ((!__ret)							\
+	if (!__ret)							\
 		local_irq_enable();					\
 	__ret;								\
 })

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
