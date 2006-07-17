Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWGQLih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWGQLih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGQLih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:38:37 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:3759 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750750AbWGQLih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:38:37 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
To: Ingo Molnar <mingo@elte.hu>, Jeff Dike <jdike@addtoit.com>,
       Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 17 Jul 2006 13:37:44 +0200
References: <6tgj0-8ip-19@gated-at.bofh.it> <6xP8s-5mc-9@gated-at.bofh.it> <6xUhQ-4Wx-33@gated-at.bofh.it> <6xVdX-6oH-53@gated-at.bofh.it> <6xVnz-6AI-21@gated-at.bofh.it> <6xZUd-4Es-13@gated-at.bofh.it> <6y7yy-7ws-13@gated-at.bofh.it> <6y7RK-7TX-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G2RQL-0000tG-Gb@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> * Jeff Dike <jdike@addtoit.com> wrote:

>> Now, there were a couple of ways to legitimately escape from UML, and
>> they *did* involve ptrace.  Things like single-stepping a system call
>> instruction or putting a breakpoint on a system call instruction and
>> single-stepping from the breakpoint.  As far as I know, these were
>> discovered and fixed by UML developers before there was any outside
>> awareness of these bugs.
> 
> also, UML 'ptrace clients' are allowed alot more leeway than what a
> seccomp-alike ptrace/utrace based syscall filter would allow. It would
> clearly exclude activities like 'setting a breakpoint' or
> 'single-stepping' - valid syscalls would be limited to
> read/write/sigreturn/exit.

So instead of breakpointing (using int3), you'd have to write
'mv flag I_AM_HERE;self:jmp self' and resort to polling?
This would not prevent (ab)use except for some corner cases.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
