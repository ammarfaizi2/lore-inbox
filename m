Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVCSN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVCSN31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVCSN0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:26:42 -0500
Received: from coderock.org ([193.77.147.115]:5512 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262470AbVCSNRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:51 -0500
Subject: [patch 09/10] arch/i386/mm/fault.c: fix sparse warnings
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:41 +0100
Message-Id: <20050319131742.1A64E1F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/mm/fault.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/fault.c~sparse-arch_i386_mm_fault arch/i386/mm/fault.c
--- kj/arch/i386/mm/fault.c~sparse-arch_i386_mm_fault	2005-03-18 20:05:20.000000000 +0100
+++ kj-domen/arch/i386/mm/fault.c	2005-03-18 20:05:20.000000000 +0100
@@ -146,7 +146,7 @@ static int __is_prefetch(struct pt_regs 
 
 		if (instr > limit)
 			break;
-		if (__get_user(opcode, (unsigned char *) instr))
+		if (__get_user(opcode, (unsigned char __user *) instr))
 			break; 
 
 		instr_hi = opcode & 0xf0; 
@@ -173,7 +173,7 @@ static int __is_prefetch(struct pt_regs 
 			scan_more = 0;
 			if (instr > limit)
 				break;
-			if (__get_user(opcode, (unsigned char *) instr)) 
+			if (__get_user(opcode, (unsigned char __user *) instr))
 				break;
 			prefetch = (instr_lo == 0xF) &&
 				(opcode == 0x0D || opcode == 0x18);
_
