Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbSJCJcx>; Thu, 3 Oct 2002 05:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbSJCJcw>; Thu, 3 Oct 2002 05:32:52 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:9996 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263217AbSJCJcw>;
	Thu, 3 Oct 2002 05:32:52 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] backtrace 
In-reply-to: Your message of "Thu, 03 Oct 2002 09:31:06 +0100."
             <3D9C004A.3080006@corvil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Oct 2002 19:38:09 +1000
Message-ID: <7453.1033637889@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2002 09:31:06 +0100, 
Padraig Brady <padraig.brady@corvil.com> wrote:
>Sorry to go off topic but this tip is just too useful IMHO.
>You can do the same in userspace with glibc. Details here:
>http://www.iol.ie/~padraiga/backtrace.c

info libc, /backtrace.

     Note that certain compiler optimisations may interfere with
     obtaining a valid backtrace.  Function inlining causes the inlined
     function to not have a stack frame; tail call optimisation
     replaces one stack frame with another; frame pointer elimination
     will stop `backtrace' from interpreting the stack contents
     correctly.

Most architectures compile with -fomit-frame-pointer (except for ARM
where RMK does it differently).  Neither gdb not glibc can cope with
kernel code built with -fomit-frame-pointer.  See the horrible
heuristics kdb has to apply to get any sort of backtrace on i386.

