Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVAaR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVAaR5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAaR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:57:49 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:54246 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261288AbVAaR5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:57:38 -0500
Date: Mon, 31 Jan 2005 18:57:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/8] s390: vfree checking cleanup.
Message-ID: <20050131175726.GB7940@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/8] s390: vfree checking cleanup.

From: James Lamanna <jlamanna@gmail.com>

arch/s390/kernel/module.c vfree() checking cleanup.

Signed-off-by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/module.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-patched/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/module.c	2005-01-31 18:51:20.000000000 +0100
@@ -396,8 +396,7 @@
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	if (me->arch.syminfo)
-		vfree(me->arch.syminfo);
+	vfree(me->arch.syminfo);
 	return 0;
 }
 
