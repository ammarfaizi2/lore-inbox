Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTGGXPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTGGXPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 19:15:50 -0400
Received: from web13604.mail.yahoo.com ([216.136.175.115]:941 "HELO
	web13604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264632AbTGGXPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 19:15:49 -0400
Message-ID: <20030707233024.13068.qmail@web13604.mail.yahoo.com>
Date: Mon, 7 Jul 2003 16:30:24 -0700 (PDT)
From: Slack Ware <slack_ware@yahoo.com>
Subject: Re: Debugging , Tracing...
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030707110001.734.6504.Mailman@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Auge Mike" 
To: linux-kernel@vger.kernel.org
Subject: Debugging , Tracing...
On Sun, 06 Jul 2003 23:48:17 +0400, Auge Mike wrote:

>Hi all,

>      I have asked before few weeks about tracing the
>execution of the 
>kernel or debugging it. Unfortunately, I faced some
>problems in using Kgdb, 
>especially that the patch was not successful on my
>redhat 7.3.
Hi, Auge. I think that the kernel execution cannot be
debugged nor traced by gdb (kgdb is just a frontend
for the GNU DeBugger), it can be used to trace/debug
the execution of any other program, including modules.
>     Whatever, lets say that kgdb worked
>successfully, how can I trace the 
>execution of “a specific system call” (lets say
>printf), so I can see how it 
>works internally. Is there any other utility for
>that? How can I do that 
>with kgdb?
Other thing, printf() is not a system call, you use
write() (syscall #4) for printing things in screen.
A recommendation: don't use gdb or kgdb for tracing
programs execution, use "strace [program] [arguments]"
in your console, instead. GDB is useful for debugging
things, like when a program received a SIGSEGV (it
generates a coredump) in a file "core", and you can
debug it for searching the error that caused that
signal.
Strace is a tool that you use for tracing programs
syscalls during it execution.
I hope this will be useful for you.
Regards,
                                           Slack

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
