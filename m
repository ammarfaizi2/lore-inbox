Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSKUHKE>; Thu, 21 Nov 2002 02:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSKUHKE>; Thu, 21 Nov 2002 02:10:04 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:10903 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S266379AbSKUHKD>; Thu, 21 Nov 2002 02:10:03 -0500
Subject: [PATCH] Get 2.5.48 UML to compile with CONFIG_NFSD=y
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Cc: jdike@karaya.com
Content-Type: multipart/mixed; boundary="=-xUKFmJiKDCfJtmyDTm5w"
Organization: 
Message-Id: <1037863030.13803.5.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 23:17:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xUKFmJiKDCfJtmyDTm5w
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There's a typo in the user-mode-linux syscall table that causes a
compilation failure with the NFS server enabled.  The attached patch
applies to BK-current and fixes the problem.

	<b

--=-xUKFmJiKDCfJtmyDTm5w
Content-Disposition: attachment; filename=2.5.48-um-nfsd.patch
Content-Type: text/plain; name=2.5.48-um-nfsd.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

==== //depot/linux-2.5-bos/arch/um/kernel/sys_call_table.c#1 - /export/bos/p4/linux-2.5-bos/arch/um/kernel/sys_call_table.c ====
Index: linux-2.5-bos/arch/um/kernel/sys_call_table.c
--- linux-2.5-bos/arch/um/kernel/sys_call_table.c.~1~	Wed Nov 20 21:45:28 2002
+++ linux-2.5-bos/arch/um/kernel/sys_call_table.c	Wed Nov 20 21:45:28 2002
@@ -238,7 +238,7 @@
 extern syscall_handler_t sys_remap_file_pages;
 
 #if CONFIG_NFSD
-#define NFSSERVCTL sys_nfsserctl
+#define NFSSERVCTL sys_nfsservctl
 #else
 #define NFSSERVCTL sys_ni_syscall
 #endif
End of Patch.

--=-xUKFmJiKDCfJtmyDTm5w--

