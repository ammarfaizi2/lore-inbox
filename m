Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbULUNva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbULUNva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbULUNva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:51:30 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40940 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261758AbULUNv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:51:27 -0500
Subject: Re: Intercepting system calls
From: Steven Rostedt <rostedt@goodmis.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041221042224.48160.qmail@web60608.mail.yahoo.com>
References: <20041221042224.48160.qmail@web60608.mail.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 21 Dec 2004 08:51:23 -0500
Message-Id: <1103637083.17511.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 20:22 -0800, selvakumar nagendran wrote:
>     I want to intercept system calls that are provided
> for IPC in Linux. I have to determine whether a
> process blocks while executing a system call and I
> must save the arguments passed to that system call.
>     Can I modify the system call source code directly
> for this? or if I want the system calls to refer my
> module, how should I do that? can anyone explain for
> this, if possible with some code?..

Do you have to do this in the kernel? Have you taken a look at ptrace?
Especially PTRACE_SYSCALL (man ptrace).  Although it may be trickier to
know if it blocked or not, but it should still be possible to do
entirely from user land, and thus easier to write/debug.

-- Steve


