Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJCKAq>; Thu, 3 Oct 2002 06:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbSJCKAq>; Thu, 3 Oct 2002 06:00:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:60381 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263246AbSJCKAo>;
	Thu, 3 Oct 2002 06:00:44 -0400
Message-Id: <5.1.0.14.2.20021003114625.00b7ea20@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 03 Oct 2002 12:03:27 +0200
To: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [OT] backtrace 
In-Reply-To: <7453.1033637889@ocs3.intra.ocs.com.au>
References: <Your message of "Thu, 03 Oct 2002 09:31:06 +0100." <3D9C004A.3080006@corvil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:38 PM 10/3/2002 +1000, Keith Owens wrote:
>On Thu, 03 Oct 2002 09:31:06 +0100,
>Padraig Brady <padraig.brady@corvil.com> wrote:
> >Sorry to go off topic but this tip is just too useful IMHO.
> >You can do the same in userspace with glibc. Details here:
> >http://www.iol.ie/~padraiga/backtrace.c
>
>info libc, /backtrace.
>
>      Note that certain compiler optimisations may interfere with
>      obtaining a valid backtrace.  Function inlining causes the inlined
>      function to not have a stack frame; tail call optimisation
>      replaces one stack frame with another; frame pointer elimination
>      will stop `backtrace' from interpreting the stack contents
>      correctly.
>
>Most architectures compile with -fomit-frame-pointer (except for ARM
>where RMK does it differently).  Neither gdb not glibc can cope with
>kernel code built with -fomit-frame-pointer.  See the horrible
>heuristics kdb has to apply to get any sort of backtrace on i386.

IIRC, r~ once mentioned that it was going to get worse. He also mentioned 
dwarf2 (sp) as a possible solution.  Did you ever look into that?

         -Mike

(I didn't.  Elf->Dwarf transmogrification of kernel is way out of my league)

