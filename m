Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVAPHqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVAPHqx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVAPHqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:46:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34062 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262443AbVAPHqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:46:52 -0500
Date: Sun, 16 Jan 2005 08:46:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
Message-ID: <20050116074649.GW4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of register_die_notifier (kernel/kprobes.c) can't be 
built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/x8664_ksyms.c.old	2005-01-16 05:38:17.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/x8664_ksyms.c	2005-01-16 08:45:54.000000000 +0100
@@ -198,7 +198,6 @@
 #endif
 
 EXPORT_SYMBOL(die_chain);
-EXPORT_SYMBOL(register_die_notifier);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_sibling_map);

