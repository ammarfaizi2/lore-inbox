Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVCIQoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVCIQoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCIQnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:43:45 -0500
Received: from [151.97.230.9] ([151.97.230.9]:61956 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261692AbVCIQlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:41:04 -0500
Subject: [patch 1/1] x86-64: forgot asmlinkage on sys_mmap
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, ak@suse.de
From: blaisorblade@yahoo.it
Date: Sat, 05 Mar 2005 20:00:04 +0100
Message-Id: <20050305190005.0943C4B47@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Andi Kleen <ak@suse.de>

I think it should be there, please check better.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/x86_64/kernel/sys_x86_64.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/sys_x86_64.c~x86-64-asmlinkage-forgot arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.11/arch/x86_64/kernel/sys_x86_64.c~x86-64-asmlinkage-forgot	2005-03-05 19:58:38.339212568 +0100
+++ linux-2.6.11-paolo/arch/x86_64/kernel/sys_x86_64.c	2005-03-05 19:58:51.062278368 +0100
@@ -38,7 +38,7 @@ asmlinkage long sys_pipe(int __user *fil
 	return error;
 }
 
-long sys_mmap(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long off)
 {
 	long error;
_
