Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWERURQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWERURQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWERURQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:17:16 -0400
Received: from ns2.suse.de ([195.135.220.15]:61064 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751392AbWERURQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:17:16 -0400
To: renzo@cs.unibo.it (Renzo Davoli)
Cc: osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
References: <20060518155337.GA17498@cs.unibo.it>
	<20060518155848.GC17498@cs.unibo.it>
From: Andi Kleen <ak@suse.de>
Date: 18 May 2006 22:17:08 +0200
In-Reply-To: <20060518155848.GC17498@cs.unibo.it>
Message-ID: <p73sln72im3.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

renzo@cs.unibo.it (Renzo Davoli) writes:

> ptmulti kernel patch inserts a new useful option for ptrace() call, 
> adding a new request type to ptrace() syscall.
> 
> With PTRACE_MULTI option you can send multiple ptrace requests with a 
> single system call: commonly a process that uses ptrace() needs
> several PTRACE_PEEKDATA for getting some useful, even small pieces of data.
> It is useful for these programs to run several ptrace
> operations while limiting the number of context switches.

What context switches do you mean?  System calls? Linux is in general
designed to have very cheap system calls and they shouldn't be more tha
a few hundred cycles. 

> 
> Debuggers and virtual machines (like User Mode Linux) and many other 
> applications that are based on ptrace can get great 
> performance improvements by PTRACE_MULTI: the number of system
> calls (and context switches) decreases significantly.

You forgot to add numbers? 

-Andi
