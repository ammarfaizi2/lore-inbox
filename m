Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSHATeU>; Thu, 1 Aug 2002 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSHATeU>; Thu, 1 Aug 2002 15:34:20 -0400
Received: from web11203.mail.yahoo.com ([216.136.131.185]:55316 "HELO
	web11203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317006AbSHATeT>; Thu, 1 Aug 2002 15:34:19 -0400
Message-ID: <20020801193747.78477.qmail@web11203.mail.yahoo.com>
Date: Thu, 1 Aug 2002 12:37:47 -0700 (PDT)
From: Datoda <datoda@yahoo.com>
Subject: PTRACE_SYSCALL
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I have played with this ptrace request a bit on
ia32 and there are a few things unclear to me. Could
someone please answer my questions? TIA.

o When the child enters a system call, and the parent
regains control after issuing PTRACE_SYSCALL, where is
the system call number stored? I guess it's either in
%eax or in orig_eax (at 0x24(esp)) of the child, but
values in both places seem invalid in my own
experiments.

o According to the man page, the child is interrupted
twice for each system call, once at the entry and once
at the exit. Intriguingly, when parent inspects the
eip of the child at both interruptions, the two eip's
are the same. What is the explanation for this?
Furthermore, the eip of the child seems to always
point at the instruction after "int". Why is that the
case?

o Is there a good document that covers PTRACE_SYSCALL
or ptrace in general?

Your answers are appreciated.




__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
