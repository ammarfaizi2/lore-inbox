Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbRFCCnH>; Sat, 2 Jun 2001 22:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbRFCCm5>; Sat, 2 Jun 2001 22:42:57 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:43780 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262742AbRFCCmp>;
	Sat, 2 Jun 2001 22:42:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is i386 thread.trapno? 
In-Reply-To: Your message of "Sat, 02 Jun 2001 21:31:42 EST."
             <200106030231.VAA03708@ccure.karaya.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Jun 2001 12:42:38 +1000
Message-ID: <17271.991536158@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2001 21:31:42 -0500, 
Jeff Dike <jdike@karaya.com> wrote:
>The i386 page fault handler sets trap_no to 14, so the fault isn't coming from 
>there, but I can't see where a SIGSEGV is being delivered to a process with 
>thread.trap_no == 1.
>
>So:
>	What do these trap numbers mean?
>	Where can I read about them?

Intel Architecture Software Developer's Manual Volume 3: System
Programming.  Interrupt and Exception Handling, table 5.1 (postscript
extract of that table has been copied in separate private mail).
intel-ia32-arch-vol3-24319202.pdf.

>and
>	Where's this segfault coming from?

Probably do_debug() which sets trapno = 1 and also uses
handle_vm86_trap(,,1).

