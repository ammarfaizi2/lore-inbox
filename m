Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264217AbTDJVys (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTDJVys (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:54:48 -0400
Received: from crack.them.org ([65.125.64.184]:45451 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S264217AbTDJVyr (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:54:47 -0400
Date: Thu, 10 Apr 2003 18:06:27 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ranga Iyengar <ambuga@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: siginfo of traced child to parent process
Message-ID: <20030410220626.GA32489@nevyn.them.org>
Mail-Followup-To: Ranga Iyengar <ambuga@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030410214141.67857.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410214141.67857.qmail@web40601.mail.yahoo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 02:41:41PM -0700, Ranga Iyengar wrote:
> I wanted to know if there is a way to get the
> siginfo_t of a child process from a parent process.
> The child process is traced by the parent process
> using ptrace system call and if the child is stopped
> because of SIGSEGV or SIGFPE, the address of the
> instruction that caused the exception is available to
> the child from the signal handler thro' the siginfo
> structure. Is there any way of getting this
> info(siginfo) to the parent. The parent attaches to
> the child in the same way 'gdb' attaches to the
> debugged programs.
> 
> I'm using linux kernel 2.4.18

There is in 2.5 - it's called PTRACE_GETSIGINFO.  There isn't in 2.4.18
though.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
