Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFQFxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFQFwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:52:05 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:22512 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264605AbTFQFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:51:59 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add linker script support for v850 "rte_nb85e_cb" platform
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030617060540.4F6A437E0@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 17 Jun 2003 15:05:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.72-moo/arch/v850/vmlinux.lds.S linux-2.5.72-moo-v850-20030617/arch/v850/vmlinux.lds.S
--- linux-2.5.72-moo/arch/v850/vmlinux.lds.S	2003-06-16 14:52:17.000000000 +0900
+++ linux-2.5.72-moo-v850-20030617/arch/v850/vmlinux.lds.S	2003-06-17 14:23:12.000000000 +0900
@@ -234,3 +239,13 @@
 #  include "rte_ma1_cb.ld"
 # endif
 #endif
+
+#ifdef CONFIG_RTE_CB_NB85E
+# ifdef CONFIG_ROM_KERNEL
+#  include "rte_nb85e_cb-rom.ld"
+# elif defined(CONFIG_RTE_CB_MULTI)
+#  include "rte_nb85e_cb-multi.ld"
+# else
+#  include "rte_nb85e_cb.ld"
+# endif
+#endif
