Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277731AbRJLPfZ>; Fri, 12 Oct 2001 11:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277732AbRJLPfP>; Fri, 12 Oct 2001 11:35:15 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:64400 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S277731AbRJLPfH>; Fri, 12 Oct 2001 11:35:07 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110121535.QAA30537@mauve.demon.co.uk>
Subject: Re: Why can't I strace some processes?
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Oct 2001 16:35:21 +0100 (BST)
In-Reply-To: <200110120816.JAA16909@mauve.demon.co.uk> from "Ian Stirling" at Oct 12, 2001 09:16:04 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> How do I strace processes that use clone, to create multiple threads?
> I've tried the latest strace.
> Thanks.

Sorry, I was going for concise, and brief, but realise now I probably went
too far.

Details: Kernel 2.4.11 strace 4.4 (neither of these seem critical.
http://www.edonkey2000.com/files/ed2k_linux_gui_0.1alpha.tar.gz
Has a binary of a p2p client for linux.
It's closed-source, and has a number of issues.
In attempts to find workarounds for these, I attempted to strace the process,
and it diddn't quite work.

It only ever traces syscalls made by the process that originated the
clone call, never resultant processes, even with -f set.
Attempring to connect and trace the resultant processes causes strace to
exit immediately, sometimes STOPing the process that was attempted to
be traced.

As all the work is done by the threads, and these seemingly can't be traced,
there is an annoying problem.

