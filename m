Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbRALBPK>; Thu, 11 Jan 2001 20:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRALBPA>; Thu, 11 Jan 2001 20:15:00 -0500
Received: from comunit.de ([195.21.213.33]:23068 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S131039AbRALBOv>;
	Thu, 11 Jan 2001 20:14:51 -0500
Message-ID: <3A5E5A80.EA2ECBC8@cut.de>
Date: Fri, 12 Jan 2001 02:14:40 +0100
From: Bjoern Kriews <bkr@cut.de>
Organization: Bleeding Edge, Inc.
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.0-test13-pre7-bkr i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre2: q&d-fix: EXPORT_SYMBOL(rpc_release_task) and 
 mmu_cr4_features 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.4.1-pre2-rfs-i/arch/i386/kernel/i386_ksyms.c~       Thu Dec 
7 06:00:12 2000
+++ linux-2.4.1-pre2-rfs-i/arch/i386/kernel/i386_ksyms.c        Fri Jan
12 01:58:37 2001
@@ -71,6 +71,8 @@
 EXPORT_SYMBOL(apm_info);
 EXPORT_SYMBOL(gdt);
 
+EXPORT_SYMBOL(mmu_cr4_features);
+
 EXPORT_SYMBOL_NOVERS(__down_failed);
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
--- linux/net/sunrpc/sunrpc_syms.c~     Sat Apr 22 01:08:52 2000
+++ linux/net/sunrpc/sunrpc_syms.c      Fri Jan 12 01:50:10 2001
@@ -36,6 +36,7 @@
 EXPORT_SYMBOL(rpciod_up);
 EXPORT_SYMBOL(rpc_new_task);
 EXPORT_SYMBOL(rpc_wake_up_status);
+EXPORT_SYMBOL(rpc_release_task);
 
 /* RPC client functions */
 EXPORT_SYMBOL(rpc_create_client);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
