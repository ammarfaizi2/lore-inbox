Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVCTLS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVCTLS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCTLRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:17:00 -0500
Received: from coderock.org ([193.77.147.115]:30859 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262134AbVCTLQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:16:31 -0500
Date: Sun, 20 Mar 2005 12:16:22 +0100
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 09/10 with proper signed-off] arch/i386/mm/fault.c: fix sparse warnings
Message-ID: <20050320111622.GD14273@nd47.coderock.org>
References: <20050319131742.1A64E1F23D@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131742.1A64E1F23D@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/mm/fault.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/fault.c~sparse-arch_i386_mm_fault arch/i386/mm/fault.c
--- kj/arch/i386/mm/fault.c~sparse-arch_i386_mm_fault	2005-03-20 12:11:20.000000000 +0100
+++ kj-domen/arch/i386/mm/fault.c	2005-03-20 12:11:20.000000000 +0100
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
