Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSBGJuQ>; Thu, 7 Feb 2002 04:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSBGJuG>; Thu, 7 Feb 2002 04:50:06 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:26620 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S287002AbSBGJt5>; Thu, 7 Feb 2002 04:49:57 -0500
Date: Thu, 7 Feb 2002 01:49:36 -0800
From: Chris Wright <chris@wirex.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.4-pre2] tkill ia64 syscall table entry
Message-ID: <20020207014936.A24241@figure1.int.wirex.com>
Mail-Followup-To: Dave McCracken <dmccr@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor nit, but it seems the tkill() patch added a sys_tkill entry without
removing an ia64_ni_syscall entry.

thanks,
-chris

--- 2.5.4-pre2/arch/ia64/kernel/entry.S	Wed Feb  6 14:51:46 2002
+++ 2.5.4-pre2-nit/arch/ia64/kernel/entry.S	Thu Feb  7 01:12:08 2002
@@ -1131,7 +1131,6 @@
 	data8 sys_getunwind			// 1215
 	data8 sys_readahead
 	data8 sys_tkill
-	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall			// 1220
