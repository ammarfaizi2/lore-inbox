Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbUKDVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUKDVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbUKDVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:46:15 -0500
Received: from smtp16.mail.bbt.yahoo.co.jp ([202.93.83.109]:23204 "HELO
	smtp16.mail.bbt.yahoo.co.jp") by vger.kernel.org with SMTP
	id S262443AbUKDVo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:44:26 -0500
X-Apparently-From: <shigekazun@yahoo.co.jp>
Message-ID: <418AA2B4.5090002@yahoo.co.jp>
Date: Fri, 05 Nov 2004 06:44:20 +0900
From: kaz <shigekazun@yahoo.co.jp>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade_spam@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       LKML <linux-kernel@vger.kernel.org>, Erik@budgetdedicated.com,
       Peter <peter@rimuhosting.com>,
       "Christopher S. Aker" <caker@theshore.net>,
       Matt Zimmerman <mdz@debian.org>
Subject: SKAS3/2.6-V7 failed with 2.6.8.1
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411041932.39733.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Blaisorblade wrote:
> 
> The SKAS3/2.6-v7 was already released, but I probably forgot to announce it. 
> So I'm announcing it now.

host-skas3-2.6.9-v7.patch failed with 2.6.8.1.  The error message was as below;

~linux-2.6.8.1$ cat ../host-skas3-2.6.9-v7.patch | patch -p1
patching file arch/i386/kernel/entry.S
Hunk #1 succeeded at 258 with fuzz 2 (offset 2 lines).
Hunk #2 FAILED at 280.
1 out of 3 hunks FAILED -- saving rejects to file arch/i386/kernel/entry.S.rej
patching file arch/i386/kernel/ptrace.c
Hunk #2 succeeded at 358 (offset -1 lines).
Hunk #3 succeeded at 366 with fuzz 1 (offset -1 lines).
Hunk #4 succeeded at 417 (offset -3 lines).
Hunk #5 succeeded at 524 (offset -4 lines).
Hunk #6 succeeded at 589 (offset -4 lines).
Hunk #7 FAILED at 600.
Hunk #8 succeeded at 632 (offset -5 lines).
1 out of 8 hunks FAILED -- saving rejects to file arch/i386/kernel/ptrace.c.rej
patching file include/asm-i386/thread_info.h
Hunk #2 FAILED at 153.
1 out of 2 hunks FAILED -- saving rejects to file include/asm-i386/thread_info.h.rej
patching file include/linux/ptrace.h
patching file kernel/fork.c
Hunk #1 succeeded at 1008 (offset -32 lines).
patching file include/linux/mm.h
Hunk #1 succeeded at 575 (offset -48 lines).
Hunk #2 succeeded at 636 (offset -49 lines).
patching file include/linux/proc_mm.h
patching file mm/Makefile
Hunk #1 FAILED at 18.
1 out of 1 hunk FAILED -- saving rejects to file mm/Makefile.rej
patching file mm/mmap.c
Hunk #1 succeeded at 736 (offset -23 lines).
Hunk #2 succeeded at 1006 (offset -28 lines).
patching file mm/mprotect.c
Hunk #2 succeeded at 186 (offset -2 lines).
Hunk #3 succeeded at 217 (offset -2 lines).
Hunk #4 succeeded at 288 (offset -2 lines).
patching file mm/proc_mm.c
patching file arch/i386/Kconfig
Hunk #1 succeeded at 757 (offset 33 lines).
patching file arch/i386/kernel/ldt.c
Hunk #6 succeeded at 172 (offset -5 lines).
Hunk #7 succeeded at 197 (offset -5 lines).
Hunk #8 succeeded at 233 (offset -5 lines).
patching file arch/i386/kernel/sys_i386.c
patching file include/asm-i386/desc.h
Hunk #1 succeeded at 124 (offset -2 lines).
patching file include/asm-i386/ptrace.h
Hunk #1 succeeded at 59 with fuzz 1 (offset -5 lines).
patching file include/asm-i386/mmu_context.h
Hunk #3 FAILED at 66.
1 out of 3 hunks FAILED -- saving rejects to file include/asm-i386/mmu_context.h.rej
patching file arch/um/include/skas_ptrace.h
patching file localversion-skas


