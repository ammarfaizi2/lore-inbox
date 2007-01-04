Return-Path: <linux-kernel-owner+w=401wt.eu-S964898AbXADQnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbXADQnP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbXADQnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:43:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964898AbXADQnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:43:14 -0500
Date: Thu, 4 Jan 2007 14:44:14 -0200
From: Glauber de Oliveira Costa <gcosta@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Use constant instead of raw number in x86_64 ioperm.c
Message-ID: <20070104164414.GB27259@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a tiny cleanup to increase readability

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="constant.patch"

diff -Nrup linux-2.6.19.1/arch/x86_64/kernel/ioport.c linux-2.6.19.1-devel/arch/x86_64/kernel/ioport.c
--- linux-2.6.19.1/arch/x86_64/kernel/ioport.c	2006-12-11 17:32:53.000000000 -0200
+++ linux-2.6.19.1-devel/arch/x86_64/kernel/ioport.c	2007-01-04 07:44:46.000000000 -0200
@@ -114,6 +114,6 @@ asmlinkage long sys_iopl(unsigned int le
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	regs->eflags = (regs->eflags &~ 0x3000UL) | (level << 12);
+	regs->eflags = (regs->eflags &~ X86_EFLAGS_IOPL) | (level << 12);
 	return 0;
 }

--IJpNTDwzlM2Ie8A6--
